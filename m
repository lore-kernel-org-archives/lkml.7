Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2822177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfDQCUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:20:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfDQCUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:20:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D17AE7F95A6E2A195E54;
        Wed, 17 Apr 2019 10:20:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Wed, 17 Apr 2019 10:20:29 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Pascal PAILLET-LME <p.paillet@st.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] regulator: stm32-pwr: Make some symbols static
Date:   Wed, 17 Apr 2019 02:31:12 +0000
Message-ID: <20190417023112.162916-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

drivers/regulator/stm32-pwr.c:35:5: warning:
 symbol 'ready_mask_table' was not declared. Should it be static?
drivers/regulator/stm32-pwr.c:47:5: warning:
 symbol 'stm32_pwr_reg_is_ready' was not declared. Should it be static?
drivers/regulator/stm32-pwr.c:57:5: warning:
 symbol 'stm32_pwr_reg_is_enabled' was not declared. Should it be static?

Fixes: 6cdae8173f67 ("regulator: Add support for stm32 power regulators")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/regulator/stm32-pwr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index e434b26d4c8b..222d593d76a2 100644
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



