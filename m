Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48D8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FD92084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c0ppq9NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfFQTty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:49:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQTtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:49:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJmd973570064
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:48:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJmd973570064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800919;
        bh=UrB9H0RRnaqLBOHxl+tOj2Km0d1DOYvMRKKrth8/FAw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=c0ppq9NT++FGAtwKr3blYNSSPDUtSEmm5ttW7mxYRHjAQZ+KzSHSE2VjVvlwUgngN
         LCCpYKO6LLwQyyhpiUv5RUaRQyIwypHrs77OYu8LVu116slXgpM/+ux9tIK49mnHV4
         fCUHbpzFIcWDwQbYsOrU7A/OIMOBTjjlehhL/HURPy+gKMd2yTgVLj8HcHcYcznPvk
         LTQG6Fi9N1aW7UkIUjgZ0PQ0aJZg7RAidz3SaUwFVyWV2Nb/THp75qd2Lou/aoFNaC
         FxB2Kn7b3Y0cVkcxHfSwjVTHaouehYWlG6uOccoHc3gKnJ9z7wISjeXZytjQAS3u6i
         uwf/ztB3567fQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJmdU73570061;
        Mon, 17 Jun 2019 12:48:39 -0700
Date:   Mon, 17 Jun 2019 12:48:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-2a8afddc084a5f5f933382758dd2767ed8a69f77@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, yao.jin@linux.intel.com,
        adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, yao.jin@linux.intel.com
In-Reply-To: <20190604130017.31207-17-adrian.hunter@intel.com>
References: <20190604130017.31207-17-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Simplify
 perf_time__parse_for_ranges() error paths slightly
Git-Commit-ID: 2a8afddc084a5f5f933382758dd2767ed8a69f77
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

Commit-ID:  2a8afddc084a5f5f933382758dd2767ed8a69f77
Gitweb:     https://git.kernel.org/tip/2a8afddc084a5f5f933382758dd2767ed8a69f77
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:14 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly

Simplify perf_time__parse_for_ranges() error paths slightly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 3e87c21c293c..9a463752dba8 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -403,7 +403,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				int *range_size, int *range_num)
 {
 	struct perf_time_interval *ptime_range;
-	int size, num, ret;
+	int size, num, ret = -EINVAL;
 
 	ptime_range = perf_time__range_alloc(time_str, &size);
 	if (!ptime_range)
@@ -415,7 +415,6 @@ int perf_time__parse_for_ranges(const char *time_str,
 			pr_err("HINT: no first/last sample time found in perf data.\n"
 			       "Please use latest perf binary to execute 'perf record'\n"
 			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			ret = -EINVAL;
 			goto error;
 		}
 
@@ -425,11 +424,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 				session->evlist->first_sample_time,
 				session->evlist->last_sample_time);
 
-		if (num < 0) {
-			pr_err("Invalid time string\n");
-			ret = -EINVAL;
-			goto error;
-		}
+		if (num < 0)
+			goto error_invalid;
 	} else {
 		num = 1;
 	}
@@ -439,6 +435,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 	*ranges = ptime_range;
 	return 0;
 
+error_invalid:
+	pr_err("Invalid time string\n");
 error:
 	free(ptime_range);
 	return ret;
