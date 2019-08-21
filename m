Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC866C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52C4233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfHUMsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:48:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:30850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbfHUMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:48:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="207724944"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2019 05:48:12 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 6/6] perf/x86/intel/pt: Get rid of reverse lookup table for ToPA
Date:   Wed, 21 Aug 2019 15:47:27 +0300
Message-Id: <20190821124727.73310-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to quickly find a ToPA entry by its page offset in the buffer,
we're using a reverse lookup table. The problem with it is that it's a
large array of mostly similar pointers, especially so now that we're
using high order allocations from the page allocator. Because its size
is limited to whatever is the maximum for kmalloc(), it places a limit
on the number of ToPA entries per buffer, and therefore, on the total
buffer size, which otherwise doesn't have to be there.

Replace the reverse lookup table with a simple runtime lookup. With the
high order AUX allocations in place, the runtime penalty of such a lookup
is much smaller and in cases where all entries in a ToPA table are of
the same size, the complexity is O(1).

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 194 ++++++++++++++++++++++++-------------
 arch/x86/events/intel/pt.h |  10 +-
 2 files changed, 131 insertions(+), 73 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 5965e9493c8b..4972c727d5c5 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -551,12 +551,14 @@ static void pt_config_buffer(void *buf, unsigned int topa_idx,
  * @offset:	offset of the first entry in this table in the buffer
  * @size:	total size of all entries in this table
  * @last:	index of the last initialized entry in this table
+ * @z_count:	how many times the first entry repeats
  */
 struct topa {
 	struct list_head	list;
 	u64			offset;
 	size_t			size;
 	int			last;
+	unsigned int		z_count;
 };
 
 /*
@@ -598,6 +600,7 @@ static inline phys_addr_t topa_pfn(struct topa *topa)
 		? &topa_to_page(t)->table[(t)->last]	\
 		: &topa_to_page(t)->table[(i)])
 #define TOPA_ENTRY_SIZE(t, i) (sizes(TOPA_ENTRY((t), (i))->size))
+#define TOPA_ENTRY_PAGES(t, i) (1 << TOPA_ENTRY((t), (i))->size)
 
 /**
  * topa_alloc() - allocate page-sized ToPA table
@@ -713,6 +716,11 @@ static int topa_insert_pages(struct pt_buffer *buf, int cpu, gfp_t gfp)
 		topa_insert_table(buf, topa);
 	}
 
+	if (topa->z_count == topa->last - 1) {
+		if (order == TOPA_ENTRY(topa, topa->last - 1)->size)
+			topa->z_count++;
+	}
+
 	TOPA_ENTRY(topa, -1)->base = page_to_phys(p) >> TOPA_SHIFT;
 	TOPA_ENTRY(topa, -1)->size = order;
 	if (!buf->snapshot &&
@@ -756,6 +764,8 @@ static void pt_topa_dump(struct pt_buffer *buf)
 			     tp->table[i].stop) ||
 			    tp->table[i].end)
 				break;
+			if (!i && topa->z_count)
+				i += topa->z_count;
 		}
 	}
 }
@@ -907,29 +917,97 @@ static void pt_read_offset(struct pt_buffer *buf)
 	buf->cur_idx = (offset & 0xffffff80) >> 7;
 }
 
-/**
- * pt_topa_next_entry() - obtain index of the first page in the next ToPA entry
- * @buf:	PT buffer.
- * @pg:		Page offset in the buffer.
- *
- * When advancing to the next output region (ToPA entry), given a page offset
- * into the buffer, we need to find the offset of the first page in the next
- * region.
- */
-static unsigned int pt_topa_next_entry(struct pt_buffer *buf, unsigned int pg)
+static struct topa_entry *
+pt_topa_entry_for_page(struct pt_buffer *buf, unsigned int pg)
+{
+	struct topa_page *tp;
+	struct topa *topa;
+	unsigned int idx, cur_pg = 0, z_pg = 0, start_idx = 0;
+
+	/*
+	 * Indicates a bug in the caller.
+	 */
+	if (WARN_ON_ONCE(pg >= buf->nr_pages))
+		return NULL;
+
+	/*
+	 * First, find the ToPA table where @pg fits. With high
+	 * order allocations, there shouldn't be many of these.
+	 */
+	list_for_each_entry(topa, &buf->tables, list) {
+		if (topa->offset + topa->size > pg << PAGE_SHIFT)
+			goto found;
+	}
+
+	/*
+	 * Hitting this means we have a problem in the ToPA
+	 * allocation code.
+	 */
+	WARN_ON_ONCE(1);
+
+	return NULL;
+
+found:
+	/*
+	 * Indicates a problem in the ToPA allocation code.
+	 */
+	if (WARN_ON_ONCE(topa->last == -1))
+		return NULL;
+
+	tp = topa_to_page(topa);
+	cur_pg = PFN_DOWN(topa->offset);
+	if (topa->z_count) {
+		z_pg = TOPA_ENTRY_PAGES(topa, 0) * (topa->z_count + 1);
+		start_idx = topa->z_count + 1;
+	}
+
+	/*
+	 * Multiple entries at the beginning of the table have the same size,
+	 * ideally all of them; if @pg falls there, the search is done.
+	 */
+	if (pg >= cur_pg && pg < cur_pg + z_pg) {
+		idx = (pg - cur_pg) / TOPA_ENTRY_PAGES(topa, 0);
+		return &tp->table[idx];
+	}
+
+	/*
+	 * Otherwise, slow path: iterate through the remaining entries.
+	 */
+	for (idx = start_idx, cur_pg += z_pg; idx < topa->last; idx++) {
+		if (cur_pg + TOPA_ENTRY_PAGES(topa, idx) > pg)
+			return &tp->table[idx];
+
+		cur_pg += TOPA_ENTRY_PAGES(topa, idx);
+	}
+
+	/*
+	 * Means we couldn't find a ToPA entry in the table that does match.
+	 */
+	WARN_ON_ONCE(1);
+
+	return NULL;
+}
+
+static struct topa_entry *
+pt_topa_prev_entry(struct pt_buffer *buf, struct topa_entry *te)
 {
-	struct topa_entry *te = buf->topa_index[pg];
+	unsigned long table = (unsigned long)te & ~(PAGE_SIZE - 1);
+	struct topa_page *tp;
+	struct topa *topa;
 
-	/* one region */
-	if (buf->first == buf->last && buf->first->last == 1)
-		return pg;
+	tp = (struct topa_page *)table;
+	if (tp->table != te)
+		return --te;
+
+	topa = &tp->topa;
+	if (topa == buf->first)
+		topa = buf->last;
+	else
+		topa = list_prev_entry(topa, list);
 
-	do {
-		pg++;
-		pg &= buf->nr_pages - 1;
-	} while (buf->topa_index[pg] == te);
+	tp = topa_to_page(topa);
 
-	return pg;
+	return &tp->table[topa->last - 1];
 }
 
 /**
@@ -964,9 +1042,13 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 		return 0;
 
 	/* clear STOP and INT from current entry */
-	buf->topa_index[buf->stop_pos]->stop = 0;
-	buf->topa_index[buf->stop_pos]->intr = 0;
-	buf->topa_index[buf->intr_pos]->intr = 0;
+	if (buf->stop_te) {
+		buf->stop_te->stop = 0;
+		buf->stop_te->intr = 0;
+	}
+
+	if (buf->intr_te)
+		buf->intr_te->intr = 0;
 
 	/* how many pages till the STOP marker */
 	npages = handle->size >> PAGE_SHIFT;
@@ -977,7 +1059,12 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 
 	idx = (head >> PAGE_SHIFT) + npages;
 	idx &= buf->nr_pages - 1;
-	buf->stop_pos = idx;
+
+	if (idx != buf->stop_pos) {
+		buf->stop_pos = idx;
+		buf->stop_te = pt_topa_entry_for_page(buf, idx);
+		buf->stop_te = pt_topa_prev_entry(buf, buf->stop_te);
+	}
 
 	wakeup = handle->wakeup >> PAGE_SHIFT;
 
@@ -987,50 +1074,19 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 		idx = wakeup;
 
 	idx &= buf->nr_pages - 1;
-	buf->intr_pos = idx;
+	if (idx != buf->intr_pos) {
+		buf->intr_pos = idx;
+		buf->intr_te = pt_topa_entry_for_page(buf, idx);
+		buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
+	}
 
-	buf->topa_index[buf->stop_pos]->stop = 1;
-	buf->topa_index[buf->stop_pos]->intr = 1;
-	buf->topa_index[buf->intr_pos]->intr = 1;
+	buf->stop_te->stop = 1;
+	buf->stop_te->intr = 1;
+	buf->intr_te->intr = 1;
 
 	return 0;
 }
 
