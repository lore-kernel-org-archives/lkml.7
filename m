Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE50C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B08222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSw3Dviy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfJDVnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:43:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45628 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfJDVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so4648802pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwzY9zGvRb6P1N8Ed1qZtykz2VMjNZvPa05n7CMX4Gw=;
        b=jSw3Dviyjy05ClBOUYY/QJuGuoSyAjvf8C5ubfUlFMJfpcjHzrg+b1IRO7zi1azAYa
         6EtRIZkuwb8qqIWgHu/ujxJbM9AuKetLnAmhPd+2WrYV3rQJ4vHLXS1XELinhSq6oZ4b
         /Oyx1txPmhFiEXmfsuqAcngarOOgc1FOJG0yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwzY9zGvRb6P1N8Ed1qZtykz2VMjNZvPa05n7CMX4Gw=;
        b=phjbFGPVYHvJCYKig7OW47XDEq0uVswgd/hKfwcyC/0JLjp6yMznxfnqQRiO1285el
         TfGZuoDmi5VN2gd3ye/tvzLB5qppT0v/O0KhhnYON+LfkfOkAzG0xOf6we88Uy23hmQd
         GRgvqlDslVOR/N6TVYsb1dMoMxrEQxIqLzbF/So9o7DV9CVVRasZLX49w8xhu77zqIAK
         e/XBANRcB9y6vmp9zv0o9tBUhXbnQoRVR0WaM/sSMhmA2D1vLSAYxRWwXMcctTYxSM+9
         14E96Y6RbZ/wcFooj2Gg5n0ltCQOb5QHc9zDd6ecnplvys7l2UJZYyrzFTfQXqkIsyFk
         BUEQ==
X-Gm-Message-State: APjAAAWQvtthB6Xtf2sD3K9YDPSP2SD1e7ujffP6a7rNjej6QT21tsOm
        M7UcDDF7dqpjmrUggsK4B+B0QCftF7I=
X-Google-Smtp-Source: APXvYqxkBBeV+sOFokmdCZP2CDSAx0V0nD19CAdCVC7j4pR3eBuLY7Lea48ZWWIDWRXRlCloHKfCdQ==
X-Received: by 2002:a17:90a:7d06:: with SMTP id g6mr18468316pjl.53.1570225417391;
        Fri, 04 Oct 2019 14:43:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Riku Voipio <riku.voipio@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org
Subject: [PATCH 01/10] leds: pca953x: Use of_device_get_match_data()
Date:   Fri,  4 Oct 2019 14:43:25 -0700
Message-Id: <20191004214334.149976-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can use the of_device_get_match_data() API to simplify the
code. Replace calls to of_match_device() with this newer API under the
assumption that where it is called will be when we know the device is
backed by a DT node. This nicely avoids referencing the match table when
it is undefined with configurations where CONFIG_OF=n.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: <linux-leds@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/leds/leds-pca9532.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index c7c7199e8ebd..7d515d5e57bd 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -467,16 +467,11 @@ pca9532_of_populate_pdata(struct device *dev, struct device_node *np)
 {
 	struct pca9532_platform_data *pdata;
 	struct device_node *child;
-	const struct of_device_id *match;
 	int devid, maxleds;
 	int i = 0;
 	const char *state;
 
-	match = of_match_device(of_pca9532_leds_match, dev);
-	if (!match)
-		return ERR_PTR(-ENODEV);
-
-	devid = (int)(uintptr_t)match->data;
+	devid = (int)(uintptr_t)of_device_get_match_data(dev);
 	maxleds = pca9532_chip_info_tbl[devid].num_leds;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
@@ -509,7 +504,6 @@ static int pca9532_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	int devid;
-	const struct of_device_id *of_id;
 	struct pca9532_data *data = i2c_get_clientdata(client);
 	struct pca9532_platform_data *pca9532_pdata =
 			dev_get_platdata(&client->dev);
@@ -525,11 +519,7 @@ static int pca9532_probe(struct i2c_client *client,
 			dev_err(&client->dev, "no platform data\n");
 			return -EINVAL;
 		}
-		of_id = of_match_device(of_pca9532_leds_match,
-				&client->dev);
-		if (unlikely(!of_id))
-			return -EINVAL;
-		devid = (int)(uintptr_t) of_id->data;
+		devid = (int)(uintptr_t)of_device_get_match_data(&client->dev);
 	} else {
 		devid = id->driver_data;
 	}
-- 
Sent by a computer through tubes

