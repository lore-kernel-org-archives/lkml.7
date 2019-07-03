Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A1BC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525EC21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124489;
	bh=q7M2F4zoZ0CpIX7ww5jNqfy1l2eO6EPtwSQhPoxFxUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q9s9L5igVjiNo6HxVGZB12CnOLBRM3ZEGPcVtP3ct82HTGhQaQUgCR43U7W+6dOpM
	 U1+tzDwguaCS1yy5mWQLOa5n4EXF06VxY1FNvpSIaqn4DPWmMlUhIozRfITwhv7L7o
	 1RVnSWMI7pUHXE0NGJZizriWBSEo6uo5XA/mEZxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfGCD2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfGCD2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A316921881;
        Wed,  3 Jul 2019 03:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124486;
        bh=q7M2F4zoZ0CpIX7ww5jNqfy1l2eO6EPtwSQhPoxFxUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyZpjhOHZSrEn+0JJCtKezOnxJKRdQjZvkppW88FIraBNNHj4k/i+Rxns9AA2JLdG
         gYFLlWAU/j91Q7vTCFI1AjtvMCDVnYA8f1676sq6SpBIiRoPdkjqPb98oJmVi2aQ1n
         uVgV2febpKjo4Fq1Ai0BiRVelYgqIAzjZWJLIPag=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/18] perf hists: Add block_info in hist_entry
Date:   Wed,  3 Jul 2019 00:27:31 -0300
Message-Id: <20190703032746.21692-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The block_info contains the program basic block information, i.e,
contains the start address and the end address of this basic block and
how much cycles it takes.

We need to compare, sort and even print out the basic block by some
orders, i.e. sort by cycles.

For this purpose, we add block_info field to hist_entry. In order not to
impact current interface, we creates a new function
hists__add_entry_block.

 v6:
 ---
 Remove the 'ops' argument in hists__add_entry_block

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 20 ++++++++++++++++++--
 tools/perf/util/hist.h |  5 +++++
 tools/perf/util/sort.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fb3271fd420c..c4defff151ed 100644
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
 
@@ -712,10 +716,22 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
 				  sample, sample_self, ops);
 }
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct addr_location *al,
+					  struct block_info *block_info)
+{
+	struct hist_entry entry = {
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
index 76ff6c6d03b8..c670122b4e40 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -16,6 +16,7 @@ struct addr_location;
 struct map_symbol;
 struct mem_info;
 struct branch_info;
+struct block_info;
 struct symbol;
 
 enum hist_filter {
@@ -149,6 +150,10 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct perf_sample *sample,
 					bool sample_self);
 
+struct hist_entry *hists__add_entry_block(struct hists *hists,
+					  struct addr_location *al,
+					  struct block_info *bi);
+
 int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 			 int max_stack_depth, void *arg);
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index ce376a73f964..43623fa874b2 100644
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
2.20.1

