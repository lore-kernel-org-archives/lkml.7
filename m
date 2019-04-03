Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95846C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687A12082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfDCQnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:43:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfDCQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:42:31 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBiy1-0004GO-1M; Wed, 03 Apr 2019 18:42:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 20/27] x86/fpu: Inline copy_user_to_fpregs_zeroing()
Date:   Wed,  3 Apr 2019 18:41:49 +0200
Message-Id: <20190403164156.19645-21-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start refactoring __fpu__restore_sig() by inlining
copy_user_to_fpregs_zeroing(). The orignal function remains and will be
used to restore from userland memory if possible.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c98c7bca13bc0..f733425c66d8d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -337,11 +337,29 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
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

