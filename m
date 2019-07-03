Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43298C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E20321850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qs5PqRNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGCOaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:30:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGCOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:30:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63ETEvY3326977
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:29:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63ETEvY3326977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164155;
        bh=uZpO31xVY2Ag8uoOXFHDUwuOrzNCk5z+2XOby4/sCr4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Qs5PqRNzIjYYxIlaSXWSGwNYDHqwovExs9fxeqp0y7x8oUrDw4+8Ep4binn0SUU8i
         72i1hqwwzOdR0iUF8w4JoCfHSuOhjJ7MgQ/nG/aPnvO6fDHez2i5U5d9Okc9odm35Z
         rOf9LWmQMF9Pl3QGc1kw9Vn4N6mx4d8deRfAXS41TltDezjBZ7l9r/hhiZTRhklelE
         9hfdMOM4Uul9hGHNu2ylJim05iKQ63fi5fBIfN5rnk1+IR2H+4UHJAZlT/laKFD4s2
         YxvssncaHLmyNJMumPPARoJY3nbMUO4izaCwdMJGdt0IFpkWTWvGCfK5Bx4qzHBsxm
         XjA3nNVhDLF0Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63ETEeW3326971;
        Wed, 3 Jul 2019 07:29:14 -0700
Date:   Wed, 3 Jul 2019 07:29:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-2f87f33f4226523df9c9cc28f9874ea02fcc3d3f@git.kernel.org>
Cc:     tglx@linutronix.de, ak@linux.intel.com, kan.liang@linux.intel.com,
        mingo@kernel.org, acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, ak@linux.intel.com, mingo@kernel.org,
          kan.liang@linux.intel.com, hpa@zytor.com, acme@redhat.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190624193711.35241-4-andi@firstfloor.org>
References: <20190624193711.35241-4-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Fix group lookup for metric group
Git-Commit-ID: 2f87f33f4226523df9c9cc28f9874ea02fcc3d3f
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

Commit-ID:  2f87f33f4226523df9c9cc28f9874ea02fcc3d3f
Gitweb:     https://git.kernel.org/tip/2f87f33f4226523df9c9cc28f9874ea02fcc3d3f
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 24 Jun 2019 12:37:10 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:41 -0300

perf stat: Fix group lookup for metric group

The metric group code tries to find a group it added earlier in the
evlist. Fix the lookup to handle groups with partially overlaps
correctly. When a sub string match fails and we reset the match, we have
to compare the first element again.

I also renamed the find_evsel function to find_evsel_group to make its
purpose clearer.

With the earlier changes this fixes:

Before:

  % perf stat -M UPI,IPC sleep 1
  ...
         1,032,922      uops_retired.retire_slots #      1.1 UPI
         1,896,096      inst_retired.any
         1,896,096      inst_retired.any
         1,177,254      cpu_clk_unhalted.thread

After:

  % perf stat -M UPI,IPC sleep 1
  ...
        1,013,193      uops_retired.retire_slots #      1.1 UPI
           932,033      inst_retired.any
           932,033      inst_retired.any          #      0.9 IPC
         1,091,245      cpu_clk_unhalted.thread

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Fixes: b18f3e365019 ("perf stat: Support JSON metrics in perf stat")
Link: http://lkml.kernel.org/r/20190624193711.35241-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 47 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 90cd84e2a503..bc25995255ab 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -85,26 +85,49 @@ struct egroup {
 	const char *metric_expr;
 };
 
-static struct perf_evsel *find_evsel(struct perf_evlist *perf_evlist,
-				     const char **ids,
-				     int idnum,
-				     struct perf_evsel **metric_events)
+static bool record_evsel(int *ind, struct perf_evsel **start,
+			 int idnum,
+			 struct perf_evsel **metric_events,
+			 struct perf_evsel *ev)
+{
+	metric_events[*ind] = ev;
+	if (*ind == 0)
+		*start = ev;
+	if (++*ind == idnum) {
+		metric_events[*ind] = NULL;
+		return true;
+	}
+	return false;
+}
+
+static struct perf_evsel *find_evsel_group(struct perf_evlist *perf_evlist,
+					   const char **ids,
+					   int idnum,
+					   struct perf_evsel **metric_events)
 {
 	struct perf_evsel *ev, *start = NULL;
 	int ind = 0;
 
 	evlist__for_each_entry (perf_evlist, ev) {
+		if (ev->collect_stat)
+			continue;
 		if (!strcmp(ev->name, ids[ind])) {
-			metric_events[ind] = ev;
-			if (ind == 0)
-				start = ev;
-			if (++ind == idnum) {
-				metric_events[ind] = NULL;
+			if (record_evsel(&ind, &start, idnum,
+					 metric_events, ev))
 				return start;
-			}
 		} else {
+			/*
+			 * We saw some other event that is not
+			 * in our list of events. Discard
+			 * the whole match and start again.
+			 */
 			ind = 0;
 			start = NULL;
+			if (!strcmp(ev->name, ids[ind])) {
+				if (record_evsel(&ind, &start, idnum,
+						 metric_events, ev))
+					return start;
+			}
 		}
 	}
 	/*
@@ -134,8 +157,8 @@ static int metricgroup__setup_events(struct list_head *groups,
 			ret = -ENOMEM;
 			break;
 		}
-		evsel = find_evsel(perf_evlist, eg->ids, eg->idnum,
-				   metric_events);
+		evsel = find_evsel_group(perf_evlist, eg->ids, eg->idnum,
+					 metric_events);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
 					eg->metric_name, eg->metric_expr);
