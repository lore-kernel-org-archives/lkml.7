Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EBCC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5702184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfHZLqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39576 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbfHZLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRS-0000wX-0o; Mon, 26 Aug 2019 13:45:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A131F1C0DDA;
        Mon, 26 Aug 2019 13:45:45 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:45:45 -0000
From:   tip-bot2 for Alexander Shishkin <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Split ToPA metadata and page layout
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190821124727.73310-5-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-5-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156681994554.3136.12901659193246626720.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     38bb8d77d0b932a0773b5de2ef42479409314f96
Gitweb:        https://git.kernel.org/tip/38bb8d77d0b932a0773b5de2ef42479409314f96
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 21 Aug 2019 15:47:25 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 12:00:14 +02:00

perf/x86/intel/pt: Split ToPA metadata and page layout

PT uses page sized ToPA tables, where the ToPA table resides at the bottom
and its driver-specific metadata taking up a few words at the top of the
page. The split is currently calculated manually and needs to be redone
every time a field is added to or removed from the metadata structure.
Also, the 32-bit version can be made smaller.

By splitting the table and metadata into separate structures, we are making
the compiler figure out the division of the page.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20190821124727.73310-5-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 93 +++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 188d45f..2e3f068 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -545,16 +545,8 @@ static void pt_config_buffer(void *buf, unsigned int topa_idx,
 	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
 }
 
-/*
- * Keep ToPA table-related metadata on the same page as the actual table,
- * taking up a few words from the top
- */
-
-#define TENTS_PER_PAGE (((PAGE_SIZE - 40) / sizeof(struct topa_entry)) - 1)
-
 /**
- * struct topa - page-sized ToPA table with metadata at the top
- * @table:	actual ToPA table entries, as understood by PT hardware
+ * struct topa - ToPA metadata
  * @list:	linkage to struct pt_buffer's list of tables
  * @phys:	physical address of this page
  * @offset:	offset of the first entry in this table in the buffer
@@ -562,7 +554,6 @@ static void pt_config_buffer(void *buf, unsigned int topa_idx,
  * @last:	index of the last initialized entry in this table
  */
 struct topa {
-	struct topa_entry	table[TENTS_PER_PAGE];
 	struct list_head	list;
 	u64			phys;
 	u64			offset;
@@ -570,8 +561,39 @@ struct topa {
 	int			last;
 };
 
+/*
+ * Keep ToPA table-related metadata on the same page as the actual table,
+ * taking up a few words from the top
+ */
+
+#define TENTS_PER_PAGE	\
+	((PAGE_SIZE - sizeof(struct topa)) / sizeof(struct topa_entry))
+
+/**
+ * struct topa_page - page-sized ToPA table with metadata at the top
+ * @table:	actual ToPA table entries, as understood by PT hardware
+ * @topa:	metadata
+ */
+struct topa_page {
+	struct topa_entry	table[TENTS_PER_PAGE];
+	struct topa		topa;
+};
+
+static inline struct topa_page *topa_to_page(struct topa *topa)
+{
+	return container_of(topa, struct topa_page, topa);
+}
+
+static inline struct topa_page *topa_entry_to_page(struct topa_entry *te)
+{
+	return (struct topa_page *)((unsigned long)te & PAGE_MASK);
+}
+
 /* make -1 stand for the last table entry */
-#define TOPA_ENTRY(t, i) ((i) == -1 ? &(t)->table[(t)->last] : &(t)->table[(i)])
+#define TOPA_ENTRY(t, i)				\
+	((i) == -1					\
+		? &topa_to_page(t)->table[(t)->last]	\
+		: &topa_to_page(t)->table[(i)])
 #define TOPA_ENTRY_SIZE(t, i) (sizes(TOPA_ENTRY((t), (i))->size))
 
 /**
@@ -584,27 +606,27 @@ struct topa {
 static struct topa *topa_alloc(int cpu, gfp_t gfp)
 {
 	int node = cpu_to_node(cpu);
-	struct topa *topa;
+	struct topa_page *tp;
 	struct page *p;
 
 	p = alloc_pages_node(node, gfp | __GFP_ZERO, 0);
 	if (!p)
 		return NULL;
 
-	topa = page_address(p);
-	topa->last = 0;
-	topa->phys = page_to_phys(p);
+	tp = page_address(p);
+	tp->topa.last = 0;
+	tp->topa.phys = page_to_phys(p);
 
 	/*
 	 * In case of singe-entry ToPA, always put the self-referencing END
 	 * link as the 2nd entry in the table
 	 */
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
-		TOPA_ENTRY(topa, 1)->base = topa->phys >> TOPA_SHIFT;
-		TOPA_ENTRY(topa, 1)->end = 1;
+		TOPA_ENTRY(&tp->topa, 1)->base = tp->topa.phys;
+		TOPA_ENTRY(&tp->topa, 1)->end = 1;
 	}
 
