Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D50320811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b+nyE/zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfCNSZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:25:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727553AbfCNSZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:25:48 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EIOtno030610
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:25:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=B1SjuVkEekeS8eDhbeoNBTknnolzEwu4k1xRDrNETn0=;
 b=b+nyE/zRlpCzW0w8yYKzwF+5WkjHClQ4dNQjQNbf+ylesZ7vNVBV+MGNXWRSvOyLxGbs
 5DIPX8M4U/ge4wEuOMr/CVL55rdxalZveGwkUz/iL2jkqURuhGSryjTtTjh9Sv6b+a3y
 rqb6GlddyRvDU0d69Ef21l/DFsQzgMHuj20= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r7u9k07fw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:25:46 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 14 Mar 2019 11:25:45 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E943862E1D1C; Thu, 14 Mar 2019 11:25:44 -0700 (PDT)
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
Subject: [PATCH perf,bpf 1/2] perf, bpf: refactor perf_event__synthesize_one_bpf_prog()
Date:   Thu, 14 Mar 2019 11:25:36 -0700
Message-ID: <20190314182538.1294526-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314182538.1294526-1-songliubraving@fb.com>
References: <20190314182538.1294526-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
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
 tools/perf/util/bpf-event.c | 60 +++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 3c01055a8c99..6e035e08aa2d 100644
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
 		__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
 		__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
-		void *func_infos = (void *)(uintptr_t)(info->func_info);
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

