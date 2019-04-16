Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300EAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E6E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfDPP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:28:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfDPP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:28:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GFS7xx3494522
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 08:28:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GFS71q3494519;
        Tue, 16 Apr 2019 08:28:07 -0700
Date:   Tue, 16 Apr 2019 08:28:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-14c9b31a925a9f5c647523a12e2b575b97c0aa47@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, songliubraving@fb.com,
        gustavo@embeddedor.com, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, jolsa@redhat.com, namhyung@kernel.org
Reply-To: jolsa@redhat.com, namhyung@kernel.org, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, gustavo@embeddedor.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          songliubraving@fb.com, hpa@zytor.com
In-Reply-To: <20190408173355.GA10501@embeddedor>
References: <20190408173355.GA10501@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf header: Fix lock/unlock imbalances when
 processing BPF/BTF info
Git-Commit-ID: 14c9b31a925a9f5c647523a12e2b575b97c0aa47
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

Commit-ID:  14c9b31a925a9f5c647523a12e2b575b97c0aa47
Gitweb:     https://git.kernel.org/tip/14c9b31a925a9f5c647523a12e2b575b97c0aa47
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Mon, 8 Apr 2019 12:33:55 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Apr 2019 11:26:43 -0300

perf header: Fix lock/unlock imbalances when processing BPF/BTF info

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
