Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39BDC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FE32081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mq1dItRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfETHKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:10:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46489 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfETHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:10:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so13187708wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 00:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LtAbtRKQaAYM2lLJPPz+ylaT8oZbFrjQXvIP/N75mbA=;
        b=mq1dItRfP5tX302POwcltohfN16RnBZUALnunlXj+OtENaVdGXsMSTTw/SDUui8gcm
         BesZXNoNas1tQHzpOvnnmAlZZIaMhvK3hIIvcomHDiiworgKYwPO1pw55KGK6ks+m79A
         zsUL48U4og1jt46xbuJmI2PVYug8ZRH+aiM6Wx6nkHZiBly7ZBPAIz+c1xGG92dWcTXQ
         OaQme5U7yEcGf29TPNg0lRpsDhMOubVS4x6RIVX/epmvcUZitIKurrYAlyiiQvsuPHCA
         HWVspmXBbQNSZ+Ni1ZqeAsJ3gD7wU+qQhalgLobVX+oFD/rSObSXT1YFI3dDYMUwN4WT
         A6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtAbtRKQaAYM2lLJPPz+ylaT8oZbFrjQXvIP/N75mbA=;
        b=kC6vN/1n5Tmqhxquvfw+1esIakZwFE5JAHTGkfPVNTQ63qwOeOlbqpI9nHZ7vW/U7V
         u+WdZd0jxrJdFjTMocMcRnIemEWQuoMHzeWlCMJ5P1bichz7Q7RYN9kfnoCMy5cDmeY7
         YK5NTgwSeQbd//6AWNZ54xgpdadnsHoXqJDuH5YYLEgrlVnabwo7c96Xh0xqCAqUB2gx
         /pDEwE8hv47p7l7xfkXa3cYADihAub7N3YhO4YyI3JSV8V0ZshcCqzwjeKPDjnK0VWvb
         xNNHnv6s4OXg307ShiMij+3bixp4yrNzfR6CZ/VK4wxITfrY4Q+MjNB/eT8XKD6uTBEs
         H/Jw==
X-Gm-Message-State: APjAAAURDFOwnP9SgQ1PdDuXgruU5S9wGcF3JaTb0dl7SLngmQB5UZsy
        dNXClf/3cNKz7eFoY7jYdw5b4g==
X-Google-Smtp-Source: APXvYqylrretxPC+LTX+MRIUJwdFN04VrBb8O0sp0/q6nUkAH3avukgowRj4HpmzmP2iyZb3AYClmA==
X-Received: by 2002:adf:9c0a:: with SMTP id f10mr3835117wrc.248.1558336247031;
        Mon, 20 May 2019 00:10:47 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y132sm24017306wmd.35.2019.05.20.00.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 00:10:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
Date:   Mon, 20 May 2019 09:10:41 +0200
Message-Id: <20190520071042.21072-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520071042.21072-1-brgl@bgdev.pl>
References: <20190520071042.21072-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that it's upstream, use the resource managed version
of i2c_new_dummy_device().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 63aa541c9608..bdeec0777029 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -507,14 +507,6 @@ static const struct at24_chip_data *at24_get_chip_data(struct device *dev)
 	return cdata;
 }
 
-static void at24_remove_dummy_clients(struct at24_data *at24)
-{
-	int i;
-
-	for (i = 1; i < at24->num_addresses; i++)
-		i2c_unregister_device(at24->client[i].client);
-}
-
 static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,
 				  struct regmap_config *regmap_config)
 {
@@ -527,18 +519,14 @@ static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,
 	dev = &base_client->dev;
 	addr = base_client->addr + index;
 
-	dummy_client = i2c_new_dummy(base_client->adapter,
-				     base_client->addr + index);
-	if (!dummy_client) {
-		dev_err(dev, "address 0x%02x unavailable\n", addr);
-		return -EADDRINUSE;
-	}
+	dummy_client = devm_i2c_new_dummy_device(dev, base_client->adapter,
+						 base_client->addr + index);
+	if (IS_ERR(dummy_client))
+		return PTR_ERR(dummy_client);
 
 	regmap = devm_regmap_init_i2c(dummy_client, regmap_config);
-	if (IS_ERR(regmap)) {
-		i2c_unregister_device(dummy_client);
+	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-	}
 
 	at24->client[index].client = dummy_client;
 	at24->client[index].regmap = regmap;
@@ -693,10 +681,8 @@ static int at24_probe(struct i2c_client *client)
 	/* use dummy devices for multiple-address chips */
 	for (i = 1; i < num_addresses; i++) {
 		err = at24_make_dummy_client(at24, i, &regmap_config);
-		if (err) {
-			at24_remove_dummy_clients(at24);
+		if (err)
 			return err;
-		}
 	}
 
 	i2c_set_clientdata(client, at24);
@@ -713,7 +699,7 @@ static int at24_probe(struct i2c_client *client)
 	pm_runtime_idle(dev);
 	if (err) {
 		err = -ENODEV;
-		goto err_clients;
+		goto err_runtime_pm;
 	}
 
 	nvmem_config.name = dev_name(dev);
@@ -733,7 +719,7 @@ static int at24_probe(struct i2c_client *client)
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
-		goto err_clients;
+		goto err_runtime_pm;
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
@@ -742,8 +728,7 @@ static int at24_probe(struct i2c_client *client)
 
 	return 0;
 
-err_clients:
-	at24_remove_dummy_clients(at24);
+err_runtime_pm:
 	pm_runtime_disable(dev);
 
 	return err;
@@ -751,11 +736,6 @@ static int at24_probe(struct i2c_client *client)
 
 static int at24_remove(struct i2c_client *client)
 {
-	struct at24_data *at24;
-
-	at24 = i2c_get_clientdata(client);
-
-	at24_remove_dummy_clients(at24);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.21.0

