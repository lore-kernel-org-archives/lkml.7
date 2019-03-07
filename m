Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACBD20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="B1EfpM0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfCGSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:00:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35984 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbfCGSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:00:02 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27HsPEn012183
        for <linux-kernel@vger.kernel.org>; Thu, 7 Mar 2019 10:00:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ADdfz0XmQGhrH9L6GystOJxYSmLPUagauau8L3M7XsI=;
 b=B1EfpM0iSBiw8VQBKEspoLJcxFghXY5vh9Ft+RL5SySbTYqhclyd2Nt8eJ99GhIXzNtJ
 eyyvaOOGG0oCE9hHXZnEwfqr4SU/ivfT+kyezDcYzIQRDxxvDpQ7m4chiRXiqZ2dcoRo
 J8Pbdi6/gBm73CC9Y3dIfpstxTCcKJ4Sz+U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r37qv859j-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:00:00 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 7 Mar 2019 09:58:33 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 51CEB62E1750; Thu,  7 Mar 2019 09:58:33 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v7 perf,bpf 08/15] perf, bpf: save btf in a rbtree in perf_env
Date:   Thu, 7 Mar 2019 09:58:03 -0800
Message-ID: <20190307175810.249857-9-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190307175810.249857-1-songliubraving@fb.com>
References: <20190307175810.249857-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_09:,,
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
 tools/perf/util/env.c       | 65 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h       |  4 +++
 4 files changed, 99 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 3ae60f74339b..4ef7c833830c 100644
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
index 6e037a9660ca..d9b1299b8a6d 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -63,6 +63,57 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
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
@@ -82,6 +133,19 @@ static void perf_env__purge_bpf(struct perf_env *env)
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
 
@@ -119,6 +183,7 @@ void perf_env__exit(struct perf_env *env)
 void perf_env__init(struct perf_env *env)
 {
 	env->bpf_progs.infos = RB_ROOT;
+	env->bpf_progs.btfs = RB_ROOT;
 	init_rwsem(&env->bpf_progs.lock);
 }
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index e034e5b438e3..c3e48504e834 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -74,10 +74,12 @@ struct perf_env {
 	struct {
 		struct rw_semaphore	lock;
 		struct rb_root		infos;
+		struct rb_root		btfs;
 	} bpf_progs;
 };
 
 struct bpf_prog_info_node;
+struct btf_node;
 
 extern struct perf_env perf_env;
 
@@ -98,4 +100,6 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 #endif /* __PERF_ENV_H */
-- 
2.17.1

