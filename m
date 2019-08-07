Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0FAC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774FE217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbfHHCAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:00:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730505AbfHHCAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:00:42 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45FC3EBC03D76B2A2438;
        Thu,  8 Aug 2019 10:00:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 10:00:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <maarten@treewalker.org>, <paul@crapouillou.net>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] regulator: act8865: Fix build error without CONFIG_POWER_SUPPLY
Date:   Wed, 7 Aug 2019 21:38:22 +0800
Message-ID: <20190807133822.67124-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building without CONFIG_POWER_SUPPLY will fail:

drivers/regulator/act8865-regulator.o: In function `act8865_pmic_probe':
act8865-regulator.c:(.text+0x357): undefined reference to `devm_power_supply_register'
drivers/regulator/act8865-regulator.o: In function `act8600_charger_get_property':
act8865-regulator.c:(.text+0x3f1): undefined reference to `power_supply_get_drvdata'

Add POWER_SUPPLY dependency to Kconfig.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2d09a79bf637 ("regulator: act8865: Add support for act8600 charger")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b57093d..37e6488 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -83,6 +83,7 @@ config REGULATOR_88PM8607
 config REGULATOR_ACT8865
 	tristate "Active-semi act8865 voltage regulator"
 	depends on I2C
+	depends on POWER_SUPPLY
 	select REGMAP_I2C
 	help
 	  This driver controls a active-semi act8865 voltage output
-- 
2.7.4


