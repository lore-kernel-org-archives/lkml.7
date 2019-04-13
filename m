Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A599FC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9FB2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfDMVES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:04:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMVES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:04:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DL2xhY2267566
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 14:03:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DL2xMU2267563;
        Sat, 13 Apr 2019 14:02:59 -0700
Date:   Sat, 13 Apr 2019 14:02:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-1d731e731c4cd7cbd3b1aa295f0932e7610da82f@git.kernel.org>
Cc:     pbonzini@redhat.com, mingo@kernel.org, x86@kernel.org,
        riel@surriel.com, tglx@linutronix.de, bigeasy@linutronix.de,
        Jason@zx2c4.com, dave.hansen@intel.com, luto@kernel.org,
        bp@suse.de, hpa@zytor.com, jannh@google.com, rkrcmar@redhat.com,
        mingo@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@redhat.com, kvm@vger.kernel.org,
          linux-kernel@vger.kernel.org, jannh@google.com,
          rkrcmar@redhat.com, hpa@zytor.com, luto@kernel.org, bp@suse.de,
          bigeasy@linutronix.de, Jason@zx2c4.com, dave.hansen@intel.com,
          tglx@linutronix.de, x86@kernel.org, riel@surriel.com,
          pbonzini@redhat.com, mingo@kernel.org
In-Reply-To: <20190403164156.19645-25-bigeasy@linutronix.de>
References: <20190403164156.19645-25-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Add a fastpath to __fpu__restore_sig()
Git-Commit-ID: 1d731e731c4cd7cbd3b1aa295f0932e7610da82f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1d731e731c4cd7cbd3b1aa295f0932e7610da82f
Gitweb:     https://git.kernel.org/tip/1d731e731c4cd7cbd3b1aa295f0932e7610da82f
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:53 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 12 Apr 2019 20:04:49 +0200

x86/fpu: Add a fastpath to __fpu__restore_sig()

The previous commits refactor the restoration of the FPU registers so
that they can be loaded from in-kernel memory. This overhead can be
avoided if the load can be performed without a pagefault.

Attempt to restore FPU registers by invoking
copy_user_to_fpregs_zeroing(). If it fails try the slowpath which can
handle pagefaults.

 [ bp: Add a comment over the fastpath to be able to find one's way
   around the function. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-25-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 6df1f15e0cd5..a1bd7be70206 100644
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
@@ -327,8 +327,27 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		if (ret)
 			goto err_out;
 		envp = &env;
+	} else {
+		/*
+		 * Attempt to restore the FPU registers directly from user
+		 * memory. For that to succeed, the user access cannot cause
+		 * page faults. If it does, fall back to the slow path below,
+		 * going through the kernel buffer with the enabled pagefault
+		 * handler.
+		 */
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
 
