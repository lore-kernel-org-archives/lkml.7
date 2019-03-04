Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B2B20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCDT5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:57:37 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:57:37 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mgvan-1hS0ri03hd-00hLZ9; Mon, 04 Mar 2019 20:57:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: msm-vibrator: use correct gpio header
Date:   Mon,  4 Mar 2019 20:56:59 +0100
Message-Id: <20190304195734.1070109-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/8+crg0rtE8F/KHpVaFS5EkmK0g90AuK4P88cv1P7RU8bbKBaQ9
 y5teQZA0/mjvKjFDhlyuhCdBAIvk9trLWev7F2QkBvtuGP709ujItMCFIZuem343y0Js0DW
 DHGOifme8zeTq63KqLs4mrbqYNcLo2GmLx4lG1k7EwslSBIrCeV3VoY4jtVdcwzesBuYzpj
 lcGScS36Qnaf3xqy2rOnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/pUvkxvbgQ=:ebr51muBYH3Z4vWd8/Xzp5
 T50cfHcamWkBBSN2TgPrFq8sEgBEK+BTu1KkiyeS1EwuFCaWqElib0Hi0EQtXBYtJkTYvaF90
 6uvI9Q6Z8l0hePKPK0MGyV12zEM+ILpsog+RDgu7DcnZHvF58mXwm0+JCF+FrpAEr53ze0Fd7
 /zgepJ+t5jm+MdNNTUpdFXTovYWCSQJCwN4fMrp4tbJAidG5jutYTGTCq70f31RVnA6OHzjRW
 9mEi1vIVnQHwn7hwEtu1suHnHrkWxR4IEhF/8FIuIIHbqRU3fJ9Cl8A0WgvQcRNC8KaYNI8Z0
 X2KcOTctCUrwOuF8CoZWhT5knRKtTvNo4qjlop072nbDtOG2JAPcSdxLDz5eU4WZRBQptzn87
 NnQAuxM0sJKSZWXanYsL14BhUIMFx+vKm3a0nk9YhBa3UpoFex2pJRwv60LGS0ZXLYKT0Ucw1
 2U6xkIP8H8PoCXZZzs468AN7cl4XzXl5ivcnedIHDdZDrCeXRCOON0kyab1oAfLv9N6nEmNgQ
 5ZLH84JHRpc5Rh9EDsU3R2W8S4jlTTKlOPGKCYjJwxozh/UL1VC+KXYJxecOCCj3A/fdRVMHM
 uQ938p/dei70Ux7ZSTk5GXFyEkGvoZ/3Dju59KW+molHbbfi2WNBT8+4HIrxdruJ3rMSdrs7y
 Mm49f7HQjBpwusuM5BRgBz1hG1BGFHRkVjZb9IoVtQFpvpJIkZqqEWWGD8kI5JkX19Gd7UQ7Z
 uKPQ//7mf1V8znGK3N5W6mb/jiNKBqDBOSj8mQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_GPIOLIB is not set, we get a couple of build
errors during test building:

drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_start':
drivers/input/misc/msm-vibrator.c:79:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
   gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
   ^~~~~~~~~~~~~~~~~~~~~~~~
   gpio_set_value_cansleep
drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_probe':
drivers/input/misc/msm-vibrator.c:176:26: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
  vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
                          ^~~~~~~~~~~~~~
                          devm_gpio_free
drivers/input/misc/msm-vibrator.c:177:13: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
             GPIOD_OUT_LOW);
             ^~~~~~~~~~~~~
             GPIOF_INIT_LOW
drivers/input/misc/msm-vibrator.c:177:13: note: each undeclared identifier is reported only once for each function it appears in

This is easy to avoid when we use gpio/consumer.h as the documented interface.

Fixes: 0f681d09e66e ("Input: add new vibrator driver for various MSM SOCs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/msm-vibrator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/msm-vibrator.c b/drivers/input/misc/msm-vibrator.c
index 69f2579c4ec2..b60f1aaee705 100644
--- a/drivers/input/misc/msm-vibrator.c
+++ b/drivers/input/misc/msm-vibrator.c
@@ -13,7 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.20.0

