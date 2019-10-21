Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF0CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751D20830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfJUG1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:27:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfJUG1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:27:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMR9Q-00027S-Fz; Mon, 21 Oct 2019 08:26:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 07C821C047B;
        Mon, 21 Oct 2019 08:26:44 +0200 (CEST)
Date:   Mon, 21 Oct 2019 06:26:43 -0000
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Fix resource leak of closedir() on the
 error paths
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <cd5f7cd2-b80d-6add-20a1-32f4f43e0744@huawei.com>
References: <cd5f7cd2-b80d-6add-20a1-32f4f43e0744@huawei.com>
MIME-Version: 1.0
Message-ID: <157163920371.29376.16536037745766899826.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6080728ff8e9c9116e52e6f840152356ac2fea56
Gitweb:        https://git.kernel.org/tip/6080728ff8e9c9116e52e6f840152356ac2fea56
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Tue, 15 Oct 2019 16:30:08 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 11:54:11 -03:00

perf tools: Fix resource leak of closedir() on the error paths

Both build_mem_topology() and rm_rf_depth_pat() have resource leaks of
closedir() on the error paths.

Fix this by calling closedir() before function returns.

Fixes: e2091cedd51b ("perf tools: Add MEM_TOPOLOGY feature to perf data file")
Fixes: cdb6b0235f17 ("perf tools: Add pattern name checking to rm_rf")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lore.kernel.org/lkml/cd5f7cd2-b80d-6add-20a1-32f4f43e0744@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 4 +++-
 tools/perf/util/util.c   | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 86d9396..becc2d1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1296,8 +1296,10 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 			continue;
 
 		if (WARN_ONCE(cnt >= size,
-			      "failed to write MEM_TOPOLOGY, way too many nodes\n"))
+			"failed to write MEM_TOPOLOGY, way too many nodes\n")) {
+			closedir(dir);
 			return -1;
+		}
 
 		ret = memory_node__read(&nodes[cnt++], idx);
 	}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 5eda6e1..ae56c76 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-		if (!match_pat(d->d_name, pat))
-			return -2;
+		if (!match_pat(d->d_name, pat)) {
+			ret =  -2;
+			break;
+		}
 
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
