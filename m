Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C564AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C325218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfDXIAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:00:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfDXIAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:00:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EA8A81AB1E0836BDAFDA;
        Wed, 24 Apr 2019 16:00:29 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 16:00:23 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <l.stach@pengutronix.de>, <aisheng.dong@nxp.com>,
        <leonard.crestez@nxp.com>, <abel.vesa@nxp.com>,
        <Anson.Huang@nxp.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] soc: imx: Fix build error without CONFIG_SOC_BUS
Date:   Wed, 24 Apr 2019 15:59:46 +0800
Message-ID: <20190424075946.23124-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

During randconfig builds, I occasionally run into an invalid configuration

drivers/soc/imx/soc-imx8.o: In function `imx8_soc_init':
soc-imx8.c:(.init.text+0x144): undefined reference to `soc_device_register'

while CONFIG_SOC_BUS is not set, the building failed like this. This patch
selects SOC_BUS to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a7e26f356ca1 ("soc: imx: Add generic i.MX8 SoC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index d80f899..2fb4e47 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -5,6 +5,7 @@ config IMX_GPCV2_PM_DOMAINS
 	depends on ARCH_MXC || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
+	select SOC_BUS
 	default y if SOC_IMX7D
 
 endmenu
-- 
2.7.4


