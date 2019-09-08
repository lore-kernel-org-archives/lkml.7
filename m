Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056D82067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947487;
	bh=q54WEmURkkkwIjLKPzleqdQLu47tYN82atWMJMqBdwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qHe02KdXg5S46yZe7g7buN/ghkPXUHTEkfrLgUOi39EvkGd0M/KC8kTClVMY5UrBe
	 sSyfCvamAgdTs36EcR3d99S+xSb5nWW8IPMFBHsur90WeGt6shJmdTpeBPWOoEHXXF
	 uz3S+cQ4eETD9jINU2SYzvg+zzECZPcaT7ItfI14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfIHMr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbfIHMrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:47:25 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075CD2190F;
        Sun,  8 Sep 2019 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946844;
        bh=q54WEmURkkkwIjLKPzleqdQLu47tYN82atWMJMqBdwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hgadf7nvMOacRQa8duS5HR9qn+vg5OnRPOD8HYUCb0lk7/Bww8HYpddSsBxzuOsB+
         XsMdkPghgmJE7Hb+/0cgQgoGFqApC/aph6HtLr0S/FTI/NAdlBdDdiifB5gcMRsK64
         FprWAfEvJls7DV584aYdPVG7Fg9nca3yC4GaGP4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/57] gpio: Fix build error of function redefinition
Date:   Sun,  8 Sep 2019 13:41:45 +0100
Message-Id: <20190908121134.504042593@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



