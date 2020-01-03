Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1CEC3276E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59F821D56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JROiiOYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgACBTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:19:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45908 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACBTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:19:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so18457006pls.12;
        Thu, 02 Jan 2020 17:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Pj7NnDsV8DAl7XvANKt95DF4vhQ5j9tx+hWo3+M62uk=;
        b=JROiiOYCr5lwF8FppQZTwu4slm8bZjMyBXPs8OobqBdx0c5DWs6MswUYTUQESgvDaq
         H6vtD/TWrexXCVTwg8eu43CZn+NbuMgU2qJ0RFZ89n6EWsuRcssXVn6WRq1HWqiZlJ3E
         SOdGHik6DEfwM1AzHc0gCvxxWL/tD2XZ5xYHwNKuuzW76IhNFNYiD71ogIRnTUqEPnnT
         U9ZyvQky1e8EHdSrkTDrx9Ro2DArdlLNzxaBRh9WKijHc4UTAG8TVnllw7mfiTPqaihm
         QjEsZJa1q1vMGe5uXCQF2kARXjqv+egyOuG4g+uSb6kKVKtyh5HHkSWgT3B0cU4MVx9+
         C6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pj7NnDsV8DAl7XvANKt95DF4vhQ5j9tx+hWo3+M62uk=;
        b=OATCEcTet0lOx08nKKIxHdCBGYHcBbIvRyOH6lWI/qYAs+QD/BUipeHoVKsuQt6Ldw
         yYqTT4BM4wDbYgpnaoTwzTUH9V00tarLmaAqKTJyhDoRd5tNuFgpbp0MYiSsBT1Q2oHT
         lQUhWxH0RUXi+TtuLfL9oYL1YAHX5FRY77rDHPk6d1EKxuDwgok+cSHao5BXfbcLT8Rv
         cEHWp4VW42NPfzuyolMzsUbCltFEXcDtzULgKCIsQotEvI/xaMXwd1wnhYqRN28ubREe
         s2ki0nVPqBnhlJ99yehw8UQNuLHIkbhkMENT/E89cydnwPKmJf9oMEvJyWrJdP7Rs9LX
         Jc/g==
X-Gm-Message-State: APjAAAWopnqvloX9U2VQWRZFM6y23ZuPVDt4+bqRIlvzyyH7px2dRH4h
        S4qLb8GH5eVTtU6mOOzdzomjpgye
X-Google-Smtp-Source: APXvYqziU4V5sowOrbh/FwOCan3iwRxFbK5Qh/qmFR88ULJJjYcBVFUjB+m2cKUQ2BrDXsi0ogFyTQ==
X-Received: by 2002:a17:90a:6587:: with SMTP id k7mr22448878pjj.40.1578014357462;
        Thu, 02 Jan 2020 17:19:17 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l14sm59177498pgt.42.2020.01.02.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 17:19:17 -0800 (PST)
Date:   Thu, 2 Jan 2020 17:19:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: gpio: switch to using devm_fwnode_gpiod_get()
Message-ID: <20200103011915.GA879@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_fwnode_get_gpiod_from_child() is going away as the name is too
unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/leds/leds-gpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index a5c73f3d5f797..f57f33008f4f3 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -151,9 +151,8 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		struct gpio_led led = {};
 		const char *state = NULL;
 
-		led.gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL, child,
-							     GPIOD_ASIS,
-							     led.name);
+		led.gpiod = devm_fwnode_gpiod_get(dev, child, NULL, GPIOD_ASIS,
+						  led.name);
 		if (IS_ERR(led.gpiod)) {
 			fwnode_handle_put(child);
 			return ERR_CAST(led.gpiod);
-- 
2.24.1.735.g03f4e72817-goog


-- 
Dmitry
