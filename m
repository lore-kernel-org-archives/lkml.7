Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B118DC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879352084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfDMVAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:00:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMVAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:00:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DL05uP2267162
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 14:00:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DL04Bt2267144;
        Sat, 13 Apr 2019 14:00:04 -0700
Date:   Sat, 13 Apr 2019 14:00:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-e0d3602f933367881bddfff310a744e6e61c284c@git.kernel.org>
Cc:     hpa@zytor.com, pbonzini@redhat.com, Jason@zx2c4.com,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        riel@surriel.com, jannh@google.com, bp@suse.de, rkrcmar@redhat.com,
        bigeasy@linutronix.de
Reply-To: mingo@redhat.com, kvm@vger.kernel.org,
          linux-kernel@vger.kernel.org, x86@kernel.org,
          dave.hansen@intel.com, tglx@linutronix.de, pbonzini@redhat.com,
          hpa@zytor.com, Jason@zx2c4.com, luto@kernel.org,
          mingo@kernel.org, bigeasy@linutronix.de, rkrcmar@redhat.com,
          riel@surriel.com, jannh@google.com, bp@suse.de
In-Reply-To: <20190403164156.19645-21-bigeasy@linutronix.de>
References: <20190403164156.19645-21-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Inline copy_user_to_fpregs_zeroing()
Git-Commit-ID: e0d3602f933367881bddfff310a744e6e61c284c
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

Commit-ID:  e0d3602f933367881bddfff310a744e6e61c284c
Gitweb:     https://git.kernel.org/tip/e0d3602f933367881bddfff310a744e6e61c284c
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:49 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 20:45:20 +0200

x86/fpu: Inline copy_user_to_fpregs_zeroing()

Start refactoring __fpu__restore_sig() by inlining
copy_user_to_fpregs_zeroing(). The original function remains and will be
used to restore from userland memory if possible.

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
Link: https://lkml.kernel.org/r/20190403164156.19645-21-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 9b9dfdc96285..c2ff43fbbd07 100644
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
