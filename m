Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2EBC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE51F21871
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279881;
	bh=9BttnztzZyPH3Ajfxw9EloCQj+0r0Zju1wjp86agW4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqAuL401t2gqJ9ArrQsn87i1eI4Y4URgTRMq6W5zzrXLwznIN2wm7CMOK+3A31mmy
	 daSWubWywO/rN9xr5bnEninz3Uj4djpr3wdpIc4CBBCPEt1mWpX2mrb41DMOrapVCk
	 651WpGzRBgOGWYxyOCjNabNUhZJER1QLGzPE3Ups=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407317AbfFKTEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405902AbfFKTEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5140221850;
        Tue, 11 Jun 2019 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279876;
        bh=9BttnztzZyPH3Ajfxw9EloCQj+0r0Zju1wjp86agW4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egOFc5AlwDqPOmNs+l3Z+WAfiD7Nf0g4IwLcvVCIk7yIix3wH/qJ6ldGLKJez6YOo
         eJmZhI+dxk4DMwFz82JZc+qcP1WcTP5N5aBIExGU3P++8MmVaLQDIgjbd89ylQPV25
         Re3bfzK79eBAThg3fPE8JnQVZyVUWLW+v5cJyjeQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 75/85] perf time-utils: Factor out set_percent_time()
Date:   Tue, 11 Jun 2019 15:59:01 -0300
Message-Id: <20190611185911.11645-76-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out set_percent_time() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 39 +++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 1d67cf1216c7..69441faab3d0 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -135,12 +135,27 @@ static int parse_percent(double *pcnt, char *str)
 	return 0;
 }
 
+static int set_percent_time(struct perf_time_interval *ptime, double start_pcnt,
+			    double end_pcnt, u64 start, u64 end)
+{
+	u64 total = end - start;
+
+	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
+	    end_pcnt < 0.0 || end_pcnt > 1.0) {
+		return -1;
+	}
+
+	ptime->start = start + round(start_pcnt * total);
+	ptime->end = start + round(end_pcnt * total);
+
+	return 0;
+}
+
 static int percent_slash_split(char *str, struct perf_time_interval *ptime,
 			       u64 start, u64 end)
 {
 	char *p, *end_str;
 	double pcnt, start_pcnt, end_pcnt;
-	u64 total = end - start;
 	int i;
 
 	/*
@@ -168,15 +183,7 @@ static int percent_slash_split(char *str, struct perf_time_interval *ptime,
 	start_pcnt = pcnt * (i - 1);
 	end_pcnt = pcnt * i;
 
-	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
-	    end_pcnt < 0.0 || end_pcnt > 1.0) {
-		return -1;
-	}
-
-	ptime->start = start + round(start_pcnt * total);
-	ptime->end = start + round(end_pcnt * total);
-
-	return 0;
+	return set_percent_time(ptime, start_pcnt, end_pcnt, start, end);
 }
 
 static int percent_dash_split(char *str, struct perf_time_interval *ptime,
@@ -184,7 +191,6 @@ static int percent_dash_split(char *str, struct perf_time_interval *ptime,
 {
 	char *start_str = NULL, *end_str;
 	double start_pcnt, end_pcnt;
-	u64 total = end - start;
 	int ret;
 
 	/*
@@ -203,16 +209,7 @@ static int percent_dash_split(char *str, struct perf_time_interval *ptime,
 
 	free(start_str);
 
-	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
-	    end_pcnt < 0.0 || end_pcnt > 1.0 ||
-	    start_pcnt > end_pcnt) {
-		return -1;
-	}
-
-	ptime->start = start + round(start_pcnt * total);
-	ptime->end = start + round(end_pcnt * total);
-
-	return 0;
+	return set_percent_time(ptime, start_pcnt, end_pcnt, start, end);
 }
 
 typedef int (*time_pecent_split)(char *, struct perf_time_interval *,
-- 
2.20.1

