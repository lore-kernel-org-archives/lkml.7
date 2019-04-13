Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0720C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2A82084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDMU7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:59:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDMU7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:59:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKwYHN2266938
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:58:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKwYvp2266935;
        Sat, 13 Apr 2019 13:58:34 -0700
Date:   Sat, 13 Apr 2019 13:58:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-a352a3b7b7920212ee4c45a41500c66826318e92@git.kernel.org>
Cc:     bigeasy@linutronix.de, hpa@zytor.com, dave.hansen@intel.com,
        tglx@linutronix.de, kvm@vger.kernel.org, bp@suse.de,
        rkrcmar@redhat.com, pbonzini@redhat.com, luto@kernel.org,
        mingo@redhat.com, mingo@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jason@zx2c4.com, riel@surriel.com,
        jannh@google.com
Reply-To: rkrcmar@redhat.com, pbonzini@redhat.com, bp@suse.de,
          kvm@vger.kernel.org, hpa@zytor.com, bigeasy@linutronix.de,
          dave.hansen@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
          luto@kernel.org, mingo@redhat.com, Jason@zx2c4.com,
          riel@surriel.com, jannh@google.com
In-Reply-To: <20190403164156.19645-19-bigeasy@linutronix.de>
References: <20190403164156.19645-19-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Prepare copy_fpstate_to_sigframe() for
 TIF_NEED_FPU_LOAD
Git-Commit-ID: a352a3b7b7920212ee4c45a41500c66826318e92
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

Commit-ID:  a352a3b7b7920212ee4c45a41500c66826318e92
Gitweb:     https://git.kernel.org/tip/a352a3b7b7920212ee4c45a41500c66826318e92
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Wed, 3 Apr 2019 18:41:47 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 18:20:04 +0200

x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD

The FPU registers need only to be saved if TIF_NEED_FPU_LOAD is not set.
Otherwise this has been already done and can be skipped.

 [ bp: Massage a bit. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
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
Link: https://lkml.kernel.org/r/20190403164156.19645-19-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 8f23f5237218..9b9dfdc96285 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -171,7 +171,17 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	copy_fpregs_to_fpstate(fpu);
+	/*
+	 * If we do not need to load the FPU registers at return to userspace
+	 * then the CPU has the current state and we need to save it. Otherwise,
+	 * it has already been done and we can skip it.
+	 */
+	fpregs_lock();
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		copy_fpregs_to_fpstate(fpu);
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+	}
+	fpregs_unlock();
 
 	if (using_compacted_format()) {
 		if (copy_xstate_to_user(buf_fx, xsave, 0, size))
