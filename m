Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7506B218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfCVWf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:35:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCVWf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:35:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMZK13754341
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:35:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMZJ64754334;
        Fri, 22 Mar 2019 15:35:19 -0700
Date:   Fri, 22 Mar 2019 15:35:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-71184c6ab7e60fd59d8dbc8fed62a1c753dc4934@git.kernel.org>
Cc:     mingo@kernel.org, songliubraving@fb.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        ast@kernel.org, sdf@google.com, daniel@iogearbox.net,
        jolsa@kernel.org, namhyung@kernel.org, peterz@infradead.org
Reply-To: mingo@kernel.org, songliubraving@fb.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
          jolsa@kernel.org, sdf@google.com, daniel@iogearbox.net,
          ast@kernel.org, acme@redhat.com, peterz@infradead.org
In-Reply-To: <20190312053051.2690567-2-songliubraving@fb.com>
References: <20190312053051.2690567-2-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Replace option --bpf-event with
 --no-bpf-event
Git-Commit-ID: 71184c6ab7e60fd59d8dbc8fed62a1c753dc4934
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

Commit-ID:  71184c6ab7e60fd59d8dbc8fed62a1c753dc4934
Gitweb:     https://git.kernel.org/tip/71184c6ab7e60fd59d8dbc8fed62a1c753dc4934
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:37 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:06 -0300

perf record: Replace option --bpf-event with --no-bpf-event

Currently, monitoring of BPF programs through bpf_event is off by
default for 'perf record'.

To turn it on, the user need to use option "--bpf-event".  As BPF gets
wider adoption in different subsystems, this option becomes
inconvenient.

This patch makes bpf_event on by default, and adds option "--no-bpf-event"
to turn it off. Since option --bpf-event is not released yet, it is safe
to remove it.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@fb.com
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-2-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/perf.h           | 2 +-
 tools/perf/util/bpf-event.c | 2 +-
 tools/perf/util/evsel.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e7144a1c1c82..f29874192d3e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1891,7 +1891,7 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
-	OPT_BOOLEAN(0, "bpf-event", &record.opts.bpf_event, "record bpf events"),
+	OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "record bpf events"),
 	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
 		    "Fail if the specified frequency can't be used"),
 	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index b120e547ddc7..c59743def8d3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -66,7 +66,7 @@ struct record_opts {
 	bool	     ignore_missing_thread;
 	bool	     strict_freq;
 	bool	     sample_id;
-	bool	     bpf_event;
+	bool	     no_bpf_event;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 028c8ec1f62a..ea012b735a37 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -187,7 +187,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	}
 
 	/* Synthesize PERF_RECORD_BPF_EVENT */
-	if (opts->bpf_event) {
+	if (!opts->no_bpf_event) {
 		*bpf_event = (struct bpf_event){
 			.header = {
 				.type = PERF_RECORD_BPF_EVENT,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a2023da5d9c..7835e05f0c0a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1036,7 +1036,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
 	attr->ksymbol = track && !perf_missing_features.ksymbol;
-	attr->bpf_event = track && opts->bpf_event &&
+	attr->bpf_event = track && !opts->no_bpf_event &&
 		!perf_missing_features.bpf_event;
 
 	if (opts->record_namespaces)
