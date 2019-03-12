Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DC3214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LAbWaoJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCLFbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:31:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbfCLFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:12 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C5UKcM026756
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=IMyuFsUCRSPrsY6Ihrsgmodgk9U0e/rsLqf4IADZFbc=;
 b=LAbWaoJ7Pllwdud0gFUwTD1M912eKQy+qKEp9xICVXcqdM1XfImqhbvPC2Jz2iBvTMHf
 rCp1bVoOTO9xPGv31SY9N2sH7mCYddppRTwSnrK7L6kBHSSGWwWdh9bnJaxOhFJT4Kct
 +uRc0oOBvrhGCqg2DSNQgmeyNMV9+0lm8Pw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r64rs097f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:31:09 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B2F1762E2019; Mon, 11 Mar 2019 22:31:05 -0700 (PDT)
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
Subject: [PATCH v9 perf,bpf 05/15] perf: change prototype of perf_event__synthesize_bpf_events()
Date:   Mon, 11 Mar 2019 22:30:41 -0700
Message-ID: <20190312053051.2690567-6-songliubraving@fb.com>
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

This patch changes the arguments of perf_event__synthesize_bpf_events()
to include perf_session* instead of perf_tool*. perf_session will be used
in the next patch.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/util/bpf-event.c | 8 +++++---
 tools/perf/util/bpf-event.h | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 458dcd0cc0e7..2d34039c4246 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1093,7 +1093,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_bpf_events(tool, process_synthesized_event,
+	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 231a90daa958..09c0721c97df 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1212,7 +1212,7 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
-	ret = perf_event__synthesize_bpf_events(&top->tool, perf_event__process,
+	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
 	if (ret < 0)
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index e9d9854be506..eedd0f7dfe0c 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -10,6 +10,7 @@
 #include "debug.h"
 #include "symbol.h"
 #include "machine.h"
+#include "session.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -42,7 +43,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
  *   -1 for failures;
  *   -2 for lack of kernel support.
  */
-static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
+static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       perf_event__handler_t process,
 					       struct machine *machine,
 					       int fd,
@@ -52,6 +53,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
 	struct bpf_event *bpf_event = &event->bpf_event;
 	struct bpf_prog_info_linear *info_linear;
+	struct perf_tool *tool = session->tool;
 	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
 	bool has_btf = false;
@@ -175,7 +177,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	return err ? -1 : 0;
 }
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts)
@@ -209,7 +211,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			continue;
 		}
 
-		err = perf_event__synthesize_one_bpf_prog(tool, process,
+		err = perf_event__synthesize_one_bpf_prog(session, process,
 							  machine, fd,
 							  event, opts);
 		close(fd);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 7890067e1a37..6698683612a7 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -15,7 +15,7 @@ struct record_opts;
 int machine__process_bpf_event(struct machine *machine, union perf_event *event,
 			       struct perf_sample *sample);
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
@@ -27,7 +27,7 @@ static inline int machine__process_bpf_event(struct machine *machine __maybe_unu
 	return 0;
 }
 
-static inline int perf_event__synthesize_bpf_events(struct perf_tool *tool __maybe_unused,
+static inline int perf_event__synthesize_bpf_events(struct perf_session *session __maybe_unused,
 						    perf_event__handler_t process __maybe_unused,
 						    struct machine *machine __maybe_unused,
 						    struct record_opts *opts __maybe_unused)
-- 
2.17.1

