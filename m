Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD12C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490B82190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfKEJiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:38:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730808AbfKEJix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:38:53 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D1BC571BAF4CB88C1DC;
        Tue,  5 Nov 2019 17:38:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 17:38:43 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v2] mm/memory-failure.c: replace with page_shift() in
 add_to_kill()
To:     <david@redhat.com>, <n-horiguchi@ah.jp.nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Message-ID: <543d8bc9-f2e7-3023-7c35-2e7ed67c0e82@huawei.com>
Date:   Tue, 5 Nov 2019 17:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function page_shift() is supported after the commit 94ad9338109f
("mm: introduce page_shift()").

So replace with page_shift() in add_to_kill() for readability.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
v1 -> v2:
 - add Reviewed-by and Acked-by

 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3151c87dff73..e48c50cac889 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -326,7 +326,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	if (is_zone_device_page(p))
 		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
 	else
-		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
+		tk->size_shift = page_shift(compound_head(p));

 	/*
 	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
-- 
2.7.4

