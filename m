Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7747DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3B92468E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576816431;
	bh=/3I8UZHYkgD2I1Xpozao4FAudgwq95weGPaLhwIL07s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OphRc2qidUcE1gHDNonfoSr3mEZcWrjGUQS7bCjICAZVqGoIHP26avqnC7GbxcK6r
	 2rwrZL5hUoXJGq3RC0qZyM0n6yNb/+bezuWGrv4z8TsuZXGbsoof8509l3E9s5exwr
	 FB2I4/mjF46PmcR9NJs/WWwdyWz54Xc1GXAeObXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLTEdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:33:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36594 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTEdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:33:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so2812310plm.3;
        Thu, 19 Dec 2019 20:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ol8A4Q2izXyIhNnbQIneXmiX1lSjbq6rcZ9kWpohYUU=;
        b=YNLSe/LekfFNUGhWYFbV0azLVMSURdLB343//uW8Ta18bCs8toqT2jXKgt4ratPuLT
         C18xOzT9CXUkptixRixETPmiuJCJ7jnNutrz+QIYLCG6ICjBBVL/jbaY2DLN9U5fMLOm
         KgCP506Favd+EQK4UPNE+/dnBoOCDpk3+2+Qia3VofW0lz6caHKiIzhAGkNeMZKfSjDn
         CP+/7Eo5VgMTAP7CR4Bg586Fgu4NLWNuIRG6R9SRR1L7TIOrx7FYpbYu05ATC+XmWhNW
         QKVG6ywbY/L9jfKAzqqLz+CW3L3yViKxHRXcXjRwJP1YrOmwM35/LBeQu2KI/Dexvse4
         k9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ol8A4Q2izXyIhNnbQIneXmiX1lSjbq6rcZ9kWpohYUU=;
        b=UNC6/0WbthuEMw7BIknIoeGUXTByFJl9GoCYKLGH49FnGbCOODtuHXpav7pBUEbA5+
         2fyaT7/axRQqCQjLjP+hFis+8hxqu/Ii2ll+zkZxkloQyHQ+/2wLAzw1qZR6wDLf+8+2
         qfwNoFZGo7uCJ+PXTwQe129ZWGNGSHuPi3Z4FylAvVyT4puKBW1HAgFlM9MTjvfKNajR
         bdl1aSwKDsHCwfaSQTorM+m4BHACKgSTRnNeeVPZm8MbeCAY3scAOdeob3Ax1kkMdTKT
         jhaY1mxDbf4x50WvW1TPiC4edB6K7DvFUrVBewN0b+6SP437Mb2jYXORF6JFH5j7d8nC
         yVzA==
X-Gm-Message-State: APjAAAVaeFyZUYOcvSSNYeJHBETu63K5BQtLoWzUXlhh3WfW9IOwegL3
        lpx1tawdBEVY26Ju0HHXnnI=
X-Google-Smtp-Source: APXvYqx8Ln0AOnLHC4qAstp4iWAA4bpWgjqBdYyaCEjiL8C5OLCmtVl85ms8W08heGYvOlag1jKkeQ==
X-Received: by 2002:a17:902:b704:: with SMTP id d4mr12389934pls.54.1576816417704;
        Thu, 19 Dec 2019 20:33:37 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id z30sm11013982pfq.154.2019.12.19.20.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 20:33:37 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 7/9] perf record: Add --all-cgroups option
Date:   Fri, 20 Dec 2019 13:32:51 +0900
Message-Id: <20191220043253.3278951-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  5 ++++-
 tools/perf/builtin-record.c              |  5 +++++
 tools/perf/util/evsel.c                  | 13 ++++++++++++-
 tools/perf/util/evsel.h                  |  1 +
 tools/perf/util/record.h                 |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b23a4012a606..6dd9d69d7dee 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -385,7 +385,10 @@ displayed with the weight and local_weight sort keys.  This currently works for
 abort events and some memory events in precise mode on modern Intel CPUs.
 
 --namespaces::
-Record events of type PERF_RECORD_NAMESPACES.
+Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
+
+--all-cgroups::
+Record events of type PERF_RECORD_CGROUP.  This enables 'cgroup' sort key.
 
 --transaction::
 Record transaction flags for transaction related events.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2802de9538ff..7d7912e121d6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1433,6 +1433,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (rec->opts.record_namespaces)
 		tool->namespace_events = true;
 
+	if (rec->opts.record_cgroup)
+		tool->cgroup_events = true;
+
 	if (rec->opts.auxtrace_snapshot_mode || rec->switch_output.enabled) {
 		signal(SIGUSR2, snapshot_sig_handler);
 		if (rec->opts.auxtrace_snapshot_mode)
@@ -2363,6 +2366,8 @@ static struct option __record_options[] = {
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &record.opts.record_cgroup,
+		    "Record cgroup events"),
 	OPT_BOOLEAN(0, "switch-events", &record.opts.record_switch_events,
 		    "Record context switch events"),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &record.opts.all_kernel,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0f5a67603139..d649b5606178 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1102,6 +1102,11 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
 
+	if (opts->record_cgroup) {
+		attr->cgroup = track && !perf_missing_features.cgroup;
+		perf_evsel__set_sample_bit(evsel, CGROUP);
+	}
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -1671,6 +1676,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.ksymbol = 0;
 	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
+	if (perf_missing_features.cgroup)
+		evsel->core.attr.cgroup = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
@@ -1782,7 +1789,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+		perf_missing_features.cgroup = true;
+		pr_debug2_peo("switching off cgroup\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
 		perf_missing_features.aux_output = true;
 		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..df71b530740b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,6 +119,7 @@ struct perf_missing_features {
 	bool ksymbol;
 	bool bpf;
 	bool aux_output;
+	bool cgroup;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 5421fd2ad383..24316458be20 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -34,6 +34,7 @@ struct record_opts {
 	bool	      auxtrace_snapshot_on_exit;
 	bool	      auxtrace_sample_mode;
 	bool	      record_namespaces;
+	bool	      record_cgroup;
 	bool	      record_switch_events;
 	bool	      all_kernel;
 	bool	      all_user;
-- 
2.24.1.735.g03f4e72817-goog

