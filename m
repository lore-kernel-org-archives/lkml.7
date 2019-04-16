Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF9BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFC220656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfDPOlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:41:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfDPOlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:41:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 06558FA49C04F976C176;
        Tue, 16 Apr 2019 22:41:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 22:41:13 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] regulator: Make symbols static
Date:   Tue, 16 Apr 2019 22:41:09 +0800
Message-ID: <20190416144109.33692-1-yuehaibing@huawei.com>
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

Fix sparse warnings:

drivers/regulator/stm32-pwr.c:35:5: warning:
 symbol 'ready_mask_table' was not declared. Should it be static?
drivers/regulator/stm32-pwr.c:47:5: warning:
 symbol 'stm32_pwr_reg_is_ready' was not declared. Should it be static?
drivers/regulator/stm32-pwr.c:57:5: warning:
 symbol 'stm32_pwr_reg_is_enabled' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/regulator/stm32-pwr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index e434b26..222d593 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -32,7 +32,7 @@ enum {
 	STM32PWR_REG_NUM_REGS
 };
 
-u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
+static u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
 	[PWR_REG11] = REG_1_1_RDY,
 	[PWR_REG18] = REG_1_8_RDY,
 	[PWR_USB33] = USB_3_3_RDY,
@@ -44,7 +44,7 @@ struct stm32_pwr_reg {
 	u32 ready_mask;
 };
 
-int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
+static int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
 {
 	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
 	u32 val;
@@ -54,7 +54,7 @@ int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
 	return (val & priv->ready_mask);
 }
 
-int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
+static int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
 {
 	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
 	u32 val;
-- 
2.7.4


