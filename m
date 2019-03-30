Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4309C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97520206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907114;
	bh=vuvNGReKYaEXTPVdnuLDTS9aoOOlZI0yvO/PUDq0HGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USIoIUSt/U2aXpsyLy5txlkRWrNP1hHwTF8EoDCYjp6l4Z5WYdeY4eCWfIGFN1+1l
	 sLxGjApBls45rFnve34l+u/hgeJG+/ixM3abnyOLwTJR66WjM+27i9LpRx7q6G92SX
	 CPVw0Bv1d7P6jAYrk8zVITMHe/Jfo870xuGeu8Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfC3Avr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbfC3Avo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3600206DD;
        Sat, 30 Mar 2019 00:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907103;
        bh=vuvNGReKYaEXTPVdnuLDTS9aoOOlZI0yvO/PUDq0HGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnKlJh+ElAMsFnQ9H03Ed4JoOA4elXdFwFw1uixgWBXaT6ct1tf9uxjdckdsFRgjh
         9JjNfU9lV9yBRhhN8tzIUI72Z6LzKpoUOJvR9/aDsNWawldPHNXqUvCrfRl7ZwgONB
         vPCw7qvmDzOdG+l4V75UBapv8oZ5qtGyEWcaSttE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 33/67] perf stat: Fix --no-scale
Date:   Fri, 29 Mar 2019 20:50:13 -0400
Message-Id: <20190330005047.25998-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ Upstream commit 75998bb263bf48c1c85d78cd2d2f3a97d3747cab ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 63a3afc7f32b..a52295dbad2b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -728,7 +728,8 @@ static struct option stat_options[] = {
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
index dbc0466db368..142e1ca94992 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1341,8 +1341,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
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
-- 
2.19.1

