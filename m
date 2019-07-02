Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73888C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E9A21851
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGBKhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:37:19 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:42242 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfGBKhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:37:19 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id AD43B7CD32A124E37288;
        Tue,  2 Jul 2019 18:37:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x62AaXJO076507;
        Tue, 2 Jul 2019 18:36:33 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070218364750-2029626 ;
          Tue, 2 Jul 2019 18:36:47 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     catalin.marinas@arm.com
Cc:     will.deacon@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, f.fainelli@gmail.com, logang@deltatee.com,
        robin.murphy@arm.com, ghackmann@android.com, hannes@cmpxchg.org,
        david@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        Junhua Huang <huang.junhua@zte.com.cn>
Subject: [PATCH] remove the initrd resource in /proc/iomem  as the initrd has freed the reserved memblock.
Date:   Tue, 2 Jul 2019 18:34:53 +0800
Message-Id: <1562063693-1541-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-02 18:36:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-02 18:36:36,
        Serialize complete at 2019-07-02 18:36:36
X-MAIL: mse-fl1.zte.com.cn x62AaXJO076507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhua Huang <huang.junhua@zte.com.cn>

The 'commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")'
show the reserved memblock in /proc/iomem. But the initrd's reserved memblock
will be freed in free_initrd_mem(), which executes after the reserve_memblock_reserved_regions().
So there are some incorrect information shown in /proc/iomem. e.g.:
80000000-bbdfffff : System RAM
  80080000-813effff : Kernel code
  813f0000-8156ffff : reserved
  81570000-817fcfff : Kernel data
  83400000-83ffffff : reserved
  90000000-90004fff : reserved
  b0000000-b2618fff : reserved
  b8c00000-bbbfffff : reserved
In this case, the range from b0000000 to b2618fff is reserved for initrd, which should be
clean from the resource tree after it was freed. As kexec-tool will collect the iomem reserved info 
and use it in second kernel, which causes error message generated a second time.

At the same time, we should free the reserved memblock in an aligned manner because 
the initrd reserves the memblock in an aligned manner in arm64_memblock_init(). 
Otherwise there are some fragments in memblock_reserved regions. e.g.:
/sys/kernel/debug/memblock # cat reserved 
   0: 0x0000000080080000..0x00000000817fafff
   1: 0x0000000083400000..0x0000000083ffffff
   2: 0x0000000090000000..0x000000009000407f
   3: 0x00000000b0000000..0x00000000b000003f
   4: 0x00000000b26184ea..0x00000000b2618fff
The fragments like the ranges from b0000000 to b000003f and from b26184ea to b2618fff 
should be freed.

Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
---
 arch/arm64/mm/init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d2adffb81b5d..14ba8113eab5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -580,8 +580,16 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
+	struct resource *res = NULL;
+
 	free_reserved_area((void *)start, (void *)end, 0, "initrd");
-	memblock_free(__virt_to_phys(start), end - start);
+	start = __virt_to_phys(start) & PAGE_MASK;
+	end = PAGE_ALIGN(__virt_to_phys(end));
+	memblock_free(start, end - start);
+	res = lookup_resource(&iomem_resource, memblock_start_of_DRAM());
+	if (res != NULL)
+		__release_region(res, start, end - start);
+
 }
 #endif
 
-- 
2.15.2

