Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5425BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D282082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfDCQmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:42:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfDCQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:42:37 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBiy7-0004GO-49; Wed, 03 Apr 2019 18:42:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 24/27] x86/fpu: Add a fastpath to __fpu__restore_sig()
Date:   Wed,  3 Apr 2019 18:41:53 +0200
Message-Id: <20190403164156.19645-25-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commits refactor the restoration of the FPU registers so
that they can be loaded from in-kernel memory. This overhead can be
avoided if the load can be performed without a pagefault.

Attempt to restore FPU registers by invoking
copy_user_to_fpregs_zeroing(). If it fails try the slowpath which can handle
pagefaults.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a5b086ec426a5..f20e1d1fffa29 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -242,10 +242,10 @@ sanitize_restored_xstate(union fpregs_state *state,
 /*
  * Restore the extended state if present. Otherwise, restore the FP/SSE state.
  */
-static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
+static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 {
 	if (use_xsave()) {
-		if ((unsigned long)buf % 64 || fx_only) {
+		if (fx_only) {
 			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_fxregs(buf);
@@ -327,7 +327,19 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		if (ret)
 			goto err_out;
 		envp = &env;
+	} else {
+		fpregs_lock();
+		pagefault_disable();
+		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
+		pagefault_enable();
+		if (!ret) {
+			fpregs_mark_activate();
+			fpregs_unlock();
+			return 0;
+		}
+		fpregs_unlock();
 	}
+
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask & ~xfeatures;
 
-- 
2.20.1

