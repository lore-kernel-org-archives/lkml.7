Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0189BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB36D20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDDCDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfDDCDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:03:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFDE630821A5;
        Thu,  4 Apr 2019 02:03:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC85D8642E;
        Thu,  4 Apr 2019 02:03:25 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill@shutemov.name, keescook@chromium.org,
        yamada.masahiro@socionext.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, thgarnie@google.com,
        mike.travis@hpe.com, frank.ramsay@hpe.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of memory region initial size
Date:   Thu,  4 Apr 2019 10:03:13 +0800
Message-Id: <20190404020314.8162-2-bhe@redhat.com>
In-Reply-To: <20190404020314.8162-1-bhe@redhat.com>
References: <20190404020314.8162-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 04 Apr 2019 02:03:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
the initial size of the direct mapping region. This is correct in
the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
46 bits, and only 4-level mode was supported.

Later, in commit:
b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
__PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no matter it's
5-level or 4-level.

This is wrong for 4-level paging since it may cause randomness of KASLR
being greatly weakened in 4-level. For KASLR, we compare the sum of RAM
size and CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING with the size of the
max RAM which can be supported by system, then choose the bigger one as
the value to reserve space for the direct mapping region. The max RAM
supported in 4-level is 64 TB according to MAX_PHYSMEM_BITS. However,
here it's 4 PB in code to be compared with when __PHYSICAL_MASK_SHIFT is
mistakenly used. E.g in a system owning 64 TB RAM, it will reserve 74 TB
(which is 64 TB plus CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING). In fact
it should reserve 64 TB according to the algorithm which is supposed to
do. Obviously the extra 10 TB space should be saved to join randomization.

So, here MAX_PHYSMEM_BITS should be used instead. Fix it by replacing
__PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.

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

