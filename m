Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66CBC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70272133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfDJIr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:47:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727184AbfDJIr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:47:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F3DE242FB7AEE5EBCD9;
        Wed, 10 Apr 2019 16:47:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 16:47:17 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <stefan.popa@analog.com>,
        <broonie@kernel.org>, <justinpopo6@gmail.com>,
        <linus.walleij@linaro.org>, <Jonathan.Cameron@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] iio: adc: ti-ads7950: Fix build error without CONFIG_GPIOLIB
Date:   Wed, 10 Apr 2019 16:45:58 +0800
Message-ID: <20190410084558.35160-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

When building with CONFIG_GPIOLIB is not set
gcc warns this:

drivers/iio/adc/ti-ads7950.c:75:19: error: field chip has incomplete type
  struct gpio_chip chip;
                   ^~~~
drivers/iio/adc/ti-ads7950.c: In function ti_ads7950_set:
drivers/iio/adc/ti-ads7950.c:409:32: error: implicit declaration of function gpiochip_get_data; did you mean acpi_get_data? [-Werror=implicit-function-declaration]
  struct ti_ads7950_state *st = gpiochip_get_data(chip);
                                ^~~~~~~~~~~~~~~~~
                                acpi_get_data

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 846c7ac..f760269 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -968,7 +968,7 @@ config TI_ADS1015
 
 config TI_ADS7950
 	tristate "Texas Instruments ADS7950 ADC driver"
-	depends on SPI
+	depends on SPI && GPIOLIB
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.7.4


