Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48181ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECA221E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570454493;
	bh=lh3E0CIAISDQ/3lKJtaW1VDx9XXZjg2jlkVnofxlIYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hmJaRUhMWw3MpENE0fZQ9Vn5gitg4YAiIOsP5+kygNxqC2x0XVKsm6isV3fk5f+mA
	 XUtzyoJYDE9T7SfrRPoFPs8DOyrEF18o524qIO3JGFAJsQcNAGKddDtPD1+lmcAA5V
	 sE/f8olc6JFH1W6PMCD65xYBNNATllRrMnmVCmds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJGNVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:21:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35075 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfJGNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:21:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so9258482lfl.2;
        Mon, 07 Oct 2019 06:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJet7u3XjH5uyIC1W6N08PyBebZ0PR2V3K260AlKy+o=;
        b=hGURAdqxyvaZNgGenotBSl0qObvzE1uXbhhxmmqhqTgbQF1TiyXKdZGDqQpix8B7H9
         dJnv/2RDwjC3vZ8bvw5HitV79P26yrZBX0KxoXOv3GdbmXtWjhCERSZt1S45fiTuYbtg
         hbe0OxoAT4RC9wTwLVnUNuyFncs+ztCR+zaogZLmyINTTbZFI499ca/8cV8JTTkWMRGf
         ysObdL+NWOij8D1YV4RLkq1O1L+f70tTSBNGKd652c45gnsCa+XwkRxuW0KbBK/59+GR
         RTnlQ4LEnJBaM12DdoyZF9LoNoiWQDTnTkLeSOWOeCevH2eWI8oFVE2DdycM1LJooxmc
         rrUQ==
X-Gm-Message-State: APjAAAV2sykIl4jVuqgD+mHkx6+FzrEAXttp9Uzuz9EVoWHrVdZceg2I
        S+++l5DoRtJD0quTJ9JN/zs=
X-Google-Smtp-Source: APXvYqwU+3IDd56V8REUm/VKUng0jSzZNgI5QaxrVJINxWIdURu92I/9j9THsKkBPUf7UUIop5ogwA==
X-Received: by 2002:a19:8a0b:: with SMTP id m11mr16757470lfd.4.1570454483254;
        Mon, 07 Oct 2019 06:21:23 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id z14sm2687360lfh.30.2019.10.07.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:21:22 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v7 6/6] media: ad5820: Add support for ad5821 and ad5823
Date:   Mon,  7 Oct 2019 15:20:50 +0200
Message-Id: <20191007132050.27298-13-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007132050.27298-1-ribalda@kernel.org>
References: <20191007132050.27298-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, both AD5821 and AD5820 share a compatible
register-set:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.pdf

Some camera modules also refer that AD5823 is a replacement of AD5820:
https://download.kamami.com/p564094-OV8865_DS.pdf

Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/ad5820.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 5651609e5095..19c74db0649f 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -25,8 +25,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 
-#define AD5820_NAME		"ad5820"
-
 /* Register definitions */
 #define AD5820_POWER_DOWN		(1 << 15)
 #define AD5820_DAC_SHIFT		4
@@ -359,13 +357,17 @@ static int ad5820_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad5820_id_table[] = {
-	{ AD5820_NAME, 0 },
+	{ "ad5820", 0 },
+	{ "ad5821", 0 },
+	{ "ad5823", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 
 static const struct of_device_id ad5820_of_table[] = {
 	{ .compatible = "adi,ad5820" },
+	{ .compatible = "adi,ad5821" },
+	{ .compatible = "adi,ad5823" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5820_of_table);
@@ -374,7 +376,7 @@ static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
-		.name	= AD5820_NAME,
+		.name	= "ad5820",
 		.pm	= &ad5820_pm,
 		.of_match_table = ad5820_of_table,
 	},
-- 
2.23.0

