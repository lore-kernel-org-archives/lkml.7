Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E455921925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194461;
	bh=7gaG9JPq6za4P8+XC/VSDDJEVErVw0eYY2v+eoNkXEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jmZIXS6/w+vvUKDlX+7aCp+wXAIVh5WtTTx/H3SFKz4FYwS0nZCcr8TrXac/x6UQV
	 C5kZKw/SrflhQVMYZshq/VJz64zLI8rbnWsGuqs+yQ4dbzl5bYH2HDxwWI171EgD3Y
	 CSFoKdba6QPfw1ymfTQiebqGAmllw+gv6Jd/cfkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfCUSyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbfCUSyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:17 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BC221873;
        Thu, 21 Mar 2019 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194456;
        bh=7gaG9JPq6za4P8+XC/VSDDJEVErVw0eYY2v+eoNkXEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfvCZz1iYJHWuFOk3tz6dw7iXJpVSX25RK+K4ZSmdkMyAlSbP5o4T1jBSyMsj5O4N
         S6oxnokAT2gNrKFKQ873Mesg1A/1YBb4aJszyT9x2Dn+yWiaOq0Nh4Ql/Qbski3dfL
         cuv5Y+gDe5S51O8tRmD33XpII2hBrxSsFJ99fxD8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/44] perf record: Replace option --bpf-event with --no-bpf-event
Date:   Thu, 21 Mar 2019 15:51:24 -0300
Message-Id: <20190321185142.11441-27-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

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
-- 
2.20.1

