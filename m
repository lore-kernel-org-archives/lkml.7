Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA4DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB544218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfCVWlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:41:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfCVWlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:41:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMeY2Q755380
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:40:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMeVDo755371;
        Fri, 22 Mar 2019 15:40:31 -0700
Date:   Fri, 22 Mar 2019 15:40:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-a70a1123174ab592c5fa8ecf09f9fad9b335b872@git.kernel.org>
Cc:     acme@redhat.com, namhyung@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, songliubraving@fb.com, sdf@google.com
Reply-To: peterz@infradead.org, ast@kernel.org, sdf@google.com,
          songliubraving@fb.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, daniel@iogearbox.net
In-Reply-To: <20190312053051.2690567-10-songliubraving@fb.com>
References: <20190312053051.2690567-10-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Save BTF information as headers to
 perf.data
Git-Commit-ID: a70a1123174ab592c5fa8ecf09f9fad9b335b872
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

Commit-ID:  a70a1123174ab592c5fa8ecf09f9fad9b335b872
Gitweb:     https://git.kernel.org/tip/a70a1123174ab592c5fa8ecf09f9fad9b335b872
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:45 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:07 -0300

perf bpf: Save BTF information as headers to perf.data

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
 tools/perf/util/header.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
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
