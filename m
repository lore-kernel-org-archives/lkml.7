Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F345F218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfCVWka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:40:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfCVWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:40:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMds1A755238
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:39:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMdrJ9755235;
        Fri, 22 Mar 2019 15:39:53 -0700
Date:   Fri, 22 Mar 2019 15:39:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-3792cb2ff43b1b193136a03ce1336462a827d792@git.kernel.org>
Cc:     songliubraving@fb.com, namhyung@kernel.org, daniel@iogearbox.net,
        sdf@google.com, ast@kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, jolsa@kernel.org
Reply-To: sdf@google.com, songliubraving@fb.com, ast@kernel.org,
          jolsa@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, daniel@iogearbox.net,
          namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20190312053051.2690567-9-songliubraving@fb.com>
References: <20190312053051.2690567-9-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Save BTF in a rbtree in perf_env
Git-Commit-ID: 3792cb2ff43b1b193136a03ce1336462a827d792
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

Commit-ID:  3792cb2ff43b1b193136a03ce1336462a827d792
Gitweb:     https://git.kernel.org/tip/3792cb2ff43b1b193136a03ce1336462a827d792
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:44 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:07 -0300

perf bpf: Save BTF in a rbtree in perf_env

BTF contains information necessary to annotate BPF programs. This patch
saves BTF for BPF programs loaded in the system.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-9-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 23 ++++++++++++++++
 tools/perf/util/bpf-event.h |  7 +++++
 tools/perf/util/env.c       | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h       |  5 ++++
 4 files changed, 102 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 37ee4e2a728a..a4fc52b4ffae 100644
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
index 98cd36f0e317..c6351b557bb0 100644
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
@@ -86,6 +138,20 @@ static void perf_env__purge_bpf(struct perf_env *env)
 
 	env->bpf_progs.infos_cnt = 0;
 
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
+	env->bpf_progs.btfs_cnt = 0;
+
 	up_write(&env->bpf_progs.lock);
 }
 
@@ -123,6 +189,7 @@ void perf_env__exit(struct perf_env *env)
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
