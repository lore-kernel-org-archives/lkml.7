Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80217C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C662070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfCNJrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:47:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCNJrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 063B63132C5E;
        Thu, 14 Mar 2019 09:47:10 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D87B5C241;
        Thu, 14 Mar 2019 09:47:01 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, x86@kernel.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 2/6] x86/mm/KASLR: Open code unnecessary function get_padding
Date:   Thu, 14 Mar 2019 17:46:41 +0800
Message-Id: <20190314094645.4883-3-bhe@redhat.com>
In-Reply-To: <20190314094645.4883-1-bhe@redhat.com>
References: <20190314094645.4883-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 14 Mar 2019 09:47:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's used only twice and we do bit shifts in the parent function
anyway so it's not like it's hiding some uninteresting detail.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/mm/kaslr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 5debf82ab06a..d7ea6b252594 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -92,12 +92,6 @@ static __initdata struct kaslr_memory_region {
 	{ &vmemmap_base, 1 },
 };
 
-/* Get size in bytes used by the memory region */
-static inline unsigned long get_padding(struct kaslr_memory_region *region)
-{
-	return (region->size_tb << TB_SHIFT);
-}
-
 /*
  * Apply no randomization if KASLR was disabled at boot or if KASAN
  * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
@@ -155,7 +149,7 @@ void __init kernel_randomize_memory(void)
 	/* Calculate entropy available between regions */
 	remain_entropy = vaddr_end - vaddr_start;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
-		remain_entropy -= get_padding(&kaslr_regions[i]);
+		remain_entropy -= kaslr_regions[i].size_tb << TB_SHIFT;
 
 	prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
 
@@ -176,7 +170,7 @@ void __init kernel_randomize_memory(void)
 		 * Jump the region and add a minimum padding based on
 		 * randomization alignment.
 		 */
-		vaddr += get_padding(&kaslr_regions[i]);
+		vaddr += kaslr_regions[i].size_tb << TB_SHIFT;
 		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
-- 
2.17.2

