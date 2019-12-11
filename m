Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EE4C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E6720836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576104499;
	bh=rxyB3WYeevkvWtvJVjpYl47utovx9Ml81cgcJenyfd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JJ7L6qqum7YxeL3tA8vrGPHw81aJS8xGWO/WPR+CCpxx67yTRq0t7glqgH2qeSUlq
	 LvoSRDnGwBbgziJUASPFe4Tc0VPcALmVRhhZOfxxrt+hMyIvaKus7U3HUDkkipDL+R
	 qnlFolKLnF5DWOURk+ORiWK2/H6Up0QB0CPzFU1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLKWsS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:48:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39330 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbfLKWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:48:17 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-XxQ9aMTEM8KdDbELsJUN2A-1; Wed, 11 Dec 2019 17:48:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0914591220;
        Wed, 11 Dec 2019 22:48:12 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77BE760BE1;
        Wed, 11 Dec 2019 22:48:09 +0000 (UTC)
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
Subject: [PATCH 2/3] perf tools: Factor metric setup code into metricgroup__setup function
Date:   Wed, 11 Dec 2019 23:47:59 +0100
Message-Id: <20191211224800.9066-3-jolsa@kernel.org>
In-Reply-To: <20191211224800.9066-1-jolsa@kernel.org>
References: <20191211224800.9066-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XxQ9aMTEM8KdDbELsJUN2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factoring metric setup code into metricgroup__setup function,
so it can be used to add metric from different sources in
following patches.

Link: https://lkml.kernel.org/n/tip-7hjix4t30ls3qqd4l60dbr2n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 38 +++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1d01958c148d..abcfa3c1b4d5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -521,32 +521,44 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 	}
 }
 
+static int metricgroup__setup(struct evlist *evlist,
+			      struct rblist *metric_events,
+			      struct strbuf *extra_events,
+			      struct list_head *group_list)
+{
+	struct parse_events_error parse_error;
+	int ret;
+
+	pr_debug("adding %s\n", extra_events->buf);
+	bzero(&parse_error, sizeof(parse_error));
+
+	ret = parse_events(evlist, extra_events->buf, &parse_error);
+	if (ret) {
+		parse_events_print_error(&parse_error, extra_events->buf);
+		return ret;
+	}
+
+	if (metric_events->nr_entries == 0)
+		metricgroup__rblist_init(metric_events);
+	return metricgroup__setup_events(group_list, evlist, metric_events);
+}
+
 int metricgroup__parse_groups(const struct option *opt,
 			   const char *str,
 			   struct rblist *metric_events)
 {
-	struct parse_events_error parse_error;
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	struct strbuf extra_events;
 	LIST_HEAD(group_list);
 	int ret;
 
-	if (metric_events->nr_entries == 0)
-		metricgroup__rblist_init(metric_events);
 	ret = metricgroup__add_metric_list(str, &extra_events, &group_list);
 	if (ret)
 		return ret;
-	pr_debug("adding %s\n", extra_events.buf);
-	bzero(&parse_error, sizeof(parse_error));
-	ret = parse_events(perf_evlist, extra_events.buf, &parse_error);
-	if (ret) {
-		parse_events_print_error(&parse_error, extra_events.buf);
-		goto out;
-	}
+
+	ret = metricgroup__setup(perf_evlist, metric_events, &extra_events,
+				 &group_list);
 	strbuf_release(&extra_events);
-	ret = metricgroup__setup_events(&group_list, perf_evlist,
-					metric_events);
-out:
 	metricgroup__free_egroups(&group_list);
 	return ret;
 }
-- 
2.21.1

