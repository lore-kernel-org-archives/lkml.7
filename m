Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE97C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50936206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 20:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0nnq4zMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfESUkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 16:40:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45412 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfESUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 16:40:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so12233569wrq.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UooUaXL2Sqm5XmPHx+kyjXtSn9qjvEx6duezW6FeIgw=;
        b=0nnq4zMi2VD+iWt+eEQ/49TXPPCiBeXwPMFlGoMAfV8ZcNtiSOvG2wozg17WbnICMk
         5vZDK2FS4RmLDOUx3JydW4v4/uEB9G+4JDaX4zmVRpnJHuzeNTaOV0ZnSmeo5lJovZsd
         MDN7gNc7rqgDTzGkuI6YYMliWi0qOE1KE7PjSYJyC3CfyXM/sWz52EUHAsEQnCttFjm8
         R3sDhdDIDZffXnqhDpLkrJB0xuzbJ98JNqiP/7ev53TdUBNp4SQMgfcV8vSpII80c7oN
         mM0jUARnz1I5+J4uZA/7TDxcuuG6iUotEr5DHSUZrVqBsGprMyhRbK7yPSDZkff9wdYg
         uaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UooUaXL2Sqm5XmPHx+kyjXtSn9qjvEx6duezW6FeIgw=;
        b=gHDSpYuc6NV8zyDZ6a8VmargcAGmpqy1+USqeXmkNsa7Ox/mUAryJVCSZbTtkz4CaH
         PdvEAmbF/RL1yiVdGO2moBrdNtY35xGybXlYPPJSMpUHnZsZ9JkQudWQv8CBaB1IEjVP
         nT/JODjst2BYYbPeyBILhVFNZQ+cAB5OM2chxo2PPtRyDS/txZXDlEzUF2/QGIsf1lFR
         XLIeZvZxrxX9WdIn96IfcMrBjwfsBpRH8UKeYRm6VgKLoAeespz/gTpmZZs654+ENInZ
         MhogFefn0aqIGQ4ix5N+zkR3IdB8Af/0LEx8f/5d3ow25sWs0AjWW1+epQ5uBdIADeh5
         c14A==
X-Gm-Message-State: APjAAAWcEWmzPOH1Yt6nJCUQi60hO1tD7NpdsqMyzEur1iQbAR2B2tH9
        mTA+hCZPOKg5JxMCXrM9XcYqhw==
X-Google-Smtp-Source: APXvYqwUtNocXFJFFHcWvp9TPyyDKdoNGMpiBUYbofA3MZFqSlQg3pS0tDBtzhwrIhzmr1e1Q/Wp3g==
X-Received: by 2002:adf:8367:: with SMTP id 94mr17329865wrd.179.1558298420607;
        Sun, 19 May 2019 13:40:20 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d17sm8710814wrw.18.2019.05.19.13.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 13:40:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] eeprom: at24: use devm_i2c_new_dummy_device()
Date:   Sun, 19 May 2019 22:40:11 +0200
Message-Id: <20190519204012.31861-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190519204012.31861-1-brgl@bgdev.pl>
References: <20190519204012.31861-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that it's upstream, use the resource managed version
of i2c_new_dummy().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 63aa541c9608..9ea196f0749f 100644
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
@@ -527,8 +519,8 @@ static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,
 	dev = &base_client->dev;
 	addr = base_client->addr + index;
 
-	dummy_client = i2c_new_dummy(base_client->adapter,
-				     base_client->addr + index);
+	dummy_client = devm_i2c_new_dummy_device(dev, base_client->adapter,
+						 base_client->addr + index);
 	if (!dummy_client) {
 		dev_err(dev, "address 0x%02x unavailable\n", addr);
 		return -EADDRINUSE;
@@ -693,10 +685,8 @@ static int at24_probe(struct i2c_client *client)
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
@@ -713,7 +703,7 @@ static int at24_probe(struct i2c_client *client)
 	pm_runtime_idle(dev);
 	if (err) {
 		err = -ENODEV;
-		goto err_clients;
+		goto err_runtime_pm;
 	}
 
 	nvmem_config.name = dev_name(dev);
@@ -733,7 +723,7 @@ static int at24_probe(struct i2c_client *client)
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
-		goto err_clients;
+		goto err_runtime_pm;
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
@@ -742,8 +732,7 @@ static int at24_probe(struct i2c_client *client)
 
 	return 0;
 
-err_clients:
-	at24_remove_dummy_clients(at24);
+err_runtime_pm:
 	pm_runtime_disable(dev);
 
 	return err;
@@ -751,11 +740,6 @@ static int at24_probe(struct i2c_client *client)
 
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

