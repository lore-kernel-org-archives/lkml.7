Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03EFC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D70218DE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946599;
	bh=YC4A5FicODasF8B4WHyElnHgEqlJvrcGPU58B1FKcsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TPRZ1sem/xp98mYvz6K9qZ3Wiz8KCZ1pXwiXKIcvc0SUy63ZJDfhpz1oFk2+BUgR3
	 /oIy7SMxqJ3J5dUi3WuKtaFknn3gEB1AzvFtm3Y7CPpnn/BLV/OtUJSwKdkE88yYZF
	 nlamIasPRWqDlkXCm1EotEv2FfE4rc+Xlp1mlAAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfIHMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfIHMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:43:14 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFB1216C8;
        Sun,  8 Sep 2019 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946594;
        bh=YC4A5FicODasF8B4WHyElnHgEqlJvrcGPU58B1FKcsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pax/rb2ik4b5hARMo4/QpcEHfdw+eZnVDhzhYHSJaIwAbOFFWxasndn2AdV27PQaS
         CGce5bGapo8uMA1Xkq9H8rKIMspITBtxKkO7CEVs3ImrR+RIuxinOPEcH2eJUrPD8R
         mOdlLOlscJAQl/SRxW8wUk27QP5Dn32WSbMBHwrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 05/23] gpio: Fix build error of function redefinition
Date:   Sun,  8 Sep 2019 13:41:40 +0100
Message-Id: <20190908121055.659392623@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121052.898169328@linuxfoundation.org>
References: <20190908121052.898169328@linuxfoundation.org>
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
index d12b5d566e4b1..11555bd821b73 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -229,30 +229,6 @@ static inline int irq_to_gpio(unsigned irq)
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



