Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D952ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452FD21928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hXFF7s+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfIKFQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:16:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44408 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIKFQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:16:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so12876699pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BMbiIR1LyRY98dnnELG+YAf1kawqGEANpBbQC+CCbhM=;
        b=hXFF7s+PuFW/NxL4QbBtCtkypBM6BCKYfL5Y4lDxq0MOLXR5iPqBGXyy6lo6DNUTzf
         bfCuPZIzKyEo5zHuuJ4/fcTkFLpI0wmW7ZILWwHnD4bjemvW3FE/mnuDq5PIvxzlDSvW
         H+OdfrFmDdj+G6wKnx6ypaSLghjQ0p14FssHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BMbiIR1LyRY98dnnELG+YAf1kawqGEANpBbQC+CCbhM=;
        b=DLnGEa2S2XaXmvFEI/MlyT+7S4R+mc8tqxEgaQJ8RbLVtXPHOdDW2hcWV6lpnVXKy6
         Lbd9YYoo42giF3r2lbvslYyg29NbKgIvt9jO3hJvwyf0aEVMSce91UeThb9ltnYry7ji
         B54ynBcS8NLRpmvnnCCW02isfTJymlgjR+hoRTir2abzywsJb0A+84sP3fwg4SMaRefB
         SJIQtCt7A3+1o8ctw+BuWUM0Kd6ovVtJFslCerRfct5PIxSxPaGbwFU8OTa+Cm/MWfKI
         6AYcy4/hJsCrBofKYX4bd/P7m0yyBZga4sIZJd34ZgzGV/KTdY4pfi3qlhoNe3xAdJB0
         +86w==
X-Gm-Message-State: APjAAAWy/s3QVw13yTQ8f9m0DOpimBjzSv9Fofz6vwtwYUk3eOoltZ3c
        zhCLn4OG266CMHcvIpQ35wG39w==
X-Google-Smtp-Source: APXvYqwYQWfMQ6vWWOF3mSdlh/pc8D0x/hHtJukanbuXtbH4cOkp3f+6D5/1gN28cXGa7MC9q4xGzA==
X-Received: by 2002:a63:6a4a:: with SMTP id f71mr30755038pgc.409.1568178973942;
        Tue, 10 Sep 2019 22:16:13 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h186sm33650986pfb.63.2019.09.10.22.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 22:16:12 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] pinctrl: iproc: Add 'get_direction' support
Date:   Wed, 11 Sep 2019 10:41:25 +0530
Message-Id: <1568178685-30738-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'get_direction' support to the iProc GPIO driver.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index b70058c..d782d70 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -355,6 +355,15 @@ static int iproc_gpio_direction_output(struct gpio_chip *gc, unsigned gpio,
 	return 0;
 }
 
+static int iproc_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct iproc_gpio *chip = gpiochip_get_data(gc);
+	unsigned int offset = IPROC_GPIO_REG(gpio, IPROC_GPIO_OUT_EN_OFFSET);
+	unsigned int shift = IPROC_GPIO_SHIFT(gpio);
+
+	return !(readl(chip->base + offset) & BIT(shift));
+}
+
 static void iproc_gpio_set(struct gpio_chip *gc, unsigned gpio, int val)
 {
 	struct iproc_gpio *chip = gpiochip_get_data(gc);
@@ -784,6 +793,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 	gc->free = iproc_gpio_free;
 	gc->direction_input = iproc_gpio_direction_input;
 	gc->direction_output = iproc_gpio_direction_output;
+	gc->get_direction = iproc_gpio_get_direction;
 	gc->set = iproc_gpio_set;
 	gc->get = iproc_gpio_get;
 
-- 
1.9.1

