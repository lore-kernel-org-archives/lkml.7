Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D89C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31B720874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfHZLqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfHZLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRS-0000xA-I6; Mon, 26 Aug 2019 13:45:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 28A641C0DAE;
        Mon, 26 Aug 2019 13:45:46 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:45:46 -0000
From:   tip-bot2 for Alexander Shishkin <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Free up space in a ToPA descriptor
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
In-Reply-To: <20190821124727.73310-6-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-6-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156681994603.3140.12429762858491080748.tip-bot2@tip-bot2>
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

Commit-ID:     91feca5e2ecc9752894d57c9a72c2645471929c3
Gitweb:        https://git.kernel.org/tip/91feca5e2ecc9752894d57c9a72c2645471929c3
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 21 Aug 2019 15:47:26 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 12:00:15 +02:00

perf/x86/intel/pt: Free up space in a ToPA descriptor

Currently, we're storing physical address of a ToPA table in its
descriptor, which is completely unnecessary. Since the descriptor
and the table itself share the same page, reducing the descriptor
size leaves more space for the table.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20190821124727.73310-6-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 2e3f068..0f38ed3 100644
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
 
