Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A21C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399A8218C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yr9oFhIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGCO3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:29:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGCO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:29:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63ESWUK3326910
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:28:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63ESWUK3326910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164113;
        bh=c/leLdi/fVYAAwoPfr2Mcdi7QNNrCV2XaHN6pMFkevo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yr9oFhIay7LGquixcjFT7ttsTGnh/MyerdORrqnSEfQ/VKUgOKvUb7jA0ou0S3kYS
         AawvhuHdI28hizNtlrINAZj7rQMXrmISrtd5zNFeqfwO1HupZmQvC4TXPMSLjTiolP
         gY6HSi8/M/DsbUD5jOIjcPUmFKZe0TEBYJqdpBw1TeVn6uBtZEl9uuHdAdKixjsnNW
         dM7ipXwhpkXwxTNNjkAsCN8Cayc6HWAoe4DVX6ZWZLEWZKUICSMa3AUhh8ut2FrO5T
         nzBaMPMV2eBsIapTTKPahGb9q07laVz8/oa/mA4zbI+MAA+ToqDYyxLd3hjUcsks2k
         OSGsFIy8c/doQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63ESW3S3326906;
        Wed, 3 Jul 2019 07:28:32 -0700
Date:   Wed, 3 Jul 2019 07:28:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-6c5f4e5cb35b4694dc035d91092d23f596ecd06a@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, ak@linux.intel.com,
        mingo@kernel.org, jolsa@kernel.org, kan.liang@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: kan.liang@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com, jolsa@kernel.org
In-Reply-To: <20190624193711.35241-3-andi@firstfloor.org>
References: <20190624193711.35241-3-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Don't merge events in the same PMU
Git-Commit-ID: 6c5f4e5cb35b4694dc035d91092d23f596ecd06a
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

Commit-ID:  6c5f4e5cb35b4694dc035d91092d23f596ecd06a
Gitweb:     https://git.kernel.org/tip/6c5f4e5cb35b4694dc035d91092d23f596ecd06a
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 24 Jun 2019 12:37:09 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:41 -0300

perf stat: Don't merge events in the same PMU

Event merging is mainly to collapse similar events in lots of different
duplicated PMUs.

It can break metric displaying. It's possible for two metrics to have
the same event, and when the two events happen in a row the second
wouldn't be displayed.  This would also not show the second metric.

To avoid this don't merge events in the same PMU. This makes sense, if
we have multiple events in the same PMU there is likely some reason for
it (e.g. using multiple groups) and we better not merge them.

While in theory it would be possible to construct metrics that have
events with the same name in different PMU no current metrics have this
problem.

This is the fix for perf stat -M UPI,IPC (needs also another bug fix to
completely work)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Fixes: 430daf2dc7af ("perf stat: Collapse identically named events")
Link: http://lkml.kernel.org/r/20190624193711.35241-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 90df41169113..58df6a0dbb9f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -554,7 +554,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct perf_evs
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
 		    strcmp(alias->unit, counter->unit) ||
-		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter))
+		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter) ||
+		    !strcmp(alias->pmu_name, counter->pmu_name))
 			break;
 		alias->merged_stat = true;
 		cb(config, alias, data, false);
