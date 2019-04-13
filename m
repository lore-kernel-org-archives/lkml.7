Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE9C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436092084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDMU6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:58:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDMU6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:58:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKvoru2266856
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:57:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKvnWA2266853;
        Sat, 13 Apr 2019 13:57:49 -0700
Date:   Sat, 13 Apr 2019 13:57:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-69277c98f5eef0d9839699b7825923c3985f665f@git.kernel.org>
Cc:     jannh@google.com, riel@surriel.com, dave.hansen@intel.com,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        pbonzini@redhat.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, rkrcmar@redhat.com,
        mingo@redhat.com, bp@suse.de, Jason@zx2c4.com, luto@kernel.org,
        tglx@linutronix.de
Reply-To: x86@kernel.org, jannh@google.com, riel@surriel.com,
          dave.hansen@intel.com, mingo@redhat.com, bp@suse.de,
          Jason@zx2c4.com, luto@kernel.org, tglx@linutronix.de,
          rkrcmar@redhat.com, mingo@kernel.org, hpa@zytor.com,
          kvm@vger.kernel.org, bigeasy@linutronix.de, pbonzini@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190403164156.19645-18-bigeasy@linutronix.de>
References: <20190403164156.19645-18-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Always store the registers in
 copy_fpstate_to_sigframe()
Git-Commit-ID: 69277c98f5eef0d9839699b7825923c3985f665f
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

Commit-ID:  69277c98f5eef0d9839699b7825923c3985f665f
Gitweb:     https://git.kernel.org/tip/69277c98f5eef0d9839699b7825923c3985f665f
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Wed, 3 Apr 2019 18:41:46 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 18:08:57 +0200

x86/fpu: Always store the registers in copy_fpstate_to_sigframe()

copy_fpstate_to_sigframe() stores the registers directly to user space.
This is okay because the FPU registers are valid and saving them
directly avoids saving them into kernel memory and making a copy.

However, this cannot be done anymore if the FPU registers are going
to be restored on the return to userland. It is possible that the FPU
registers will be invalidated in the middle of the save operation and
this should be done with disabled preemption / BH.

Save the FPU registers to the task's FPU struct and copy them to the
user memory later on.

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
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-18-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 155f4552413e..8f23f5237218 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -144,8 +144,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  *	buf == buf_fx for 64-bit frames and 32-bit fsave frame.
  *	buf != buf_fx for 32-bit frames with fxstate.
  *
- * Save the state directly to the user frame pointed by the aligned pointer
- * 'buf_fx'.
+ * Save the state to task's fpu->state and then copy it to the user frame
+ * pointed to by the aligned pointer 'buf_fx'.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -155,6 +155,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
+	struct fpu *fpu = &current->thread.fpu;
+	struct xregs_state *xsave = &fpu->state.xsave;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
 
@@ -169,9 +171,16 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			sizeof(struct user_i387_ia32_struct), NULL,
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
-	/* Save the live registers state to the user frame directly. */
-	if (copy_fpregs_to_sigframe(buf_fx))
-		return -1;
+	copy_fpregs_to_fpstate(fpu);
+
+	if (using_compacted_format()) {
+		if (copy_xstate_to_user(buf_fx, xsave, 0, size))
+			return -1;
+	} else {
+		fpstate_sanitize_xstate(fpu);
+		if (__copy_to_user(buf_fx, xsave, fpu_user_xstate_size))
+			return -1;
+	}
 
 	/* Save the fsave header for the 32-bit frames. */
 	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
