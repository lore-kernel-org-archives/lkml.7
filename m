Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF845C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EADC20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfCKTsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:48:25 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:48:25 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MatZt-1gW0hZ3vFT-00cRJq; Mon, 11 Mar 2019 20:48:23 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH] drivers: gpio: octeon: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 20:48:21 +0100
Message-Id: <1552333701-22712-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-23-git-send-email-info@metux.net>
References: <1552330521-4276-23-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:O7zyg437ojWNNGrlqt+uZMayC1uHEekNobbsCmkjlBHoogDhJ7s
 vcewt2TcovNki/OHV1FNN0R5v7qqb/r0Ldp2sng5MS/60FLRSFvTgAVgEoFRndZSUKm1kp6
 zVaJ9cpx0rmnYLyW7yPuLXkcaPPyhjL1DrslaFHv4LJ7doSdY/LtPoFEDldBoQ3fonYzq31
 F8jZuEy56ZpOONXh3h9tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKA2JKYwJhI=:VyHwXOQ+26ejCUDVXokCeW
 Q8CIfTMo3RkRdBr2QtJhzh8lirkAhA0A1emszDMNbaYs8ev9SKZVrxJmsQQnMaxvUhgyZ0zPa
 L4r+zfXWeZE8UJeAlXxVZ8AlBJ0a1M8ZU9gMaDeVoqXij01uE0c/Z/N5kl34HNRGolm5E6Ln9
 XOGpI6hHSF8WTGO6Mlv91GZdXfip8ESf9orjosDHNwMXDutES4cfLQ54V3jmvD6klJ6huQEqc
 MPNjB2lawgxV7bpRkmqPV5zQNWCxqOArO+EA5w7vCEVyrvpB2ZGB7sHjAWwj8Vvx96+I4dtv/
 IDm1V2fnqPAwT7rrZrWlUFFfc4QXmpb/k/8t529dg1fBGOYBH4B6J6/Uj/W1fnHr7cgAUhfyQ
 vv6F7kx2hhpMAgYIa9i6jFlgPP+YoPld3gpY4TygF4xVKQZsIHJfcZWaqtFluH9wKf/TOzMpN
 UF37zk60HkpoVFqYkzqePKXBGUnqWSN88z2mVHM5HjTiZ/461B+TAgvDf1AyeQDPorydU4V9J
 sSYoiyxnhu3dP9C//4AVGi1CJiurMw19s3bA5TXFvuTUWbpwN+hB5BhTouROZ+PS2iMVhPsYW
 Erl2bmiMNPMVImPprem3vrDhI8tQ65zajj7Y+WlDZpxO5liO+lQdxVv8REJ3hf2EFZFujvMTw
 LPxOtTG7fxtCPb6xu+yrKyJX10taT1lTAYud49C39ylU2h746kMsWiuMgWcmWOdXIxsCVW6yw
 5uaovKpgf9LeK0KqtUPlAleMMB4mM/yvCd7L9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-octeon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index 1b19c88..afb0e8a 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -82,7 +82,6 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 {
 	struct octeon_gpio *gpio;
 	struct gpio_chip *chip;
-	struct resource *res_mem;
 	void __iomem *reg_base;
 	int err = 0;
 
@@ -91,8 +90,7 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	chip = &gpio->chip;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(&pdev->dev, res_mem);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-- 
1.9.1

