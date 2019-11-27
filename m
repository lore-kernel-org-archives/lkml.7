Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B19C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110D62068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfK0Mmw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:42:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44615 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfK0Mmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:42:52 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iZweZ-0006Ro-Qo; Wed, 27 Nov 2019 13:42:43 +0100
Date:   Wed, 27 Nov 2019 13:42:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Barret Rhoden <brho@google.com>,
        Josh Bleecher Snyder <josharian@gmail.com>
Cc:     "Rik van Riel\"" <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
Message-ID: <20191127124243.u74osvlkhcmsskng@linutronix.de>
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
 <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
 <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state/owner of FPU is saved fpu_fpregs_owner_ctx by pointing to the
context that is currently loaded. It never changed during the life time
of a task and remained stable/constant.

Since we deferred loading the FPU registers on return to userland, the
content of fpu_fpregs_owner_ctx may change during preemption and must
not be cached.
This went unnoticed for some time and was now noticed, in particular
gcc-9 is able to cache that load in copy_fpstate_to_sigframe() and reuse
it in the retry loop:

  copy_fpstate_to_sigframe()
    load fpu_fpregs_owner_ctx and save on stack
    fpregs_lock()
    copy_fpregs_to_sigframe() /* failed */
    fpregs_unlock()
         *** PREEMPTION, another uses FPU, changes fpu_fpregs_owner_ctx ***

    fault_in_pages_writeable() /* succeed, retry */

    fpregs_lock()
	__fpregs_load_activate()
	  fpregs_state_valid() /* uses fpu_fpregs_owner_ctx from stack */
    copy_fpregs_to_sigframe() /* succeeds, random FPU content */

This is a comparison of the assembly of gcc-9, without vs with this
patch:

| # arch/x86/kernel/fpu/signal.c:173:      if (!access_ok(buf, size))
|        cmpq    %rdx, %rax      # tmp183, _4
|        jb      .L190   #,
|-# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|-#APP
|-# 512 "arch/x86/include/asm/fpu/internal.h" 1
|-       movq %gs:fpu_fpregs_owner_ctx,%rax      #, pfo_ret__
|-# 0 "" 2
|-#NO_APP
|-       movq    %rax, -88(%rbp) # pfo_ret__, %sfp
…
|-# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|-       movq    -88(%rbp), %rcx # %sfp, pfo_ret__
|-       cmpq    %rcx, -64(%rbp) # pfo_ret__, %sfp
|+# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|+#APP
|+# 512 "arch/x86/include/asm/fpu/internal.h" 1
|+       movq %gs:fpu_fpregs_owner_ctx(%rip),%rax        # fpu_fpregs_owner_ctx, pfo_ret__
|+# 0 "" 2
|+# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
|+#NO_APP
|+       cmpq    %rax, -64(%rbp) # pfo_ret__, %sfp

Use this_cpu_read() instead this_cpu_read_stable() to avoid caching of
fpu_fpregs_owner_ctx during preemption points.

Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")
---

There is no Sign-off by here. Could this please be verified by the
reporter?

Also I would like to add
	Debugged-by: Ian Lance Taylor

but I lack the complete address also I'm not sure if he wants to.
Also please send a Reported-by line since I'm not sure who started this.

 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c95c365058aa..44c48e34d7994 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -509,7 +509,7 @@ static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
 
 static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
 {
-	return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
+	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
 }
 
 /*
-- 
2.24.0

