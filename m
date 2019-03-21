Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A924C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338A21925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfCUU2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:28:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbfCUU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:26:57 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h74H5-00057y-W8; Thu, 21 Mar 2019 21:26:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 20/24] x86/fpu: Inline copy_user_to_fpregs_zeroing()
Date:   Thu, 21 Mar 2019 21:26:28 +0100
Message-Id: <20190321202632.16810-21-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321202632.16810-1-bigeasy@linutronix.de>
References: <20190321202632.16810-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start refactoring __fpu__restore_sig() by inlining
copy_user_to_fpregs_zeroing().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 97ea6909ede1f..5a467a381245c 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -220,28 +220,6 @@ sanitize_restored_xstate(union fpregs_state *state,
 	}
 }
 
-/*
- * Restore the extended state if present. Otherwise, restore the FP/SSE state.
- */
-static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
-{
-	if (use_xsave()) {
-		if ((unsigned long)buf % 64 || fx_only) {
-			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_fxregs(buf);
-		} else {
-			u64 init_bv = xfeatures_mask & ~xbv;
-			if (unlikely(init_bv))
-				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_xregs(buf, xbv);
-		}
-	} else if (use_fxsr()) {
-		return copy_user_to_fxregs(buf);
-	} else
-		return copy_user_to_fregs(buf);
-}
-
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 {
 	int ia32_fxstate = (buf != buf_fx);
@@ -319,11 +297,29 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		kfree(tmp);
 		return err;
 	} else {
+		int ret;
+
 		/*
 		 * For 64-bit frames and 32-bit fsave frames, restore the user
 		 * state to the registers directly (with exceptions handled).
 		 */
-		if (copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only)) {
+		if (use_xsave()) {
+			if ((unsigned long)buf_fx % 64 || fx_only) {
+				u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+				ret = copy_user_to_fxregs(buf_fx);
+			} else {
+				u64 init_bv = xfeatures_mask & ~xfeatures;
+				if (unlikely(init_bv))
+					copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+				ret = copy_user_to_xregs(buf_fx, xfeatures);
+			}
+		} else if (use_fxsr()) {
+			ret = copy_user_to_fxregs(buf_fx);
+		} else
+			ret = copy_user_to_fregs(buf_fx);
+
+		if (ret) {
 			fpu__clear(fpu);
 			return -1;
 		}
-- 
2.20.1

