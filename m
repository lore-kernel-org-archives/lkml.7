Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB95216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfK1JWg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:22:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46415 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK1JWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:22:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaG04-000467-9b; Thu, 28 Nov 2019 10:22:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B5F9A1C1AEF;
        Thu, 28 Nov 2019 10:22:11 +0100 (CET)
Date:   Thu, 28 Nov 2019 09:22:11 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Austin Clements <austin@google.com>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Chase <drchase@golang.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ian@airs.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191128085306.hxfa2o3knqtu4wfn@linutronix.de>
References: <20191128085306.hxfa2o3knqtu4wfn@linutronix.de>
MIME-Version: 1.0
Message-ID: <157493293150.21853.7731511969770345792.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     59c4bd853abcea95eccc167a7d7fd5f1a5f47b98
Gitweb:        https://git.kernel.org/tip/59c4bd853abcea95eccc167a7d7fd5f1a5f47b98
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 28 Nov 2019 09:53:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 Nov 2019 10:16:46 +01:00

x86/fpu: Don't cache access to fpu_fpregs_owner_ctx

The state/owner of the FPU is saved to fpu_fpregs_owner_ctx by pointing
to the context that is currently loaded. It never changed during the
lifetime of a task - it remained stable/constant.

After deferred FPU registers loading until return to userland was
implemented, the content of fpu_fpregs_owner_ctx may change during
preemption and must not be cached.

This went unnoticed for some time and was now noticed, in particular
since gcc 9 is caching that load in copy_fpstate_to_sigframe() and
reusing it in the retry loop:

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

This is a comparison of the assembly produced by gcc 9, without vs with this
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

The Fixes: tag points to the commit where deferred FPU loading was
added. Since this commit, the compiler is no longer allowed to move the
load of fpu_fpregs_owner_ctx somewhere else / outside of the locked
section. A task preemption will change its value and stale content will
be observed.

 [ bp: Massage. ]

Debugged-by: Austin Clements <austin@google.com>
Debugged-by: David Chase <drchase@golang.org>
Debugged-by: Ian Lance Taylor <ian@airs.com>
Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Borislav Petkov <bp@suse.de>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Austin Clements <austin@google.com>
Cc: Barret Rhoden <brho@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Chase <drchase@golang.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: ian@airs.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Bleecher Snyder <josharian@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191128085306.hxfa2o3knqtu4wfn@linutronix.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205663
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c95c36..44c48e3 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -509,7 +509,7 @@ static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
 
 static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
 {
-	return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
+	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
 }
 
 /*
