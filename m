Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC74C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4F820645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZJOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:14:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:10040 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfFZJOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:14:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 02:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="166973917"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2019 02:14:19 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, will.deacon@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Fix exclusive events' grouping
Date:   Wed, 26 Jun 2019 12:14:09 +0300
Message-Id: <20190626091409.47637-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, we tried to disallow grouping exclusive events for the fear of
complications they would cause with moving between contexts. Specifically,
moving a software group to a hardware context would violate the exclusivity
rules if both groups contain matching exclusive events.

This attempt was, however, unsuccessful: the check that we have in the
perf_event_open() syscall is both wrong (looks at wrong PMU) and
insufficient (group leader may still be exclusive), as can be illustrated
by running

$ perf record -e '{intel_pt//,cycles}' uname
$ perf record -e '{cycles,intel_pt//}' uname

ultimately successfully.

Furthermore, we are completely free to trigger the exclusivity violation
by -e '{cycles,intel_pt//}' -e '{intel_pt//,instructions}', even though
the helpful perf record will not allow that, the ABI will. The warning
later in the perf_event_open() path will also not trigger, because it's
also wrong.

Fix all this by validating the original group before moving, getting rid
of broken safeguards and placing a useful one to perf_install_in_context().
And while at it, place exclusive events on their own list to avoid
iterating through all events.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: bed5b25ad9c8a ("perf: Add a pmu capability for "exclusive" events")
---
 include/linux/perf_event.h | 12 +++++++++++
 kernel/events/core.c       | 41 ++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2ddae518dce6..3fdb5cbd22ae 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -574,6 +574,12 @@ struct perf_event {
 	 */
 	struct list_head		sibling_list;
 	struct list_head		active_list;
+
+	/*
+	 * Link to ctx::exclusive_list
+	 */
+	struct list_head		exclusive_entry;
+
 	/*
 	 * Node on the pinned or flexible tree located at the event context;
 	 */
@@ -739,6 +745,7 @@ struct perf_event_context {
 	struct perf_event_groups	pinned_groups;
 	struct perf_event_groups	flexible_groups;
 	struct list_head		event_list;
+	struct list_head		exclusive_list;
 
 	struct list_head		pinned_active;
 	struct list_head		flexible_active;
@@ -1054,6 +1061,11 @@ static inline int in_software_context(struct perf_event *event)
 	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
 }
 
+static inline int is_exclusive_pmu(struct pmu *pmu)
+{
+	return pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE;
+}
+
 extern struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
 
 extern void ___perf_sw_event(u32, u64, struct pt_regs *, u64);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23efe6792abc..7a159af28206 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1688,6 +1688,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
 
+	if (is_exclusive_pmu(event->pmu))
+		list_add_rcu(&event->exclusive_entry, &ctx->exclusive_list);
 	ctx->generation++;
 }
 
@@ -1871,6 +1873,9 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	list_del_rcu(&event->event_entry);
 
+	if (is_exclusive_pmu(event->pmu))
+		list_del_rcu(&event->exclusive_entry);
+
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
@@ -2553,6 +2558,9 @@ static int  __perf_install_in_context(void *info)
 	return ret;
 }
 
+static bool exclusive_event_installable(struct perf_event *event,
+					struct perf_event_context *ctx);
+
 /*
  * Attach a performance event to a context.
  *
@@ -2567,6 +2575,8 @@ perf_install_in_context(struct perf_event_context *ctx,
 
 	lockdep_assert_held(&ctx->mutex);
 
+	WARN_ON_ONCE(!exclusive_event_installable(event, ctx));
+
 	if (event->cpu != -1)
 		event->cpu = cpu;
 
@@ -4071,6 +4081,7 @@ static void __perf_event_init_context(struct perf_event_context *ctx)
 	INIT_LIST_HEAD(&ctx->event_list);
 	INIT_LIST_HEAD(&ctx->pinned_active);
 	INIT_LIST_HEAD(&ctx->flexible_active);
+	INIT_LIST_HEAD(&ctx->exclusive_list);
 	refcount_set(&ctx->refcount, 1);
 }
 
@@ -4360,7 +4371,7 @@ static int exclusive_event_init(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
 
-	if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE))
+	if (!is_exclusive_pmu(pmu))
 		return 0;
 
 	/*
@@ -4391,7 +4402,7 @@ static void exclusive_event_destroy(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
 
-	if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE))
+	if (!is_exclusive_pmu(pmu))
 		return;
 
 	/* see comment in exclusive_event_init() */
@@ -4411,17 +4422,18 @@ static bool exclusive_event_match(struct perf_event *e1, struct perf_event *e2)
 	return false;
 }
 
-/* Called under the same ctx::mutex as perf_install_in_context() */
 static bool exclusive_event_installable(struct perf_event *event,
 					struct perf_event_context *ctx)
 {
 	struct perf_event *iter_event;
 	struct pmu *pmu = event->pmu;
 
-	if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE))
+	lockdep_assert_held(&ctx->mutex);
+
+	if (!is_exclusive_pmu(pmu))
 		return true;
 
-	list_for_each_entry(iter_event, &ctx->event_list, event_entry) {
+	list_for_each_entry(iter_event, &ctx->exclusive_list, exclusive_entry) {
 		if (exclusive_event_match(iter_event, event))
 			return false;
 	}
@@ -10917,11 +10929,6 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_alloc;
 	}
 
-	if ((pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE) && group_leader) {
-		err = -EBUSY;
-		goto err_context;
-	}
-
 	/*
 	 * Look up the group leader (we will attach this event to it):
 	 */
@@ -11009,6 +11016,17 @@ SYSCALL_DEFINE5(perf_event_open,
 				move_group = 0;
 			}
 		}
+
+		/*
+		 * Failure to create exclusive events returns -EBUSY.
+		 */
+		err = -EBUSY;
+		if (!exclusive_event_installable(group_leader, ctx))
+			goto err_locked;
+
+		for_each_sibling_event(sibling, group_leader)
+			if (!exclusive_event_installable(sibling, ctx))
+				goto err_locked;
 	} else {
 		mutex_lock(&ctx->mutex);
 	}
@@ -11045,9 +11063,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	 * because we need to serialize with concurrent event creation.
 	 */
 	if (!exclusive_event_installable(event, ctx)) {
-		/* exclusive and group stuff are assumed mutually exclusive */
-		WARN_ON_ONCE(move_group);
-
 		err = -EBUSY;
 		goto err_locked;
 	}
-- 
2.20.1

