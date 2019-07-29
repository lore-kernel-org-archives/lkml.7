Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E527EC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8698206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfG2O0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:26:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfG2O0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:26:14 -0400
Received: from orion.localdomain ([77.4.29.213]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmlCY-1iH1pj0Dd0-00jrbB; Mon, 29 Jul 2019 16:26:13 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH] input: misc: soc_button_array: use platform_device_register_resndata()
Date:   Mon, 29 Jul 2019 16:26:12 +0200
Message-Id: <1564410372-18506-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:fqc44a8/rKnpNASqG6Z6PSHWX575HMzuMroIOGhWv8fytufkDi1
 5zIytflr0N4U8Eq4b260l5k+gSvMNqlRk3JhHmb6hyQSyfCl6p/zou2uL1FFQJN+zIYSsgz
 3cXd5zEk44Vh9p4gatuKUEwOIUVZB9A0BY55/Pi9UST9EwATtTi0HI1eFFucBr19Kgvo7/6
 YDXJMDxHxcWo2s5Oo6Oag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w0TcFa6ZOp0=:dEMl3YhymDb9m78rodQEL1
 CBSzQBMLP0kue6Aj1jLMXSrVKt0fOogVXe/E8Rwkx0fsyhYbV1AmivTQK6b179neZmf0gO8ii
 MAhhXiQneBh9JwJCoXjUIrpA9LboK7IBdIUDaHYLULhF83wwDs8ORm87vBBbjBoAjjLsB5DV9
 Q4Dlo4Jrn6kfPrJRaUxiKLiEG5IJfy45gpYEdP9NjuqsW5ZyiUmYJ+TdxO+3JjBGMX4xDFcke
 cGa7YzWuh8l8iW6F+ZFBGOCbbwusWxOHTWhvxqVWdH4YRQC/Sgd9sEtyNMVnLPt4I7xYI1mAp
 ldod3ayZohR30g+j/tuzqOeb6djVWhNRMfKA22qAtj8w7YhhbObflR01fAbDMwOPa3XGgwYnz
 JuS45cCMPdAT7RdfWrToqVSpFnQDqrNG0MhJohXA+X2FJHG4jCyBXLMkQdyaRTgC7TRUFvfIv
 LWnuvMV085AGvvium27lmMGXJCzuwVcfGHocdjn1XzaHpgzymv7RcZyPaCbc/ZN2uQTmdl0ab
 iwm/ybqYqCb6QXYTZL4AJbSIDEstUVqhl0zYYxq+9X4eous6lcU4tStPqnwBK00QrW9/NIHoE
 v8cO48Xepz5JFI1rQfL+EQy5hkivCBqGstESxFtw3rwIeyXrtJLrkMTbO1td1g5n7Kr6jRwox
 JY+nXEJkgrQuErH9ecsvI/X3XOT+UzFzkI21qHDprCoSFymD08s0NB2roVEyEbGmSsM8oBT6U
 tSzeVRi2gntP+ct6ugOIdLLHWxwD8J1ZbUAD5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The registration of gpio-keys device can be written much shorter
by using the platform_device_register_resndata() helper.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/input/misc/soc_button_array.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 5e59f8e5..f5e148b 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -110,25 +110,21 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
 	gpio_keys_pdata->nbuttons = n_buttons;
 	gpio_keys_pdata->rep = autorepeat;
 
-	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
-	if (!pd) {
-		error = -ENOMEM;
+	pd = platform_device_register_resndata(NULL,
+		"gpio-keys",
+		PLATFORM_DEVID_AUTO,
+		NULL,
+		0,
+		gpio_keys_pdata,
+		sizeof(*gpio_keys_pdata));
+
+	if (IS_ERR(pd)) {
+		dev_err(&pdev->dev, "failed registering gpio-keys: %ld\n", PTR_ERR(pd));
 		goto err_free_mem;
 	}
 
-	error = platform_device_add_data(pd, gpio_keys_pdata,
-					 sizeof(*gpio_keys_pdata));
-	if (error)
-		goto err_free_pdev;
-
-	error = platform_device_add(pd);
-	if (error)
-		goto err_free_pdev;
-
 	return pd;
 
-err_free_pdev:
-	platform_device_put(pd);
 err_free_mem:
 	devm_kfree(&pdev->dev, gpio_keys_pdata);
 	return ERR_PTR(error);
-- 
1.9.1

