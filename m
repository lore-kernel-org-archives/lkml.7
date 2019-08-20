Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F8C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3281722DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfHTMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:25:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfHTMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:25:46 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4eOd-1iQTex3btP-011hHa; Tue, 20 Aug 2019 14:25:44 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH v2] (submitted) input: misc: soc_button_array: use platform_device_register_resndata()
Date:   Tue, 20 Aug 2019 14:25:44 +0200
Message-Id: <1566303944-15321-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:DeU1/LtNheaj5rXfBgJzSh743MbaR6JLBKVErYqoADUipXQJFUe
 bC2hFMf5UV93XvX+Ql5G3/jYkkeMT+myuB/Qo5ELXDpMKaz4MILFxj8ro+vj3sVhd0kglN9
 5Grnn8hGlnMg0Y+ms+3YKC78Noew1GIMhRm9o4eNjO7BrKo3rc98Ik5kFpU9dIvkat30JEm
 fskuTgs4HY0SX0iTXCShQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TEfkfqHrXxw=:ygYv71I+ZEKf/eWbKvlcLB
 CTwwr6v+Dti8wA5dP3NNwclF/BdAHZj5i2JkRettYHZfHeuJAjJT8BLgj7Rqhn2DqIE4qSzci
 feCG1Qxf8N0eWf54JQD82EIk9dDrqQs6B0ufG3ivvcska0CIJYkIOaido1YPt043kwacHERJf
 jmzHPnSjTxmPEHa3PXbgaUFb8tlkw9iZfJM3CLxU6NRo5zpUTa9b44x0B+/s/3GSdGFw4Q0D0
 wtWL3mguNUbRWI6h/T7+vFOiyghPSopT5CgV6jL732C6UeX5vOjuPGA/4sT/5JNw3AGh1QJNl
 SbdU9KVSGbV/RYeNh8RsRqvsdp0jeg7KEjQeBC3eNvJiVnYryim9P8N4SWJi9a92ZMHp3e4/x
 FZQKmApsG92LdB2TfdOCq6Cw42M3n6hZIUf7xGuRRfqtt32I6KhAXoov9vmseHWlTlHPqNqTV
 u1xdWmosl1EI7UewUgAw1t0k5n//Rax580qjVGkms0gJ6/3FK1TcTeG6KsmGCEGmeDZZhsS9C
 AI2F0S+oET56o0QVtR6Wn6huWl1EU4w40be2iiWAnKBgP4Hvys2ZO5q2jzzXrX/hieDovSEte
 SKkpqqZ8Og5GQe183/ODXMUGlZFzLW41fCcALfd0ID/Qh4zGYmLM/9ei0kYjKYzDv+BjIicNJ
 4Wvsxhm3wjAHaf4qBB2ixt0ycaJfhgGEUpwv89L0pfWDGiVzhB9E8+DBLnyohsWlp886b/MSk
 JPcWNQ0/2+KpYHU9l8PRnOmVUX9Y6z+/Q1eVjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The registration of gpio-keys device can be written much shorter
by using the platform_device_register_resndata() helper.

v2:
    * pass &pdev->dev to platform_device_register_resndata()
    * fixed errval on failed platform_device_register_resndata()

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/input/misc/soc_button_array.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 5e59f8e5..27550f9 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -110,25 +110,24 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
 	gpio_keys_pdata->nbuttons = n_buttons;
 	gpio_keys_pdata->rep = autorepeat;
 
-	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
-	if (!pd) {
-		error = -ENOMEM;
+	pd = platform_device_register_resndata(
+		&pdev->dev,
+		"gpio-keys",
+		PLATFORM_DEVID_AUTO,
+		NULL,
+		0,
+		gpio_keys_pdata,
+		sizeof(*gpio_keys_pdata));
+
+	error = PTR_ERR_OR_ZERO(pd);
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

