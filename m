Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456A32184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfGSBBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:01:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfGSBBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:01:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14D4288903822913EF0F;
        Fri, 19 Jul 2019 09:01:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 19 Jul 2019 09:01:29 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] mtd: hyperbus: fix build error about CONFIG_REGMAP
Date:   Fri, 19 Jul 2019 09:07:03 +0800
Message-ID: <20190719010703.63815-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MUX_MMIO and CONFIG_HBMC_AM654 are both 'm', there are
some building error as below:

drivers/mux/mmio.c: In function mux_mmio_probe:
drivers/mux/mmio.c:76:20: error: storage size of field isnt known
   struct reg_field field;
                    ^~~~~
drivers/mux/mmio.c:102:15: error: implicit declaration of function devm_regmap_field_alloc; did you mean devm_mux_chip_alloc? [-Werror=implicit-function-declaration]
   fields[i] = devm_regmap_field_alloc(dev, regmap, field);
               ^~~~~~~~~~~~~~~~~~~~~~~
               devm_mux_chip_alloc
drivers/mux/mmio.c:76:20: warning: unused variable field [-Wunused-variable]
   struct reg_field field;
                    ^~~~~
cc1: some warnings being treated as errors
make[2]: *** [drivers/mux/mmio.o] Error 1
make[1]: *** [drivers/mux] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

This because CONFIG_REGMAP is not enable, so change the Kconfig for HBMC_AM654.

Fixes: b07079f1642c("mtd: hyperbus: Add driver for TI's HyperBus memory controller")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/mtd/hyperbus/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
index cff6bbd..f324fa6 100644
--- a/drivers/mtd/hyperbus/Kconfig
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -14,6 +14,8 @@ if MTD_HYPERBUS
 
 config HBMC_AM654
 	tristate "HyperBus controller driver for AM65x SoC"
+	select OF
+	select REGMAP
 	select MULTIPLEXER
 	select MUX_MMIO
 	help
-- 
2.7.4

