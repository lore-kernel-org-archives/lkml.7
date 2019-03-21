Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FE320657
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194536;
	bh=aBnwpYeGycUO/yn6ZP5L94pp1uErJDPVc21ZOO7Yu+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z2T2e50DyCZMo4ZnoN1SB2ROeEJfVKHrL0LCsdnj0jiCTcMBGqBqrs1bEBHjMM7oy
	 jbD7Ib5bIW1gmww41IVbQ8vedUl0DQNal/B0dMP5JQsNzykYs2dEtoZ8fPsvrkcPlg
	 RWPG6tZOrtf12xX2w3YOy3h4h3v2M+soIpHCFXBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfCUSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbfCUSzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:55:31 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB8420643;
        Thu, 21 Mar 2019 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194530;
        bh=aBnwpYeGycUO/yn6ZP5L94pp1uErJDPVc21ZOO7Yu+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3CjoCqJKtAJGFdH8RRI5c1mue5rQwQSboVyNuReN/Xgkr/PKyOmWjxk8scuBT9Tr
         oFROae8AX7eRI86ZNC3EHuoO3mcrmpYUQ/vWgyJPlCXd5XpMCMPMIfapG2mroKJ4MB
         lVGKQvD0173Z2sJDHG9XhJ+YFMKH5YNNHNI2l2cw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH 44/44] perf bpf: Show more BPF program info in print_bpf_prog_info()
Date:   Thu, 21 Mar 2019 15:51:42 -0300
Message-Id: <20190321185142.11441-45-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

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
 tools/perf/util/bpf-event.c | 40 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 11 +++++++++-
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
-- 
2.20.1

