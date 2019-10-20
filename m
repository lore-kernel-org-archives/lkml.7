Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C04C21D80
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfJTQOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 12:14:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:39869 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfJTQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 12:13:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 09:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="187321662"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 20 Oct 2019 09:13:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3FA72300393; Sun, 20 Oct 2019 09:13:58 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 5/9] perf evsel: Add iterator to iterate over events ordered by CPU
Date:   Sun, 20 Oct 2019 09:13:42 -0700
Message-Id: <20191020161346.18938-6-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020161346.18938-1-andi@firstfloor.org>
References: <20191020161346.18938-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add some common code that is needed to iterate over all events
in CPU order. Used in followon patches

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evlist.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  4 ++++
 tools/perf/util/evsel.h  |  1 +
 3 files changed, 38 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index fdef4eb82b48..00eaa6c5cdbe 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -324,6 +324,39 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
 		return perf_thread_map__nr(evlist->core.threads);
 }
 
+struct perf_cpu_map *evlist__cpu_iter_start(struct evlist *evlist)
+{
+	struct perf_cpu_map *cpus;
+	struct evsel *pos;
+
+	/*
+	 * evlist->cpus is not necessarily a superset of all the
+	 * event's cpus, so compute our own super set. This
+	 * assume that there is a super set
+	 */
+	cpus = evlist->core.cpus;
+	evlist__for_each_entry(evlist, pos) {
+		pos->cpu_index = 0;
+		if (pos->core.cpus->nr > cpus->nr)
+			cpus = pos->core.cpus;
+	}
+	return cpus;
+}
+
+bool evlist__cpu_iter_skip(struct evsel *ev, int cpu)
+{
+	if (ev->cpu_index >= ev->core.cpus->nr)
+		return true;
+	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_index] != cpu)
+		return true;
+	return false;
+}
+
+void evlist__cpu_iter_next(struct evsel *ev)
+{
+	ev->cpu_index++;
+}
+
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a55f0f2546e5..3f1268b9347b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -309,6 +309,10 @@ void perf_evlist__to_front(struct evlist *evlist,
 void perf_evlist__set_tracking_event(struct evlist *evlist,
 				     struct evsel *tracking_evsel);
 
+struct perf_cpu_map *evlist__cpu_iter_start(struct evlist *evlist);
+bool evlist__cpu_iter_skip(struct evsel *ev, int cpu);
+void evlist__cpu_iter_next(struct evsel *ev);
+
 struct evsel *
 perf_evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68321d10eb2d..227320501eb8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -172,6 +172,7 @@ struct evsel {
 	bool			collect_stat;
 	bool			weak_group;
 	bool			percore;
+	int			cpu_index;
 	const char		*pmu_name;
 	struct {
 		perf_evsel__sb_cb_t	*cb;
-- 
2.21.0

