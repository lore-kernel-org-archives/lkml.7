Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60DAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04A4222A0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfDJLGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:06:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfDJLGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:06:07 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3M-0005Ba-4K; Wed, 10 Apr 2019 13:06:04 +0200
Message-Id: <20190410103646.130022106@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/debug.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -89,8 +89,8 @@ struct dma_debug_entry {
 	int		 sg_mapped_ents;
 	enum map_err_types  map_err_type;
 #ifdef CONFIG_STACKTRACE
-	struct		 stack_trace stacktrace;
-	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
+	unsigned int	st_len;
+	unsigned long	st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
 #endif
 };
 
@@ -174,7 +174,7 @@ static inline void dump_entry_trace(stru
 #ifdef CONFIG_STACKTRACE
 	if (entry) {
 		pr_warning("Mapped at:\n");
-		print_stack_trace(&entry->stacktrace, 0);
+		stack_trace_print(entry->st_entries, entry->st_len, 0);
 	}
 #endif
 }
@@ -704,12 +704,9 @@ static struct dma_debug_entry *dma_entry
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
 #ifdef CONFIG_STACKTRACE
-	entry->stacktrace.max_entries = DMA_DEBUG_STACKTRACE_ENTRIES;
-	entry->stacktrace.entries = entry->st_entries;
-	entry->stacktrace.skip = 2;
-	save_stack_trace(&entry->stacktrace);
+	entry->st_len = stack_trace_save(entry->st_entries,
+					 ARRAY_SIZE(entry->st_entries), 2);
 #endif
-
 	return entry;
 }
 


