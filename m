Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A16FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D27218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xlNHOb3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfGCOgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:36:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGCOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:36:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EZn2A3328238
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:35:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EZn2A3328238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164550;
        bh=G5FkcvtJiukOlfqJqw1fFdgIbdaGtZzPZJnoABLmduo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xlNHOb3DrR0zjs31qZCP9eeIDarvbKlDJY29gG7a+gDLwRQiDv/PaGbzIu/lMWBka
         g1/WkNSc8cmyTXQ74lQGKS0db5hHTreShC8ysQkvVvc9HuojcqcRWIkew8nvJpENZg
         pFQON6fDaRAk0EVXUDfmAjDIpKpAn5mQ1hTZ1dtQABQpGZYspzJY0tIHoNBXjBCJqh
         z9Q9aRMmg/O8oNWbWlUukClT6LrG48DIkCuJrOkSAWjc+p3zuWpSCRSS1Ey+fQ2eNl
         1keGlB6/dtyBBlL6JGp0no8/07D2HHVlDIpLtaA1kGcnusVyAObkpwFRmKmsr/+kcu
         639FFgel5W7sQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EZn3T3328235;
        Wed, 3 Jul 2019 07:35:49 -0700
Date:   Wed, 3 Jul 2019 07:35:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-f3810817b20645ffae809feb30e9fe260fbd6c4d@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
        yao.jin@linux.intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        acme@redhat.com, jolsa@kernel.org
Reply-To: acme@redhat.com, jolsa@kernel.org, ak@linux.intel.com,
          peterz@infradead.org, kan.liang@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, yao.jin@intel.com,
          linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
          hpa@zytor.com
In-Reply-To: <1561713784-30533-6-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-6-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf diff: Link same basic blocks among different
 data
Git-Commit-ID: f3810817b20645ffae809feb30e9fe260fbd6c4d
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

Commit-ID:  f3810817b20645ffae809feb30e9fe260fbd6c4d
Gitweb:     https://git.kernel.org/tip/f3810817b20645ffae809feb30e9fe260fbd6c4d
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 17:23:02 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 13:20:15 -0300

perf diff: Link same basic blocks among different data

The target is to compare the performance difference (cycles diff) for
the same basic blocks in different data files.

The same basic block means same function, same start address and same
end address. This patch finds the same basic blocks from different data
files and link them together and resort by the cycles diff.

 v3:
 ---
 The block stuffs are maintained by new structure 'block_hist',
 so this patch is update accordingly.

 v2:
 ---
 Since now the basic block hists is changed to per symbol,
 the patch only links the basic block hists for the same
 symbol in different data files.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-6-git-send-email-yao.jin@linux.intel.com
[ sym->name is an array, not a pointer, so no need to check it for NULL, fixes de build in some distros ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 83b8c0f3fb16..fafb7b3f58fb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -641,6 +641,82 @@ static int process_block_per_sym(struct hist_entry *he)
 	return 0;
 }
 
+static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
+{
+	struct block_info *bi_a = a->block_info;
+	struct block_info *bi_b = b->block_info;
+	int cmp;
+
+	if (!bi_a->sym || !bi_b->sym)
+		return -1;
+
+	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
+
+	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
+		return 0;
+
+	return -1;
+}
+
+static struct hist_entry *get_block_pair(struct hist_entry *he,
+					 struct hists *hists_pair)
+{
+	struct rb_root_cached *root = hists_pair->entries_in;
+	struct rb_node *next = rb_first_cached(root);
+	int cmp;
+
+	while (next != NULL) {
+		struct hist_entry *he_pair = rb_entry(next, struct hist_entry,
+						      rb_node_in);
+
+		next = rb_next(&he_pair->rb_node_in);
+
+		cmp = block_pair_cmp(he_pair, he);
+		if (!cmp)
+			return he_pair;
+	}
+
+	return NULL;
+}
+
+static void compute_cycles_diff(struct hist_entry *he,
+				struct hist_entry *pair)
+{
+	pair->diff.computed = true;
+	if (pair->block_info->num && he->block_info->num) {
+		pair->diff.cycles =
+			pair->block_info->cycles_aggr / pair->block_info->num_aggr -
+			he->block_info->cycles_aggr / he->block_info->num_aggr;
+	}
+}
+
+static void block_hists_match(struct hists *hists_base,
+			      struct hists *hists_pair)
+{
+	struct rb_root_cached *root = hists_base->entries_in;
+	struct rb_node *next = rb_first_cached(root);
+
+	while (next != NULL) {
+		struct hist_entry *he = rb_entry(next, struct hist_entry,
+						 rb_node_in);
+		struct hist_entry *pair = get_block_pair(he, hists_pair);
+
+		next = rb_next(&he->rb_node_in);
+
+		if (pair) {
+			hist_entry__add_pair(pair, he);
+			compute_cycles_diff(he, pair);
+		}
+	}
+}
+
+static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
+{
+	/* Skip the calculation of column length in output_resort */
+	he->filtered = true;
+	return 0;
+}
+
 static void hists__precompute(struct hists *hists)
 {
 	struct rb_root_cached *root;
@@ -653,6 +729,7 @@ static void hists__precompute(struct hists *hists)
 
 	next = rb_first_cached(root);
 	while (next != NULL) {
+		struct block_hist *bh, *pair_bh;
 		struct hist_entry *he, *pair;
 		struct data__file *d;
 		int i;
@@ -681,6 +758,16 @@ static void hists__precompute(struct hists *hists)
 				break;
 			case COMPUTE_CYCLES:
 				process_block_per_sym(pair);
+				bh = container_of(he, struct block_hist, he);
+				pair_bh = container_of(pair, struct block_hist,
+						       he);
+
+				if (bh->valid && pair_bh->valid) {
+					block_hists_match(&bh->block_hists,
+							  &pair_bh->block_hists);
+					hists__output_resort_cb(&pair_bh->block_hists,
+								NULL, filter_cb);
+				}
 				break;
 			default:
 				BUG_ON(1);
