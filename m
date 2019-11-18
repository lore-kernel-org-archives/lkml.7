Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4450AC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8132230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=balena-io.20150623.gappssmtp.com header.i=@balena-io.20150623.gappssmtp.com header.b="JgKcWsjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKRVDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:03:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44889 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:03:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id n186so2570152lfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balena-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xLSwjMM5gI2J2gppQ59d09E7fV18npt1+nrN74KyqiA=;
        b=JgKcWsjTOqu/8g8wZ2Ie4/NHh43TeeHoY7JDk3xFm5Dp/ecTsw3A2bgDoYP8RMUnpo
         z1rBY/owj/t+O4QRb1mt1Yy/Qapnm6ufoPbf4kPU8+5OAx+JAty2UXO33vqWkXSsPvrS
         /oc0fYWks3LgL3oIXbO5G6/wgUVQB1o0VyObb6avrNs49HtjEq+MN7d1/CjzS7uziJq3
         bpmhxfllYNcawMJHwKvYcenK0KmUUHST4kf8aPLiaSBGvNwduLqp9efS61zQCvJ4txbP
         PcecAKfI2h3++/BYaZgsmj4iGgYNMiF0vNeIwYOawvnZHwT+Kt9Vmlf7B+bPAJmuqAMO
         nabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xLSwjMM5gI2J2gppQ59d09E7fV18npt1+nrN74KyqiA=;
        b=tAJ+1c5nTy6gdrxyn7lupLY/wvZbhKs9V3Kkjirb1ge483VC6mfWEVxO7lX0C+3iU5
         oGi/G0a9T+4OUdRDL+U9nm2IgwoBmUcET4e0q/z6raOd+M5+AWdORAjFgwgz4yPbFGOm
         Rm2sqNspDuuEW8zYYByd0WZrZiuEEmcXkED0Bw5wHcyJK2n298t3OH8xSPC8KHVTzHzu
         +bzFiJALD2YxisJfn8PIDny3qaCggc15cl6JnPqsFfBII5JXDLf6bVgNfiOWfdqIJzLg
         w4W1UVWAkZIglZSKOCWNQcClZO7E63XPHO0/Mfgo1dLhPHBHpADwH7X61sWi5qHk4C8o
         rixQ==
X-Gm-Message-State: APjAAAVqvYsQ2fgc+XhwPzQ4GFYKSy+W/dH2rQcfqWHHvc7e8oB49XkJ
        aNfQB16UkbMPwJ+nRSFcBT1LEA==
X-Google-Smtp-Source: APXvYqxIBXwXyxjFhevZBDKZUTLTOZsXFgk0ci08yH+GMl+8KCDyJC4zf0cRwXbI4RyIyxwxJddTFw==
X-Received: by 2002:a19:5211:: with SMTP id m17mr1058629lfb.126.1574110980234;
        Mon, 18 Nov 2019 13:03:00 -0800 (PST)
Received: from majorz.localdomain (212-39-89-85.ip.btc-net.bg. [212.39.89.85])
        by smtp.gmail.com with ESMTPSA id p193sm11621120lfa.18.2019.11.18.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:02:59 -0800 (PST)
Date:   Mon, 18 Nov 2019 23:02:55 +0200
From:   Zahari Petkov <zahari@balena.io>
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zahari Petkov <zahari@balena.io>
Subject: [PATCH v2] leds: pca963x: Fix open-drain initialization
Message-ID: <20191118210255.GA99907@majorz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit bb29b9cccd95 ("leds: pca963x: Add bindings to invert
polarity") Mode register 2 was initialized directly with either 0x01
or 0x05 for open-drain or totem pole (push-pull) configuration.

Afterwards, MODE2 initialization started using bitwise operations on
top of the default MODE2 register value (0x05). Using bitwise OR for
setting OUTDRV with 0x01 and 0x05 does not produce correct results.
When open-drain is used, instead of setting OUTDRV to 0, the driver
keeps it as 1:

Open-drain: 0x05 | 0x01 -> 0x05 (0b101 - incorrect)
Totem pole: 0x05 | 0x05 -> 0x05 (0b101 - correct but still wrong)

Now OUTDRV setting uses correct bitwise operations for initialization:

Open-drain: 0x05 & ~0x04 -> 0x01 (0b001 - correct)
Totem pole: 0x05 | 0x04 -> 0x05 (0b101 - correct)

Additional MODE2 register definitions are introduced now as well.

Fixes: bb29b9cccd95 ("leds: pca963x: Add bindings to invert polarity")
Signed-off-by: Zahari Petkov <zahari@balena.io>
---
 drivers/leds/leds-pca963x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 4afc317901a8..66cdc003b8f4 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -40,6 +40,8 @@
 #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
 #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
 
+#define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
+#define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
 #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
 
 #define PCA963X_MODE1		0x00
@@ -438,12 +440,12 @@ static int pca963x_probe(struct i2c_client *client,
 						    PCA963X_MODE2);
 		/* Configure output: open-drain or totem pole (push-pull) */
 		if (pdata->outdrv == PCA963X_OPEN_DRAIN)
-			mode2 |= 0x01;
+			mode2 &= ~PCA963X_MODE2_OUTDRV;
 		else
-			mode2 |= 0x05;
+			mode2 |= PCA963X_MODE2_OUTDRV;
 		/* Configure direction: normal or inverted */
 		if (pdata->dir == PCA963X_INVERTED)
-			mode2 |= 0x10;
+			mode2 |= PCA963X_MODE2_INVRT;
 		i2c_smbus_write_byte_data(pca963x->chip->client, PCA963X_MODE2,
 					  mode2);
 	}
-- 
2.24.0

