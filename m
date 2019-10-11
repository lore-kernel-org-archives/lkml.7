Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805D2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B27206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfJKDGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:06:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfJKDGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:06:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4CC76DC55C64BDC9EEB5;
        Fri, 11 Oct 2019 11:06:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 11 Oct 2019 11:05:58 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jerome.pouiller@silabs.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH] staging: wfx: fix an undefined reference error when CONFIG_MMC=m
Date:   Fri, 11 Oct 2019 11:02:19 +0800
Message-ID: <1570762939-8735-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit the following error when compile the kernel.

drivers/staging/wfx/main.o: In function `wfx_core_init':
/home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
drivers/staging/wfx/main.o: In function `wfx_core_exit':
/home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/staging/wfx/Kconfig  | 3 ++-
 drivers/staging/wfx/Makefile | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wfx/Kconfig b/drivers/staging/wfx/Kconfig
index 9b8a1c7..4d045513 100644
--- a/drivers/staging/wfx/Kconfig
+++ b/drivers/staging/wfx/Kconfig
@@ -1,7 +1,8 @@
 config WFX
 	tristate "Silicon Labs wireless chips WF200 and further"
 	depends on MAC80211
-	depends on (SPI || MMC)
+	depends on SPI
+	select MMC
 	help
 	  This is a driver for Silicons Labs WFxxx series (WF200 and further)
 	  chipsets. This chip can be found on SPI or SDIO buses.
diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
index 0d9c1ed..fc30b49 100644
--- a/drivers/staging/wfx/Makefile
+++ b/drivers/staging/wfx/Makefile
@@ -17,8 +17,9 @@ wfx-y := \
 	key.o \
 	main.o \
 	sta.o \
-	debug.o
+	debug.o \
+	bus_sdio.o
+
 wfx-$(CONFIG_SPI) += bus_spi.o
-wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
 
 obj-$(CONFIG_WFX) += wfx.o
-- 
1.7.12.4

