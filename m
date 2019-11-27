Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0552C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7867215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887059;
	bh=tHz6rQfVRrlihB6AmfT2FhFCw8KS4l93N13Y6nXzowU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSZ9v+Ue1mlFVlXP7vO8LmWuc0If1YQe5TyoXh+LKS3TwAzqssUbczKFAg6hz8/Ny
	 yDFbUWH/7t1lfC+pcF8qB9ZtGcB61jTpbjYsKcOJwpFwgsPfIRcKN75wr8dCyAJAaU
	 JBC5g3yxjFiuL2M4uVw/oUXTgjgW4O/SJxkpD2o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfK0Uhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbfK0Uhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35390215A5;
        Wed, 27 Nov 2019 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887051;
        bh=tHz6rQfVRrlihB6AmfT2FhFCw8KS4l93N13Y6nXzowU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWHH52AnS3JRYbBA2HSpMAJQ64KC12wjNC22m7urZkWp/5BpxSAPmfjBwBIFeh9L/
         rldgn+Roq3EEWHHcoJN1u9LYyvzwAAkm6O9HwyICZwWhG7rXzLG3uNaCE7D933VDpK
         E/AGpndM0VTWRGkrtxSsS2k+5vXfMS0mcrM4ImzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 094/132] pinctrl: qcom: spmi-gpio: fix gpio-hog related boot issues
Date:   Wed, 27 Nov 2019 21:31:25 +0100
Message-Id: <20191127203020.871800932@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Masney <masneyb@onstation.org>

[ Upstream commit 149a96047237574b756d872007c006acd0cc6687 ]

When attempting to setup up a gpio hog, device probing would repeatedly
fail with -EPROBE_DEFERED errors. It was caused by a circular dependency
between the gpio and pinctrl frameworks. If the gpio-ranges property is
present in device tree, then the gpio framework will handle the gpio pin
registration and eliminate the circular dependency.

See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
gpio-hog related boot issues") for a detailed commit message that
explains the issue in much more detail. The code comment in this commit
came from Christian's commit.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4ea810cafaac6..913b2604d3454 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -793,10 +793,23 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 		goto err_chip;
 	}
 
-	ret = gpiochip_add_pin_range(&state->chip, dev_name(dev), 0, 0, npins);
-	if (ret) {
-		dev_err(dev, "failed to add pin range\n");
-		goto err_range;
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
+	if (!of_property_read_bool(dev->of_node, "gpio-ranges")) {
+		ret = gpiochip_add_pin_range(&state->chip, dev_name(dev), 0, 0,
+					     npins);
+		if (ret) {
+			dev_err(dev, "failed to add pin range\n");
+			goto err_range;
+		}
 	}
 
 	return 0;
-- 
2.20.1



