Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CEBC32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 20:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D5422B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 20:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyINPNLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgADU11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 15:27:27 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39393 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADU11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:27:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so6088249pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 12:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HJy76YM2N1yba8mg4BtiDuoyJEAWWP/jvJI+Qk0+uxM=;
        b=FyINPNLtVkKrjh7/mSLbipyFuu2xRsx3wcavrG2eiIBagNyG2pc3AV6qBli37V8k9q
         Ed+em6X3XZ7LryZ3RkdHz6YocGp0mQipUvBHR+W/UrrJ9IXL80pfaTBscpEJrz8fxo8N
         shx/GwU7INXWjnqwmn1VdbYA7IOgZ1n9Ve4QFXgVw8P8K7Hoq7EEVRYlkXIY3HAeAKRh
         TH6drKlnjByEPV2Xaat65wZ4p9JBYDErE0sHoJgnYqIqA7tK6oRWFMq7F8KPyjtLS2if
         UJBVnuWZK67VIVd9Zba8uayJYaiXxFM+CvISVpEeYQogrFgvc0f2x1nawL/dqmrufkUn
         dGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HJy76YM2N1yba8mg4BtiDuoyJEAWWP/jvJI+Qk0+uxM=;
        b=likSOFye15mLr+XuzcDziySM1Au0bLY0SBt34X2FabaZZofATS80YC+OSH3P0S7YEb
         6XAE+eaSrHOxp2Vyoy2jwcvtzemeeaEM1ng6GsLtjybOBDaMLm+yZdpQ+s3/mirxP8yJ
         2Ql3afwtTyZc9MUN2gqNhRegkFiCGwyiQN435eq/ghwQnli6Qib3w14E4WgtVdizvfpo
         fvxKjACcWOt0F9IqMmspZha6y1Vbkm47JnMXrywcuHGqjH5mPb+QL1nQNoKodkR5ieCO
         ZXvRnHerQQCiGrH9jwJ3eTEsZGCrE2jMc683QSOCvpzT6E7i5PONuVTPm56hTZ8TS1hd
         HKGg==
X-Gm-Message-State: APjAAAXWmOKYmtMgQmuTtprGplt1JcZHJiGt2MdFkA/OCvrU1UGfFK+S
        Jr8CiN6+6vuKCVEm+PBmAac=
X-Google-Smtp-Source: APXvYqxErlcQTXI8HcFMFVttuRqN/byY/mQ5n+QNJgPB0Qv/3EkHLfd0FjMxSDXrLS2U7Fp8QkPi3Q==
X-Received: by 2002:a17:90a:7781:: with SMTP id v1mr34763654pjk.57.1578169646381;
        Sat, 04 Jan 2020 12:27:26 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q8sm68850329pgg.92.2020.01.04.12.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 12:27:26 -0800 (PST)
Date:   Sat, 4 Jan 2020 12:27:23 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: atmel: switch to using
 devm_fwnode_gpiod_get()
Message-ID: <20200104202723.GA16116@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_fwnode_get_index_gpiod_from_child() is going away as the name is
too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

V2: fixed a typo notices by Alexandre Belloni

 drivers/mtd/nand/raw/atmel/nand-controller.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 8d6be90a6fe8a..3ba17a98df4dd 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1578,9 +1578,8 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 
 	nand->numcs = numcs;
 
-	gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev, "det", 0,
-						      &np->fwnode, GPIOD_IN,
-						      "nand-det");
+	gpio = devm_fwnode_gpiod_get(nc->dev, of_fwnode_handle(np),
+				     "det", GPIOD_IN, "nand-det");
 	if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
 		dev_err(nc->dev,
 			"Failed to get detect gpio (err = %ld)\n",
@@ -1624,9 +1623,10 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 			nand->cs[i].rb.type = ATMEL_NAND_NATIVE_RB;
 			nand->cs[i].rb.id = val;
 		} else {
-			gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev,
-							"rb", i, &np->fwnode,
-							GPIOD_IN, "nand-rb");
+			gpio = devm_fwnode_gpiod_get_index(nc->dev,
+							   of_fwnode_handle(np),
+							   "rb", i, GPIOD_IN,
+							   "nand-rb");
 			if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
 				dev_err(nc->dev,
 					"Failed to get R/B gpio (err = %ld)\n",
@@ -1640,10 +1640,10 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 			}
 		}
 
-		gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev, "cs",
-							      i, &np->fwnode,
-							      GPIOD_OUT_HIGH,
-							      "nand-cs");
+		gpio = devm_fwnode_gpiod_get_index(nc->dev,
+						   of_fwnode_handle(np),
+						   "cs", i, GPIOD_OUT_HIGH,
+						   "nand-cs");
 		if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
 			dev_err(nc->dev,
 				"Failed to get CS gpio (err = %ld)\n",
-- 
2.24.1.735.g03f4e72817-goog


-- 
Dmitry
