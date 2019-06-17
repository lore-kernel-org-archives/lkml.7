Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB5B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfFQSlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:41:50 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfFQSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:41:43 -0400
Received: from orion.localdomain ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MowSu-1iPkr60HhG-00qVKy; Mon, 17 Jun 2019 20:41:22 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     thloh@altera.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 02/30] drivers: gpio: altera: use subsys_platform_driver()
Date:   Mon, 17 Jun 2019 20:40:43 +0200
Message-Id: <1560796871-18560-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
References: <1560796871-18560-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:n6lNF/HiERfH9tPVBrtbF8cjwb9Kd5R4hEw89zBMMBUSS2AViuC
 4gJyGnofyR32s6hyLipxjrmtm0hVyHI6gjievevJWOve7tRnvPBcIMtAJw7wKJhAWq5rDjj
 Iyj9m7RQrAUUKBSUGqHD1PBvmVAELc1atMNKegIh8gMZfgg4yV3opmtlH4Fg5chMY3jfnUb
 MdYDYDeTK0EIp4a8LH4YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FubfsVQejOg=:hcx/YkqnedyIVid8oMi3jN
 yFOL1ldrSamVyPD1XqgcK7HgFK+YLZiUZ5yvtylcHhNZk5uHA+E7qZ88wMhHMfx/G6qICZD0t
 kUFz1TDSL2m3B39o8Io548h4eFN/QTaqpPmDIe0dunWwnR1niVaJ+u0P0aqZd25Dz4V8TegoU
 pnvj81x//YNVy2u9bJ0kzKQxjgLvAtc83GT8hRXOiDQFPm9mriTFPaw1bpeR1oNppt0pK83dJ
 dD3mH7BDynA0Q4gJRNVe3ofzSKpACg3mGS7U9Vq2lYVKtrr/SyraobT8ddVtOx3qWQIW4RD3v
 fjskP8Mt6UrUjEJDI1a4nmMvvYdD07zeobqRexYJCodR3kxAkE8iDK5liLpetva6eRoNkJjFX
 b9uKQXHWqbf4vnKcgKhkMLaddWIxFDwa4F2DxlBbqF9Z5OSAq8vVPA2y06vqu/VVEtOAra6v5
 K89jcHmBOGrt2YxGcaQO4ADJoAFw3n+DDbQL7f+fjeIJDS3PS0S3hoA0Wz14HnVEeV+yD6LSd
 rzL3OApCEIKrUxcGx9Z4W21lsMRMqPj7+3/YclHcYNUiad8gv47ZcU1aICcAME4tCBOv6a9Ko
 GGL12YFdJN5kIorHVpjmaAXnznWQPuaMSTNIur8CLGbRii4Vg63T6blfjBi4swjCMcib4ojaD
 48A8xT3tkMu3KlL2VaZbvNvw/u0D38Ga6DgmOIxmWdQbhVbYsS4c09qzB2a/ebj+8aJS6Lcbk
 3G/hwmRXYSg8ea7msahEPVimEv97KizsfoZKPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
subsys_platform_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-altera.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index e088b90..b757c650 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -342,18 +342,7 @@ static int altera_gpio_remove(struct platform_device *pdev)
 	.probe		= altera_gpio_probe,
 	.remove		= altera_gpio_remove,
 };
-
-static int __init altera_gpio_init(void)
-{
-	return platform_driver_register(&altera_gpio_driver);
-}
-subsys_initcall(altera_gpio_init);
-
-static void __exit altera_gpio_exit(void)
-{
-	platform_driver_unregister(&altera_gpio_driver);
-}
-module_exit(altera_gpio_exit);
+subsys_platform_driver(altera_gpio_driver);
 
 MODULE_AUTHOR("Tien Hock Loh <thloh@altera.com>");
 MODULE_DESCRIPTION("Altera GPIO driver");
-- 
1.9.1

