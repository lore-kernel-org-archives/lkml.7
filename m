Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A8C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651FF2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520609;
	bh=nmVqm5LCFkN57JcvZZ3jWRa4TbV2CnF7sjsDTG8/21g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GrQGa9ELCjoBgAD8dtPAtw8s/8diW2gqXcJch4NuAeTA40/3NvxLBFASM9ZkfJ6cu
	 lceRFUKHawTcAU/XsE9Z91DoCBTrW3BLpBdU4jWoHWVrVr+qG+nuFX8JEaDoPR6QLB
	 uOYrpNiQuBUjz8R1FiT+MF44y+zDFGh6iCTWzjkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfFZDn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfFZDnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:43:18 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C988F20659;
        Wed, 26 Jun 2019 03:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520598;
        bh=nmVqm5LCFkN57JcvZZ3jWRa4TbV2CnF7sjsDTG8/21g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oj3KhlkTDOL0SVQQZacBz9WkB7BPKTbaqBnuvXFQ7uAJLPHgG/PlrUnUowFxeXCAP
         d9Sk0HUBa0nlUWJjt+DTkxorCPO5mRTe2M8LE4E2CGp/A57H8OfJ6kVNijYqd7+Szj
         T0ihNz78K1g3kdPBR7qH3RbEPFSEcQUwK268yK8k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 44/51] i2c: pca-platform: Fix GPIO lookup code
Date:   Tue, 25 Jun 2019 23:41:00 -0400
Message-Id: <20190626034117.23247-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit a0cac264a86fbf4d6cb201fbbb73c1d335e3248a ]

The devm_gpiod_request_gpiod() call will add "-gpios" to
any passed connection ID before looking it up.

I do not think the reset GPIO on this platform is named
"reset-gpios-gpios" but rather "reset-gpios" in the device
tree, so fix this up so that we get a proper reset GPIO
handle.

Also drop the inclusion of the legacy GPIO header.

Fixes: 0e8ce93bdceb ("i2c: pca-platform: add devicetree awareness")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pca-platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index de3fe6e828cb..f50afa8e3cba 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -21,7 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/i2c-algo-pca.h>
 #include <linux/platform_data/i2c-pca-platform.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -173,7 +172,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = np;
 
-	i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset-gpios", GPIOD_OUT_LOW);
+	i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(i2c->gpio))
 		return PTR_ERR(i2c->gpio);
 
-- 
2.20.1

