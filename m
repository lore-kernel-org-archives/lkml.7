Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994EDC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656E42084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PGuyHIhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfFQTqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:46:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQTqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:46:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJkYV13569571
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:46:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJkYV13569571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800795;
        bh=rN1JPfgbPjB9jAtqUqfTs0ZvDW8KmYio1DgXW/FgUsY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PGuyHIhsT1Op4oSRnFi5ngZizDSjRFtKC4vSHuJyHXxb6ZuOq3PnVJAboaj8t/EB0
         +Ze4ItRK1O+guBCTsjMMF02j0t9UPKfNEGtjx558BgkPWPcQHeqB7DjXMEw5V1INJP
         iwiI5p7IUjoe3hG0Ui77A3h32RimjdQe9PBtYXKB3IZuPEuOsfglNzAfig5xXUl2pU
         05izIxe6hpPDl03gV0eBKTbrAoWmBWHL3KQG2QaUjx1m+T5aMSXoJWOhZZOCfnkZoQ
         jk0o1aWbM92Z0062qwfMH+CTDM3ftobC0936dbpsq2UKt562v1u0eQrnx4dQF9zbNY
         f/yyr0/WGiY2Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJkYRF3569568;
        Mon, 17 Jun 2019 12:46:34 -0700
Date:   Mon, 17 Jun 2019 12:46:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-c763242a5e742f8fefda0bb6cfdf6a5a34ae5e10@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com,
        yao.jin@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, jolsa@redhat.com
Reply-To: jolsa@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          yao.jin@linux.intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190604130017.31207-14-adrian.hunter@intel.com>
References: <20190604130017.31207-14-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Factor out set_percent_time()
Git-Commit-ID: c763242a5e742f8fefda0bb6cfdf6a5a34ae5e10
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

Commit-ID:  c763242a5e742f8fefda0bb6cfdf6a5a34ae5e10
Gitweb:     https://git.kernel.org/tip/c763242a5e742f8fefda0bb6cfdf6a5a34ae5e10
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:11 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf time-utils: Factor out set_percent_time()

Factor out set_percent_time() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 39 ++++++++++++++++++---------------------
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
