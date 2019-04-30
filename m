Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8301C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A8820675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NUXAOg55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfD3Laq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:30:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfD3Lap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:30:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBUEME1350830
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:30:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBUEME1350830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623815;
        bh=WhZbhuJokP1cXy8dq38BMW62S+nhjuqIofFpVeNtwlQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NUXAOg55Kzf7uIAgTL+FyaFBlKrz37KJiHDG1ojJh7ufwY0QeJFI61DKfNNqmmMS4
         b6WocASQT10yd3d71erhssxC1uunXAZneiFIPCLJ18jA7mSNsVdqsXP4u44cMI+qCq
         ZZlsBkHlKWl6enDEUqSob8n6v9kknJsAtRMYYc6/8+dhZwkjMU84bniqHFu3/IXkB9
         Z9t0LA5nPJHKgIbzc1tzOOfmiGcVgiCWCo3wA/PpGmWzWS4Hf6ORGuqk1XIuQT+5M0
         8ROB2KsqZyXCnsH1feWvV1BWGYkx0akOFfWF4MyZTOg+s8ITwDBs+S84w0VmCHm8Y1
         a/myCNAbLxgCA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBUDqN1350825;
        Tue, 30 Apr 2019 04:30:13 -0700
Date:   Tue, 30 Apr 2019 04:30:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-531bd721812cad4b7f7158b246fba8303b555be7@git.kernel.org>
Cc:     luto@kernel.org, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        bigeasy@linutronix.de, peterz@infradead.org, tglx@linutronix.de,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        oleg@redhat.com
Reply-To: hpa@zytor.com, bp@alien8.de, fenghua.yu@intel.com,
          luto@kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, bigeasy@linutronix.de,
          mingo@kernel.org, tglx@linutronix.de, oleg@redhat.com,
          linux-kernel@vger.kernel.org, dave.hansen@intel.com
In-Reply-To: <20190430083126.rilbb76yc27vrem5@linutronix.de>
References: <20190430083126.rilbb76yc27vrem5@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Remove unnecessary saving of FPU registers
 in copy_fpstate_to_sigframe()
Git-Commit-ID: 531bd721812cad4b7f7158b246fba8303b555be7
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

Commit-ID:  531bd721812cad4b7f7158b246fba8303b555be7
Gitweb:     https://git.kernel.org/tip/531bd721812cad4b7f7158b246fba8303b555be7
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 30 Apr 2019 10:31:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 13:07:54 +0200

x86/fpu: Remove unnecessary saving of FPU registers in copy_fpstate_to_sigframe()

Since commit:

  eeec00d73be2e ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")

there is no need to have FPU registers saved if
copy_fpregs_to_sigframe() fails, because we retry it after we resolved
the fault condition.

Saving the registers is not wrong but it is not necessary and it forces us
to load the FPU registers on the retry attempt.

Don't save the FPU registers if copy_fpstate_to_sigframe() fails.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason@zx2c4.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@suse.de
Cc: jannh@google.com
Cc: kurt.kanzenbach@linutronix.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: riel@surriel.com
Cc: rkrcmar@redhat.com
Link: http://lkml.kernel.org/r/20190430083126.rilbb76yc27vrem5@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/fpu/signal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 6d6c2d6afde4..08c5059dc4ec 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -157,10 +157,9 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  */
 int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
-	struct fpu *fpu = &current->thread.fpu;
 	struct task_struct *tsk = current;
 	int ia32_fxstate = (buf != buf_fx);
-	int ret = -EFAULT;
+	int ret;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
@@ -187,9 +186,6 @@ retry:
 	pagefault_disable();
 	ret = copy_fpregs_to_sigframe(buf_fx);
 	pagefault_enable();
-	if (ret && !test_thread_flag(TIF_NEED_FPU_LOAD))
-		copy_fpregs_to_fpstate(fpu);
-	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 
 	if (ret) {
