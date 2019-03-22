Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4163218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfCVWj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:39:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfCVWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:39:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMdFQg755194
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:39:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMdF9p755189;
        Fri, 22 Mar 2019 15:39:15 -0700
Date:   Fri, 22 Mar 2019 15:39:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-606f972b1361f477cbd4e6e8ac00742fde4b39db@git.kernel.org>
Cc:     sdf@google.com, mingo@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, songliubraving@fb.com,
        daniel@iogearbox.net, ast@kernel.org, namhyung@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, sdf@google.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
          ast@kernel.org, daniel@iogearbox.net, songliubraving@fb.com,
          peterz@infradead.org, tglx@linutronix.de, jolsa@kernel.org
In-Reply-To: <20190312053051.2690567-8-songliubraving@fb.com>
References: <20190312053051.2690567-8-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Save bpf_prog_info information as
 headers to perf.data
Git-Commit-ID: 606f972b1361f477cbd4e6e8ac00742fde4b39db
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

Commit-ID:  606f972b1361f477cbd4e6e8ac00742fde4b39db
Gitweb:     https://git.kernel.org/tip/606f972b1361f477cbd4e6e8ac00742fde4b39db
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:43 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:06 -0300

perf bpf: Save bpf_prog_info information as headers to perf.data

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
 tools/perf/util/header.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++-
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
