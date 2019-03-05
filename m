Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1947CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A19208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799551;
	bh=KPMnys5GN9gI3WARy0LfjjVIyBQSEIoBAoDcvpp9ju4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mQhjLrpM281yGKiterZs6UWf6IQM2rS6jcRHEpIwvGND5rUooN7yry9EPIF/uUBhT
	 51piRd/YJV1r1xoMrbPT+1rJfvNu/KDhey0knG0Ry9NScN2Xij35LTVYbpOAIj29DT
	 Z+zxyMr/CHjgRJQvUuFcUbtbTYTODOnjPorB4Aq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfCEPZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:25:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbfCEPZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7608F5944A;
        Tue,  5 Mar 2019 15:25:47 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 432201001E61;
        Tue,  5 Mar 2019 15:25:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/8] perf hist: Fix memory leak of srcline
Date:   Tue,  5 Mar 2019 16:25:31 +0100
Message-Id: <20190305152536.21035-4-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 05 Mar 2019 15:25:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

We can't allocate he->srcline unconditionaly, only when
new hist_entry is created. Moving he->srcline allocation
into hist_entry__init function.

Original-patch-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/n/tip-2ijaiiwlzmk4cae3zs97pq0x@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/hist.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 74e307d17c49..f9eb95bf3938 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -419,6 +419,13 @@ static int hist_entry__init(struct hist_entry *he,
 		if (he->raw_data == NULL)
 			goto err_infos;
 	}
+
+	if (he->srcline) {
+		he->srcline = strdup(he->srcline);
+		if (he->srcline == NULL)
+			goto err_rawdata;
+	}
+
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
@@ -429,6 +436,9 @@ static int hist_entry__init(struct hist_entry *he,
 
 	return 0;
 
+err_rawdata:
+	free(he->raw_data);
+
 err_infos:
 	if (he->branch_info) {
 		map__put(he->branch_info->from.map);
@@ -605,7 +615,7 @@ __hists__add_entry(struct hists *hists,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.socket	 = al->socket,
 		.cpu	 = al->cpu,
 		.cpumode = al->cpumode,
@@ -962,7 +972,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			.map = al->map,
 			.sym = al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.parent = iter->parent,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
-- 
2.17.2

