Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6CDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CAD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412761;
	bh=3YuYJgHzPeqfnu9iRUvtg9XL7Q+BuK2tpsB3QoGyXMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T+2GLfuA36GcQzsAJY0LL/Gp1ZFV9ma9LkT7GTikWIFfGhyVpBRQdauJlN5ydkIp/
	 y9TE4aGUx84CfjKOgbjmoLNaKDmNOZMo3UY9/u8wzIkR3sgincLpxEFWf5AqwDzs4I
	 LPiVRj3C5GNHRq0xWeUptG6mch1ynHZvFAuTtY8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfLCWjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfLCWjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:39:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6122E2073C;
        Tue,  3 Dec 2019 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412755;
        bh=3YuYJgHzPeqfnu9iRUvtg9XL7Q+BuK2tpsB3QoGyXMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZqETis+E9fdXXzsH8ZXCtUa7ed1qhaVwXeyOMohVmLZs+VjzgKiVOlIP7L2sAHcD
         loZ3PAK/xBQ50vrVCBHPKO/apv1FG/x7P4lNoFssGNVfhM7hxiOyV/AP0elWRBEZdU
         xRKpiiMK1awVzu/rwvjzTjOAyIwh0+RpY71d3IZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Austin Clements <austin@google.com>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Chase <drchase@golang.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ian@airs.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 5.4 15/46] x86/fpu: Dont cache access to fpu_fpregs_owner_ctx
Date:   Tue,  3 Dec 2019 23:35:35 +0100
Message-Id: <20191203212732.978208719@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 59c4bd853abcea95eccc167a7d7fd5f1a5f47b98 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/fpu/internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -509,7 +509,7 @@ static inline void __fpu_invalidate_fpre
 
 static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
 {
-	return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
+	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
 }
 
 /*


