Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05D2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CB921530
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfE1JbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:31:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfE1JbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:31:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D08CE769A90EAD893066;
        Tue, 28 May 2019 17:31:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 17:31:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>, <lkundrak@v3.sk>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 1/2] Platform: OLPC: Fix build error without CONFIG_SPI
Date:   Tue, 28 May 2019 17:28:05 +0800
Message-ID: <20190528092806.20080-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190528092806.20080-1-yuehaibing@huawei.com>
References: <20190528092806.20080-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build error while CONFIG_SPI is not set

drivers/platform/olpc/olpc-xo175-ec.o: In function `olpc_xo175_ec_remove':
olpc-xo175-ec.c:(.text+0x190): undefined reference to `spi_slave_abort'
drivers/platform/olpc/olpc-xo175-ec.o: In function `olpc_xo175_ec_send_command':
olpc-xo175-ec.c:(.text+0x374): undefined reference to `spi_async'
drivers/platform/olpc/olpc-xo175-ec.o: In function `olpc_xo175_ec_cmd':
olpc-xo175-ec.c:(.text+0x8a0): undefined reference to `spi_slave_abort'
drivers/platform/olpc/olpc-xo175-ec.o: In function `olpc_xo175_ec_spi_driver_init':
olpc-xo175-ec.c:(.init.text+0x14): undefined reference to `__spi_register_driver'

We should depends on CONFIG_SPI_SLAVE other than directly select it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 0c3d931b3ab9 ("Platform: OLPC: Add XO-1.75 EC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/platform/olpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfig
index 858ac1d..1d3244a 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -5,7 +5,7 @@ config OLPC_EC
 config OLPC_XO175_EC
 	tristate "OLPC XO 1.75 Embedded Controller"
 	depends on ARCH_MMP || COMPILE_TEST
-	select SPI_SLAVE
+	depends on SPI_SLAVE
 	select OLPC_EC
 	help
 	  Include support for the OLPC XO Embedded Controller (EC). The EC
-- 
2.7.4


