Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA2C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB63120870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfDNH2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 03:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfDNH2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 03:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C601DC058CB4;
        Sun, 14 Apr 2019 07:28:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F33919C56;
        Sun, 14 Apr 2019 07:28:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill@shutemov.name, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 RESEND 1/2] x86/mm/KASLR: Fix the size of the direct mapping section
Date:   Sun, 14 Apr 2019 15:28:03 +0800
Message-Id: <20190414072804.12560-2-bhe@redhat.com>
In-Reply-To: <20190414072804.12560-1-bhe@redhat.com>
References: <20190414072804.12560-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 14 Apr 2019 07:28:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel_randomize_memory() uses __PHYSICAL_MASK_SHIFT to calculate
the maximum amount of system RAM supported. The size of the direct
mapping section is obtained from the smaller one of the below two
values:

 (actual system RAM size + padding size) vs (max system RAM size supported)

This calculation is wrong since commit:
b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52").

In commit b83ce5ee91471d, __PHYSICAL_MASK_SHIFT was changed to be 52,
regardless of whether it's using 4-level or 5-level page tables.
It will always use 4 PB as the maximum amount of system RAM, even
in 4-level paging mode where it should be 64 TB.  Thus the size of
the direct mapping section will always be the sum of the actual
system RAM size plus the padding size.

Even when the amount of system RAM is 64 TB, the following layout will
still be used. Obviously KALSR will be weakened significantly.

   |____|_______actual RAM_______|_padding_|______the rest_______|
   0            64TB                                            ~120TB

What we want is the following:

   |____|_______actual RAM_______|_________the rest______________|
   0            64TB                                            ~120TB

So the code should use MAX_PHYSMEM_BITS instead. Fix it by replacing
__PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.

Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 9a8756517504..387d4ed25d7c 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -94,7 +94,7 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
-	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
 	/*
-- 
2.17.2

