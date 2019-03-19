Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179F720835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LiQcC43K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfCSQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:55:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34726 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727691AbfCSQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:55:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2JGklmI028163
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=YkJK+QDQeU0RAeiicWK1naakK302b4E3rfK83ukBeow=;
 b=LiQcC43KT9gUVkuXkSScuZqOVPXXOFr1VVSslYQPKEIc7HL0+b2wiOxX5d1CGGIx55Gx
 raP97o8h3daZu2F5Wy8m9I/TALWGTXNuC48dHU1Bbz1710eNqEG0T5lMsEfJN2w85H/a
 asqHgUmqu4dCmSOUOirvhStcBSJ5fElGZY0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2rb36fragh-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:55:03 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 19 Mar 2019 09:55:01 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B669162E1F1B; Tue, 19 Mar 2019 09:54:59 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 perf,bpf 1/2] perf, bpf: refactor perf_event__synthesize_one_bpf_prog()
Date:   Tue, 19 Mar 2019 09:54:53 -0700
Message-ID: <20190319165454.1298742-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190319165454.1298742-1-songliubraving@fb.com>
References: <20190319165454.1298742-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract logic to create program names to synthesize_bpf_prog_name(), so
that it can be reused in header.c:print_bpf_prog_info().

This commit doesn't change the behavior.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 62 +++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 8fadd0471a9a..b615933c6a8c 100644
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
 
-- 
2.17.1

