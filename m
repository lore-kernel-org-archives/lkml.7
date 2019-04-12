Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C980C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9AB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555079015;
	bh=KcZc/Q87mSZdaxKAP2rQR8iwxlfMxkYHuvN2OZV2L10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WurLt4iOLzYuXM7m7Jq57hwgukhCafrbq/iaz9Hu/+DwITlsyX7t5YbO1pH1bmU9w
	 F9C0KbsMikbjpFXoKv1jpMRNTWsgllA3Or+qjop8iXgNJBb8rV8PA+VxhbEhOBtvld
	 P3GbNaw+H5lW+fP8KJJ8lnHHHJ/XQaLEcKQihNqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDLOXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfDLOXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:23:32 -0400
Received: from quaco.ghostprotocols.net (177-58-174-75.3g.claro.net.br [177.58.174.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E65920818;
        Fri, 12 Apr 2019 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555079012;
        bh=KcZc/Q87mSZdaxKAP2rQR8iwxlfMxkYHuvN2OZV2L10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVAQ5JBignfKChZuAokoowCgptCJWcfazh3o019fu/tY+SVWv6HSDTLHS0Bizd2Cb
         g0HcZgO7DNBebAKojQZdnJ+ChWFZJPQwENhoXIv5dlSj+0lvFA6xp6mDkTpHw84zwQ
         B14KRphrKq8AT8d22ohseQ3/lcu69Axufhk7KNzc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/7] perf header: Fix lock/unlock imbalances when processing BPF/BTF info
Date:   Fri, 12 Apr 2019 11:22:46 -0300
Message-Id: <20190412142250.20595-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Fix lock/unlock imbalances by refactoring the code a bit and adding
calls to up_write() before return.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Addresses-Coverity-ID: 1444315 ("Missing unlock")
Addresses-Coverity-ID: 1444316 ("Missing unlock")
Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.data")
Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Link: http://lkml.kernel.org/r/20190408173355.GA10501@embeddedor
[ Simplified the exit path to have just one up_write() + return ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b9e693825873..2d2af2ac2b1e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
+	up_write(&env->bpf_progs.lock);
 	return 0;
 out:
 	free(info_linear);
@@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_env *env = &ff->ph->env;
+	struct btf_node *node = NULL;
 	u32 count, i;
+	int err = -1;
 
 	if (ff->ph->needs_swap) {
 		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
@@ -2636,31 +2639,32 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	down_write(&env->bpf_progs.lock);
 
 	for (i = 0; i < count; ++i) {
-		struct btf_node *node;
 		u32 id, data_size;
 
 		if (do_read_u32(ff, &id))
-			return -1;
+			goto out;
 		if (do_read_u32(ff, &data_size))
-			return -1;
+			goto out;
 
 		node = malloc(sizeof(struct btf_node) + data_size);
 		if (!node)
-			return -1;
+			goto out;
 
 		node->id = id;
 		node->data_size = data_size;
 
-		if (__do_read(ff, node->data, data_size)) {
-			free(node);
-			return -1;
-		}
+		if (__do_read(ff, node->data, data_size))
+			goto out;
 
 		perf_env__insert_btf(env, node);
+		node = NULL;
 	}
 
+	err = 0;
+out:
 	up_write(&env->bpf_progs.lock);
-	return 0;
+	free(node);
+	return err;
 }
 
 struct feature_ops {
-- 
2.20.1

