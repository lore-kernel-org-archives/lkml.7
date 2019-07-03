Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2CBC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544BE21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QmyVYrH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGCOaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:30:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36983 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGCOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:30:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63ETv4T3327103
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:29:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63ETv4T3327103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164198;
        bh=cwZJ4/7DwY+nlFIjz3BW5YppDgjiKGhNyiNJUZe8TsY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QmyVYrH4Okp45VBDK4D1yJScaDpDKVysa2JfKS3Gu5VjXa5Vz9es4xvb3TOpiLA/W
         /Vr9mut4QLVjpzoPqmhChFADX8eEsnmCPYTeoR31/yktJeyiwvV5SYdjmtoHtpvKvf
         Wyg3Hn9Z0YUJt1YKbAjADy11y9of2/OPkaiq3kJsX0wsRo4rVggsWFmU1fLxp8UyTk
         UtQnMBmEu8wyF2wn+fX84HHPKV7idTEa9lGGB5dM/g/P3yUMZU7Yye7EI3TJGRvw0f
         XeYeNJw0XWLSQ6m4z2W/xURYQ/GUgRGrs5DwXVeSu1nIumqAtwaDK4g4CmjQQu66mD
         0j/IP3jHomH8w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63ETvE93327100;
        Wed, 3 Jul 2019 07:29:57 -0700
Date:   Wed, 3 Jul 2019 07:29:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-e3a9427323a53ceee540276a74af7706f350d052@git.kernel.org>
Cc:     jolsa@kernel.org, agustinv@codeaurora.org, mingo@kernel.org,
        ak@linux.intel.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, kan.liang@linux.intel.com, hpa@zytor.com
Reply-To: acme@redhat.com, ak@linux.intel.com, hpa@zytor.com,
          kan.liang@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
          agustinv@codeaurora.org
In-Reply-To: <20190624193711.35241-5-andi@firstfloor.org>
References: <20190624193711.35241-5-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Fix metrics with --no-merge
Git-Commit-ID: e3a9427323a53ceee540276a74af7706f350d052
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e3a9427323a53ceee540276a74af7706f350d052
Gitweb:     https://git.kernel.org/tip/e3a9427323a53ceee540276a74af7706f350d052
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 24 Jun 2019 12:37:11 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:41 -0300

perf stat: Fix metrics with --no-merge

Since Fixes: 8c5421c016a4 ("perf pmu: Display pmu name when printing
unmerged events in stat") using --no-merge adds the PMU name to the
evsel name.

This breaks the metric value lookup because the parser doesn't know
about this.

Remove the extra postfixes for the metric evaluation.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Fixes: 8c5421c016a4 ("perf pmu: Display pmu name when printing unmerged events in stat")
Link: http://lkml.kernel.org/r/20190624193711.35241-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
