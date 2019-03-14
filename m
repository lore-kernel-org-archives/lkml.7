Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E699AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF082070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCNJrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfCNJrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79EF040F5C;
        Thu, 14 Mar 2019 09:47:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 139145C241;
        Thu, 14 Mar 2019 09:47:25 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, x86@kernel.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 5/6] x86/mm/KASLR: Calculate the actual size of vmemmap region
Date:   Thu, 14 Mar 2019 17:46:44 +0800
Message-Id: <20190314094645.4883-6-bhe@redhat.com>
In-Reply-To: <20190314094645.4883-1-bhe@redhat.com>
References: <20190314094645.4883-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 14 Mar 2019 09:47:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmemmap region has different maximum size depending on paging mode.
Now its size is hardcoded as 1TB in memory KASLR, this is not
right for 5-level paging mode. It will cause overflow if vmemmap
region is randomized to be adjacent to cpu_entry_area region and
its actual size is bigger than 1 TB.

So here calculate how many TB by the actual size of vmemmap region
and align up to 1TB boundary. In 4-level the size will be 1 TB always
since the max is 1 TB. In 5-level it's variable so that space can
be saved for randomization.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index ebf6d1d92385..615a79f6b701 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -69,19 +69,22 @@ static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
  *
  *	{ &page_offset_base, 0 },
  *	{ &vmalloc_base,     0 },
- *	{ &vmemmap_base,     1 },
+ *	{ &vmemmap_base,     0 },
  *
  * @size_tb: size in TB of each memory region. E.g, the sizes in 4-level
  * pageing mode are:
  *
  *	- Physical memory mapping: (actual RAM size + 10 TB padding)
  *	- Vmalloc: 32 TB
- *	- Vmemmap: 1 TB
+ *	- Vmemmap: (needed size aligned to 1TB boundary)
  *
- * As seen, the size of the physical memory mapping region is variable,
- * calculated according to the actual size of system RAM in order to
- * save more space for randomization. The rest are fixed values related
- * to paging mode.
+ * As seen, only the vmalloc region is fixed value related to paging
+ * mode. While the sizes of the physical memory mapping region and
+ * vmemmap region are variable. The size of the physical memory mapping
+ * region is calculated according to the actual size of system RAM plus
+ * padding value. And the size of vmemmap is calculated as needed and
+ * aligned to 1 TB boundary. The calculations done here is to save more
+ * space for randomization.
  */
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;
@@ -89,7 +92,7 @@ static __initdata struct kaslr_memory_region {
 } kaslr_regions[] = {
 	{ &page_offset_base, 0 },
 	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 1 },
+	{ &vmemmap_base, 0 },
 };
 
 /*
@@ -115,6 +118,7 @@ void __init kernel_randomize_memory(void)
 	unsigned long rand, memory_tb;
 	struct rnd_state rand_state;
 	unsigned long remain_entropy;
+	unsigned long vmemmap_size;
 
 	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
 	vaddr = vaddr_start;
@@ -146,6 +150,15 @@ void __init kernel_randomize_memory(void)
 	if (memory_tb < kaslr_regions[0].size_tb)
 		kaslr_regions[0].size_tb = memory_tb;
 
+	/*
+	 * Calculate how many TB vmemmap region needs, and align to 1 TB
+	 * boundary. It's 1 TB in 4-level since the max is 1 TB, while
+	 * variable in 5-level.
+	 */
+	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
+		sizeof(struct page);
+	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
+
 	/* Calculate entropy available between regions */
 	remain_entropy = vaddr_end - vaddr_start;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
-- 
2.17.2

