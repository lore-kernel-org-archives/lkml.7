Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69432C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470D920673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfFXThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:37:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:60546 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfFXThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:37:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 12:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="152047193"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2019 12:37:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 65E3C30212A; Mon, 24 Jun 2019 12:37:20 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [PATCH v1 4/4] perf stat: Fix metrics with --no-merge
Date:   Mon, 24 Jun 2019 12:37:11 -0700
Message-Id: <20190624193711.35241-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624193711.35241-1-andi@firstfloor.org>
References: <20190624193711.35241-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Since 8c5421c016a4 ("perf pmu: Display pmu name when printing ...")
using --no-merge adds the PMU name to the evsel name. This breaks
the metric value lookup because the parser doesn't know about this.

Remove the extra postfixes for the metric evaluation.

Fixes: 8c5421c016a4 ("perf pmu: Display pmu name when printing ...")
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-shadow.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3f8fd127d31e..cb891e5c2969 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -724,6 +724,7 @@ static void generic_metric(struct perf_stat_config *config,
 	double ratio;
 	int i;
 	void *ctxp = out->ctx;
+	char *n, *pn;
 
 	expr__ctx_init(&pctx);
 	expr__add_id(&pctx, name, avg);
@@ -743,7 +744,19 @@ static void generic_metric(struct perf_stat_config *config,
 			stats = &v->stats;
 			scale = 1.0;
 		}
-		expr__add_id(&pctx, metric_events[i]->name, avg_stats(stats)*scale);
+
+		n = strdup(metric_events[i]->name);
+		if (!n)
+			return;
+		/*
+		 * This display code with --no-merge adds [cpu] postfixes.
+		 * These are not supported by the parser. Remove everything
+		 * after the space.
+		 */
+		pn = strchr(n, ' ');
+		if (pn)
+			*pn = 0;
+		expr__add_id(&pctx, n, avg_stats(stats)*scale);
 	}
 	if (!metric_events[i]) {
 		const char *p = metric_expr;
@@ -760,6 +773,9 @@ static void generic_metric(struct perf_stat_config *config,
 				     (metric_name ? metric_name : name) : "", 0);
 	} else
 		print_metric(config, ctxp, NULL, NULL, "", 0);
+
+	for (i = 1; i < pctx.num_ids; i++)
+		free((void *)pctx.ids[i].name);
 }
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
-- 
2.20.1

