Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F273C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EDB20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367624;
	bh=gG+2F9C/S0DMH23te/XhT23kWIErjZKsjY4shtCkNpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LhPI7A98VKdkX1+kaz1V4PCWO7+Is+k8VsXMr6AthS6xSwW03xotiy5wBLV5s8eRs
	 1lMl5XDvvOJMRKxhJSQ/gHLssgnPmFE2cztN3QQaf8eydgra9mpspJSZIJ4AYYU64C
	 YoB2FrbjUU6loTP6lGYreCXpswTGjvOK+5rjvWBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfB1P1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732793AbfB1PLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041A0218D9;
        Thu, 28 Feb 2019 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366681;
        bh=gG+2F9C/S0DMH23te/XhT23kWIErjZKsjY4shtCkNpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYHeCsa4hu3XIPaObcRWkAUkj+wLqFETF3PjTywcUq1QtSOT0kVtI/HMHVwevpU3/
         IeOSCVcrbTYm898189wH1HA24A0lLLqg4WBwOw7WCsV/C6Z06JxEm2LXw6C3FvQM4p
         pc82LNY4s2521wbx1kbWjNfwS8H5kbVjD+fyY54E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Kridner <jkridner@gmail.com>, Jason Kridner <jdk@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/64] pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18
Date:   Thu, 28 Feb 2019 10:10:12 -0500
Message-Id: <20190228151105.11277-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Kridner <jkridner@gmail.com>

[ Upstream commit f165988b77ef849eb0c1aebd94fe778024f88314 ]

Fixes issue created by 9b3e4207661e67f04c72af15e29f74cd944f5964.

It wasn't possible for one_regmap_config to be non-NULL at the point
it was tested for mcp23s18 devices.

Applied the same pattern of allocating one_regmap_config using
devm_kmemdump() and then initializing the local regmap structure
from that.

Signed-off-by: Jason Kridner <jdk@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index cf73a403d22df..cecbce21d01f7 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -832,8 +832,13 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 		break;
 
 	case MCP_TYPE_S18:
+		one_regmap_config =
+			devm_kmemdup(dev, &mcp23x17_regmap,
+				sizeof(struct regmap_config), GFP_KERNEL);
+		if (!one_regmap_config)
+			return -ENOMEM;
 		mcp->regmap = devm_regmap_init(dev, &mcp23sxx_spi_regmap, mcp,
-					       &mcp23x17_regmap);
+					       one_regmap_config);
 		mcp->reg_shift = 1;
 		mcp->chip.ngpio = 16;
 		mcp->chip.label = "mcp23s18";
-- 
2.19.1

