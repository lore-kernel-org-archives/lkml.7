Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95288C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686792082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCVIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:08:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:08:37 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBn7Y-0000mx-HO; Wed, 03 Apr 2019 23:08:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH] =?UTF-8?q?sched:=20Document=20that=20RT=20task=20prioriti?= =?UTF-8?q?es=20are=201=E2=80=A699?=
Date:   Wed,  3 Apr 2019 23:08:21 +0200
Message-Id: <20190403210821.10916-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John identified three files which claim that RT task priorities start at
zero. As far as I understand, 0 is used for DL and has nothing to do
wihich RT priorities as identified by the RT policy.

Correct the comment, valid RT priorities are in the range from 1 to 99.

Reported-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/scheduler/sched-rt-group.txt | 2 +-
 include/linux/sched/prio.h                 | 2 +-
 kernel/sched/cpupri.h                      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.txt b/Documentation/scheduler/sched-rt-group.txt
index d8fce3e784574..23f8f8465a775 100644
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
index 7d64feafc408e..6986c32356842 100644
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
index 7dc20a3232e72..40257a97fb8f2 100644
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
-- 
2.20.1

