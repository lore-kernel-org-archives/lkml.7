Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E38C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FEB22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfHUMsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:48:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:30850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfHUMsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:48:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="207724929"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2019 05:48:10 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 5/6] perf/x86/intel/pt: Free up space in a ToPA descriptor
Date:   Wed, 21 Aug 2019 15:47:26 +0300
Message-Id: <20190821124727.73310-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we're storing physical address of a ToPA table in its
descriptor, which is completely unnecessary. Since the descriptor
and the table itself share the same page, reducing the descriptor
size leaves more space for the table.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e7b0f8f4f1b0..5965e9493c8b 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -548,14 +548,12 @@ static void pt_config_buffer(void *buf, unsigned int topa_idx,
 /**
  * struct topa - ToPA metadata
  * @list:	linkage to struct pt_buffer's list of tables
- * @phys:	physical address of this page
  * @offset:	offset of the first entry in this table in the buffer
  * @size:	total size of all entries in this table
  * @last:	index of the last initialized entry in this table
  */
 struct topa {
 	struct list_head	list;
-	u64			phys;
 	u64			offset;
 	size_t			size;
 	int			last;
@@ -589,6 +587,11 @@ static inline struct topa_page *topa_entry_to_page(struct topa_entry *te)
 	return (struct topa_page *)((unsigned long)te & PAGE_MASK);
 }
 
+static inline phys_addr_t topa_pfn(struct topa *topa)
+{
+	return PFN_DOWN(virt_to_phys(topa_to_page(topa)));
+}
+
 /* make -1 stand for the last table entry */
 #define TOPA_ENTRY(t, i)				\
 	((i) == -1					\
@@ -615,14 +618,13 @@ static struct topa *topa_alloc(int cpu, gfp_t gfp)
 
 	tp = page_address(p);
 	tp->topa.last = 0;
-	tp->topa.phys = page_to_phys(p);
 
 	/*
 	 * In case of singe-entry ToPA, always put the self-referencing END
 	 * link as the 2nd entry in the table
 	 */
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
-		TOPA_ENTRY(&tp->topa, 1)->base = tp->topa.phys;
+		TOPA_ENTRY(&tp->topa, 1)->base = page_to_phys(p);
 		TOPA_ENTRY(&tp->topa, 1)->end = 1;
 	}
 
@@ -666,7 +668,7 @@ static void topa_insert_table(struct pt_buffer *buf, struct topa *topa)
 
 	BUG_ON(last->last != TENTS_PER_PAGE - 1);
 
-	TOPA_ENTRY(last, -1)->base = topa->phys >> TOPA_SHIFT;
+	TOPA_ENTRY(last, -1)->base = topa_pfn(topa);
 	TOPA_ENTRY(last, -1)->end = 1;
 }
 
@@ -739,8 +741,8 @@ static void pt_topa_dump(struct pt_buffer *buf)
 		struct topa_page *tp = topa_to_page(topa);
 		int i;
 
-		pr_debug("# table @%p (%016Lx), off %llx size %zx\n", tp->table,
-			 topa->phys, topa->offset, topa->size);
+		pr_debug("# table @%p, off %llx size %zx\n", tp->table,
+			 topa->offset, topa->size);
 		for (i = 0; i < TENTS_PER_PAGE; i++) {
 			pr_debug("# entry @%p (%lx sz %u %c%c%c) raw=%16llx\n",
 				 &tp->table[i],
@@ -1111,7 +1113,7 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
 
 	/* link last table to the first one, unless we're double buffering */
 	if (intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
-		TOPA_ENTRY(buf->last, -1)->base = buf->first->phys >> TOPA_SHIFT;
+		TOPA_ENTRY(buf->last, -1)->base = topa_pfn(buf->first);
 		TOPA_ENTRY(buf->last, -1)->end = 1;
 	}
 
-- 
2.23.0.rc1

