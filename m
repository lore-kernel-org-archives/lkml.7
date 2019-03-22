Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2136BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DB221925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCVWhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:37:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCVWhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:37:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMbJR9754755
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:37:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMbIE8754752;
        Fri, 22 Mar 2019 15:37:18 -0700
Date:   Fri, 22 Mar 2019 15:37:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-a742258af131e570a68ad8cf16cd2cc4692675a0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        daniel@iogearbox.net, sdf@google.com, ast@kernel.org,
        hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, songliubraving@fb.com,
        peterz@infradead.org
Reply-To: sdf@google.com, daniel@iogearbox.net, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, ast@kernel.org,
          acme@redhat.com, jolsa@kernel.org, songliubraving@fb.com,
          peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de
In-Reply-To: <20190312053051.2690567-5-songliubraving@fb.com>
References: <20190312053051.2690567-5-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Synthesize bpf events with
 bpf_program__get_prog_info_linear()
Git-Commit-ID: a742258af131e570a68ad8cf16cd2cc4692675a0
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

Commit-ID:  a742258af131e570a68ad8cf16cd2cc4692675a0
Gitweb:     https://git.kernel.org/tip/a742258af131e570a68ad8cf16cd2cc4692675a0
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:40 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:06 -0300

perf bpf: Synthesize bpf events with bpf_program__get_prog_info_linear()

With bpf_program__get_prog_info_linear, we can simplify the logic that
synthesizes bpf events.

This patch doesn't change the behavior of the code.

Commiter notes:

Needed this (for all four variables), suggested by Song, to overcome
build failure on debian experimental cross building to MIPS 32-bit:

  -               u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
  +               u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags);

  util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
  util/bpf-event.c:143:35: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
                                     ^
  util/bpf-event.c:144:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     __u32 *prog_lens = (__u32 *)(info->jited_func_lens);
                        ^
  util/bpf-event.c:145:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     __u64 *prog_addrs = (__u64 *)(info->jited_ksyms);
                         ^
  util/bpf-event.c:146:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     void *func_infos = (void *)(info->func_info);
                        ^
  cc1: all warnings being treated as errors

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@fb.com
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-5-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 118 +++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 78 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index ea012b735a37..e0cbe7f87170 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -3,7 +3,9 @@
 #include <stdlib.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
+#include <bpf/libbpf.h>
 #include <linux/btf.h>
