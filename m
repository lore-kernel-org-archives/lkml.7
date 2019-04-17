Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319FFC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A54620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfDQIfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbfDQIfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:35:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAE53C4EAC;
        Wed, 17 Apr 2019 08:35:40 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F1B519C7C;
        Wed, 17 Apr 2019 08:35:39 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:35:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill@shutemov.name,
        keescook@chromium.org, peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 RESEND 1/2] x86/mm/KASLR: Fix the size of the direct
 mapping section
Message-ID: <20190417083536.GE7065@MiWiFi-R3L-srv>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-2-bhe@redhat.com>
 <20190415185319.GI29317@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415185319.GI29317@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 17 Apr 2019 08:35:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/19 at 08:53pm, Borislav Petkov wrote:
> Now, lemme make sure I understand exactly what you're fixing here:
> you're fixing the case where CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING is
> not 0. Which is the case when CONFIG_MEMORY_HOTPLUG is enabled.
> 
> Yes, no?

Yes, the padding is reserved specifically for possible furture memory
hotplugging.
> 
> If so, please extend the commit message with that fact because it is
> crucial and the last missing piece in the explanation.
> 
> Otherwise, when the padding is 0, the clamping:
> 
>         /* Adapt phyiscal memory region size based on available memory */
>         if (memory_tb < kaslr_regions[0].size_tb)
>                 kaslr_regions[0].size_tb = memory_tb;
> 
> will "fix" the direct mapping section size.

I made a new one to add this fact, I can repost if it's OK to you.
Thanks.

From 6f0fdb9df6acdcd42b8cbdecaf5058c3090fd577 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Thu, 4 Apr 2019 10:03:13 +0800
Subject: [PATCH] x86/mm/KASLR: Fix the size of the direct mapping section

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

Here, the size of padding region can be configured with
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING, 10 TB by default. The above
issue only exists when CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING is set
to a non-zero value. Otherwise, using __PHYSICAL_MASK_SHIFT doesn't
affect KASLR either.

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
index 78974ee5d97f..4679a0075048 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -95,7 +95,7 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
-	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
 	/*
-- 
2.17.2

