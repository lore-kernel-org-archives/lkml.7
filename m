Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D32720856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139907;
	bh=TcJGiK/14Nxwj+qaIVKcpNBi8zgouqjN1Nd0xz9Mqhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rErj7X5cHaf7KClWOKwVjd8hETVdyjP1inqC0nr4mal5Ie3vTAGs/1xk6LwqNPtP
	 oxHwLWdGhXiyONLnSesmSIhY08tSkeYtHMjSkSLXnhNzrHr9rT5XQGtcXDp9U3Qd4Y
	 wEjbcv+YIozxzBJLkyabMeAlan7h4raqY7+LyN6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbfDARbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733281AbfDARbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB36A2070B;
        Mon,  1 Apr 2019 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139900;
        bh=TcJGiK/14Nxwj+qaIVKcpNBi8zgouqjN1Nd0xz9Mqhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oV+knyusEtDkAOyVn+YQ7FSXRP/bVt13bJLEcA+9DLZXmfN0UFSjearKtoh2IZdIL
         VHw0O8N+9U1dm5M/aQsyjPc3u4ZZ222+N1wZc6g0063OldzoX4bzxHsLEuqWL6QOId
         kcoeZjGtewNmRw1/VdhK5e9mY2n7VyPdAiK2kK7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Muckle <steve.muckle@linaro.org>,
        Yuyang Du <yuyang.du@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <Juri.Lelli@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 040/131] sched/fair: Fix new tasks load avg removed from source CPU in wake_up_new_task()
Date:   Mon,  1 Apr 2019 19:01:50 +0200
Message-Id: <20190401170055.666989726@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0905f04eb21fc1c2e690bed5d0418a061d56c225 ]

If a newly created task is selected to go to a different CPU in fork
balance when it wakes up the first time, its load averages should
not be removed from the source CPU since they are never added to
it before. The same is also applicable to a never used group entity.

Fix it in remove_entity_load_avg(): when entity's last_update_time
is 0, simply return. This should precisely identify the case in
question, because in other migrations, the last_update_time is set
to 0 after remove_entity_load_avg().

Reported-by: Steve Muckle <steve.muckle@linaro.org>
Signed-off-by: Yuyang Du <yuyang.du@intel.com>
[peterz: cfs_rq_last_update_time]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <Juri.Lelli@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/20151216233427.GJ28098@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c2af250547bb..6051007918ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2841,27 +2841,45 @@ dequeue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		max_t(s64,  cfs_rq->runnable_load_sum - se->avg.load_sum, 0);
 }
 
-/*
- * Task first catches up with cfs_rq, and then subtract
- * itself from the cfs_rq (task must be off the queue now).
- */
-void remove_entity_load_avg(struct sched_entity *se)
-{
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	u64 last_update_time;
-
 #ifndef CONFIG_64BIT
+static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
+{
 	u64 last_update_time_copy;
+	u64 last_update_time;
 
 	do {
 		last_update_time_copy = cfs_rq->load_last_update_time_copy;
 		smp_rmb();
 		last_update_time = cfs_rq->avg.last_update_time;
 	} while (last_update_time != last_update_time_copy);
+
+	return last_update_time;
+}
 #else
-	last_update_time = cfs_rq->avg.last_update_time;
+static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->avg.last_update_time;
+}
 #endif
 
+/*
+ * Task first catches up with cfs_rq, and then subtract
+ * itself from the cfs_rq (task must be off the queue now).
+ */
+void remove_entity_load_avg(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	u64 last_update_time;
+
+	/*
+	 * Newly created task or never used group entity should not be removed
+	 * from its (source) cfs_rq
+	 */
+	if (se->avg.last_update_time == 0)
+		return;
+
+	last_update_time = cfs_rq_last_update_time(cfs_rq);
+
 	__update_load_avg(last_update_time, cpu_of(rq_of(cfs_rq)), &se->avg, 0, 0, NULL);
 	atomic_long_add(se->avg.load_avg, &cfs_rq->removed_load_avg);
 	atomic_long_add(se->avg.util_avg, &cfs_rq->removed_util_avg);
-- 
2.19.1



