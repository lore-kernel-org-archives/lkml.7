Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2432C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7565F20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402523;
	bh=zs1S8QTcATifZyvgM4wdwaUFVuzz3zhjmwNFWrMfG6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IaIb59IZQ5U4Dl8j9VHhYCu8vpBSsud+jD8nPVJwmVkfORVqfQTszM5MY96SgEcJt
	 ls5A3ZToQKt6BrmslMCJhX3RBNwQImeX/wAj8ofbR/5qxo7dKkXiWM7Np0Jh8KH5Kw
	 1xgnA5nep9yjWf7pf86Gjlw4JkEFpKt42DwJMfEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfKVGCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbfKVGB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A69ED2071B;
        Fri, 22 Nov 2019 06:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402517;
        bh=zs1S8QTcATifZyvgM4wdwaUFVuzz3zhjmwNFWrMfG6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuX4lvwgL8tXT9cs6c8LHt2miDG+UR+65r4Wi7oX9tRVK5+emRdm5iyRxBYvv09wk
         KiqZ5F25uxeg3P4XQKfxhb6meczHrlE+A8zyRHC9ldG2t/WPgJdgWIwH23yqB68Nvo
         5lBib6zIPOKhu5sk3YsDNpYAYmraqa4uAAFoaA8Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Schiller <ms@dev.tdt.de>, John Crispin <john@phrozen.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 26/91] pinctrl: xway: fix gpio-hog related boot issues
Date:   Fri, 22 Nov 2019 01:00:24 -0500
Message-Id: <20191122060129.4239-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit 9b4924da4711674e62d97d4f5360446cc78337af ]

This patch is based on commit a86caa9ba5d7 ("pinctrl: msm: fix gpio-hog
related boot issues").

It fixes the issue that the gpio ranges needs to be defined before
gpiochip_add().

Therefore, we also have to swap the order of registering the pinctrl
driver and registering the gpio chip.

You also have to add the "gpio-ranges" property to the pinctrl device
node to get it finally working.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-xway.c | 39 +++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index dd85ad1807f52..8ea1c6e2a6b2b 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -1748,14 +1748,6 @@ static int pinmux_xway_probe(struct platform_device *pdev)
 	}
 	xway_pctrl_desc.pins = xway_info.pads;
 
-	/* register the gpio chip */
-	xway_chip.parent = &pdev->dev;
-	ret = devm_gpiochip_add_data(&pdev->dev, &xway_chip, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register gpio chip\n");
-		return ret;
-	}
-
 	/* setup the data needed by pinctrl */
 	xway_pctrl_desc.name	= dev_name(&pdev->dev);
 	xway_pctrl_desc.npins	= xway_chip.ngpio;
@@ -1777,10 +1769,33 @@ static int pinmux_xway_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* finish with registering the gpio range in pinctrl */
-	xway_gpio_range.npins = xway_chip.ngpio;
-	xway_gpio_range.base = xway_chip.base;
-	pinctrl_add_gpio_range(xway_info.pctrl, &xway_gpio_range);
+	/* register the gpio chip */
+	xway_chip.parent = &pdev->dev;
+	xway_chip.owner = THIS_MODULE;
+	xway_chip.of_node = pdev->dev.of_node;
+	ret = devm_gpiochip_add_data(&pdev->dev, &xway_chip, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register gpio chip\n");
+		return ret;
+	}
+
+	/*
+	 * For DeviceTree-supported systems, the gpio core checks the
+	 * pinctrl's device node for the "gpio-ranges" property.
+	 * If it is present, it takes care of adding the pin ranges
+	 * for the driver. In this case the driver can skip ahead.
+	 *
+	 * In order to remain compatible with older, existing DeviceTree
+	 * files which don't set the "gpio-ranges" property or systems that
+	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
+	 */
+	if (!of_property_read_bool(pdev->dev.of_node, "gpio-ranges")) {
+		/* finish with registering the gpio range in pinctrl */
+		xway_gpio_range.npins = xway_chip.ngpio;
+		xway_gpio_range.base = xway_chip.base;
+		pinctrl_add_gpio_range(xway_info.pctrl, &xway_gpio_range);
+	}
+
 	dev_info(&pdev->dev, "Init done\n");
 	return 0;
 }
-- 
2.20.1

