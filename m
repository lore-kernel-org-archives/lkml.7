Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC413C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7590B20883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCVWYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:24:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCVWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:24:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMMqZx750654
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:22:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMMp7E750651;
        Fri, 22 Mar 2019 15:22:51 -0700
Date:   Fri, 22 Mar 2019 15:22:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-xggjvwcdaj2aqy8ib3i4b1g6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com, mingo@kernel.org,
        hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de
Reply-To: acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          ak@linux.intel.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix --no-scale
Git-Commit-ID: 75998bb263bf48c1c85d78cd2d2f3a97d3747cab
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

Commit-ID:  75998bb263bf48c1c85d78cd2d2f3a97d3747cab
Gitweb:     https://git.kernel.org/tip/75998bb263bf48c1c85d78cd2d2f3a97d3747cab
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 15:50:01 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:03 -0300

perf stat: Fix --no-scale

The -c option to enable multiplex scaling has been useless for quite
some time because scaling is default.

It's only useful as --no-scale to disable scaling. But the non scaling
code path has bitrotted and doesn't print anything because perf output
code relies on value run/ena information.

Also even when we don't want to scale a value it's still useful to show
its multiplex percentage.

This patch:
  - Fixes help and documentation to show --no-scale instead of -c
  - Removes -c, only keeps the long option because -c doesn't support negatives.
  - Enables running/enabled even with --no-scale
  - And fixes some other problems in the no-scale output.

Before:

  $ perf stat --no-scale -e cycles true

   Performance counter stats for 'true':

       <not counted>      cycles

         0.000984154 seconds time elapsed

After:

  $ ./perf stat --no-scale -e cycles true

   Performance counter stats for 'true':

             706,070      cycles

         0.001219821 seconds time elapsed

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
LPU-Reference: 20190314225002.30108-9-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-xggjvwcdaj2aqy8ib3i4b1g6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 ++---
 tools/perf/builtin-stat.c              |  3 ++-
 tools/perf/util/evsel.c                |  3 +--
 tools/perf/util/stat.c                 | 12 ++++--------
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4bc2085e5197..39c05f89104e 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -72,9 +72,8 @@ report::
 --all-cpus::
         system-wide collection from all CPUs (default if no target is specified)
 
--c::
---scale::
-	scale/normalize counter values
+--no-scale::
+	Don't scale/normalize counter values
 
 -d::
 --detailed::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7b8f09b0b8bf..49ee3c2033ec 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -718,7 +718,8 @@ static struct option stat_options[] = {
 		    "system-wide collection from all CPUs"),
 	OPT_BOOLEAN('g', "group", &group,
 		    "put the counters into a counter group"),
-	OPT_BOOLEAN('c', "scale", &stat_config.scale, "scale/normalize counters"),
+	OPT_BOOLEAN(0, "scale", &stat_config.scale,
+		    "Use --no-scale to disable counter scaling for multiplexing"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_INTEGER('r', "repeat", &stat_config.run_count,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e979c0..53ec40cacd4b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1344,8 +1344,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 			scaled = 1;
 			count->val = (u64)((double) count->val * count->ena / count->run + 0.5);
 		}
-	} else
-		count->ena = count->run = 0;
+	}
 
 	if (pscaled)
 		*pscaled = scaled;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4d40515307b8..2856cc9d5a31 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -291,10 +291,8 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 		break;
 	case AGGR_GLOBAL:
 		aggr->val += count->val;
-		if (config->scale) {
-			aggr->ena += count->ena;
-			aggr->run += count->run;
-		}
+		aggr->ena += count->ena;
+		aggr->run += count->run;
 	case AGGR_UNSET:
 	default:
 		break;
@@ -442,10 +440,8 @@ int create_perf_stat_counter(struct perf_evsel *evsel,
 	struct perf_event_attr *attr = &evsel->attr;
 	struct perf_evsel *leader = evsel->leader;
 
-	if (config->scale) {
-		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
-				    PERF_FORMAT_TOTAL_TIME_RUNNING;
-	}
+	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+			    PERF_FORMAT_TOTAL_TIME_RUNNING;
 
 	/*
 	 * The event is part of non trivial group, let's enable
