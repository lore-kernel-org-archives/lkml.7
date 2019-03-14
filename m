Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C17AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA221019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCNJrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCNJrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:47:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DC286857A;
        Thu, 14 Mar 2019 09:47:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E556269300;
        Thu, 14 Mar 2019 09:46:55 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, x86@kernel.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 1/6] x86/mm/KASLR: Improve code comments about struct kaslr_memory_region
Date:   Thu, 14 Mar 2019 17:46:40 +0800
Message-Id: <20190314094645.4883-2-bhe@redhat.com>
In-Reply-To: <20190314094645.4883-1-bhe@redhat.com>
References: <20190314094645.4883-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Mar 2019 09:47:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old comment above kaslr_memory_region is not clear enough to explain
the concepts of memory region KASLR.

[Ingo suggested this and helped to prettify the text]

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 51 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 9a8756517504..5debf82ab06a 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -42,9 +42,46 @@
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
 /*
- * Memory regions randomized by KASLR (except modules that use a separate logic
- * earlier during boot). The list is ordered based on virtual addresses. This
- * order is kept after randomization.
+ * struct kaslr_memory_region -  represent continuous chunks of kernel
+ * virtual memory regions, to be randomized by KASLR.
+ *
+ * ( The exception is the module space virtual memory window which
+ *   uses separate logic earlier during bootup. )
+ *
+ * Currently there are three such regions: the physical memory mapping,
+ * vmalloc and vmemmap regions.
+ *
+ * The array below has the entries ordered based on virtual addresses.
+ * The order is kept after randomization, i.e. the randomized virtual
+ * addresses of these regions are still ascending.
+ *
+ * Here are the fields:
+ *
+ * @base: points to a global variable used by the MM to get the virtual
+ * base address of any of the above regions. This allows the early KASLR
+ * KASLR code to modify these base addresses early during bootup, on a
+ * per bootup basis, without the MM code even being aware of whether it
+ * got changed and to what value.
+ *
+ * When KASLR is active then the MM code makes sure that for each region
+ * there's such a single, dynamic, global base address 'unsigned long'
+ * variable available for the KASLR code to point to and modify directly:
+ *
+ *	{ &page_offset_base, 0 },
+ *	{ &vmalloc_base,     0 },
+ *	{ &vmemmap_base,     1 },
+ *
+ * @size_tb: size in TB of each memory region. E.g, the sizes in 4-level
+ * pageing mode are:
+ *
+ *	- Physical memory mapping: (actual RAM size + 10 TB padding)
+ *	- Vmalloc: 32 TB
+ *	- Vmemmap: 1 TB
+ *
+ * As seen, the size of the physical memory mapping region is variable,
+ * calculated according to the actual size of system RAM in order to
+ * save more space for randomization. The rest are fixed values related
+ * to paging mode.
  */
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;
@@ -70,7 +107,13 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
-/* Initialize base and padding for each memory region randomized with KASLR */
+/*
+ * kernel_randomize_memory - initialize base and padding for each
+ * memory region randomized with KASLR.
+ *
+ * When randomize the layout, their order are kept, still the physical
+ * memory mapping region is handled firstly, next vmalloc and vmemmap.
+ */
 void __init kernel_randomize_memory(void)
 {
 	size_t i;
-- 
2.17.2

