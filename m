Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97243C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642A6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fMasOW4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCLFbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:31:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49506 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727078AbfCLFbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:00 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2C5Nuuk015315
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:30:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=FKyla0QQJmABdIegC7k5TNI5N68m/ViLaeiBzOrc3T8=;
 b=fMasOW4/nPLQWQjcW4tKMiPwRhNrpn18aL/HZy5YpCb9JgnkDdio2o25k9jbArUaU4Jq
 DYqbcqVRvO5Tr21RmF/gQ2J+/rszCdDsEnLJqJcS8XAyjYmv3ct7Sf/hjhXK5bm8ltZv
 4Au555B8+ZlD8BBuf6ICgiGJby6HxX9IZPg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2r667b826k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:30:59 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:30:58 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 0BCB762E2019; Mon, 11 Mar 2019 22:30:56 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v9 perf,bpf 01/15] perf-record: replace option --bpf-event with --no-bpf-event
Date:   Mon, 11 Mar 2019 22:30:37 -0700
Message-ID: <20190312053051.2690567-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312053051.2690567-1-songliubraving@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, monitoring of BPF programs through bpf_event is off by default
for perf-record. To turn it on, the user need to use option "--bpf-event".
As BPF gets wider adoption in different subsystems, this option becomes
inconvinient.

This patch makes bpf_event on by default, and adds option "--no-bpf-event"
to turn it off. Since option --bpf-event is not released yet, it is safe
to remove it.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/perf.h           | 2 +-
 tools/perf/util/bpf-event.c | 2 +-
 tools/perf/util/evsel.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f3f7f3100336..458dcd0cc0e7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1870,7 +1870,7 @@ static struct option __record_options[] = {
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
index 3bbf73e979c0..bda4a968762d 100644
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
2.17.1

