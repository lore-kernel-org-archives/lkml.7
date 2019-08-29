Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93565C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720352189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfH2MAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:00:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2MAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:00:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3J6B-0001zx-Bn; Thu, 29 Aug 2019 14:00:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9DD1A1C07C3;
        Thu, 29 Aug 2019 14:00:18 +0200 (CEST)
Date:   Thu, 29 Aug 2019 12:00:18 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Make expiry_active check
 actually work correctly
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156708001844.5526.1400646883200520277.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a2ed4fd685cd23e98922f933d5dbccfbe82a4f08
Gitweb:        https://git.kernel.org/tip/a2ed4fd685cd23e98922f933d5dbccfbe82a4f08
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Aug 2019 12:52:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2019 12:52:28 +02:00

posix-cpu-timers: Make expiry_active check actually work correctly

The state tracking changes broke the expiry active check by not writing to
it and instead sitting timers_active, which is already set.

That's not a big issue as the actual expiry is protected by sighand lock,
so concurrent handling is not possible. That means that the second task
which invokes that function executes the expiry code for nothing.

Write to the proper flag.

Also add a check whether the flag is set into check_process_timers(). That
check had been missing in the code before the rework already. The check for
another task handling the expiry of process wide timers was only done in
the fastpath check. If the fastpath check returns true because a per task
timer expired, then the checking of process wide timers was done in
parallel which is as explained above just a waste of cycles.

Fixes: 244d49e30653 ("posix-cpu-timers: Move state tracking to struct posix_cputimers")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-cpu-timers.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 73c492c..c3a95b1 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -884,16 +884,17 @@ static void check_process_timers(struct task_struct *tsk,
 
 	/*
 	 * If there are no active process wide timers (POSIX 1.b, itimers,
-	 * RLIMIT_CPU) nothing to check.
+	 * RLIMIT_CPU) nothing to check. Also skip the process wide timer
+	 * processing when there is already another task handling them.
 	 */
-	if (!READ_ONCE(pct->timers_active))
+	if (!READ_ONCE(pct->timers_active) || pct->expiry_active)
 		return;
 
-       /*
+	/*
 	 * Signify that a thread is checking for process timers.
 	 * Write access to this field is protected by the sighand lock.
 	 */
-	pct->timers_active = true;
+	pct->expiry_active = true;
 
 	/*
 	 * Collect the current process totals. Group accounting is active
