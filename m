Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6452075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfCVWrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:47:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54485 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfCVWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:47:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMlA4R758107
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:47:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMl72P758096;
        Fri, 22 Mar 2019 15:47:07 -0700
Date:   Fri, 22 Mar 2019 15:47:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-f8dfeae009effc0b6dac2741cf8d7cbb91edb982@git.kernel.org>
Cc:     songliubraving@fb.com, jolsa@kernel.org, hpa@zytor.com,
        acme@redhat.com, peterz@infradead.org, ast@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, sdf@google.com,
        daniel@iogearbox.net
Reply-To: tglx@linutronix.de, sdf@google.com, daniel@iogearbox.net,
          mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
          songliubraving@fb.com, jolsa@kernel.org, ast@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190319165454.1298742-3-songliubraving@fb.com>
References: <20190319165454.1298742-3-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Show more BPF program info in
 print_bpf_prog_info()
Git-Commit-ID: f8dfeae009effc0b6dac2741cf8d7cbb91edb982
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

Commit-ID:  f8dfeae009effc0b6dac2741cf8d7cbb91edb982
Gitweb:     https://git.kernel.org/tip/f8dfeae009effc0b6dac2741cf8d7cbb91edb982
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Tue, 19 Mar 2019 09:54:54 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 21 Mar 2019 11:27:04 -0300

perf bpf: Show more BPF program info in print_bpf_prog_info()

This patch enables showing bpf program name, address, and size in the
header.

Before the patch:

  perf report --header-only
  ...
  # bpf_prog_info of id 9
  # bpf_prog_info of id 10
  # bpf_prog_info of id 13

After the patch:

  # bpf_prog_info 9: bpf_prog_7be49e3934a125ba addr 0xffffffffa0024947 size 229
  # bpf_prog_info 10: bpf_prog_2a142ef67aaad174 addr 0xffffffffa007c94d size 229
  # bpf_prog_info 13: bpf_prog_47368425825d7384_task__task_newt addr 0xffffffffa0251137 size 369

Committer notes:

Fix the fallback definition when HAVE_LIBBPF_SUPPORT is not defined,
i.e. add the missing 'static inline' and add the __maybe_unused to the
args. Also add stdio.h since we now use FILE * in bpf-event.h.

Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190319165454.1298742-3-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 11 ++++++++++-
 tools/perf/util/header.c    |  5 +++--
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index d5b041649f26..2a4a0da35632 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -438,3 +438,43 @@ int bpf_event__add_sb_event(struct perf_evlist **evlist,
 
 	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
 }
+
+void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				    struct perf_env *env,
+				    FILE *fp)
+{
+	__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
+	__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
+	char name[KSYM_NAME_LEN];
+	struct btf *btf = NULL;
+	u32 sub_prog_cnt, i;
+
+	sub_prog_cnt = info->nr_jited_ksyms;
+	if (sub_prog_cnt != info->nr_prog_tags ||
+	    sub_prog_cnt != info->nr_jited_func_lens)
+		return;
+
+	if (info->btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(env, info->btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	if (sub_prog_cnt == 1) {
+		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, 0);
+		fprintf(fp, "# bpf_prog_info %u: %s addr 0x%llx size %u\n",
+			info->id, name, prog_addrs[0], prog_lens[0]);
+		return;
+	}
+
+	fprintf(fp, "# bpf_prog_info %u:\n", info->id);
+	for (i = 0; i < sub_prog_cnt; i++) {
+		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, i);
+
+		fprintf(fp, "# \tsub_prog %u: %s addr 0x%llx size %u\n",
+			i, name, prog_addrs[i], prog_lens[i]);
+	}
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 8cb1189149ec..04c33b3bfe28 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -7,6 +7,7 @@
 #include <pthread.h>
 #include <api/fd/array.h>
 #include "event.h"
+#include <stdio.h>
 
 struct machine;
 union perf_event;
@@ -38,7 +39,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      struct record_opts *opts);
 int bpf_event__add_sb_event(struct perf_evlist **evlist,
 				 struct perf_env *env);
-
+void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				    struct perf_env *env,
+				    FILE *fp);
 #else
 static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
 					     union perf_event *event __maybe_unused,
@@ -61,5 +64,11 @@ static inline int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_un
 	return 0;
 }
 
+static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
+						  struct perf_env *env __maybe_unused,
+						  FILE *fp __maybe_unused)
+{
+
+}
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 01dda2f65d36..b9e693825873 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1468,8 +1468,9 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 
 		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
 		next = rb_next(&node->rb_node);
-		fprintf(fp, "# bpf_prog_info of id %u\n",
-			node->info_linear->info.id);
+
+		bpf_event__print_bpf_prog_info(&node->info_linear->info,
+					       env, fp);
 	}
 
 	up_read(&env->bpf_progs.lock);