-	return topa;
+	return &tp->topa;
 }
 
 /**
@@ -714,22 +736,23 @@ static void pt_topa_dump(struct pt_buffer *buf)
 	struct topa *topa;
 
 	list_for_each_entry(topa, &buf->tables, list) {
+		struct topa_page *tp = topa_to_page(topa);
 		int i;
 
-		pr_debug("# table @%p (%016Lx), off %llx size %zx\n", topa->table,
+		pr_debug("# table @%p (%016Lx), off %llx size %zx\n", tp->table,
 			 topa->phys, topa->offset, topa->size);
 		for (i = 0; i < TENTS_PER_PAGE; i++) {
 			pr_debug("# entry @%p (%lx sz %u %c%c%c) raw=%16llx\n",
-				 &topa->table[i],
-				 (unsigned long)topa->table[i].base << TOPA_SHIFT,
-				 sizes(topa->table[i].size),
-				 topa->table[i].end ?  'E' : ' ',
-				 topa->table[i].intr ? 'I' : ' ',
-				 topa->table[i].stop ? 'S' : ' ',
-				 *(u64 *)&topa->table[i]);
+				 &tp->table[i],
+				 (unsigned long)tp->table[i].base << TOPA_SHIFT,
+				 sizes(tp->table[i].size),
+				 tp->table[i].end ?  'E' : ' ',
+				 tp->table[i].intr ? 'I' : ' ',
+				 tp->table[i].stop ? 'S' : ' ',
+				 *(u64 *)&tp->table[i]);
 			if ((intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) &&
-			     topa->table[i].stop) ||
-			    topa->table[i].end)
+			     tp->table[i].stop) ||
+			    tp->table[i].end)
 				break;
 		}
 	}
@@ -792,7 +815,7 @@ static void pt_update_head(struct pt *pt)
  */
 static void *pt_buffer_region(struct pt_buffer *buf)
 {
-	return phys_to_virt(buf->cur->table[buf->cur_idx].base << TOPA_SHIFT);
+	return phys_to_virt(TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
 }
 
 /**
@@ -869,9 +892,11 @@ static void pt_handle_status(struct pt *pt)
 static void pt_read_offset(struct pt_buffer *buf)
 {
 	u64 offset, base_topa;
+	struct topa_page *tp;
 
 	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base_topa);
-	buf->cur = phys_to_virt(base_topa);
+	tp = phys_to_virt(base_topa);
+	buf->cur = &tp->topa;
 
 	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, offset);
 	/* offset within current output region */
@@ -1021,6 +1046,7 @@ static void pt_buffer_setup_topa_index(struct pt_buffer *buf)
  */
 static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 {
+	struct topa_page *cur_tp;
 	int pg;
 
 	if (buf->snapshot)
@@ -1029,7 +1055,8 @@ static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 	pg = (head >> PAGE_SHIFT) & (buf->nr_pages - 1);
 	pg = pt_topa_next_entry(buf, pg);
 
-	buf->cur = (struct topa *)((unsigned long)buf->topa_index[pg] & PAGE_MASK);
+	cur_tp = topa_entry_to_page(buf->topa_index[pg]);
+	buf->cur = &cur_tp->topa;
 	buf->cur_idx = buf->topa_index[pg] - TOPA_ENTRY(buf->cur, 0);
 	buf->output_off = head & (pt_buffer_region_size(buf) - 1);
 
@@ -1294,7 +1321,7 @@ void intel_pt_interrupt(void)
 			return;
 		}
 
-		pt_config_buffer(buf->cur->table, buf->cur_idx,
+		pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
 				 buf->output_off);
 		pt_config(event);
 	}
@@ -1359,7 +1386,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 	WRITE_ONCE(pt->handle_nmi, 1);
 	hwc->state = 0;
 
-	pt_config_buffer(buf->cur->table, buf->cur_idx,
+	pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
 			 buf->output_off);
 	pt_config(event);
 
