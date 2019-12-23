Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8A8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F5221655
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577081328;
	bh=46uNJRB5JBzCzs8HFKGDRpqaYuzHdJqsDNFFCtZQOeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O85K8bGCLLaike/gf06p2H82p9/I7TI7PGwx3xJV98gyMuqyymbVHi1FHhduBMssy
	 DNyQfHCTmFFsJfPiumX6zXQgvZSJ18trf1EAkd1o8KezaA6Ycf0c/Qe3cHrVBce4eV
	 c3BqbJSfWgNGlmGvUv14emeemFizDpz1NGHm5YI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfLWGIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:08:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35858 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLWGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:08:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so6037317plm.3;
        Sun, 22 Dec 2019 22:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8zFN4u1s+ibahYyH5XQDwxGFJc14mdBoek3gA8QsyM=;
        b=aME/RTy6nG0IPetzQX4qR8/nS67W4xvQztASYo0QMa+PdgZepu8J6oaMzs8ULcnDI3
         2vI4lNd+bAmfCBPOWJbk5w9jxysHPGKrbqs0Vg/q8pG+/kT4EWCNnaUuMZd7WZLgIuLo
         I+qec5UJLg/oV40fEUUSOCACS6GQ8mtD48c6OsQEbFRwHsluchJn/aXJF1GuoRiiSrDD
         irJf6C5gVgQvZHUvGo2Km5QYx/XCmXWA16uMS9pPtB4nsJFtjTrhzmGMGTclXG4S8/Jh
         dE5StifBTSAaB0bLvDhfjgld52oqJkFrGZURK6NK+QUYI5JWEbOKRN8TESWEq3IPETVC
         yxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=g8zFN4u1s+ibahYyH5XQDwxGFJc14mdBoek3gA8QsyM=;
        b=NKEo47UWb/e7Zso8chLUETotPZufelEWQq57aYyXYTuTjvbsWwKCNE5SqcnrJGILX3
         wcBZkMo6uCC/SM3uAsnjdv/3AHy+/MDEgjI3rVvRNezm6wAJ9DNy7qypcJzSmIMJL4NZ
         IfQp9buidoIDa9e/+D8mITZ640SsVOC9QxW2XO+ZsiO7Gbr6vtD/f2GgenjOBQh+Z6lX
         yiAeRQhTu9BZtes0TQIPAr9LtH6fsT35yveQG14KJvPTYVBtpG/dJPfev9/g6vI1zYBA
         LTNsZqtVlOAzxrz2AzIQFKfg9CknC9nTgXYIIK2v88KQ9RXdAdDO8MBhGsSA7PNap2Yd
         x8uA==
X-Gm-Message-State: APjAAAXNqaSZPBtXwwfOFBFEZl3N55jBlwBHXtpZkxiDS6DXzVayVK/g
        ujTy/bPqwC/4QHtAA1TuqY4=
X-Google-Smtp-Source: APXvYqw/Cw05gkMnL2UmePIu3IBjENm0fgwpFFb2o7YWlCmx+P17DmItnhgR0hFZMR8aWV0h7XPiNg==
X-Received: by 2002:a17:902:d68e:: with SMTP id v14mr14746054ply.216.1577081312512;
        Sun, 22 Dec 2019 22:08:32 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p185sm22978212pfg.61.2019.12.22.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:08:31 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 7/9] perf record: Add --all-cgroups option
Date:   Mon, 23 Dec 2019 15:07:57 +0900
Message-Id: <20191223060759.841176-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
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
 tools/perf/util/evsel.c                  | 11 ++++++++++-
 tools/perf/util/evsel.h                  |  1 +
 tools/perf/util/record.h                 |  1 +
 5 files changed, 21 insertions(+), 2 deletions(-)

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
index 0f5a67603139..ff6c6683a32b 100644
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
 
@@ -1782,7 +1787,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+	if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+		perf_missing_features.cgroup = true;
+		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
+		goto out_close;
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

