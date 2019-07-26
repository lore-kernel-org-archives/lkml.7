Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C38C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024C921994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfGZXqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfGZXqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C595785539;
        Fri, 26 Jul 2019 23:46:02 +0000 (UTC)
Received: from llong.com (ovpn-124-85.rdu2.redhat.com [10.10.124.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C2C319C69;
        Fri, 26 Jul 2019 23:45:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH] sched/core: Don't use dying mm as active_mm for kernel threads
Date:   Fri, 26 Jul 2019 19:45:41 -0400
Message-Id: <20190726234541.3771-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 26 Jul 2019 23:46:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that a dying mm_struct where the owning task has exited can
stay on as active_mm of kernel threads as long as no other user tasks
run on those CPUs that use it as active_mm. This prolongs the life time
of dying mm holding up memory and other resources that cannot be freed.

Fix that by forcing the kernel threads to use init_mm as the active_mm
if the previous active_mm is dying.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 13 +++++++++++--
 mm/init-mm.c        |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..ca348e1f5a1e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3233,13 +3233,22 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 * Both of these contain the full memory barrier required by
 	 * membarrier after storing to rq->curr, before returning to
 	 * user-space.
+	 *
+	 * If mm is NULL and oldmm is dying (!owner), we switch to
+	 * init_mm instead to make sure that oldmm can be freed ASAP.
 	 */
-	if (!mm) {
+	if (!mm && oldmm->owner) {
 		next->active_mm = oldmm;
 		mmgrab(oldmm);
 		enter_lazy_tlb(oldmm, next);
-	} else
+	} else {
+		if (!mm) {
+			mm = &init_mm;
+			next->active_mm = mm;
+			mmgrab(mm);
+		}
 		switch_mm_irqs_off(oldmm, mm, next);
+	}
 
 	if (!prev->mm) {
 		prev->active_mm = NULL;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index a787a319211e..5bfc6bc333ca 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/cpumask.h>
+#include <linux/sched/task.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -36,5 +37,6 @@ struct mm_struct init_mm = {
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+	.owner		= &init_task,
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.18.1