-/**
- * pt_buffer_setup_topa_index() - build topa_index[] table of regions
- * @buf:	PT buffer.
- *
- * topa_index[] references output regions indexed by offset into the
- * buffer for purposes of quick reverse lookup.
- */
-static void pt_buffer_setup_topa_index(struct pt_buffer *buf)
-{
-	struct topa *cur = buf->first, *prev = buf->last;
-	struct topa_entry *te_cur = TOPA_ENTRY(cur, 0),
-		*te_prev = TOPA_ENTRY(prev, prev->last - 1);
-	int pg = 0, idx = 0;
-
-	while (pg < buf->nr_pages) {
-		int tidx;
-
-		/* pages within one topa entry */
-		for (tidx = 0; tidx < 1 << te_cur->size; tidx++, pg++)
-			buf->topa_index[pg] = te_prev;
-
-		te_prev = te_cur;
-
-		if (idx == cur->last - 1) {
-			/* advance to next topa table */
-			idx = 0;
-			cur = list_entry(cur->list.next, struct topa, list);
-		} else {
-			idx++;
-		}
-		te_cur = TOPA_ENTRY(cur, idx);
-	}
-
-}
-
 /**
  * pt_buffer_reset_offsets() - adjust buffer's write pointers from aux_head
  * @buf:	PT buffer.
@@ -1049,17 +1105,18 @@ static void pt_buffer_setup_topa_index(struct pt_buffer *buf)
 static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 {
 	struct topa_page *cur_tp;
+	struct topa_entry *te;
 	int pg;
 
 	if (buf->snapshot)
 		head &= (buf->nr_pages << PAGE_SHIFT) - 1;
 
 	pg = (head >> PAGE_SHIFT) & (buf->nr_pages - 1);
-	pg = pt_topa_next_entry(buf, pg);
+	te = pt_topa_entry_for_page(buf, pg);
 
-	cur_tp = topa_entry_to_page(buf->topa_index[pg]);
+	cur_tp = topa_entry_to_page(te);
 	buf->cur = &cur_tp->topa;
-	buf->cur_idx = buf->topa_index[pg] - TOPA_ENTRY(buf->cur, 0);
+	buf->cur_idx = te - TOPA_ENTRY(buf->cur, 0);
 	buf->output_off = head & (pt_buffer_region_size(buf) - 1);
 
 	local64_set(&buf->head, head);
@@ -1109,8 +1166,6 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
 		}
 	}
 
-	pt_buffer_setup_topa_index(buf);
-
 	/* link last table to the first one, unless we're double buffering */
 	if (intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
 		TOPA_ENTRY(buf->last, -1)->base = topa_pfn(buf->first);
@@ -1147,13 +1202,14 @@ pt_buffer_setup_aux(struct perf_event *event, void **pages,
 		cpu = raw_smp_processor_id();
 	node = cpu_to_node(cpu);
 
-	buf = kzalloc_node(offsetof(struct pt_buffer, topa_index[nr_pages]),
-			   GFP_KERNEL, node);
+	buf = kzalloc_node(sizeof(struct pt_buffer), GFP_KERNEL, node);
 	if (!buf)
 		return NULL;
 
 	buf->snapshot = snapshot;
 	buf->data_pages = pages;
+	buf->stop_pos = -1;
+	buf->intr_pos = -1;
 
 	INIT_LIST_HEAD(&buf->tables);
 
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 8de8ed089697..1d2bb7572374 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -64,8 +64,10 @@ struct pt_pmu {
  * @lost:	if data was lost/truncated
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
- * @stop_pos:	STOP topa entry in the buffer
- * @intr_pos:	INT topa entry in the buffer
+ * @stop_pos:	STOP topa entry index
+ * @intr_pos:	INT topa entry index
+ * @stop_te:	STOP topa entry pointer
+ * @intr_te:	INT topa entry pointer
  * @data_pages:	array of pages from perf
  * @topa_index:	table of topa entries indexed by page offset
  */
@@ -78,9 +80,9 @@ struct pt_buffer {
 	local_t			data_size;
 	local64_t		head;
 	bool			snapshot;
-	unsigned long		stop_pos, intr_pos;
+	long			stop_pos, intr_pos;
+	struct topa_entry	*stop_te, *intr_te;
 	void			**data_pages;
-	struct topa_entry	*topa_index[0];
 };
 
 #define PT_FILTERS_NUM	4
-- 
2.23.0.rc1

