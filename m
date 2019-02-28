Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440A1218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dPm6Pe07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfB1FIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:08:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730900AbfB1FHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:07:12 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1S52MCs020153
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=f75OzOV8t/NIIVTsztaDCpTFpn3lcoCkIWgCVc9kl+s=;
 b=dPm6Pe076FBAIMQpxcdaXnBqqAwOSAYZpX0Hod3NooME3NtfHlwavvPkTZ6V8nj5tsCI
 lWGVNc40s+pxizyZcar838yUcfkSZsMpRa6/vaHpCFKNw7Bz9NLk5FO5jZ/N6t/ppMIh
 c+t9KfEEXYPBRIp7uogdx0vb555cDSLjmwA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qx6r6rcsh-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 21:07:11 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 21:07:09 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id ABD5162E2B27; Wed, 27 Feb 2019 21:07:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf,bpf 09/15] perf, bpf: save btf information as headers to perf.data
Date:   Wed, 27 Feb 2019 21:06:37 -0800
Message-ID: <20190228050643.958685-10-songliubraving@fb.com>
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

This patch enables perf-record to save btf information as headers to
perf.data A new header type HEADER_BPF_BTF is introduced for this data.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/header.c | 108 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h |   1 +
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 16f5bedb0b7d..3df8428c4c91 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1121,6 +1121,45 @@ static int write_bpf_prog_info(struct feat_fd *ff,
 	return ret;
 }
 
+static int write_bpf_btf(struct feat_fd *ff,
+			 struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+	u32 count = 0;
+	int ret;
+
+	down_read(&env->bpf_progs.lock);
+
+	root = &env->bpf_progs.btfs;
+	next = rb_first(root);
+	while (next) {
+		++count;
+		next = rb_next(next);
+	}
+
+	ret = do_write(ff, &count, sizeof(count));
+
+	if (ret < 0)
+		goto out;
+
+	next = rb_first(root);
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		ret = do_write(ff, &node->id,
+			       sizeof(u32) * 2 + node->data_size);
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
@@ -1624,6 +1663,28 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 	up_read(&env->bpf_progs.lock);
 }
 
+static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_read(&env->bpf_progs.lock);
+
+	root = &env->bpf_progs.btfs;
+	next = rb_first(root);
+
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		fprintf(fp, "# btf info of id %u\n", node->id);
+	}
+
+	up_read(&env->bpf_progs.lock);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2726,6 +2787,50 @@ static int process_bpf_prog_info(struct feat_fd *ff,
 	return err;
 }
 
+static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	u32 count, i;
+
+	if (do_read_u32(ff, &count))
+		return -1;
+
+	down_write(&env->bpf_progs.lock);
+
+	for (i = 0; i < count; ++i) {
+		struct btf_node *node;
+		u32 id, data_size;
+
+		if (do_read_u32(ff, &id))
+			return -1;
+		if (do_read_u32(ff, &data_size))
+			return -1;
+
+		node = malloc(sizeof(struct btf_node) + data_size);
+		if (!node)
+			return -1;
+
+		node->id = id;
+		node->data_size = data_size;
+
+		if (__do_read(ff, node->data, data_size)) {
+			free(node);
+			return -1;
+		}
+
+		/* endian mismatch, drop the btf, continue */
+		if (ff->ph->needs_swap) {
+			free(node);
+			continue;
+		}
+
+		perf_env__insert_btf(env, node);
+	}
+
+	up_write(&env->bpf_progs.lock);
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2786,7 +2891,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
 	FEAT_OPR(CLOCKID,       clockid,        false),
-	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
+	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
+	FEAT_OPR(BPF_BTF,       bpf_btf,        false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0785c91b4c3a..9e7d931f7c0d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -40,6 +40,7 @@ enum {
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
 	HEADER_BPF_PROG_INFO,
+	HEADER_BPF_BTF,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.17.1

