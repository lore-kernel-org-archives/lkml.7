Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0420656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfDXJP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:15:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfDXJP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:15:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 73C43F0C4FEDCA5A985A;
        Wed, 24 Apr 2019 17:15:55 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 17:15:46 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <l.stach@pengutronix.de>, <aisheng.dong@nxp.com>,
        <leonard.crestez@nxp.com>, <abel.vesa@nxp.com>,
        <Anson.Huang@nxp.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] soc: imx: Fix build error without CONFIG_SOC_BUS
Date:   Wed, 24 Apr 2019 17:15:17 +0800
Message-ID: <20190424091517.41428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190424075946.23124-1-yuehaibing@huawei.com>
References: <20190424075946.23124-1-yuehaibing@huawei.com>
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
Suggested-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: select SOC_BUS from CONFIG_ARCH_MXC directly
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b5ca9c5..ae7f008 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -157,6 +157,7 @@ config ARCH_MXC
 	select IMX_GPCV2_PM_DOMAINS
 	select PM
 	select PM_GENERIC_DOMAINS
+	select SOC_BUS
 	help
 	  This enables support for the ARMv8 based SoCs in the
 	  NXP i.MX family.
-- 
2.7.4


