Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84644C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0C12070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJGG5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:57:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfJGG5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:57:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 697CFF29AA39D751D815;
        Mon,  7 Oct 2019 14:57:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 7 Oct 2019
 14:57:18 +0800
Subject: [PATCH] mm/cma.c: Switch to bitmap_zalloc() for cma bitmap allocation
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <akpm@linux-foundation.org>, <rppt@linux.ibm.com>,
        <huyue2@yulong.com>, <peng.fan@nxp.com>, <aryabinin@virtuozzo.com>,
        <ryh.szk.cmnty@gmail.com>, <andreyknvl@google.com>,
        <opendmb@gmail.com>, <tglx@linutronix.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <895d4627-f115-c77a-d454-c0a196116426@huawei.com>
Message-ID: <2ab873b7-c754-0af9-f119-f6d435d84767@huawei.com>
Date:   Mon, 7 Oct 2019 14:57:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <895d4627-f115-c77a-d454-c0a196116426@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() is used for cma bitmap allocation in cma_activate_area(),
switch to bitmap_zalloc() is more clearly.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 mm/cma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 7fe0b83..be55d19 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -95,13 +95,11 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,

 static int __init cma_activate_area(struct cma *cma)
 {
-	int bitmap_size = BITS_TO_LONGS(cma_bitmap_maxno(cma)) * sizeof(long);
 	unsigned long base_pfn = cma->base_pfn, pfn = base_pfn;
 	unsigned i = cma->count >> pageblock_order;
 	struct zone *zone;

-	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-
+	cma->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma), GFP_KERNEL);
 	if (!cma->bitmap) {
 		cma->count = 0;
 		return -ENOMEM;
@@ -139,7 +137,7 @@ static int __init cma_activate_area(struct cma *cma)

 not_in_zone:
 	pr_err("CMA area %s could not be activated\n", cma->name);
-	kfree(cma->bitmap);
+	bitmap_free(cma->bitmap);
 	cma->count = 0;
 	return -EINVAL;
 }
-- 
2.7.4

