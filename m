Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8745C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836F520651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfC0PFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:05:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbfC0PFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:05:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9E900C02DB1BED3E7BE3;
        Wed, 27 Mar 2019 23:05:39 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Mar 2019
 23:05:29 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <marek.vasut@gmail.com>, <richard@nod.at>,
        <joakim.tjernlund@infinera.com>, <ikegami@allied-telesis.co.jp>,
        <keescook@chromium.org>, <vigneshr@ti.com>
CC:     <liujian56@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] mtd: cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Date:   Wed, 27 Mar 2019 23:03:53 +0800
Message-ID: <1553699033-103289-1-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function do_write_buffer(), in the for loop, there is a case
chip_ready() returns 1 while chip_good() returns 0, so it never
break the loop.
To fix this, chip_good() is enough and it should timeout if it stay
not good status for a while.

Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write buffer to check correct value")
Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
---
v3-v4:
1. add "mtd: " prefix to subject
2. add some comment suggested by reviewers

I forgot to resend this patch, I am very sorry.

 drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 72428b6..bcabc50 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -1876,7 +1876,11 @@ static int __xipram do_write_buffer(struct map_info *map, struct flchip *chip,
 			continue;
 		}
 
-		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
+		/*
+		 * We check "time_after" && "!chip_good" before checking
+		 * "chip_good" to avoid the failure due to scheduling.
+		 */
+		if (time_after(jiffies, timeo) && !chip_good(map, adr, datum))
 			break;
 
 		if (chip_good(map, adr, datum)) {
-- 
2.7.4

