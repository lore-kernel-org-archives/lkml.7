Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED16121916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194496;
	bh=lYQ/n+Y4xHMgqy5KFfFhkHGsSUQC2fiJ3KQ/lK4k1yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zgY+wt7Tk465xCNa1mRi4lVsmyPnyeXy8Fl7VINAlgToo3Ut7uzGFInLrXBgmFCJ5
	 sI4797hBPfsIWlaHnzjiidW2EAYTFX17N0xxjYkEgD+KN98mHLVLhFNieMdJQXj7WU
	 xuZOygciLE+cmGQPO0j0svGy7C1CXN8N2zIqjY0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfCUSyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfCUSyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:52 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926FE205F4;
        Thu, 21 Mar 2019 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194491;
        bh=lYQ/n+Y4xHMgqy5KFfFhkHGsSUQC2fiJ3KQ/lK4k1yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKVXIJYxBgUDZbhEyONxF1nCc6EsnFHWzLmika/b5eXVTo+Ep+0mTXtjQEcjV63+G
         pnhlbpMUBmD1M6QJyGNinYQwDF0c6BT9/XRTcL/Mz14KTMhNObS78AkZt/bR0yuEcC
         v20KdjmIwhYdIBjtNH96g4TROa+/SU06dkHJMbtc=
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
        Stanislav Fomichev <sdf@google.com>, kernel-team@fb.com
Subject: [PATCH 34/44] perf bpf: Save BTF information as headers to perf.data
Date:   Thu, 21 Mar 2019 15:51:32 -0300
Message-Id: <20190321185142.11441-35-acme@kernel.org>
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

This patch enables 'perf record' to save BTF information as headers to
perf.data.

A new header type HEADER_BPF_BTF is introduced for this data.

Committer testing:

As root, being on the kernel sources top level directory, run:

    # perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c -e *msg

Just to compile and load a BPF program that attaches to the
raw_syscalls:sys_{enter,exit} tracepoints to trace the syscalls ending
in "msg" (recvmsg, sendmsg, recvmmsg, sendmmsg, etc).

Make sure you have a recent enough clang, say version 9, to get the
BTF ELF sections needed for this testing:

  # clang --version | head -1
  clang version 9.0.0 (https://git.llvm.org/git/clang.git/ 7906282d3afec5dfdc2b27943fd6c0309086c507) (https://git.llvm.org/git/llvm.git/ a1b5de1ff8ae8bc79dc8e86e1f82565229bd0500)
  # readelf -SW tools/perf/examples/bpf/augmented_raw_syscalls.o | grep BTF
    [22] .BTF              PROGBITS        0000000000000000 000ede 000b0e 00      0   0  1
    [23] .BTF.ext          PROGBITS        0000000000000000 0019ec 0002a0 00      0   0  1
    [24] .rel.BTF.ext      REL             0000000000000000 002fa8 000270 10     30  23  8

Then do a systemwide perf record session for a few seconds:

  # perf record -a sleep 2s

Then look at:

  # perf report --header-only | grep b[pt]f
  # event : name = cycles:ppp, , id = { 1116204, 1116205, 1116206, 1116207, 1116208, 1116209, 1116210, 1116211 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
  # bpf_prog_info of id 13
  # bpf_prog_info of id 14
  # bpf_prog_info of id 15
  # bpf_prog_info of id 16
  # bpf_prog_info of id 17
  # bpf_prog_info of id 18
  # bpf_prog_info of id 21
  # bpf_prog_info of id 22
  # bpf_prog_info of id 51
  # bpf_prog_info of id 52
  # btf info of id 8
  #

We need to show more info about these BPF and BTF entries , but that can
be done later.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-10-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 101 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h |   1 +
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e6a81af516f6..01dda2f65d36 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -928,6 +928,39 @@ static int write_bpf_prog_info(struct feat_fd *ff __maybe_unused,
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
+static int write_bpf_btf(struct feat_fd *ff,
+			 struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+	int ret;
+
+	down_read(&env->bpf_progs.lock);
+
+	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
+		       sizeof(env->bpf_progs.btfs_cnt));
+
+	if (ret < 0)
+		goto out;
+
+	root = &env->bpf_progs.btfs;
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
@@ -1442,6 +1475,28 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
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
@@ -2564,6 +2619,49 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
+static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	u32 count, i;
+
+	if (ff->ph->needs_swap) {
+		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
+		return 0;
+	}
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
@@ -2625,7 +2723,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
 	FEAT_OPR(CLOCKID,	clockid,	false),
 	FEAT_OPN(DIR_FORMAT,	dir_format,	false),
-	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
+	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
+	FEAT_OPR(BPF_BTF,       bpf_btf,        false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 1dc85f0f895d..386da49e1bfa 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -41,6 +41,7 @@ enum {
 	HEADER_CLOCKID,
 	HEADER_DIR_FORMAT,
 	HEADER_BPF_PROG_INFO,
+	HEADER_BPF_BTF,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.20.1

