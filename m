Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C3C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2120836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576104496;
	bh=qK3vK/0RHkFSlJhjYsC+OrZMch/SplVYDxI4YaZsOjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sd7mmvk8hfeOfXH5R0LnhyjEnRR+BJUNtCFGEm2dh3nd5EoF0iza3hme+0HLnqd2R
	 lp/mKWryU40GO10D33bqsPw2Jay+r2JCyPILuePEziAPxdNYvj93hNziRGMu5hS+FY
	 nhp8nWycwiKu48G6QH2CmPhYpWideWOFf4i5HbaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLKWsP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:48:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbfLKWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:48:15 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-RdzSd0cVPPuc-zrqkavFYQ-1; Wed, 11 Dec 2019 17:48:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E618107ACCD;
        Wed, 11 Dec 2019 22:48:09 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAD3260BF1;
        Wed, 11 Dec 2019 22:48:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH 1/3] perf tools: Factor metric addition into add_metric function
Date:   Wed, 11 Dec 2019 23:47:58 +0100
Message-Id: <20191211224800.9066-2-jolsa@kernel.org>
In-Reply-To: <20191211224800.9066-1-jolsa@kernel.org>
References: <20191211224800.9066-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: RdzSd0cVPPuc-zrqkavFYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factoring metric addition into add_metric function,
so it can be used to add metric from different sources
in following patches.

Link: https://lkml.kernel.org/n/tip-qw1727kbewu315mz2h0y5xfm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 110 +++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6a4d350d5cdb..1d01958c148d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -396,13 +396,65 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	strlist__delete(metriclist);
 }
 
+static int add_metric(const char *name, const char *expr, const char *unit,
+		      struct strbuf *events, struct list_head *group_list)
+{
+	bool no_group = false;
+	struct egroup *eg;
+	const char **ids;
+	int idnum, j;
+
+	pr_debug("metric expr %s for %s\n", expr, name);
+
+	if (expr__find_other(expr, NULL, &ids, &idnum) < 0)
+		return -1;
+
+	if (events->len > 0)
+		strbuf_addf(events, ",");
+
+	for (j = 0; j < idnum; j++) {
+		pr_debug("found event %s\n", ids[j]);
+		/*
+		 * Duration time maps to a software event and can make
+		 * groups not count. Always use it outside a
+		 * group.
+		 */
+		if (!strcmp(ids[j], "duration_time")) {
+			if (j > 0)
+				strbuf_addf(events, "}:W,");
+			strbuf_addf(events, "duration_time");
+			no_group = true;
+			continue;
+		}
+		strbuf_addf(events, "%s%s",
+			j == 0 || no_group ? "{" : ",",
+			ids[j]);
+		no_group = false;
+	}
+
+	if (!no_group)
+		strbuf_addf(events, "}:W");
+
+	eg = malloc(sizeof(struct egroup));
+	if (!eg)
+		return -ENOMEM;
+
+	eg->ids         = ids;
+	eg->idnum       = idnum;
+	eg->metric_name = name;
+	eg->metric_expr = expr;
+	eg->metric_unit = unit;
+	list_add_tail(&eg->nd, group_list);
+	return 0;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
 	int ret = -EINVAL;
-	int i, j;
+	int i;
 
 	if (!map)
 		return 0;
@@ -414,55 +466,17 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			break;
 		if (!pe->metric_expr)
 			continue;
-		if (match_metric(pe->metric_group, metric) ||
-		    match_metric(pe->metric_name, metric)) {
-			const char **ids;
-			int idnum;
-			struct egroup *eg;
-			bool no_group = false;
 
-			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
-
-			if (expr__find_other(pe->metric_expr,
-					     NULL, &ids, &idnum) < 0)
-				continue;
-			if (events->len > 0)
-				strbuf_addf(events, ",");
-			for (j = 0; j < idnum; j++) {
-				pr_debug("found event %s\n", ids[j]);
-				/*
-				 * Duration time maps to a software event and can make
-				 * groups not count. Always use it outside a
-				 * group.
-				 */
-				if (!strcmp(ids[j], "duration_time")) {
-					if (j > 0)
-						strbuf_addf(events, "}:W,");
-					strbuf_addf(events, "duration_time");
-					no_group = true;
-					continue;
-				}
-				strbuf_addf(events, "%s%s",
-					j == 0 || no_group ? "{" : ",",
-					ids[j]);
-				no_group = false;
-			}
-			if (!no_group)
-				strbuf_addf(events, "}:W");
+		if (!match_metric(pe->metric_group, metric) &&
+		    !match_metric(pe->metric_name, metric))
+			continue;
 
-			eg = malloc(sizeof(struct egroup));
-			if (!eg) {
-				ret = -ENOMEM;
-				break;
-			}
-			eg->ids = ids;
-			eg->idnum = idnum;
-			eg->metric_name = pe->metric_name;
-			eg->metric_expr = pe->metric_expr;
-			eg->metric_unit = pe->unit;
-			list_add_tail(&eg->nd, group_list);
-			ret = 0;
-		}
+		ret = add_metric(pe->metric_name,
+				 pe->metric_expr,
+				 pe->unit,
+				 events, group_list);
+		if (ret)
+			break;
 	}
 	return ret;
 }
-- 
2.21.1

