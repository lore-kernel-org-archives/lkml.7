Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A306E2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfCVWrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:47:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfCVWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:47:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMkTc0758039
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:46:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMkTpR758036;
        Fri, 22 Mar 2019 15:46:29 -0700
Date:   Fri, 22 Mar 2019 15:46:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-fc462ac75b36daaa61e9bda7fba66ed1b3a500b4@git.kernel.org>
Cc:     songliubraving@fb.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        ast@kernel.org, sdf@google.com, hpa@zytor.com, jolsa@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, namhyung@kernel.org
Reply-To: mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          daniel@iogearbox.net, hpa@zytor.com, songliubraving@fb.com,
          namhyung@kernel.org, peterz@infradead.org, ast@kernel.org,
          sdf@google.com, acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20190319165454.1298742-2-songliubraving@fb.com>
References: <20190319165454.1298742-2-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Extract logic to create program names
 from perf_event__synthesize_one_bpf_prog()
Git-Commit-ID: fc462ac75b36daaa61e9bda7fba66ed1b3a500b4
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

Commit-ID:  fc462ac75b36daaa61e9bda7fba66ed1b3a500b4
Gitweb:     https://git.kernel.org/tip/fc462ac75b36daaa61e9bda7fba66ed1b3a500b4
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Tue, 19 Mar 2019 09:54:53 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 21 Mar 2019 11:27:04 -0300

perf bpf: Extract logic to create program names from perf_event__synthesize_one_bpf_prog()

Extract logic to create program names to synthesize_bpf_prog_name(), so
that it can be reused in header.c:print_bpf_prog_info().

This commit doesn't change the behavior.

Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190319165454.1298742-2-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 62 +++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 2a8c245ca942..d5b041649f26 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -111,6 +111,38 @@ static int perf_env__fetch_btf(struct perf_env *env,
 	return 0;
 }
 
+static int synthesize_bpf_prog_name(char *buf, int size,
+				    struct bpf_prog_info *info,
+				    struct btf *btf,
+				    u32 sub_id)
+{
+	u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags);
+	void *func_infos = (void *)(uintptr_t)(info->func_info);
+	u32 sub_prog_cnt = info->nr_jited_ksyms;
+	const struct bpf_func_info *finfo;
+	const char *short_name = NULL;
+	const struct btf_type *t;
+	int name_len;
+
+	name_len = snprintf(buf, size, "bpf_prog_");
+	name_len += snprintf_hex(buf + name_len, size - name_len,
+				 prog_tags[sub_id], BPF_TAG_SIZE);
+	if (btf) {
+		finfo = func_infos + sub_id * info->func_info_rec_size;
+		t = btf__type_by_id(btf, finfo->type_id);
+		short_name = btf__name_by_offset(btf, t->name_off);
+	} else if (sub_id == 0 && sub_prog_cnt == 1) {
+		/* no subprog */
+		if (info->name[0])
+			short_name = info->name;
+	} else
+		short_name = "F";
+	if (short_name)
+		name_len += snprintf(buf + name_len, size - name_len,
+				     "_%s", short_name);
+	return name_len;
+}
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -135,7 +167,6 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 	struct bpf_prog_info_node *info_node;
 	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
-	bool has_btf = false;
 	struct perf_env *env;
 	u32 sub_prog_cnt, i;
 	int err = 0;
@@ -189,19 +220,13 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			btf = NULL;
 			goto out;
 		}
-		has_btf = true;
 		perf_env__fetch_btf(env, info->btf_id, btf);
 	}
 
 	/* Synthesize PERF_RECORD_KSYMBOL */
 	for (i = 0; i < sub_prog_cnt; i++) {
-		u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(uintptr_t)(info->prog_tags);
-		__u32 *prog_lens  = (__u32 *)(uintptr_t)(info->jited_func_lens);
+		__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
 		__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
-		void *func_infos  = (void *)(uintptr_t)(info->func_info);
-		const struct bpf_func_info *finfo;
-		const char *short_name = NULL;
-		const struct btf_type *t;
 		int name_len;
 
 		*ksymbol_event = (struct ksymbol_event){
@@ -214,26 +239,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF,
 			.flags = 0,
 		};
-		name_len = snprintf(ksymbol_event->name, KSYM_NAME_LEN,
-				    "bpf_prog_");
-		name_len += snprintf_hex(ksymbol_event->name + name_len,
-					 KSYM_NAME_LEN - name_len,
-					 prog_tags[i], BPF_TAG_SIZE);
-		if (has_btf) {
-			finfo = func_infos + i * info->func_info_rec_size;
-			t = btf__type_by_id(btf, finfo->type_id);
-			short_name = btf__name_by_offset(btf, t->name_off);
-		} else if (i == 0 && sub_prog_cnt == 1) {
-			/* no subprog */
-			if (info->name[0])
-				short_name = info->name;
-		} else
-			short_name = "F";
-		if (short_name)
-			name_len += snprintf(ksymbol_event->name + name_len,
-					     KSYM_NAME_LEN - name_len,
-					     "_%s", short_name);
 
+		name_len = synthesize_bpf_prog_name(ksymbol_event->name,
+						    KSYM_NAME_LEN, info, btf, i);
 		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
 							 sizeof(u64));
 
