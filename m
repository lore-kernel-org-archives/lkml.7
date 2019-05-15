Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955FDC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6342082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfEOVCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:02:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:15270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfEOVCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:02:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 14:02:06 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 14:02:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, tj@kernel.org, mark.rutland@arm.com,
        irogers@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/4] perf: Add filter_match() as a parameter for pinned/flexible_sched_in()
Date:   Wed, 15 May 2019 14:01:30 -0700
Message-Id: <1557954092-67275-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
References: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A fast path will be introduced in the following patches to speed up the
cgroup events sched in, which only needs a simpler filter_match().

Add filter_match() as a parameter for pinned/flexible_sched_in().

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e7ca0474..a3885e68 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3316,7 +3316,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 }
 
 static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
-			      int (*func)(struct perf_event *, void *), void *data)
+			      int (*func)(struct perf_event *, void *, int (*)(struct perf_event *)),
+			      void *data)
 {
 	struct perf_event **evt, *evt1, *evt2;
 	int ret;
@@ -3336,7 +3337,7 @@ static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
 			evt = &evt2;
 		}
 
-		ret = func(*evt, data);
+		ret = func(*evt, data, event_filter_match);
 		if (ret)
 			return ret;
 
@@ -3353,7 +3354,8 @@ struct sched_in_data {
 	enum event_type_t event_type;
 };
 
-static int pinned_sched_in(struct perf_event *event, void *data)
+static int pinned_sched_in(struct perf_event *event, void *data,
+			   int (*filter_match)(struct perf_event *))
 {
 	struct sched_in_data *sid = data;
 
@@ -3363,7 +3365,7 @@ static int pinned_sched_in(struct perf_event *event, void *data)
 	if (perf_cgroup_skip_switch(sid->event_type, event, true))
 		return 0;
 
-	if (!event_filter_match(event))
+	if (!filter_match(event))
 		return 0;
 
 	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
@@ -3381,7 +3383,8 @@ static int pinned_sched_in(struct perf_event *event, void *data)
 	return 0;
 }
 
-static int flexible_sched_in(struct perf_event *event, void *data)
+static int flexible_sched_in(struct perf_event *event, void *data,
+			     int (*filter_match)(struct perf_event *))
 {
 	struct sched_in_data *sid = data;
 
@@ -3391,7 +3394,7 @@ static int flexible_sched_in(struct perf_event *event, void *data)
 	if (perf_cgroup_skip_switch(sid->event_type, event, false))
 		return 0;
 
-	if (!event_filter_match(event))
+	if (!filter_match(event))
 		return 0;
 
 	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-- 
2.7.4

