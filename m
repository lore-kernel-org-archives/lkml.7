Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475DDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CBB22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfH1Na2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:30:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1Na2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:30:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2y1h-0004Jp-Nm; Wed, 28 Aug 2019 15:30:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 53D921C07D2;
        Wed, 28 Aug 2019 15:30:17 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:30:17 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Allow normal events to output AUX data
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        kan.liang@linux.intel.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190806084606.4021-2-alexander.shishkin@linux.intel.com>
References: <20190806084606.4021-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156699901719.4858.12786762701473177634.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ab43762ef010967e4ccd53627f70a2eecbeafefb
Gitweb:        https://git.kernel.org/tip/ab43762ef010967e4ccd53627f70a2eecbeafefb
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Tue, 06 Aug 2019 11:46:00 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Aug 2019 11:29:38 +02:00

perf: Allow normal events to output AUX data

In some cases, ordinary (non-AUX) events can generate data for AUX events.
For example, PEBS events can come out as records in the Intel PT stream
instead of their usual DS records, if configured to do so.

One requirement for such events is to consistently schedule together, to
ensure that the data from the "AUX output" events isn't lost while their
corresponding AUX event is not scheduled. We use grouping to provide this
guarantee: an "AUX output" event can be added to a group where an AUX event
is a group leader, and provided that the former supports writing to the
latter.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: kan.liang@linux.intel.com
Link: https://lkml.kernel.org/r/20190806084606.4021-2-alexander.shishkin@linux.intel.com
---
 include/linux/perf_event.h      | 14 +++++-
 include/uapi/linux/perf_event.h |  3 +-
 kernel/events/core.c            | 93 ++++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e8ad3c5..61448c1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -246,6 +246,7 @@ struct perf_event;
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
 #define PERF_PMU_CAP_NO_EXCLUDE			0x80
+#define PERF_PMU_CAP_AUX_OUTPUT			0x100
 
 /**
  * struct pmu - generic performance monitoring unit
@@ -447,6 +448,16 @@ struct pmu {
 					/* optional */
 
 	/*
+	 * Check if event can be used for aux_output purposes for
+	 * events of this PMU.
+	 *
+	 * Runs from perf_event_open(). Should return 0 for "no match"
+	 * or non-zero for "match".
+	 */
+	int (*aux_output_match)		(struct perf_event *event);
+					/* optional */
+
+	/*
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
@@ -681,6 +692,9 @@ struct perf_event {
 	struct perf_addr_filter_range	*addr_filter_ranges;
 	unsigned long			addr_filters_gen;
 
+	/* for aux_output events */
+	struct perf_event		*aux_event;
+
 	void (*destroy)(struct perf_event *);
 	struct rcu_head			rcu_head;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd..bb7b271 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_output     :  1, /* generate AUX records instead of events */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c11..2aad959 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1887,6 +1887,89 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	ctx->generation++;
 }
 
+static int
+perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
+{
+	if (!has_aux(aux_event))
+		return 0;
+
+	if (!event->pmu->aux_output_match)
+		return 0;
+
+	return event->pmu->aux_output_match(aux_event);
+}
+
+static void put_event(struct perf_event *event);
+static void event_sched_out(struct perf_event *event,
+			    struct perf_cpu_context *cpuctx,
+			    struct perf_event_context *ctx);
+
+static void perf_put_aux_event(struct perf_event *event)
+{
+	struct perf_event_context *ctx = event->ctx;
+	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_event *iter;
+
+	/*
+	 * If event uses aux_event tear down the link
+	 */
+	if (event->aux_event) {
+		iter = event->aux_event;
+		event->aux_event = NULL;
+		put_event(iter);
+		return;
+	}
+
+	/*
+	 * If the event is an aux_event, tear down all links to
+	 * it from other events.
+	 */
+	for_each_sibling_event(iter, event->group_leader) {
+		if (iter->aux_event != event)
+			continue;
+
+		iter->aux_event = NULL;
+		put_event(event);
+
+		/*
+		 * If it's ACTIVE, schedule it out and put it into ERROR
+		 * state so that we don't try to schedule it again. Note
+		 * that perf_event_enable() will clear the ERROR status.
+		 */
+		event_sched_out(iter, cpuctx, ctx);
+		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+	}
+}
+
+static int perf_get_aux_event(struct perf_event *event,
+			      struct perf_event *group_leader)
+{
+	/*
+	 * Our group leader must be an aux event if we want to be
+	 * an aux_output. This way, the aux event will precede its
+	 * aux_output events in the group, and therefore will always
+	 * schedule first.
+	 */
+	if (!group_leader)
+		return 0;
+
+	if (!perf_aux_output_match(event, group_leader))
+		return 0;
+
+	if (!atomic_long_inc_not_zero(&group_leader->refcount))
+		return 0;
+
+	/*
+	 * Link aux_outputs to their aux event; this is undone in
+	 * perf_group_detach() by perf_put_aux_event(). When the
+	 * group in torn down, the aux_output events loose their
+	 * link to the aux_event and can't schedule any more.
+	 */
+	event->aux_event = group_leader;
+
+	return 1;
+}
+
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *sibling, *tmp;
@@ -1902,6 +1985,8 @@ static void perf_group_detach(struct perf_event *event)
 
 	event->attach_state &= ~PERF_ATTACH_GROUP;
 
+	perf_put_aux_event(event);
+
 	/*
 	 * If this is a sibling, remove it from its group.
 	 */
@@ -10426,6 +10511,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_ns;
 	}
 
+	if (event->attr.aux_output &&
+	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
+		err = -EOPNOTSUPP;
+		goto err_pmu;
+	}
+
 	err = exclusive_event_init(event);
 	if (err)
 		goto err_pmu;
@@ -11082,6 +11173,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
+	if (event->attr.aux_output && !perf_get_aux_event(event, group_leader))
+		goto err_locked;
 
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
