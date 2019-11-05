Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D1C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3331E21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfKELbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:31:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730757AbfKELbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:31:05 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08A5AD5513D0C2584768;
        Tue,  5 Nov 2019 19:31:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 19:30:52 +0800
To:     <dougmill@linux.ibm.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] ehea: replace with page_shift() in ehea_is_hugepage()
Message-ID: <f581efc8-5d92-fed7-27b5-d5c5e9bce8ee@huawei.com>
Date:   Tue, 5 Nov 2019 19:30:45 +0800
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

So replace with page_shift() in ehea_is_hugepage() for readability.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
index 6e70658d50c4..db45373ea31c 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
@@ -670,13 +670,10 @@ int ehea_rem_sect_bmap(unsigned long pfn, unsigned long nr_pages)

 static int ehea_is_hugepage(unsigned long pfn)
 {
-	int page_order;
-
 	if (pfn & EHEA_HUGEPAGE_PFN_MASK)
 		return 0;

-	page_order = compound_order(pfn_to_page(pfn));
-	if (page_order + PAGE_SHIFT != EHEA_HUGEPAGESHIFT)
+	if (page_shift(pfn_to_page(pfn)) != EHEA_HUGEPAGESHIFT)
 		return 0;

 	return 1;
-- 
2.7.4

