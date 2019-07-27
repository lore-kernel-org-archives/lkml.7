Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C34C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373C420693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 17:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfG0RLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 13:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfG0RLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 13:11:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1918236899;
        Sat, 27 Jul 2019 17:11:38 +0000 (UTC)
Received: from llong.com (ovpn-120-96.rdu2.redhat.com [10.10.120.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBFDB1001B07;
        Sat, 27 Jul 2019 17:11:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] sched/core: Don't use dying mm as active_mm of kthreads
Date:   Sat, 27 Jul 2019 13:10:47 -0400
Message-Id: <20190727171047.31610-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 27 Jul 2019 17:11:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that a dying mm_struct where the owning task has exited
can stay on as active_mm of kernel threads as long as no other user
tasks run on those CPUs that use it as active_mm. This prolongs the
life time of dying mm holding up memory and other resources like swap
space that cannot be freed.

Fix that by forcing the kernel threads to use init_mm as the active_mm
if the previous active_mm is dying.

The determination of a dying mm is based on the absence of an owning
task. The selection of the owning task only happens with the CONFIG_MEMCG
option. Without that, there is no simple way to determine the life span
of a given mm. So it falls back to the old behavior.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mm_types.h | 15 +++++++++++++++
 kernel/sched/core.c      | 13 +++++++++++--
 mm/init-mm.c             |  4 ++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3a37a89eb7a7..32712e78763c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -623,6 +623,21 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending) > 1;
 }
 
+#ifdef CONFIG_MEMCG
+/*
+ * A mm is considered dying if there is no owning task.
+ */
+static inline bool mm_dying(struct mm_struct *mm)
+{
+	return !mm->owner;
+}
+#else
+static inline bool mm_dying(struct mm_struct *mm)
+{
+	return false;
+}
+#endif
+
 struct vm_fault;
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..923a63262dfd 100644
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
+	if (!mm && !mm_dying(oldmm)) {
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
index a787a319211e..69090a11249c 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/cpumask.h>
+#include <linux/sched/task.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -36,5 +37,8 @@ struct mm_struct init_mm = {
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+#ifdef CONFIG_MEMCG
+	.owner		= &init_task,
+#endif
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.18.1

