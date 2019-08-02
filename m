Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330D7C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109492087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395134AbfHBPAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:00:07 -0400
Received: from foss.arm.com ([217.140.110.172]:53654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395109AbfHBO74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:59:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D591596;
        Fri,  2 Aug 2019 07:59:55 -0700 (PDT)
Received: from e107985-lin.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A650A3F575;
        Fri,  2 Aug 2019 07:59:54 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] sched/deadline: Cleanup on_dl_rq() handling
Date:   Fri,  2 Aug 2019 15:59:45 +0100
Message-Id: <20190802145945.18702-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802145945.18702-1-dietmar.eggemann@arm.com>
References: <20190802145945.18702-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove BUG_ON() in __enqueue_dl_entity() since there is already one in
enqueue_dl_entity().

Move the check that the dl_se is not on the dl_rq from
__dequeue_dl_entity() to dequeue_dl_entity() to align with the enqueue
side and use the on_dl_rq() helper function.

BUG_ON in dequeue_dl_entity() instead of silently return. Make this
possible by checking for !p->dl_throttled in dequeue_task_dl() before
calling __dequeue_task_dl(). update_curr_dl() will set
p->dl_throttled=1 in case it already calls __dequeue_task_dl().
The condition !p->dl_throttled && !on_dl_rq() is a BUG.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c34e35e7ac23..2add54c8be8a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1407,8 +1407,6 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 	struct sched_dl_entity *entry;
 	int leftmost = 1;
 
-	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
-
 	while (*link) {
 		parent = *link;
 		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
@@ -1430,9 +1428,6 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 
-	if (RB_EMPTY_NODE(&dl_se->rb_node))
-		return;
-
 	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
 	RB_CLEAR_NODE(&dl_se->rb_node);
 
@@ -1466,6 +1461,8 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 
 static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
 {
+	BUG_ON(!on_dl_rq(dl_se));
+
 	__dequeue_dl_entity(dl_se);
 }
 
@@ -1544,7 +1541,9 @@ static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	update_curr_dl(rq);
-	__dequeue_task_dl(rq, p, flags);
+
+	if (!p->dl.dl_throttled)
+		__dequeue_task_dl(rq, p, flags);
 
 	if (p->on_rq == TASK_ON_RQ_MIGRATING || flags & DEQUEUE_SAVE) {
 		sub_running_bw(&p->dl, &rq->dl);
-- 
2.17.1

