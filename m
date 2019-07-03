Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCD5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C69121850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DdrTG2CG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGCOeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:34:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59679 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCOeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:34:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EXeKq3327977
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:33:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EXeKq3327977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164421;
        bh=4QD03aod61Bm0yGmvT6C8+Oeri7Lw+TZVcSCAW8IEXs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DdrTG2CGmXiJGC4caSt8HAA5zV/H1gF5P6Bx1eNzGuo8Er6qt9r4bWYDoJOi0FM7e
         Z2fIE+z+fPS+Cuwrp6tC+sQIUXaUupTNlru15G+uZZyj654NFk7ZIWb7tapWXhR/QT
         WkbbLlAEeQkJrpsw1F6WJj1HuKwjHHHt0IHZvE9D/8EApsN2uYF8+UT/NyhuU1JuH2
         r6105Q8aPYaIqhh1r6P1k2mPEYT5zXLy1bFcv562FM0zKyT2g+wG3wVW0Y3l3tOHq8
         oz+N5uFsZ8a0MDnzYlRDlVBMvG/edOGjMVnz3gkE/SL+foxtjQp+/g0wLUcYYCsT44
         Yc9ZsClFGn3lg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EXdgo3327974;
        Wed, 3 Jul 2019 07:33:39 -0700
Date:   Wed, 3 Jul 2019 07:33:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-fe96245c7f38c4ea92c1c599b43f176e27d9921e@git.kernel.org>
Cc:     kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, yao.jin@intel.com, yao.jin@linux.intel.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, jolsa@kernel.org
Reply-To: ak@linux.intel.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, yao.jin@linux.intel.com, jolsa@kernel.org,
          hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          kan.liang@linux.intel.com, yao.jin@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <1561713784-30533-3-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-3-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf hists: Add block_info in hist_entry
Git-Commit-ID: fe96245c7f38c4ea92c1c599b43f176e27d9921e
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

Commit-ID:  fe96245c7f38c4ea92c1c599b43f176e27d9921e
Gitweb:     https://git.kernel.org/tip/fe96245c7f38c4ea92c1c599b43f176e27d9921e
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 17:22:59 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 12:45:23 -0300

perf hists: Add block_info in hist_entry

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
