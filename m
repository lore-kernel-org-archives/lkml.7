Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B7DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525EB204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfF0GUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:20:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:39130 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF0GUC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:20:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 23:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="156135493"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2019 23:20:00 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 2/7] perf util: Add block_info in hist_entry
Date:   Thu, 27 Jun 2019 22:09:24 +0800
Message-Id: <1561644569-22306-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
References: <1561644569-22306-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block_info contains the program basic block information, i.e,
contains the start address and the end address of this basic block and
how much cycles it takes. We need to compare, sort and even print out
the basic block by some orders, i.e. sort by cycles.

For this purpose, we add block_info field to hist_entry. In order not to
impact current interface, we creates a new function hists__add_entry_block.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/hist.c | 22 ++++++++++++++++++++--
 tools/perf/util/hist.h |  6 ++++++
 tools/perf/util/sort.h |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fb3271f..680ad93 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -574,6 +574,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 */
 			mem_info__zput(entry->mem_info);
 
+			block_info__zput(entry->block_info);
+
 			/* If the map of an existing hist_entry has
 			 * become out-of-date due to an exec() or
 			 * similar, update it.  Otherwise we will
@@ -645,6 +647,7 @@ __hists__add_entry(struct hists *hists,
 		   struct symbol *sym_parent,
 		   struct branch_info *bi,
 		   struct mem_info *mi,
+		   struct block_info *block_info,
 		   struct perf_sample *sample,
 		   bool sample_self,
 		   struct hist_entry_ops *ops)
@@ -677,6 +680,7 @@ __hists__add_entry(struct hists *hists,
 		.hists	= hists,
 		.branch_info = bi,
 		.mem_info = mi,
+		.block_info = block_info,
 		.transaction = sample->transaction,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
@@ -699,7 +703,7 @@ struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct perf_sample *sample,
 				    bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
 				  sample, sample_self, NULL);
 }
 
@@ -712,10 +716,24 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
 				  sample, sample_self, ops);
 }
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct hist_entry_ops *ops,
+					  struct addr_location *al,
+					  struct block_info *block_info)
+{
+	struct hist_entry entry = {
+		.ops = ops,
+		.block_info = block_info,
+		.hists = hists,
+	}, *he = hists__findnew_entry(hists, &entry, al, false);
+
+	return he;
+}
+
 static int
 iter_next_nop_entry(struct hist_entry_iter *iter __maybe_unused,
 		    struct addr_location *al __maybe_unused)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 76ff6c6..c8f7d66 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -16,6 +16,7 @@ struct addr_location;
 struct map_symbol;
 struct mem_info;
 struct branch_info;
+struct block_info;
 struct symbol;
 
 enum hist_filter {
@@ -149,6 +150,11 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self);
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct hist_entry_ops *ops,
+					  struct addr_location *al,
+					  struct block_info *bi);
+
 int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 			 int max_stack_depth, void *arg);
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index ce376a7..43623fa 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -144,6 +144,7 @@ struct hist_entry {
 	long			time;
 	struct hists		*hists;
 	struct mem_info		*mem_info;
+	struct block_info	*block_info;
 	void			*raw_data;
 	u32			raw_size;
 	int			num_res;
-- 
2.7.4

