Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284B8C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03E721873
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120261;
	bh=xuDko2Kvy6nVBXl4m0duI21ACo6zyJn/Se4GyDooj/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xmCZJ9Kts6kPGcuDtN+wheE28AQJEek1Qo60lcVxdKtjxbXA0ar0mzYs5WDln0Cr7
	 4dLGHn/oMh/QEgBmAu164wzuz9DM/GvYVJJGGlNKgWmtDghNAhRblLyDMAZfx5xvbF
	 C/nGVJo7G5DQHkHBiitgPdGS3cPtMY6IuVre8Ry4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfGCCRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbfGCCQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:16:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF29021873;
        Wed,  3 Jul 2019 02:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120206;
        bh=xuDko2Kvy6nVBXl4m0duI21ACo6zyJn/Se4GyDooj/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZON/nKn3jUVkBLCDcbG2xulQw1uAcsmuZqSQsvJ4Tv1uEyBo+b8xmOi4IRVXqOmu
         uIzIZhlzKHicYgcDEYersimzHL88/OlNV2lV/jDGDTQIMu91EG9HmQrr0Bpp7gdh3l
         vnAjgeuw/t0ywszIlwbUwEMpOfYbcy9fHCMn/LQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phil Reid <preid@electromag.com.au>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/26] pinctrl: mcp23s08: Fix add_data and irqchip_add_nested call order
Date:   Tue,  2 Jul 2019 22:16:15 -0400
Message-Id: <20190703021625.18116-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021625.18116-1-sashal@kernel.org>
References: <20190703021625.18116-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Reid <preid@electromag.com.au>

[ Upstream commit 6dbc6e6f58556369bf999cd7d9793586f1b0e4b4 ]

Currently probing of the mcp23s08 results in an error message
"detected irqchip that is shared with multiple gpiochips:
please fix the driver"

This is due to the following:

Call to mcp23s08_irqchip_setup() with call hierarchy:
mcp23s08_irqchip_setup()
  gpiochip_irqchip_add_nested()
    gpiochip_irqchip_add_key()
      gpiochip_set_irq_hooks()

Call to devm_gpiochip_add_data() with call hierarchy:
devm_gpiochip_add_data()
  gpiochip_add_data_with_key()
    gpiochip_add_irqchip()
      gpiochip_set_irq_hooks()

The gpiochip_add_irqchip() returns immediately if there isn't a irqchip
but we added a irqchip due to the previous mcp23s08_irqchip_setup()
call. So it calls gpiochip_set_irq_hooks() a second time.

Fix this by moving the call to devm_gpiochip_add_data before
the call to mcp23s08_irqchip_setup

Fixes: 02e389e63e35 ("pinctrl: mcp23s08: fix irq setup order")
Suggested-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index cecbce21d01f..33c3eca0ece9 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -889,6 +889,10 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	if (ret < 0)
 		goto fail;
 
+	ret = devm_gpiochip_add_data(dev, &mcp->chip, mcp);
+	if (ret < 0)
+		goto fail;
+
 	mcp->irq_controller =
 		device_property_read_bool(dev, "interrupt-controller");
 	if (mcp->irq && mcp->irq_controller) {
@@ -930,10 +934,6 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 			goto fail;
 	}
 
-	ret = devm_gpiochip_add_data(dev, &mcp->chip, mcp);
-	if (ret < 0)
-		goto fail;
-
 	if (one_regmap_config) {
 		mcp->pinctrl_desc.name = devm_kasprintf(dev, GFP_KERNEL,
 				"mcp23xxx-pinctrl.%d", raw_chip_address);
-- 
2.20.1

