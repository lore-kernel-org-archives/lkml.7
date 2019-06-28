Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94ADC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3635208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF1WHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:07:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:49434 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfF1WHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:07:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 15:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="183771159"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2019 15:07:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6439F301BCC; Fri, 28 Jun 2019 15:07:46 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/3] perf tools metric: Don't include duration_time in group
Date:   Fri, 28 Jun 2019 15:07:37 -0700
Message-Id: <20190628220737.13259-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628220737.13259-1-andi@firstfloor.org>
References: <20190628220737.13259-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The Memory_BW metric generates groups including duration_time,
which maps to a software event.

For some reason this makes the group always not count.

Always put duration_time outside a group when generating metrics.
It's always the same time, so no need to group it.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/metricgroup.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1c85c9624c58..17ec05e17e7b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -410,6 +410,7 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			const char **ids;
 			int idnum;
 			struct egroup *eg;
+			bool no_group = false;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
@@ -420,11 +421,25 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				strbuf_addf(events, ",");
 			for (j = 0; j < idnum; j++) {
 				pr_debug("found event %s\n", ids[j]);
+				/*
+				 * Duration time maps to a software event and can make
+				 * groups not count. Always use it outside a
+				 * group.
+				 */
+				if (!strcmp(ids[j], "duration_time")) {
+					if (j > 0)
+						strbuf_addf(events, "}:W,");
+					strbuf_addf(events, "duration_time");
+					no_group = true;
+					continue;
+				}
 				strbuf_addf(events, "%s%s",
-					j == 0 ? "{" : ",",
+					j == 0 || no_group ? "{" : ",",
 					ids[j]);
+				no_group = false;
 			}
-			strbuf_addf(events, "}:W");
+			if (!no_group)
+				strbuf_addf(events, "}:W");
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
-- 
2.20.1

