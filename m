Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75726C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB592075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfDPINW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:13:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfDPINV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:13:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3G8DCqF3352577
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 01:13:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3G8DBIU3352574;
        Tue, 16 Apr 2019 01:13:11 -0700
Date:   Tue, 16 Apr 2019 01:13:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-37a8f8590f307db8f8cfa62dfd82b3fc0978607c@git.kernel.org>
Cc:     bigeasy@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, john.ogness@linutronix.de,
        tglx@linutronix.de
Reply-To: bigeasy@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          john.ogness@linutronix.de
In-Reply-To: <20190403210821.10916-1-bigeasy@linutronix.de>
References: <20190403210821.10916-1-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Document that RT task priorities are
 1...99
Git-Commit-ID: 37a8f8590f307db8f8cfa62dfd82b3fc0978607c
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

Commit-ID:  37a8f8590f307db8f8cfa62dfd82b3fc0978607c
Gitweb:     https://git.kernel.org/tip/37a8f8590f307db8f8cfa62dfd82b3fc0978607c
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 23:08:21 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 10:06:08 +0200

sched/core: Document that RT task priorities are 1...99

John identified three files which claim that RT task priorities start at
zero. As far as I understand, 0 is used for DL and has nothing to do
wihich RT priorities as identified by the RT policy.

Correct the comment, valid RT priorities are in the range from 1 to 99.

Reported-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190403210821.10916-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/scheduler/sched-rt-group.txt | 2 +-
 include/linux/sched/prio.h                 | 2 +-
 kernel/sched/cpupri.h                      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.txt
index d8fce3e78457..23f8f8465a77 100644
--- a/Documentation/scheduler/sched-rt-group.txt
+++ b/Documentation/scheduler/sched-rt-group.txt
@@ -175,7 +175,7 @@ get their allocated time.
 
 Implementing SCHED_EDF might take a while to complete. Priority Inheritance is
 the biggest challenge as the current linux PI infrastructure is geared towards
-the limited static priority levels 0-99. With deadline scheduling you need to
+the limited static priority levels 1-99. With deadline scheduling you need to
 do deadline inheritance (since priority is inversely proportional to the
 deadline delta (deadline - now)).
 
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index 7d64feafc408..6986c3235684 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -8,7 +8,7 @@
 
 /*
  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
- * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
+ * priority is 1..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
  * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
  * values are inverted: lower p->prio value means higher priority.
  *
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index 7dc20a3232e7..40257a97fb8f 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -5,7 +5,7 @@
 #define CPUPRI_INVALID		-1
 #define CPUPRI_IDLE		 0
 #define CPUPRI_NORMAL		 1
-/* values 2-101 are RT priorities 0-99 */
+/* values 2-101 are RT priorities 1-99 */
 
 struct cpupri_vec {
 	atomic_t		count;
