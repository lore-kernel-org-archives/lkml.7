Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8265CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4072171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZV5MYwvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfG3Rs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:48:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbfG3Rsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:48:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHmlJW3319929
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:48:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHmlJW3319929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564508928;
        bh=8JIhDeu16bZOxt+Be+Qj+fCWljtQ0dgsbiBhUKIanM8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=ZV5MYwvWxtfEeWwkcYossfEL/rfqj5PJ+++gxZ6G8Bmc3jDYJJ43veKwFu/RC1OiL
         Ium5GHzikCU6FTs0BCsubleVTR+iunk5HJ46uH1YarIKMU24iJ3CcdKvZG4F3UtYgB
         x4wtrpFpnvSUqD/yey07mQpasQ7go0HA0aDrilkCh6K5buQqX4yNrTJv7sKyMFpKtB
         9tglAaGIgbEdwUtOdi1zhAP+BztilEZupdyjbcvAmVU0QDw2eWDd0jPv4XsgvtuZeU
         hZ/IF7HezygK8zv+ZtZua5x9kQHVDAqu2pS+tnuWM9hhQKl89Kd9GuxPWoJT3MdW/2
         a0At50KU86FlQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHmk033319926;
        Tue, 30 Jul 2019 10:48:46 -0700
Date:   Tue, 30 Jul 2019 10:48:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3y8hrb6lszjfi23vjlic3cib@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, lclaudio@redhat.com,
        adrian.hunter@intel.com, tglx@linutronix.de, namhyung@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
          mingo@kernel.org, lclaudio@redhat.com, adrian.hunter@intel.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Store backpointer to attached
 bpf_object
Git-Commit-ID: af4a0991f40a1e50e5caff0317f152df2c82bdeb
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

Commit-ID:  af4a0991f40a1e50e5caff0317f152df2c82bdeb
Gitweb:     https://git.kernel.org/tip/af4a0991f40a1e50e5caff0317f152df2c82bdeb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 15 Jul 2019 16:22:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf evsel: Store backpointer to attached bpf_object

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
