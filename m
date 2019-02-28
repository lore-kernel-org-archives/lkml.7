Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E53C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AC5214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfB1Afs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:35:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfB1Afs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:35:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E9C076547;
        Thu, 28 Feb 2019 00:35:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A94B619CE;
        Thu, 28 Feb 2019 00:35:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/2] x86/mm/KASLR: Change the granularity of randomization to PUD size in 5-level
Date:   Thu, 28 Feb 2019 08:35:22 +0800
Message-Id: <20190228003522.9957-3-bhe@redhat.com>
In-Reply-To: <20190228003522.9957-1-bhe@redhat.com>
References: <20190228003522.9957-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 28 Feb 2019 00:35:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current randomization granularity of 5-level is 512 GB. Improve
it to 1 GB. This can add more randomness to memory region KASLR in
5-level paging mode

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 131e08a10a68..99ec75634613 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -204,10 +204,7 @@ void __init kernel_randomize_memory(void)
 		 */
 		entropy = remain_entropy / (ARRAY_SIZE(kaslr_regions) - i);
 		prandom_bytes_state(&rand_state, &rand, sizeof(rand));
-		if (pgtable_l5_enabled())
-			entropy = (rand % (entropy + 1)) & P4D_MASK;
-		else
-			entropy = (rand % (entropy + 1)) & PUD_MASK;
+		entropy = (rand % (entropy + 1)) & PUD_MASK;
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
 
@@ -216,10 +213,7 @@ void __init kernel_randomize_memory(void)
 		 * randomization alignment.
 		 */
 		vaddr += kaslr_regions[i].size_tb << TB_SHIFT;
-		if (pgtable_l5_enabled())
-			vaddr = round_up(vaddr + 1, P4D_SIZE);
-		else
-			vaddr = round_up(vaddr + 1, PUD_SIZE);
+		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
 }
@@ -276,8 +270,8 @@ static void __meminit init_trampoline_pud(void)
  * that area. In case KASLR disabled, the 1st PGD entry of the
  * direct mapping is copied directly. If KASLR is enabled, only
  * copy the 1st PUD entry where physical address 0 resides since
- * the granularity of randomization is PUD size in 4-level, and
- * P4D size in 5-level.
+ * the granularity of randomization is PUD size in both 4-level and
+ * 5-level.
  *
  * This consumes one low memory page in 4-level case, and extra one
  * in 5-level.
-- 
2.17.2

