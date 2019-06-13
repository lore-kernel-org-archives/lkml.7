Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD749C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1823207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfFMO7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 10:59:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35419 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732600AbfFMOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:50:43 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hbR3n-0002Ty-FI; Thu, 13 Jun 2019 16:50:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/6] workqueue: Use swait for wq_manager_wait
Date:   Thu, 13 Jun 2019 16:50:26 +0200
Message-Id: <20190613145027.27753-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613145027.27753-1-bigeasy@linutronix.de>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the workqueue code use raw_spinlock_t typed locking there
must not be a spinlock_t typed lock be acquired. A wait_queue_head uses
a spinlock_t lock for its list protection.

Use a swait based queue head to avoid raw_spinlock_t -> spinlock_t
locking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a3c2959e5c4f0..f27a57fce5079 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -50,6 +50,7 @@
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
+#include <linux/swait.h>
 
 #include "workqueue_internal.h"
 
@@ -301,7 +302,7 @@ static struct workqueue_attrs *wq_update_unbound_numa_attrs_buf;
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
 static DEFINE_SPINLOCK(wq_mayday_lock);	/* protects wq->maydays list */
-static DECLARE_WAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
+static DECLARE_SWAIT_QUEUE_HEAD(wq_manager_wait); /* wait for manager to go away */
 
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
@@ -2143,7 +2144,7 @@ static bool manage_workers(struct worker *worker)
 
 	pool->manager = NULL;
 	pool->flags &= ~POOL_MANAGER_ACTIVE;
-	wake_up(&wq_manager_wait);
+	swake_up_one(&wq_manager_wait);
 	return true;
 }
 
@@ -3538,7 +3539,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * manager and @pool gets freed with the flag set.
 	 */
 	spin_lock_irq(&pool->lock);
-	wait_event_lock_irq(wq_manager_wait,
+	swait_event_lock_irq(wq_manager_wait,
 			    !(pool->flags & POOL_MANAGER_ACTIVE), pool->lock);
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
-- 
2.20.1

