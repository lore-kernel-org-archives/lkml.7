Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4E20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RJ30lQxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfCSQzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:55:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727825AbfCSQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:55:06 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2JGriGO019951
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:55:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hp+mTaaT90nzSV5AtswYqF3KVxHNbMolXV039YyRoPA=;
 b=RJ30lQxCgXC96eppl67iJ2siPsR5aNwFQdjiDRKb2KZOBRSkzDcEDygWsKhXLP/5EejM
 XwLghCgo1wXB9fRXy7d0Qdo5MjpU7YvAaOCcgjD2pKihTFeRLH/kWGHOOVRbPWcmdhE2
 Q1IrkhR7AczcsEdATadapCFpjkUST5Qajvo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2raxvyh9w7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:55:05 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 19 Mar 2019 09:55:01 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 46CBC62E1F1B; Tue, 19 Mar 2019 09:55:01 -0700 (PDT)
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
Subject: [PATCH v2 perf,bpf 2/2] perf, bpf: show more BPF program info in print_bpf_prog_info()
Date:   Tue, 19 Mar 2019 09:54:54 -0700
Message-ID: <20190319165454.1298742-3-songliubraving@fb.com>
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

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 40 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 10 +++++++++-
 tools/perf/util/header.c    |  5 +++--
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index b615933c6a8c..6951712dd19b 100644
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
index 8cb1189149ec..d9cb4170ae79 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -38,7 +38,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
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
@@ -61,5 +63,11 @@ static inline int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_un
 	return 0;
 }
 
+void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				    struct perf_env *env,
+				    FILE *fp)
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
2.17.1

