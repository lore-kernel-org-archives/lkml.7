Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F58DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B09D206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055156;
	bh=AtCq6jVeihqXRMeoxArxYvOW6neI01z4myOsxS1vX7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5Qx0ATIyDP8tTgdEx83HyTN8w2hcInu7rPAIiJbz3v/mqp4WJpxHxvdkORsbPU1T
	 VdB7jc1hMfSkBwD/D1BdPOii41OrmU5FW/GU4j6Ur5TTI+X/M865Hy6wNF6OCyRORQ
	 E924EBQdhjDdca2nZoh8eiLY7vF87QNCkJ36Bpw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfFTSZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfFTSGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:06:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176F6204FD;
        Thu, 20 Jun 2019 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054007;
        bh=AtCq6jVeihqXRMeoxArxYvOW6neI01z4myOsxS1vX7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AS8Uxyclsn3DGQd20+fxZ4nconYu8LWbmzoeyeEih/erMFym+9QB4iLjhCvGaxfFw
         JUBIY3KcuQFauf3QKOhbgM9KCV3P3dMCZ9o80+PoWYbZpeL1Qwnc+IvOPraeA9bQku
         PWG1P+digfvhHmdCdtY3Q8jEpxTxSc2IDELNzovg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 103/117] gpio: fix gpio-adp5588 build errors
Date:   Thu, 20 Jun 2019 19:57:17 +0200
Message-Id: <20190620174357.919590022@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e9646f0f5bb62b7d43f0968f39d536cfe7123b53 ]

The gpio-adp5588 driver uses interfaces that are provided by
GPIOLIB_IRQCHIP, so select that symbol in its Kconfig entry.

Fixes these build errors:

../drivers/gpio/gpio-adp5588.c: In function ‘adp5588_irq_handler’:
../drivers/gpio/gpio-adp5588.c:266:26: error: ‘struct gpio_chip’ has no member named ‘irq’
            dev->gpio_chip.irq.domain, gpio));
                          ^
../drivers/gpio/gpio-adp5588.c: In function ‘adp5588_irq_setup’:
../drivers/gpio/gpio-adp5588.c:298:2: error: implicit declaration of function ‘gpiochip_irqchip_add_nested’ [-Werror=implicit-function-declaration]
  ret = gpiochip_irqchip_add_nested(&dev->gpio_chip,
  ^
../drivers/gpio/gpio-adp5588.c:307:2: error: implicit declaration of function ‘gpiochip_set_nested_irqchip’ [-Werror=implicit-function-declaration]
  gpiochip_set_nested_irqchip(&dev->gpio_chip,
  ^

Fixes: 459773ae8dbb ("gpio: adp5588-gpio: support interrupt controller")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-gpio@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 12d417a4d4a8..b992badb99dd 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -670,6 +670,7 @@ config GPIO_ADP5588
 config GPIO_ADP5588_IRQ
 	bool "Interrupt controller support for ADP5588"
 	depends on GPIO_ADP5588=y
+	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to enable the adp5588 to be used as an interrupt
 	  controller. It requires the driver to be built in the kernel.
-- 
2.20.1



