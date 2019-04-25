Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33FEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EFB206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfDYRgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:36:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60014 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbfDYRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:36:01 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hJiHh-00058D-PA; Thu, 25 Apr 2019 19:35:45 +0200
Date:   Thu, 25 Apr 2019 19:35:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, jannh@google.com, riel@surriel.com,
        dave.hansen@intel.com, mingo@redhat.com, bp@suse.de,
        Jason@zx2c4.com, luto@kernel.org, tglx@linutronix.de,
        rkrcmar@redhat.com, mingo@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, pbonzini@redhat.com,
        kurt.kanzenbach@linutronix.de
Subject: [RFC PATCH] x86/fpu: Don't unconditionally add XFEATURE_MASK_FPSSE
 on sigentry
Message-ID: <20190425173545.sogxyptbaqvoofm6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit reverts commit 04944b793e18e ("x86: xsave: set FP, SSE bits
in the xsave header in the user sigcontext"). The commit claims that it
is required for legacy applications but fails to explain why this is
needed and it is not obvious to me why the application would require the
FP/SSE state in the signal handler.

In the compacted form, the XSAVES may save only XMM+SSE but skip FP.
This is denoted by header->xfeatures = 6. The fastpath
(copy_fpregs_to_sigframe()) does that but _also_ initialises the FP
state (cwd to 0x37f, mxcsr as we do, remaining fields to 0).
The slowpath (copy_xstate_to_user()) leaves most of the FP untouched.
Only mxcsr and mxcsr_flags are set due to xfeatures_mxcsr_quirk().
Now that XFEATURE_MASK_FP is set unconditionally we load on return from
signal random garbage as the FP state.
This results in SIGFPE on one particular machine (the same testcase
(starting a java application) on older generations seems to work).

One way to fix this is not to unconditionally set XFEATURE_MASK_FPSSE
since it was never saved. This avoids loading garbage on the return
path.
We could also initialise the FP state in the xfeatures_mxcsr_quirk()
case like xsave does.

Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Fixes: 69277c98f5eef ("x86/fpu: Always store the registers in copy_fpstate_to_sigframe()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 7026f1c4e5e30..6c66203b19f3c 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -81,7 +81,6 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 {
 	struct xregs_state __user *x = buf;
 	struct _fpx_sw_bytes *sw_bytes;
-	u32 xfeatures;
 	int err;
 
 	/* Setup the bytes not touched by the [f]xsave and reserved for SW. */
@@ -93,28 +92,6 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
 			  (__u32 __user *)(buf + fpu_user_xstate_size));
-
-	/*
-	 * Read the xfeatures which we copied (directly from the cpu or
-	 * from the state in task struct) to the user buffers.
-	 */
-	err |= __get_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
-
-	/*
-	 * For legacy compatible, we always set FP/SSE bits in the bit
-	 * vector while saving the state to the user context. This will
-	 * enable us capturing any changes(during sigreturn) to
-	 * the FP/SSE bits by the legacy applications which don't touch
-	 * xfeatures in the xsave header.
-	 *
-	 * xsave aware apps can change the xfeatures in the xsave
-	 * header as well as change any contents in the memory layout.
-	 * xrestore as part of sigreturn will capture all the changes.
-	 */
-	xfeatures |= XFEATURE_MASK_FPSSE;
-
-	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
-
 	return err;
 }
 
-- 
2.20.1

