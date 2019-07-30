Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22988C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E999320578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455878;
	bh=7xKWf7f7XU6np8Pt92Tf+FJQxVCbkw4YzuYP8oLd2ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMieE9nT6cmJqzSrX3sG2uuGyNLWIy9UDdaySn48FXT3KCof6QhWaIbPExrq77GPL
	 mGVtSQldq/3OopOn75uCJLZfbTirHvde52p/ueGhI7f/IvbCFyMfoIo/hV1Jrvv8xd
	 8cbp85UJv9odRG6CGFW3lpuc1muOo/ukG1+XSY+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbfG3DEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731504AbfG3C4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:56:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E8E21849;
        Tue, 30 Jul 2019 02:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455389;
        bh=7xKWf7f7XU6np8Pt92Tf+FJQxVCbkw4YzuYP8oLd2ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIK1R+SRONsBW73JKCAzMiAHuJjFcRhQmnn2Bju8t1AFCQ4HntJHUog+TpWEwt4Zg
         rDm6Ert5ZG0dxq6+nJTqzIdfi0Mf5YegFUC+XVOjb9mZfeiaPMK5FNPQPQbMoz6EAR
         +5ED7p2OzUKJvX9SlQIBLjchWmP+8wmqRRfISLaE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 003/107] perf evsel: Store backpointer to attached bpf_object
Date:   Mon, 29 Jul 2019 23:54:26 -0300
Message-Id: <20190730025610.22603-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We may want to get to this bpf_object, to search for other BPF programs,
etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3y8hrb6lszjfi23vjlic3cib@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c   | 4 ++--
 tools/perf/util/bpf-loader.h   | 2 +-
 tools/perf/util/evsel.c        | 1 +
 tools/perf/util/evsel.h        | 3 +++
 tools/perf/util/parse-events.c | 3 ++-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index c61974a50aa5..6d0dfb777a79 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -763,7 +763,7 @@ int bpf__foreach_event(struct bpf_object *obj,
 
 		if (priv->is_tp) {
 			fd = bpf_program__fd(prog);
-			err = (*func)(priv->sys_name, priv->evt_name, fd, arg);
+			err = (*func)(priv->sys_name, priv->evt_name, fd, obj, arg);
 			if (err) {
 				pr_debug("bpf: tracepoint call back failed, stop iterate\n");
 				return err;
@@ -788,7 +788,7 @@ int bpf__foreach_event(struct bpf_object *obj,
 				return fd;
 			}
 
-			err = (*func)(tev->group, tev->event, fd, arg);
+			err = (*func)(tev->group, tev->event, fd, obj, arg);
 			if (err) {
 				pr_debug("bpf: call back failed, stop iterate\n");
 				return err;
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 3f46856e3330..8c3441a4b72c 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -46,7 +46,7 @@ struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
 
 typedef int (*bpf_prog_iter_callback_t)(const char *group, const char *event,
-					int fd, void *arg);
+					int fd, struct bpf_object *obj, void *arg);
 
 #ifdef HAVE_LIBBPF_SUPPORT
 struct bpf_object *bpf__prepare_load(const char *filename, bool source);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 52459dd5ad0c..7d1757a2ec46 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -234,6 +234,7 @@ void perf_evsel__init(struct perf_evsel *evsel,
 	evsel->scale	   = 1.0;
 	evsel->max_events  = ULONG_MAX;
 	evsel->evlist	   = NULL;
+	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->node);
 	INIT_LIST_HEAD(&evsel->config_terms);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cad54e8ba522..b27935a6d36c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -82,6 +82,8 @@ enum perf_tool_event {
 	PERF_TOOL_DURATION_TIME = 1,
 };
 
+struct bpf_object;
+
 /** struct perf_evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -152,6 +154,7 @@ struct perf_evsel {
 	char			*group_name;
 	bool			cmdline_group_boundary;
 	struct list_head	config_terms;
+	struct bpf_object	*bpf_obj;
 	int			bpf_fd;
 	bool			auto_merge_stats;
 	bool			merged_stat;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fac6b32ef94a..0540303e5e97 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -630,7 +630,7 @@ struct __add_bpf_event_param {
 	struct list_head *head_config;
 };
 
-static int add_bpf_event(const char *group, const char *event, int fd,
+static int add_bpf_event(const char *group, const char *event, int fd, struct bpf_object *obj,
 			 void *_param)
 {
 	LIST_HEAD(new_evsels);
@@ -672,6 +672,7 @@ static int add_bpf_event(const char *group, const char *event, int fd,
 		pr_debug("adding %s:%s to %p\n",
 			 group, event, pos);
 		pos->bpf_fd = fd;
+		pos->bpf_obj = obj;
 	}
 	list_splice(&new_evsels, list);
 	return 0;
-- 
2.21.0

