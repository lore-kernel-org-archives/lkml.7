Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93826C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574892171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="R1YjOHy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfB1FHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:07:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730975AbfB1FHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:07:24 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S54rv8004102
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=YXo/IcTa7ZQ5MGQ0eDsg3DkV+WYqVL0dB8XhWsmnnzA=;
 b=R1YjOHy+5N/IWO/LpP11E7+iUH3JRxjy/zl9kWg6nXbaX0x5ELIvO+qBf72H08+DOJAD
 1U0w0r0ZHbP29C7AwM+SuZYNILlNsqKayMNXx5EyLNz7qBMEZ8D3IAxemgVrdiHOS3/H
 HcplqGwtxvON6IeNR+ggwSDKVTtEQN+neCw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx5s90j2u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:21 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 21:07:20 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AF21B62E2B27; Wed, 27 Feb 2019 21:07:20 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf,bpf 15/15] perf, bpf: save bpf_prog_info and btf of short living bpf programs
Date:   Wed, 27 Feb 2019 21:06:43 -0800
Message-ID: <20190228050643.958685-16-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228050643.958685-1-songliubraving@fb.com>
References: <20190228050643.958685-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fully annotate BPF programs with source code mapping, 4 different
information are needed:
    1) PERF_RECORD_KSYMBOL
    2) PERF_RECORD_BPF_EVENT
    3) bpf_prog_info
    4) btf

This patch handles 3) and 4) for short living BPF programs. For timely
process of these information, a dedicated event is added to the side
band evlist. When PERF_RECORD_BPF_EVENT is received via the side band
event, the polling thread gathers 3) and 4) vis sys_bpf and store them
in perf_env. These information are saved to perf.data at the end of
perf-record.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c |  3 ++
 tools/perf/builtin-top.c    |  3 ++
 tools/perf/util/bpf-event.c | 66 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 18 ++++++++++
 tools/perf/util/evlist.c    |  5 +++
 5 files changed, 95 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d10c1d5a9e89..ce26d37c2871 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1207,6 +1207,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (opts->bpf_event)
+		bpf_event__add_polling_event();
+
 	poll_args.env = &session->header.env;
 	poll_args.done = &done;
 	perf_evlist__start_polling_thread(&rec->opts.target, &poll_args);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f41545445917..851c4dcce66f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1655,6 +1655,9 @@ int cmd_top(int argc, const char **argv)
 
 	top.record_opts.bpf_event = !top.no_bpf_event;
 
+	if (top.record_opts.bpf_event)
+		bpf_event__add_polling_event();
+
 	poll_args.env = &perf_env;
 	poll_args.done = &done;
 	perf_evlist__start_polling_thread(target, &poll_args);
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 048ef00371ad..664906237ffb 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -12,6 +12,7 @@
 #include "machine.h"
 #include "env.h"
 #include "session.h"
+#include "evlist.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -332,3 +333,68 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	free(event);
 	return err;
 }
+
+void perf_env__add_bpf_info(struct perf_env *env, u32 id)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct btf *btf = NULL;
+	u64 arrays;
+	u32 btf_id;
+	int fd;
+
+	fd = bpf_prog_get_fd_by_id(id);
+	if (fd < 0)
+		return;
+
+	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
+
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
+		goto out;
+	}
+
+	btf_id = info_linear->info.btf_id;
+
+	info_node = malloc(sizeof(struct bpf_prog_info_node));
+	if (info_node) {
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+	} else
+		free(info_linear);
+
+	if (btf_id == 0)
+		goto out;
+
+	if (btf__get_from_id(btf_id, &btf)) {
+		pr_debug("%s: failed to get BTF of id %u, aborting\n",
+			 __func__, btf_id);
+		goto out;
+	}
+	perf_env__fetch_btf(env, btf_id, btf);
+
+out:
+	free(btf);
+	close(fd);
+}
+
+int bpf_event__add_polling_event(void)
+{
+	struct perf_event_attr attr = {
+		.type	          = PERF_TYPE_SOFTWARE,
+		.config           = PERF_COUNT_SW_DUMMY,
+		.watermark        = 1,
+		.bpf_event        = 1,
+		.wakeup_watermark = 1,
+		.size	   = sizeof(attr), /* to capture ABI version */
+	};
+
+	return perf_evlist__new_side_band_event(&attr);
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index b9ec394dc7c7..03a6f018e219 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -4,12 +4,17 @@
 
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
+#include <pthread.h>
+#include <api/fd/array.h>
 #include "event.h"
 
 struct machine;
 union perf_event;
+struct perf_env;
 struct perf_sample;
 struct record_opts;
+struct evlist;
+struct target;
 
 struct bpf_prog_info_node {
 	struct bpf_prog_info_linear	*info_linear;
@@ -31,6 +36,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
+int bpf_event__add_polling_event(void);
+void perf_env__add_bpf_info(struct perf_env *env, u32 id);
+
 #else
 static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
 					     union perf_event *event __maybe_unused,
@@ -46,5 +54,15 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
 {
 	return 0;
 }
+
+static inline int bpf_event__add_polling_event(void)
+{
+	return 0;
+}
+
+void perf_env__add_bpf_info(struct perf_env *env __maybe_unused,
+			    u32 id __maybe_unused)
+{
+}
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 61b87c8111e6..58ac42878c0a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1886,6 +1886,11 @@ static void *perf_evlist__poll_thread(void *arg)
 				pr_debug("processing vip event of type %d\n",
 					 event->header.type);
 				switch (event->header.type) {
+				case PERF_RECORD_BPF_EVENT:
+					if (event->bpf_event.type != PERF_BPF_EVENT_PROG_LOAD)
+						break;
+					perf_env__add_bpf_info(args->env, event->bpf_event.id);
+					break;
 				default:
 					break;
 				}
-- 
2.17.1

