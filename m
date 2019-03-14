Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E571C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A120811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LpPV/Z5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfCNSZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:25:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39832 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727814AbfCNSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:25:51 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EIPnhR001472
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:25:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=830Mg/wijT0PLFqrHCfyVEw3VcP7HavW/LmK5w0hH70=;
 b=LpPV/Z5emzQzzg8qEWP0lsQV8vc0K4/cqk8OfmjVDG6++A+2YLfVYzVrDvU5H3qiJm/L
 8KH2a8E75u8mSTjgtf/PVCKnyrlySexS/EHoovOkz3dvhyovGF6/XAs0MhGgYgDjPKmM
 mR6ovUXz7GTjtfW0EVIpztqxW4hk2/G7kro= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r7gxuj9rx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:25:50 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 14 Mar 2019 11:25:48 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CBCE362E1D1C; Thu, 14 Mar 2019 11:25:46 -0700 (PDT)
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
Subject: [PATCH perf,bpf 2/2] perf, bpf: show BPF program name in print_bpf_prog_info()
Date:   Thu, 14 Mar 2019 11:25:37 -0700
Message-ID: <20190314182538.1294526-3-songliubraving@fb.com>
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

This patch enables showing bpf program name in the header.

Before the patch:

  perf report --header-only
  ...
  # bpf_prog_info of id 9
  # bpf_prog_info of id 10
  # bpf_prog_info of id 13

After the patch:

  # bpf_prog_info 9: bpf_prog_7be49e3934a125ba
  # bpf_prog_info 10: bpf_prog_2a142ef67aaad174
  # bpf_prog_info 13: bpf_prog_47368425825d7384_task__task_newt

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 36 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 10 +++++++++-
 tools/perf/util/header.c    |  5 +++--
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 6e035e08aa2d..dde35a36e2de 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -433,3 +433,39 @@ int bpf_event__add_sb_event(struct perf_evlist **evlist,
 
 	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
 }
+
+void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				    struct perf_env *env,
+				    FILE *fp)
+{
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
+		fprintf(fp, "# bpf_prog_info %u: %s\n", info->id, name);
+		return;
+	}
+
+	fprintf(fp, "# bpf_prog_info %u:\n", info->id);
+	for (i = 0; i < sub_prog_cnt; i++) {
+		synthesize_bpf_prog_name(name, KSYM_NAME_LEN, info, btf, i);
+
+		fprintf(fp, "# \tsub_prog %u: %s\n", i, name);
+	}
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 249909c826e7..4270dfd9cde9 100644
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
@@ -61,5 +63,11 @@ static int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_unused,
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
index 7decd2d1dbda..588a80bdd500 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1434,8 +1434,9 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 
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

