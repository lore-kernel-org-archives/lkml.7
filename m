Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E8320848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799559;
	bh=ks+J52TSVLj80xtppxUa6ohjS97rRX1WSr6urnjityA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S2Lkns3gWYgq9bcGMJxphKXSrZ0Dop4DGfoKrII7eV3c23hIMzQHR1kuwl7sVxdIc
	 TzI0bYWYv45A+E3YBtxRnzObBTSRMG51QYt5UB17d9buu7k9g1XZEmucwxBbcUzshx
	 b2nI5UO/BSMHbVoU/axLiCOVR3yQIUf17UQ38PWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfCEPZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:25:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbfCEPZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 027576697A;
        Tue,  5 Mar 2019 15:25:55 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C77C81001DF0;
        Tue,  5 Mar 2019 15:25:52 +0000 (UTC)
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
Subject: [PATCH 6/8] perf tools: Probe for precise_ip with simple attr
Date:   Tue,  5 Mar 2019 16:25:34 +0100
Message-Id: <20190305152536.21035-7-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 05 Mar 2019 15:25:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we probe for precise_ip with user specified
perf_event_attr, which might fail because of unsupported
kernel features, which would get disabled during the
open time anyway.

Switching the probe to take place on simple hw cycles,
so the following record sets proper precise_ip:

  # perf record -e cycles:P ls
  # perf evlist -v
  cycles:P: size: 112, ... precise_ip: 3, ...

Link: http://lkml.kernel.org/n/tip-rwncfxifbhnmd89yx0va5zg0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 25 ++++++++++++++++++++-----
 tools/perf/util/evsel.c  |  8 --------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 08cedb643ea6..ed20f4379956 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -230,18 +230,33 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr)
+void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
 {
-	attr->precise_ip = 3;
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_HARDWARE,
+		.config		= PERF_COUNT_HW_CPU_CYCLES,
+		.exclude_kernel	= 1,
+		.precise_ip	= 3,
+	};
 
-	while (attr->precise_ip != 0) {
-		int fd = sys_perf_event_open(attr, 0, -1, -1, 0);
+	event_attr_init(&attr);
+
+	/*
+	 * Unnamed union member, not supported as struct member named
+	 * initializer in older compilers such as gcc 4.4.7
+	 */
+	attr.sample_period = 1;
+
+	while (attr.precise_ip != 0) {
+		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 		if (fd != -1) {
 			close(fd);
 			break;
 		}
-		--attr->precise_ip;
+		--attr.precise_ip;
 	}
+
+	pattr->precise_ip = attr.precise_ip;
 }
 
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index eec542bab815..2ef229e24b6f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -294,20 +294,12 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 
 	if (!precise)
 		goto new_event;
-	/*
-	 * Unnamed union member, not supported as struct member named
-	 * initializer in older compilers such as gcc 4.4.7
-	 *
-	 * Just for probing the precise_ip:
-	 */
-	attr.sample_period = 1;
 
 	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
-	attr.sample_period = 0;
 new_event:
 	evsel = perf_evsel__new(&attr);
 	if (evsel == NULL)
-- 
2.17.2

