Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41331C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F322246F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKLLSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33586 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfKLLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBD-0000F5-OF; Tue, 12 Nov 2019 12:17:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B7541C0084;
        Tue, 12 Nov 2019 12:17:51 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:51 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf diff: Don't use hack to skip column length calculation
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191107074719.26139-2-yao.jin@linux.intel.com>
References: <20191107074719.26139-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157355747111.29376.17426346123468487029.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0bdf181fe0e5b6f6d5764ff482d7ae4707f8986b
Gitweb:        https://git.kernel.org/tip/0bdf181fe0e5b6f6d5764ff482d7ae4707f8986b
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Thu, 07 Nov 2019 15:47:13 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 09:08:03 -03:00

perf diff: Don't use hack to skip column length calculation

Previously we use a nasty hack to skip the hists__calc_col_len for block
since this function is not very suitable for block column length
calculation.

This patch removes the hack code and add a check at the entry of
hists__calc_col_len to skip for block case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 11 ++---------
 tools/perf/util/hist.c    |  2 ++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 5281629..faf99a8 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -765,13 +765,6 @@ static void block_hists_match(struct hists *hists_base,
 	}
 }
 
-static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
-{
-	/* Skip the calculation of column length in output_resort */
-	he->filtered = true;
-	return 0;
-}
-
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -820,8 +813,8 @@ static void hists__precompute(struct hists *hists)
 				if (bh->valid && pair_bh->valid) {
 					block_hists_match(&bh->block_hists,
 							  &pair_bh->block_hists);
-					hists__output_resort_cb(&pair_bh->block_hists,
-								NULL, filter_cb);
+					hists__output_resort(&pair_bh->block_hists,
+							     NULL);
 				}
 				break;
 			default:
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 679a1d7..daa6eef 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -80,6 +80,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	int symlen;
 	u16 len;
 
+	if (h->block_info)
+		return;
 	/*
 	 * +4 accounts for '[x] ' priv level info
 	 * +2 accounts for 0x prefix on raw addresses
