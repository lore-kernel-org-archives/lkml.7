Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BC3C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C6B20868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFIJQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 05:16:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18117 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfFIJQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 05:16:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 714EED491E95A3D71315;
        Sun,  9 Jun 2019 17:16:18 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.190) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sun, 9 Jun 2019 17:16:08 +0800
From:   ChenGang <cg.chen@huawei.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <osalvador@suse.de>, <pavel.tatashin@microsoft.com>
CC:     <mgorman@techsingularity.net>, <rppt@linux.ibm.com>,
        <richard.weiyang@gmail.com>, <alexander.h.duyck@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        ChenGang <cg.chen@huawei.com>
Subject: [PATCH] mm: align up min_free_kbytes to multipy of 4
Date:   Sun, 9 Jun 2019 17:10:28 +0800
Message-ID: <1560071428-24267-1-git-send-email-cg.chen@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.190]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually the value of min_free_kbytes is multiply of 4,
and in this case ,the right shift is ok.
But if it's not, the right-shifting operation will lose the low 2 bits,
and this cause kernel don't reserve enough memory.
So it's necessary to align the value of min_free_kbytes to multiply of 4.
For example, if min_free_kbytes is 64, then should keep 16 pages,
but if min_free_kbytes is 65 or 66, then should keep 17 pages.

Signed-off-by: ChenGang <cg.chen@huawei.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8a..1baeeba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7611,7 +7611,8 @@ static void setup_per_zone_lowmem_reserve(void)
 
 static void __setup_per_zone_wmarks(void)
 {
-	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
+	unsigned long pages_min =
+		(PAGE_ALIGN(min_free_kbytes * 1024) / 1024) >> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
 	struct zone *zone;
 	unsigned long flags;
-- 
1.8.5.6

