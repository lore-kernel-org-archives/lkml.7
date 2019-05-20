Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97959C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7721F2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfETFiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:38:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:24180 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbfETFiM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:38:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 May 2019 22:38:12 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2019 22:38:11 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 7/9] perf diff: Compute cycles diff of basic blocks
Date:   Mon, 20 May 2019 21:27:54 +0800
Message-Id: <1558358876-32211-8-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
References: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have already linked up the same basic blocks.
Now we compute the cycles diff value of basic blocks, in order to
sort by diff cycles later.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/sort.h    |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 72c33ab..47e34a3 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1132,6 +1132,31 @@ static void block_hists_match(struct hists *hists_base,
 	}
 }
 
+static void compute_block_hists_diff(struct block_hists *block_hists,
+				     struct data__file *d)
+{
+	struct hists *hists = &block_hists->hists;
+	struct rb_root_cached *root = hists->entries_in;
+	struct rb_node *next = rb_first_cached(root);
+
+	while (next != NULL) {
+		struct hist_entry *he = rb_entry(next, struct hist_entry,
+						 rb_node_in);
+		struct hist_entry *pair = get_pair_data(he, d);
+
+		next = rb_next(&he->rb_node_in);
+
+		if (pair) {
+			pair->diff.computed = true;
+			if (pair->block_info->num && he->block_info->num) {
+				pair->diff.cycles_diff =
+					pair->block_info->cycles_aggr / pair->block_info->num_aggr -
+					he->block_info->cycles_aggr / he->block_info->num_aggr;
+			}
+		}
+	}
+}
+
 static void basic_block_process(void)
 {
 	struct hists *hists_base = &data__files[0].block_hists.hists;
@@ -1151,6 +1176,12 @@ static void basic_block_process(void)
 		block_hists_match(hists_base, hists);
 	}
 
+	data__for_each_file_new(i, d) {
+		hists = &d->block_hists.hists;
+		d->hists = hists;
+		compute_block_hists_diff(&data__files[0].block_hists, d);
+	}
+
 	data__for_each_file(i, d) {
 		hists__delete_entries(&d->block_hists.sym_hists);
 		hists__delete_entries(&d->block_hists.hists);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 43623fa..de9e61a 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -79,6 +79,8 @@ struct hist_entry_diff {
 
 		/* HISTC_WEIGHTED_DIFF */
 		s64	wdiff;
+
+		s64     cycles_diff;
 	};
 };
 
-- 
2.7.4