+#include <linux/err.h>
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
@@ -49,99 +51,62 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 {
 	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
 	struct bpf_event *bpf_event = &event->bpf_event;
-	u32 sub_prog_cnt, i, func_info_rec_size = 0;
-	u8 (*prog_tags)[BPF_TAG_SIZE] = NULL;
-	struct bpf_prog_info info = { .type = 0, };
-	u32 info_len = sizeof(info);
-	void *func_infos = NULL;
-	u64 *prog_addrs = NULL;
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
-	u32 *prog_lens = NULL;
 	bool has_btf = false;
-	char errbuf[512];
+	u32 sub_prog_cnt, i;
 	int err = 0;
+	u64 arrays;
 
-	/* Call bpf_obj_get_info_by_fd() to get sizes of arrays */
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
 
-	if (err) {
-		pr_debug("%s: failed to get BPF program info: %s, aborting\n",
-			 __func__, str_error_r(errno, errbuf, sizeof(errbuf)));
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		info_linear = NULL;
+		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
 		return -1;
 	}
-	if (info_len < offsetof(struct bpf_prog_info, prog_tags)) {
+
+	if (info_linear->info_len < offsetof(struct bpf_prog_info, prog_tags)) {
 		pr_debug("%s: the kernel is too old, aborting\n", __func__);
 		return -2;
 	}
 
+	info = &info_linear->info;
+
 	/* number of ksyms, func_lengths, and tags should match */
-	sub_prog_cnt = info.nr_jited_ksyms;
-	if (sub_prog_cnt != info.nr_prog_tags ||
-	    sub_prog_cnt != info.nr_jited_func_lens)
+	sub_prog_cnt = info->nr_jited_ksyms;
+	if (sub_prog_cnt != info->nr_prog_tags ||
+	    sub_prog_cnt != info->nr_jited_func_lens)
 		return -1;
 
 	/* check BTF func info support */
-	if (info.btf_id && info.nr_func_info && info.func_info_rec_size) {
+	if (info->btf_id && info->nr_func_info && info->func_info_rec_size) {
 		/* btf func info number should be same as sub_prog_cnt */
-		if (sub_prog_cnt != info.nr_func_info) {
+		if (sub_prog_cnt != info->nr_func_info) {
 			pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
-			return -1;
-		}
-		if (btf__get_from_id(info.btf_id, &btf)) {
-			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info.btf_id);
-			return -1;
+			err = -1;
+			goto out;
 		}
-		func_info_rec_size = info.func_info_rec_size;
-		func_infos = calloc(sub_prog_cnt, func_info_rec_size);
-		if (!func_infos) {
-			pr_debug("%s: failed to allocate memory for func_infos, aborting\n", __func__);
-			return -1;
+		if (btf__get_from_id(info->btf_id, &btf)) {
+			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
+			err = -1;
+			btf = NULL;
+			goto out;
 		}
 		has_btf = true;
 	}
 
-	/*
-	 * We need address, length, and tag for each sub program.
-	 * Allocate memory and call bpf_obj_get_info_by_fd() again
-	 */
-	prog_addrs = calloc(sub_prog_cnt, sizeof(u64));
-	if (!prog_addrs) {
-		pr_debug("%s: failed to allocate memory for prog_addrs, aborting\n", __func__);
-		goto out;
-	}
-	prog_lens = calloc(sub_prog_cnt, sizeof(u32));
-	if (!prog_lens) {
-		pr_debug("%s: failed to allocate memory for prog_lens, aborting\n", __func__);
-		goto out;
-	}
-	prog_tags = calloc(sub_prog_cnt, BPF_TAG_SIZE);
-	if (!prog_tags) {
-		pr_debug("%s: failed to allocate memory for prog_tags, aborting\n", __func__);
-		goto out;
-	}
-
-	memset(&info, 0, sizeof(info));
-	info.nr_jited_ksyms = sub_prog_cnt;
-	info.nr_jited_func_lens = sub_prog_cnt;
-	info.nr_prog_tags = sub_prog_cnt;
-	info.jited_ksyms = ptr_to_u64(prog_addrs);
-	info.jited_func_lens = ptr_to_u64(prog_lens);
-	info.prog_tags = ptr_to_u64(prog_tags);
-	info_len = sizeof(info);
-	if (has_btf) {
-		info.nr_func_info = sub_prog_cnt;
-		info.func_info_rec_size = func_info_rec_size;
-		info.func_info = ptr_to_u64(func_infos);
-	}
-
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
-	if (err) {
-		pr_debug("%s: failed to get BPF program info, aborting\n", __func__);
-		goto out;
-	}
-
 	/* Synthesize PERF_RECORD_KSYMBOL */
 	for (i = 0; i < sub_prog_cnt; i++) {
+		u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags);
+		__u32 *prog_lens  = (__u32 *)(uintptr_t)(info->jited_func_lens);
+		__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
+		void *func_infos  = (void *)(uintptr_t)(info->func_info);
 		const struct bpf_func_info *finfo;
 		const char *short_name = NULL;
 		const struct btf_type *t;
@@ -163,13 +128,13 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 					 KSYM_NAME_LEN - name_len,
 					 prog_tags[i], BPF_TAG_SIZE);
 		if (has_btf) {
-			finfo = func_infos + i * info.func_info_rec_size;
+			finfo = func_infos + i * info->func_info_rec_size;
 			t = btf__type_by_id(btf, finfo->type_id);
 			short_name = btf__name_by_offset(btf, t->name_off);
 		} else if (i == 0 && sub_prog_cnt == 1) {
 			/* no subprog */
-			if (info.name[0])
-				short_name = info.name;
+			if (info->name[0])
+				short_name = info->name;
 		} else
 			short_name = "F";
 		if (short_name)
@@ -195,9 +160,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			},
 			.type = PERF_BPF_EVENT_PROG_LOAD,
 			.flags = 0,
-			.id = info.id,
+			.id = info->id,
 		};
-		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
+		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
 		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
@@ -205,10 +170,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	}
 
 out:
-	free(prog_tags);
-	free(prog_lens);
-	free(prog_addrs);
-	free(func_infos);
+	free(info_linear);
 	free(btf);
 	return err ? -1 : 0;
 }
