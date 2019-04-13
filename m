Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7307CC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9902147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDMVFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:05:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54871 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfDMVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:05:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DL4Q3h2269420
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 14:04:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DL4PiC2269417;
        Sat, 13 Apr 2019 14:04:25 -0700
Date:   Sat, 13 Apr 2019 14:04:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-06b251dff78704c7d122bd109384d970a7dbe94d@git.kernel.org>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, x86@kernel.org,
        mingo@kernel.org, mingo@redhat.com, Jason@zx2c4.com,
        kvm@vger.kernel.org, dave.hansen@intel.com, riel@surriel.com,
        luto@kernel.org, bp@suse.de, bigeasy@linutronix.de,
        tglx@linutronix.de, jannh@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, jannh@google.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
          bigeasy@linutronix.de, kvm@vger.kernel.org,
          dave.hansen@intel.com, riel@surriel.com, luto@kernel.org,
          Jason@zx2c4.com, mingo@kernel.org, mingo@redhat.com,
          x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com
In-Reply-To: <20190403164156.19645-27-bigeasy@linutronix.de>
References: <20190403164156.19645-27-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Restore regs in copy_fpstate_to_sigframe()
 in order to use the fastpath
Git-Commit-ID: 06b251dff78704c7d122bd109384d970a7dbe94d
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

Commit-ID:  06b251dff78704c7d122bd109384d970a7dbe94d
Gitweb:     https://git.kernel.org/tip/06b251dff78704c7d122bd109384d970a7dbe94d
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 12 Apr 2019 20:16:15 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 12 Apr 2019 20:16:15 +0200

x86/fpu: Restore regs in copy_fpstate_to_sigframe() in order to use the fastpath

If a task is scheduled out and receives a signal then it won't be
able to take the fastpath because the registers aren't available. The
slowpath is more expensive compared to XRSTOR + XSAVE which usually
succeeds.

Here are some clock_gettime() numbers from a bigger box with AVX512
during bootup:

- __fpregs_load_activate() takes 140ns - 350ns. If it was the most recent
  FPU context on the CPU then the optimisation in __fpregs_load_activate()
  will skip the load (which was disabled during the test).

- copy_fpregs_to_sigframe() takes 200ns - 450ns if it succeeds. On a
  pagefault it is 1.8us - 3us usually in the 2.6us area.

- The slowpath takes 1.5us - 6us. Usually in the 2.6us area.

My testcases (including lat_sig) take the fastpath without
__fpregs_load_activate(). I expect this to be the majority.

Since the slowpath is in the >1us area it makes sense to load the
registers and attempt to save them directly. The direct save may fail
but should only happen on the first invocation or after fork() while the
page is read-only.

 [ bp: Massage a bit. ]

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
Link: https://lkml.kernel.org/r/20190403164156.19645-27-bigeasy@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 3c3167576216..7026f1c4e5e3 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -175,20 +175,21 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 			(struct _fpstate_32 __user *) buf) ? -1 : 1;
 
 	/*
-	 * If we do not need to load the FPU registers at return to userspace
-	 * then the CPU has the current state. Try to save it directly to
-	 * userland's stack frame if it does not cause a pagefault. If it does,
-	 * try the slowpath.
+	 * Load the FPU registers if they are not valid for the current task.
+	 * With a valid FPU state we can attempt to save the state directly to
+	 * userland's stack frame which will likely succeed. If it does not, do
+	 * the slowpath.
 	 */
 	fpregs_lock();
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		pagefault_disable();
-		ret = copy_fpregs_to_sigframe(buf_fx);
-		pagefault_enable();
-		if (ret)
-			copy_fpregs_to_fpstate(fpu);
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-	}
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
+
+	pagefault_disable();
+	ret = copy_fpregs_to_sigframe(buf_fx);
+	pagefault_enable();
+	if (ret && !test_thread_flag(TIF_NEED_FPU_LOAD))
+		copy_fpregs_to_fpstate(fpu);
+	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 
 	if (ret) {
