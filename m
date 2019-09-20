Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBD2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408196AbfITGDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:03:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404716AbfITGDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:03:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0FC62B46316453C97F4;
        Fri, 20 Sep 2019 14:03:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 14:03:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zbr@ioremap.net>, <gregkh@linuxfoundation.org>,
        <yuehaibing@huawei.com>, <tglx@linutronix.de>,
        <tbogendoerfer@suse.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] w1: ds250x: Fix build error without CRC16
Date:   Fri, 20 Sep 2019 14:03:18 +0800
Message-ID: <20190920060318.35020-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CRC16 is not set, building will fails:

drivers/w1/slaves/w1_ds250x.o: In function `w1_ds2505_read_page':
w1_ds250x.c:(.text+0x82f): undefined reference to `crc16'
w1_ds250x.c:(.text+0x90a): undefined reference to `crc16'
w1_ds250x.c:(.text+0x91a): undefined reference to `crc16'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 25ec8710d9c2 ("w1: add DS2501, DS2502, DS2505 EPROM device driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/w1/slaves/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index ebed495b..b784763 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -103,6 +103,7 @@ config W1_SLAVE_DS2438
 
 config W1_SLAVE_DS250X
 	tristate "512b/1kb/16kb EPROM family support"
+	select CRC16
 	help
 	  Say Y here if you want to use a 1-wire
 	  512b/1kb/16kb EPROM family device (DS250x).
-- 
2.7.4


