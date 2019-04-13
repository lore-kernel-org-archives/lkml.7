Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC2C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CA02084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfDMUuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:50:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfDMUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:50:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKmhx62265251
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:48:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKmhVk2265248;
        Sat, 13 Apr 2019 13:48:43 -0700
Date:   Sat, 13 Apr 2019 13:48:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-88f5260a3bf9bfb276b5b4aac2e81587e425a1d7@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, kvm@vger.kernel.org,
        aubrey.li@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, rkrcmar@redhat.com,
        luto@kernel.org, bigeasy@linutronix.de, pbonzini@redhat.com,
        jannh@google.com, mingo@redhat.com, Jason@zx2c4.com,
        nstange@suse.de, riel@surriel.com, dave.hansen@intel.com,
        billm@melbpc.org.au
Reply-To: dave.hansen@intel.com, billm@melbpc.org.au, nstange@suse.de,
          riel@surriel.com, mingo@redhat.com, Jason@zx2c4.com,
          rkrcmar@redhat.com, luto@kernel.org, pbonzini@redhat.com,
          bigeasy@linutronix.de, jannh@google.com, mingo@kernel.org,
          tglx@linutronix.de, aubrey.li@intel.com, kvm@vger.kernel.org,
          linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
          bp@suse.de
In-Reply-To: <20190403164156.19645-5-bigeasy@linutronix.de>
References: <20190403164156.19645-5-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Always init the state in fpu__clear()
Git-Commit-ID: 88f5260a3bf9bfb276b5b4aac2e81587e425a1d7
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

Commit-ID:  88f5260a3bf9bfb276b5b4aac2e81587e425a1d7
Gitweb:     https://git.kernel.org/tip/88f5260a3bf9bfb276b5b4aac2e81587e425a1d7
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:33 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Apr 2019 19:28:06 +0200

x86/fpu: Always init the state in fpu__clear()

fpu__clear() only initializes the state if the CPU has FPU support.
This initialisation is also required for FPU-less systems and takes
place in math_emulate(). Since fpu__initialize() only performs the
initialization if ->initialized is zero it does not matter that it
is invoked each time an opcode is emulated. It makes the removal of
->initialized easier if the struct is also initialized in the FPU-less
case at the same time.

Move fpu__initialize() before the FPU feature check so it is also
performed in the FPU-less case too.

 [ bp: Massage a bit. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Bill Metzenthen <billm@melbpc.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-5-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 1 -
 arch/x86/kernel/fpu/core.c          | 5 ++---
 arch/x86/math-emu/fpu_entry.c       | 3 ---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 75a1d5f712ee..70ecb7c032cb 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -24,7 +24,6 @@
 /*
  * High level FPU state handling functions:
  */
-extern void fpu__initialize(struct fpu *fpu);
 extern void fpu__prepare_read(struct fpu *fpu);
 extern void fpu__prepare_write(struct fpu *fpu);
 extern void fpu__save(struct fpu *fpu);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1940319268ae..e43296854e37 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -223,7 +223,7 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
  * Activate the current task's in-memory FPU context,
  * if it has not been used before:
  */
-void fpu__initialize(struct fpu *fpu)
+static void fpu__initialize(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
@@ -236,7 +236,6 @@ void fpu__initialize(struct fpu *fpu)
 		fpu->initialized = 1;
 	}
 }
-EXPORT_SYMBOL_GPL(fpu__initialize);
 
 /*
  * This function must be called before we read a task's fpstate.
@@ -365,8 +364,8 @@ void fpu__clear(struct fpu *fpu)
 	/*
 	 * Make sure fpstate is cleared and initialized.
 	 */
+	fpu__initialize(fpu);
 	if (static_cpu_has(X86_FEATURE_FPU)) {
-		fpu__initialize(fpu);
 		user_fpu_begin();
 		copy_init_fpstate_to_fpregs();
 	}
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 9e2ba7e667f6..a873da6b46d6 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -113,9 +113,6 @@ void math_emulate(struct math_emu_info *info)
 	unsigned long code_base = 0;
 	unsigned long code_limit = 0;	/* Initialized to stop compiler warnings */
 	struct desc_struct code_descriptor;
-	struct fpu *fpu = &current->thread.fpu;
-
-	fpu__initialize(fpu);
 
 #ifdef RE_ENTRANT_CHECKING
 	if (emulating) {
