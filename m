Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E48C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1DF214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bH0ZN6H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCLFcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:32:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37934 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727251AbfCLFbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:15 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C5UhDM026012
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=2tzfLyc2EVrnwKn1BzqySZzBaeNMC6PpArIzrrNrPYY=;
 b=bH0ZN6H55w+hTl3K8NHuRFUFhwnDh+ez+yZb8svwrVcdT0vjCwBbPnTk+MtuGcSEGz36
 8QAsixvsmPvfINgE3dlFEUKoIA+FgOu1OcFn/O/kCfLTqMY3/OnLEbcT1QnZssVWBpKO
 fb83ZScmM48ZUdJft+9VkcHpdZQiHptLNZ4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r644y0e0w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:14 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:31:13 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E6F3E62E2019; Mon, 11 Mar 2019 22:31:11 -0700 (PDT)
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
Subject: [PATCH v9 perf,bpf 08/15] perf, bpf: save btf in a rbtree in perf_env
Date:   Mon, 11 Mar 2019 22:30:44 -0700
Message-ID: <20190312053051.2690567-9-songliubraving@fb.com>
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

btf contains information necessary to annotate bpf programs. This patch
saves btf for bpf programs loaded in the system.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 23 +++++++++++++
 tools/perf/util/bpf-event.h |  7 ++++
 tools/perf/util/env.c       | 66 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h       |  5 +++
 4 files changed, 101 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 9013f7c29761..e02a38a98d8d 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -34,6 +34,28 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+static int perf_env__fetch_btf(struct perf_env *env,
+			       u32 btf_id,
+			       struct btf *btf)
+{
+	struct btf_node *node;
+	u32 data_size;
+	const void *data;
+
+	data = btf__get_raw_data(btf, &data_size);
+
+	node = malloc(data_size + sizeof(struct btf_node));
+	if (!node)
+		return -1;
+
+	node->id = btf_id;
+	node->data_size = data_size;
+	memcpy(node->data, data, data_size);
+
+	perf_env__insert_btf(env, node);
+	return 0;
+}
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -113,6 +135,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			goto out;
 		}
 		has_btf = true;
+		perf_env__fetch_btf(env, info->btf_id, btf);
 	}
 
 	/* Synthesize PERF_RECORD_KSYMBOL */
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index fad932f7404f..b9ec394dc7c7 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -16,6 +16,13 @@ struct bpf_prog_info_node {
 	struct rb_node			rb_node;
 };
 
+struct btf_node {
+	struct rb_node	rb_node;
+	u32		id;
+	u32		data_size;
+	char		data[];
+};
+
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf_event(struct machine *machine, union perf_event *event,
 			       struct perf_sample *sample);
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index fb82623b0822..84bdf726c6a1 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -64,6 +64,58 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 	return node;
 }
 
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+{
+	struct rb_node *parent = NULL;
+	__u32 btf_id = btf_node->id;
+	struct btf_node *node;
+	struct rb_node **p;
+
+	down_write(&env->bpf_progs.lock);
+	p = &env->bpf_progs.btfs.rb_node;
+
+	while (*p != NULL) {
+		parent = *p;
+		node = rb_entry(parent, struct btf_node, rb_node);
+		if (btf_id < node->id) {
+			p = &(*p)->rb_left;
+		} else if (btf_id > node->id) {
+			p = &(*p)->rb_right;
+		} else {
+			pr_debug("duplicated btf %u\n", btf_id);
+			goto out;
+		}
+	}
+
+	rb_link_node(&btf_node->rb_node, parent, p);
+	rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
+	env->bpf_progs.btfs_cnt++;
+out:
+	up_write(&env->bpf_progs.lock);
+}
+
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+{
+	struct btf_node *node = NULL;
+	struct rb_node *n;
+
+	down_read(&env->bpf_progs.lock);
+	n = env->bpf_progs.btfs.rb_node;
+
+	while (n) {
+		node = rb_entry(n, struct btf_node, rb_node);
+		if (btf_id < node->id)
+			n = n->rb_left;
+		else if (btf_id > node->id)
+			n = n->rb_right;
+		else
+			break;
+	}
+
+	up_read(&env->bpf_progs.lock);
+	return node;
+}
+
 /* purge data in bpf_progs.infos tree */
 static void perf_env__purge_bpf(struct perf_env *env)
 {
@@ -83,6 +135,19 @@ static void perf_env__purge_bpf(struct perf_env *env)
 		rb_erase(&node->rb_node, root);
 		free(node);
 	}
+
+	root = &env->bpf_progs.btfs;
+	next = rb_first(root);
+
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		rb_erase(&node->rb_node, root);
+		free(node);
+	}
+
 	up_write(&env->bpf_progs.lock);
 }
 
@@ -120,6 +185,7 @@ void perf_env__exit(struct perf_env *env)
 void perf_env__init(struct perf_env *env)
 {
 	env->bpf_progs.infos = RB_ROOT;
+	env->bpf_progs.btfs = RB_ROOT;
 	init_rwsem(&env->bpf_progs.lock);
 }
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 24b11c564ba4..4f8e2b485c01 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -75,10 +75,13 @@ struct perf_env {
 		struct rw_semaphore	lock;
 		struct rb_root		infos;
 		u32			infos_cnt;
+		struct rb_root		btfs;
+		u32			btfs_cnt;
 	} bpf_progs;
 };
 
 struct bpf_prog_info_node;
+struct btf_node;
 
 extern struct perf_env perf_env;
 
@@ -99,4 +102,6 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 #endif /* __PERF_ENV_H */
-- 
2.17.1

