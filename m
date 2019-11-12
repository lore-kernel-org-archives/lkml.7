Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14669C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E4A2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKLA7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:59:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:61338 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfKLA7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:59:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 16:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; 
   d="scan'208";a="215864805"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2019 16:59:43 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 40F57301A83; Mon, 11 Nov 2019 16:59:43 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     jolsa@kernel.org
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 12/12] perf stat: Use affinity for enabling/disabling events
Date:   Mon, 11 Nov 2019 16:59:41 -0800
Message-Id: <20191112005941.649137-13-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112005941.649137-1-andi@firstfloor.org>
References: <20191112005941.649137-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Restructure event enabling/disabling to use affinity, which
minimizes the number of IPIs needed.

Before on a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 54.65    1.899986          22     84812       660 ioctl

after:

 39.21    0.930451          10     84796       644 ioctl

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros
v3: Use new iterator macros
v4: Update iterators again
---
 tools/perf/util/evlist.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 17960e4d3a45..682a1f37d244 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -378,11 +378,28 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
+
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	evlist__for_each_cpu (evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
 
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__cpu_iter_skip(pos, cpu))
+				continue;
+			if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__disable_cpu(pos, pos->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
-		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__disable(pos);
+		pos->disabled = true;
 	}
 
 	evlist->enabled = false;
@@ -391,11 +408,28 @@ void evlist__disable(struct evlist *evlist)
 void evlist__enable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
 
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	evlist__for_each_cpu (evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__cpu_iter_skip(pos, cpu))
+				continue;
+			if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__enable_cpu(pos, pos->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__enable(pos);
+		pos->disabled = false;
 	}
 
 	evlist->enabled = true;
-- 
2.23.0

