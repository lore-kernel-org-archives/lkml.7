Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8563C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11A523427
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102569;
	bh=hGzTm4jDH5Y0WsNa/Vw17G8zXJmTDBmqLYC2f/tuNCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X+xGuDzH3wolr5JSymV17DIF+NTAS8/1/M4LHIaGZ/D0IqofWVPp7DCvANUzlJOqG
	 hId7Uihx9Ggrc1kaKXjcplrAF4O2K5CJy/jo0FRay6ie+OLGJCAN78nOZhIha3t90q
	 Um4ibIicbVSoJw4ccAGjw3FAGVcL4AjdzxJptfP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfH2SQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbfH2SQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E7F233FF;
        Thu, 29 Aug 2019 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102563;
        bh=hGzTm4jDH5Y0WsNa/Vw17G8zXJmTDBmqLYC2f/tuNCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9Ma/sOV0++c/pJhWiGFPMv2yucIOCFunLB3gwKAJcBOES9eHBVxSVZVt16CH+rRM
         MKZbZMrMDZ8W4Wn8nNbMA46J3kIzEvLtBumnA3aBDz0XKNFH0ucGWwerSG4XGz3/4e
         WTCRB8JdTivCWFp3B2N88tPfyb2BkbnOPa9MJsNs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/45] gpio: Fix build error of function redefinition
Date:   Thu, 29 Aug 2019 14:15:10 -0400
Message-Id: <20190829181547.8280-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 68e03b85474a51ec1921b4d13204782594ef7223 ]

when do randbuilding, I got this error:

In file included from drivers/hwmon/pmbus/ucd9000.c:19:0:
./include/linux/gpio/driver.h:576:1: error: redefinition of gpiochip_add_pin_range
 gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 ^~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/hwmon/pmbus/ucd9000.c:18:0:
./include/linux/gpio.h:245:1: note: previous definition of gpiochip_add_pin_range was here
 gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 ^~~~~~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 964cb341882f ("gpio: move pincontrol calls to <linux/gpio/driver.h>")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190731123814.46624-1-yuehaibing@huawei.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gpio.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 39745b8bdd65d..b3115d1a7d494 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -240,30 +240,6 @@ static inline int irq_to_gpio(unsigned irq)
 	return -EINVAL;
 }
 
-static inline int
-gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
-		       unsigned int gpio_offset, unsigned int pin_offset,
-		       unsigned int npins)
-{
-	WARN_ON(1);
-	return -EINVAL;
-}
-
-static inline int
-gpiochip_add_pingroup_range(struct gpio_chip *chip,
-			struct pinctrl_dev *pctldev,
-			unsigned int gpio_offset, const char *pin_group)
-{
-	WARN_ON(1);
-	return -EINVAL;
-}
-
-static inline void
-gpiochip_remove_pin_ranges(struct gpio_chip *chip)
-{
-	WARN_ON(1);
-}
-
 static inline int devm_gpio_request(struct device *dev, unsigned gpio,
 				    const char *label)
 {
-- 
2.20.1

