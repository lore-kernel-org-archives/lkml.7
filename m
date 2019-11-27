Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5CEC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CD42071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfK0ITi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:19:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43964 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfK0ITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXp-0002Pb-LI; Wed, 27 Nov 2019 09:19:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4BE171C1E6D;
        Wed, 27 Nov 2019 09:19:29 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:29 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ptrace: Remove set_segment_reg()
 implementations for current
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484276921.21853.10028026818717673035.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8e05f1b4f27d07a0f93e7c6fd28525a5d082b85c
Gitweb:        https://git.kernel.org/tip/8e05f1b4f27d07a0f93e7c6fd28525a5d082b85c
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Mon, 15 Jul 2019 10:08:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 22:00:12 +01:00

x86/ptrace: Remove set_segment_reg() implementations for current

seg_segment_reg() should be unreachable with task == current.
Rather than confusingly trying to make it work, just explicitly
disable this case.

(regset->get is used for current in the coredump code, but the ->set
 interface is only used for ptrace, and you can't ptrace yourself.)

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/ptrace.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 066e5b0..3b3b169 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -182,6 +182,9 @@ static u16 get_segment_reg(struct task_struct *task, unsigned long offset)
 static int set_segment_reg(struct task_struct *task,
 			   unsigned long offset, u16 value)
 {
+	if (WARN_ON_ONCE(task == current))
+		return -EIO;
+
 	/*
 	 * The value argument was already truncated to 16 bits.
 	 */
@@ -209,10 +212,7 @@ static int set_segment_reg(struct task_struct *task,
 		break;
 
 	case offsetof(struct user_regs_struct, gs):
-		if (task == current)
-			set_user_gs(task_pt_regs(task), value);
-		else
-			task_user_gs(task) = value;
+		task_user_gs(task) = value;
 	}
 
 	return 0;
@@ -272,6 +272,9 @@ static u16 get_segment_reg(struct task_struct *task, unsigned long offset)
 static int set_segment_reg(struct task_struct *task,
 			   unsigned long offset, u16 value)
 {
+	if (WARN_ON_ONCE(task == current))
+		return -EIO;
+
 	/*
 	 * The value argument was already truncated to 16 bits.
 	 */
@@ -281,23 +284,15 @@ static int set_segment_reg(struct task_struct *task,
 	switch (offset) {
 	case offsetof(struct user_regs_struct,fs):
 		task->thread.fsindex = value;
-		if (task == current)
-			loadsegment(fs, task->thread.fsindex);
 		break;
 	case offsetof(struct user_regs_struct,gs):
 		task->thread.gsindex = value;
-		if (task == current)
-			load_gs_index(task->thread.gsindex);
 		break;
 	case offsetof(struct user_regs_struct,ds):
 		task->thread.ds = value;
-		if (task == current)
-			loadsegment(ds, task->thread.ds);
 		break;
 	case offsetof(struct user_regs_struct,es):
 		task->thread.es = value;
-		if (task == current)
-			loadsegment(es, task->thread.es);
 		break;
 
 		/*
