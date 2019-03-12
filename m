Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625B42171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lu2uViHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCLFbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:31:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53512 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbfCLFb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:29 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C5ORxT012572
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Wz940ZHpHhBki+8kzKaet1iYJ66x+jJjJKtTt0dRD7Y=;
 b=lu2uViHo+lmRDtMeLWuj0WOTzbDUMArzDxjDPy0/oZARMQ4bURq2ioaXio2QPOMjAUDU
 NFtaqRa7cvxlYoOyNl8W1M4pt6JIZ0dCRHDiy1nE7ZBVoLPxZXYHADni6KbxVajq9Gy6
 kS11aaxPb/HRvKWWKtpQJObGjT/jsD5/nZI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r668jg207-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:28 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:31:26 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B801D62E2019; Mon, 11 Mar 2019 22:31:25 -0700 (PDT)
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
Subject: [PATCH v9 perf,bpf 15/15] perf, bpf: save bpf_prog_info and btf of short living bpf programs
Date:   Mon, 11 Mar 2019 22:30:51 -0700
Message-ID: <20190312053051.2690567-16-songliubraving@fb.com>
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
 tools/perf/builtin-record.c |  2 +
 tools/perf/builtin-top.c    |  2 +
 tools/perf/util/bpf-event.c | 95 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 15 ++++++
 4 files changed, 114 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f792dd28d936..3c0596a68992 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1217,6 +1217,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (!opts->no_bpf_event)
+		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
 	perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target);
 
 	err = record__synthesize(rec, false);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9577dba4996b..b7790d66cac2 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1641,6 +1641,8 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
+	if (!top.record_opts.no_bpf_event)
+		bpf_event__add_sb_event(&sb_evlist, &perf_env);
 	perf_evlist__start_sb_thread(sb_evlist, target);
 
 	status = __cmd_top(&top);
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index af434de3a23e..77e0fdead6f4 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -13,6 +13,7 @@
 #include "env.h"
 #include "session.h"
 #include "map.h"
+#include "evlist.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -330,3 +331,97 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	free(event);
 	return err;
 }
+
+static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
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
+static int bpf_event__sb_cb(union perf_event *event, void *data)
+{
+	struct perf_env *env = data;
+
+	if (event->header.type != PERF_RECORD_BPF_EVENT)
+		return -1;
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		perf_env__add_bpf_info(env, event->bpf_event.id);
+
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		/*
+		 * Do not free bpf_prog_info and btf of the program here,
+		 * as annotation still need them. They will be freed at
+		 * the end of the session.
+		 */
+		break;
+	default:
+		pr_debug("unexpected bpf_event type of %d\n",
+			 event->bpf_event.type);
+		break;
+	}
+
+	return 0;
+}
+
+int bpf_event__add_sb_event(struct perf_evlist **evlist,
+			    struct perf_env *env)
+{
+	struct perf_event_attr attr = {
+		.type	          = PERF_TYPE_SOFTWARE,
+		.config           = PERF_COUNT_SW_DUMMY,
+		.sample_id_all    = 1,
+		.watermark        = 1,
+		.bpf_event        = 1,
+		.wakeup_watermark = 1,
+		.size	   = sizeof(attr), /* to capture ABI version */
+	};
+
+	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index b9ec394dc7c7..249909c826e7 100644
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
+int bpf_event__add_sb_event(struct perf_evlist **evlist,
+				 struct perf_env *env);
+
 #else
 static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
 					     union perf_event *event __maybe_unused,
@@ -46,5 +54,12 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
 {
 	return 0;
 }
+
+static int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_unused,
+				   struct perf_env *env __maybe_unused)
+{
+	return 0;
+}
+
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
-- 
2.17.1

