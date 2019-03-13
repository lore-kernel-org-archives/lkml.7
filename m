Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfCMPkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:40:01 -0400
Received: from smtprz14.163.net ([106.3.154.247]:10438 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfCMPju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:39:50 -0400
Received: from 172.25.16.147 (unknown [172.25.16.147])
        by freemail02.tom.com (Postfix) with ESMTP id 35757B00D48
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 21:46:02 +0800 (CST)
Received: from 172.25.16.91 (HELO smtp.tom.com) ([172.25.16.91])
          by localhost (TOM SMTP Server) with SMTP ID -1386801626
          for <linux-kernel@vger.kernel.org>;
          Wed, 13 Mar 2019 21:46:02 +0800 (CST)
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 7A495B00D36
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 21:46:01 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 76B2E816F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 21:46:01 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wMxY7qjuTUQ9 for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 21:45:59 +0800 (CST)
Received: from localhost (unknown [110.184.152.196])
        by antispam2.tom.com (Postfix) with ESMTPA id 9562B81067;
        Wed, 13 Mar 2019 21:45:58 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     bbrezillon@kernel.org
Cc:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH v2] mtd: spi-nor: Return error when nor->addr_width does not match the device size
Date:   Wed, 13 Mar 2019 21:45:53 +0800
Message-Id: <1552484753-3393-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some is25lp256, the DWORD1 of JEDEC Basic Flash Parameter Header
is 0xfff920e5. So the DWORD1[18:17] Address Bytes bits are 0b00,
means that 3-Byte only addressing. But the device size is larger
than 16MB, nor->addr_width must be 4 to access the whole address.
An error should be returned when nor->addr_width does not match
the device size in spi_nor_parse_bfpt(). Then it can go back to
use spi_nor_ids[] for setting the right addr_width.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/mtd/spi-nor/spi-nor.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e13bbd..63933c7 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2811,6 +2811,14 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	}
 	params->size >>= 3; /* Convert to bytes. */
 
+	/*
+	 * If the device exceeds 16MiB, addr_width must be 4.
+	 * addr_width == 3 means the Address Bytes we are
+	 * reading from BFPT is wrong.
+	 */
+	if (params->size > 0x1000000 && nor->addr_width == 3)
+		return -EINVAL;
+
 	/* Fast Read settings. */
 	for (i = 0; i < ARRAY_SIZE(sfdp_bfpt_reads); i++) {
 		const struct sfdp_bfpt_read *rd = &sfdp_bfpt_reads[i];
-- 
1.9.1

