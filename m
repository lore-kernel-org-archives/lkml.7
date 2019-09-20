Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA622080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989743;
	bh=PeElNlpH9IG2KF67PPPdCydzhTDeRnFOcsjPh5VrkL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aEoLGS9qKQlTwe+opuWVYmDTi7UEdAySA5jXe2epIcvg2LAqkzbus1AoT4oATxZzS
	 4jIkn6r4TcXAuKAbZOq60xdymTaPt3Wq+deNt5+HHLN6ZCzHrFxjXZPpSjU+HGmqO2
	 QdFQOlkvE/hk4DmmHE/mbV+OCb81Dg0I10O8+OQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfITO3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389137AbfITO0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0324820B7C;
        Fri, 20 Sep 2019 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989594;
        bh=PeElNlpH9IG2KF67PPPdCydzhTDeRnFOcsjPh5VrkL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mh1dZfF1XeaA9QaEiJ10V3cKqfZujmTXUkDxbfuw1eIuWzubZOWFCACLYNqz95E96
         4zIDWYJkuOLJp/6njYwMKlrctrgWVHbu8OlGo24pBMGF+zG2Ej4vSxyAFf3pfbX64K
         VpLXbGFNM8g9xijnl1+koogN8Y/3skDP8+B1VCIo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 15/31] perf stat: Move perf_stat_synthesize_config() to event.h
Date:   Fri, 20 Sep 2019 11:25:26 -0300
Message-Id: <20190920142542.12047-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Together with the other synthsizers, and rename it to
perf_event__synthesize_stat_events().

This allows us to stop including event.h in util/stat.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q5ebhrp44txboobs86htu5r9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c |  4 ++--
 tools/perf/util/event.h   |  5 +++++
 tools/perf/util/stat.c    | 10 +++++-----
 tools/perf/util/stat.h    |  8 ++------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5bc0c570b7b6..b55e8060810b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -540,8 +540,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
-						  process_synthesized_event, is_pipe);
+		err = perf_event__synthesize_stat_events(&stat_config, NULL, evsel_list,
+							 process_synthesized_event, is_pipe);
 		if (err < 0)
 			return err;
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4e6d33c76d57..89a2404170a0 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -293,6 +293,11 @@ typedef int (*perf_event__handler_t)(struct perf_tool *tool,
 				     struct perf_sample *sample,
 				     struct machine *machine);
 
+int perf_event__synthesize_stat_events(struct perf_stat_config *config,
+				       struct perf_tool *tool,
+				       struct evlist *evlist,
+				       perf_event__handler_t process,
+				       bool attrs);
 int perf_event__synthesize_attr(struct perf_tool *tool,
 				struct perf_event_attr *attr, u32 ids, u64 *id,
 				perf_event__handler_t process);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d309c1cc13db..2e318d95c528 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -495,11 +495,11 @@ int create_perf_stat_counter(struct evsel *evsel,
 	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
 }
 
-int perf_stat_synthesize_config(struct perf_stat_config *config,
-				struct perf_tool *tool,
-				struct evlist *evlist,
-				perf_event__handler_t process,
-				bool attrs)
+int perf_event__synthesize_stat_events(struct perf_stat_config *config,
+				       struct perf_tool *tool,
+				       struct evlist *evlist,
+				       perf_event__handler_t process,
+				       bool attrs)
 {
 	int err;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 14fe3e548229..0f9c9f6e2041 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -7,8 +7,9 @@
 #include <sys/types.h>
 #include <sys/resource.h>
 #include "rblist.h"
-#include "event.h"
 
+struct perf_cpu_map;
+struct perf_stat_config;
 struct timespec;
 
 struct stats {
@@ -210,11 +211,6 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target);
-int perf_stat_synthesize_config(struct perf_stat_config *config,
-				struct perf_tool *tool,
-				struct evlist *evlist,
-				perf_event__handler_t process,
-				bool attrs);
 void
 perf_evlist__print_counters(struct evlist *evlist,
 			    struct perf_stat_config *config,
-- 
2.21.0

