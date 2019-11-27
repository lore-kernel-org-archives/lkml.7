Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71217C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442D72071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfK0IUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:20:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43968 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0ITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXp-0002Pa-Iz; Wed, 27 Nov 2019 09:19:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1F1811C004F;
        Wed, 27 Nov 2019 09:19:29 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:28 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ptrace: Document FSBASE and GSBASE ABI oddities
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484276896.21853.7610159468997605731.tip-bot2@tip-bot2>
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

Commit-ID:     56f2ab41b652251f336a0f471b1033afeaedd161
Gitweb:        https://git.kernel.org/tip/56f2ab41b652251f336a0f471b1033afeaedd161
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 17 Jul 2019 06:44:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 22:00:12 +01:00

x86/ptrace: Document FSBASE and GSBASE ABI oddities

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/ptrace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 3b3b169..f0e1ddb 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -281,6 +281,20 @@ static int set_segment_reg(struct task_struct *task,
 	if (invalid_selector(value))
 		return -EIO;
 
+	/*
+	 * This function has some ABI oddities.
+	 *
+	 * A 32-bit ptracer probably expects that writing FS or GS will change
+	 * FSBASE or GSBASE respectively.  In the absence of FSGSBASE support,
+	 * this code indeed has that effect.  When FSGSBASE is added, this
+	 * will require a special case.
+	 *
+	 * For existing 64-bit ptracers, writing FS or GS *also* currently
+	 * changes the base if the selector is nonzero the next time the task
+	 * is run.  This behavior may not be needed, and trying to preserve it
+	 * when FSGSBASE is added would be complicated at best.
+	 */
+
 	switch (offset) {
 	case offsetof(struct user_regs_struct,fs):
 		task->thread.fsindex = value;
@@ -370,6 +384,9 @@ static int putreg(struct task_struct *child,
 		 * When changing the FS base, use do_arch_prctl_64()
 		 * to set the index to zero and to set the base
 		 * as requested.
+		 *
+		 * NB: This behavior is nonsensical and likely needs to
+		 * change when FSGSBASE support is added.
 		 */
 		if (child->thread.fsbase != value)
 			return do_arch_prctl_64(child, ARCH_SET_FS, value);
