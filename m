Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8DFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E644218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194486;
	bh=LW4hdLENfOgMrYLvfqLQmeVzyIGD1Dd9Nqi8rAvgPAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01gy2C8dLt7FZvzCdcICfkaS5a0xk0/My44B2LDE8Ri3XqfM0nqs2nkzw2KfVJiOE
	 03J06x6Gm9+FXq9HlWZai/h9SB3d+8xhEwqkbtwqjkVWHYUTRH8U7aTrwyTV4PlUX+
	 tmmU4vmqtY1K1fmNIsaSypINAXKROflLsKKsYhqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfCUSyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbfCUSyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:41 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4FA42192C;
        Thu, 21 Mar 2019 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194481;
        bh=LW4hdLENfOgMrYLvfqLQmeVzyIGD1Dd9Nqi8rAvgPAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1l0O5YR2urAwJhvUMH4z4uWXxyxiK2rFIQbByj7r92MD6S/SZe1X/4esxKeqJ5cy0
         nS5WRs9I3nzH+CGDDkPvETJpnNmNuTuKvgP5Mu0qkZH61A18+1qXHshw7+MD0U7mZM
         Vo25RGY3/uXlmiRKQEKKWBf4LZsMlHaeG9v8C/jE=
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
Subject: [PATCH 32/44] perf bpf: Save bpf_prog_info information as headers to perf.data
Date:   Thu, 21 Mar 2019 15:51:30 -0300
Message-Id: <20190321185142.11441-33-acme@kernel.org>
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

This patch enables perf-record to save bpf_prog_info information as
headers to perf.data. A new header type HEADER_BPF_PROG_INFO is
introduced for this data.

Committer testing:

As root, being on the kernel sources top level directory, run:

  # perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c -e *msg

Just to compile and load a BPF program that attaches to the
raw_syscalls:sys_{enter,exit} tracepoints to trace the syscalls ending
in "msg" (recvmsg, sendmsg, recvmmsg, sendmmsg, etc).

Then do a systemwide perf record session for a few seconds:

  # perf record -a sleep 2s

Then look at:

  # perf report --header-only | grep -i bpf
  # bpf_prog_info of id 13
  # bpf_prog_info of id 14
  # bpf_prog_info of id 15
  # bpf_prog_info of id 16
  # bpf_prog_info of id 17
  # bpf_prog_info of id 18
  # bpf_prog_info of id 21
  # bpf_prog_info of id 22
  # bpf_prog_info of id 208
  # bpf_prog_info of id 209
  #

We need to show more info about these programs, like bpftool does for
the ones running on the system, i.e. 'perf record/perf report' become a
way of saving the BPF state in a machine to then analyse on another,
together with all the other information that is already saved in the
perf.data header:

  # perf report --header-only
  # ========
  # captured on    : Tue Mar 12 11:42:13 2019
  # header version : 1
  # data offset    : 296
  # data size      : 16294184
  # feat offset    : 16294480
  # hostname : quaco
  # os release : 5.0.0+
  # perf version : 5.0.gd783c8
  # arch : x86_64
  # nrcpus online : 8
  # nrcpus avail : 8
  # cpudesc : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  # cpuid : GenuineIntel,6,142,10
  # total memory : 24555720 kB
  # cmdline : /home/acme/bin/perf (deleted) record -a
  # event : name = cycles:ppp, , id = { 3190123, 3190124, 3190125, 3190126, 3190127, 3190128, 3190129, 3190130 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|CPU|PERIOD, read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1
  # CPU_TOPOLOGY info available, use -I to display
  # NUMA_TOPOLOGY info available, use -I to display
  # pmu mappings: intel_pt = 8, software = 1, power = 11, uprobe = 7, uncore_imc = 12, cpu = 4, cstate_core = 18, uncore_cbox_2 = 15, breakpoint = 5, uncore_cbox_0 = 13, tracepoint = 2, cstate_pkg = 19, uncore_arb = 17, kprobe = 6, i915 = 10, msr = 9, uncore_cbox_3 = 16, uncore_cbox_1 = 14
  # CACHE info available, use -I to display
  # time of first sample : 116392.441701
  # time of last sample : 116400.932584
  # sample duration :   8490.883 ms
  # MEM_TOPOLOGY info available, use -I to display
  # bpf_prog_info of id 13
  # bpf_prog_info of id 14
  # bpf_prog_info of id 15
  # bpf_prog_info of id 16
  # bpf_prog_info of id 17
  # bpf_prog_info of id 18
  # bpf_prog_info of id 21
  # bpf_prog_info of id 22
  # bpf_prog_info of id 208
  # bpf_prog_info of id 209
  # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT
  # ========
  #

Committer notes:

We can't use the libbpf unconditionally, as the build may have been with
NO_LIBBPF, when we end up with linking errors, so provide dummy
{process,write}_bpf_prog_info() wrapped by HAVE_LIBBPF_SUPPORT for that
case.

Printing are not affected by this, so can continue as is.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20190312053051.2690567-8-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 153 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h |   1 +
 2 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b0683bf4d9f3..e6a81af516f6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -18,6 +18,7 @@
 #include <sys/utsname.h>
 #include <linux/time64.h>
 #include <dirent.h>
+#include <bpf/libbpf.h>
 
 #include "evlist.h"
 #include "evsel.h"
@@ -40,6 +41,7 @@
 #include "time-utils.h"
 #include "units.h"
 #include "cputopo.h"
+#include "bpf-event.h"
 
 #include "sane_ctype.h"
 
@@ -876,6 +878,56 @@ static int write_dir_format(struct feat_fd *ff,
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
+#ifdef HAVE_LIBBPF_SUPPORT
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
+#else // HAVE_LIBBPF_SUPPORT
+static int write_bpf_prog_info(struct feat_fd *ff __maybe_unused,
+			       struct perf_evlist *evlist __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1367,6 +1419,29 @@ static void print_dir_format(struct feat_fd *ff, FILE *fp)
 	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
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
@@ -2414,6 +2489,81 @@ static int process_dir_format(struct feat_fd *ff,
 	return do_read_u64(ff, &data->dir.version);
 }
 
+#ifdef HAVE_LIBBPF_SUPPORT
+static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
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
+#else // HAVE_LIBBPF_SUPPORT
+static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2474,7 +2624,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
 	FEAT_OPR(CLOCKID,	clockid,	false),
-	FEAT_OPN(DIR_FORMAT,	dir_format,	false)
+	FEAT_OPN(DIR_FORMAT,	dir_format,	false),
+	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 6a231340238d..1dc85f0f895d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -40,6 +40,7 @@ enum {
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
 	HEADER_DIR_FORMAT,
+	HEADER_BPF_PROG_INFO,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.20.1

