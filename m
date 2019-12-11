Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C9C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D216B22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfLKQoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:44:37 -0500
Received: from foss.arm.com ([217.140.110.172]:38628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfLKQof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:44:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 244FD31B;
        Wed, 11 Dec 2019 08:44:35 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AD893F52E;
        Wed, 11 Dec 2019 08:44:33 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 1/7] sched: Add WF_TTWU, WF_EXEC wakeup flags
Date:   Wed, 11 Dec 2019 16:43:55 +0000
Message-Id: <20191211164401.5013-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211164401.5013-1-valentin.schneider@arm.com>
References: <20191211164401.5013-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To remove the sd_flag parameter of select_task_rq(), we need another way of
encoding wakeup kinds. There already is a WF_FORK flag, add the missing
ones.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/sched.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..1936ab2faff0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1639,11 +1639,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 }
 
 /*
- * wake flags
+ * Wake flags
  */
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
-#define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
+#define WF_TTWU                 0x02            /* Regular task wakeup */
+#define WF_FORK			0x04		/* Child wakeup after fork */
+#define WF_EXEC			0x08		/* "Fake" wakeup at exec */
+#define WF_MIGRATED		0x10		/* Internal use, task got migrated */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
-- 
2.24.0

