Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C942C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031392087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CiMkJqRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfCKT4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728812AbfCKT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:42 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BJt4bw013644
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=YWXsYdST2zmeSXglNx6IFiwx+yjYXyzauDldq7sU6d4=;
 b=CiMkJqRxz5igQYk/i8M7Ac+AVhzJUrrJHifZspk3GYx2/VDYP1QuW7UU9q4vbeff2vjg
 HSansm4NHKz0tPuvjarOZD0J5Q7ccClKRdPd4EweDFYFNGMkIwmzlsO/KSGr3kWw5ThR
 6fPyAHHJ5I24XpOTHjIULawHfOywerkbTwM= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2r5vc4rexa-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:56:42 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 12:56:33 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CEC4762E1B7E; Mon, 11 Mar 2019 12:56:31 -0700 (PDT)
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
Subject: [PATCH v8 perf,bpf 07/15] perf, bpf: save bpf_prog_info information as headers to perf.data
Date:   Mon, 11 Mar 2019 12:55:47 -0700
Message-ID: <20190311195555.889995-8-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311195555.889995-1-songliubraving@fb.com>
References: <20190311195555.889995-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables perf-record to save bpf_prog_info information as
headers to perf.data. A new header type HEADER_BPF_PROG_INFO is
introduced for this data.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/header.c | 139 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h |   1 +
 2 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4b88de5e9192..e53ee3111430 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -18,6 +18,7 @@
 #include <sys/utsname.h>
 #include <linux/time64.h>
 #include <dirent.h>
+#include <bpf/libbpf.h>
 
 #include "evlist.h"
 #include "evsel.h"
@@ -39,6 +40,7 @@
 #include "tool.h"
 #include "time-utils.h"
 #include "units.h"
+#include "bpf-event.h"
 
 #include "sane_ctype.h"
 
@@ -1074,6 +1076,48 @@ static int write_clockid(struct feat_fd *ff,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
+static int write_bpf_prog_info(struct feat_fd *ff,
+			       struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+	int ret;
+
+	down_read(&env->bpf_progs.lock);
+
+	ret = do_write(ff, &env->bpf_progs.infos_cnt,
+		       sizeof(env->bpf_progs.infos_cnt));
+	if (ret < 0)
+		goto out;
+
+	root = &env->bpf_progs.infos;
+	next = rb_first(root);
+	while (next) {
+		struct bpf_prog_info_node *node;
+		size_t len;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+		len = sizeof(struct bpf_prog_info_linear) +
+			node->info_linear->data_len;
+
+		/* before writing to file, translate address to offset */
+		bpf_program__bpil_addr_to_offs(node->info_linear);
+		ret = do_write(ff, node->info_linear, len);
+		/*
+		 * translate back to address even when do_write() fails,
+		 * so that this function never changes the data.
+		 */
+		bpf_program__bpil_offs_to_addr(node->info_linear);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	up_read(&env->bpf_progs.lock);
+	return ret;
+}
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1554,6 +1598,29 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.clockid_res_ns * 1000);
 }
 
+static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_read(&env->bpf_progs.lock);
+
+	root = &env->bpf_progs.infos;
+	next = rb_first(root);
+
+	while (next) {
+		struct bpf_prog_info_node *node;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+		fprintf(fp, "# bpf_prog_info of id %u\n",
+			node->info_linear->info.id);
+	}
+
+	up_read(&env->bpf_progs.lock);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2586,6 +2653,75 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_bpf_prog_info(struct feat_fd *ff,
+				 void *data __maybe_unused)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct perf_env *env = &ff->ph->env;
+	u32 count, i;
+	int err = -1;
+
+	if (ff->ph->needs_swap) {
+		pr_warning("interpreting bpf_prog_info from systems with endianity is not yet supported\n");
+		return 0;
+	}
+
+	if (do_read_u32(ff, &count))
+		return -1;
+
+	down_write(&env->bpf_progs.lock);
+
+	for (i = 0; i < count; ++i) {
+		u32 info_len, data_len;
+
+		info_linear = NULL;
+		info_node = NULL;
+		if (do_read_u32(ff, &info_len))
+			goto out;
+		if (do_read_u32(ff, &data_len))
+			goto out;
+
+		if (info_len > sizeof(struct bpf_prog_info)) {
+			pr_warning("detected invalid bpf_prog_info\n");
+			goto out;
+		}
+
+		info_linear = malloc(sizeof(struct bpf_prog_info_linear) +
+				     data_len);
+		if (!info_linear)
+			goto out;
+		info_linear->info_len = sizeof(struct bpf_prog_info);
+		info_linear->data_len = data_len;
+		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
+			goto out;
+		if (__do_read(ff, &info_linear->info, info_len))
+			goto out;
+		if (info_len < sizeof(struct bpf_prog_info))
+			memset(((void *)(&info_linear->info)) + info_len, 0,
+			       sizeof(struct bpf_prog_info) - info_len);
+
+		if (__do_read(ff, info_linear->data, data_len))
+			goto out;
+
+		info_node = malloc(sizeof(struct bpf_prog_info_node));
+		if (!info_node)
+			goto out;
+
+		/* after reading from file, translate offset to address */
+		bpf_program__bpil_offs_to_addr(info_linear);
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+	}
+
+	return 0;
+out:
+	free(info_linear);
+	free(info_node);
+	up_write(&env->bpf_progs.lock);
+	return err;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2645,7 +2781,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
-	FEAT_OPR(CLOCKID,       clockid,        false)
+	FEAT_OPR(CLOCKID,       clockid,        false),
+	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0d553ddca0a3..0785c91b4c3a 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -39,6 +39,7 @@ enum {
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
+	HEADER_BPF_PROG_INFO,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.17.1

