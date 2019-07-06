Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC63C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 06:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EDA21670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 06:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfGFGrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 02:47:14 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:28044 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfGFGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 02:47:14 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 18AAF49C2BE7C4472856;
        Sat,  6 Jul 2019 14:47:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x666ko2S087166;
        Sat, 6 Jul 2019 14:46:50 +0800 (GMT-8)
        (envelope-from huang.junhua@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070614473487-2126688 ;
          Sat, 6 Jul 2019 14:47:34 +0800 
From:   Junhua Huang <huang.junhua@zte.com.cn>
To:     catalin.marinas@arm.com
Cc:     will.deacon@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, f.fainelli@gmail.com, logang@deltatee.com,
        robin.murphy@arm.com, ghackmann@android.com, hannes@cmpxchg.org,
        david@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        Junhua Huang <huang.junhua@zte.com.cn>
Subject: [PATCH v2] arm64: mm: free the initrd reserved memblock in a aligned manner
Date:   Sat, 6 Jul 2019 14:41:15 +0800
Message-Id: <1562395275-10772-1-git-send-email-huang.junhua@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-06 14:47:34,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-06 14:46:57,
        Serialize complete at 2019-07-06 14:46:57
X-MAIL: mse-fl2.zte.com.cn x666ko2S087166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should free the initrd reserved memblock in an aligned manner, 
because the initrd reserves the memblock in an aligned manner 
in arm64_memblock_init(). 
Otherwise there are some fragments in memblock_reserved regions
after free_initrd_mem(). e.g.:
/sys/kernel/debug/memblock # cat reserved 
   0: 0x0000000080080000..0x00000000817fafff
   1: 0x0000000083400000..0x0000000083ffffff
   2: 0x0000000090000000..0x000000009000407f
   3: 0x00000000b0000000..0x00000000b000003f
   4: 0x00000000b26184ea..0x00000000b2618fff
The fragments like the ranges from b0000000 to b000003f and 
from b26184ea to b2618fff should be freed.

And we can do free_reserved_area() after memblock_free(),
as free_reserved_area() calls __free_pages(), once we've done 
that it could be allocated somewhere else, 
but memblock and iomem still say this is reserved memory.

Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
---
v2: fix the start/end typo to free the same memory that we reserved
and remove the blank line.

 arch/arm64/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d2adffb81b5d..2e9e42d06362 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -580,8 +580,12 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
+	unsigned long aligned_start, aligned_end;
+
+	aligned_start = __virt_to_phys(start) & PAGE_MASK;
+	aligned_end = PAGE_ALIGN(__virt_to_phys(end));
+	memblock_free(aligned_start, aligned_end - aligned_start);
 	free_reserved_area((void *)start, (void *)end, 0, "initrd");
-	memblock_free(__virt_to_phys(start), end - start);
 }
 #endif
 
-- 
2.15.2

