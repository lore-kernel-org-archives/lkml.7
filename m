Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E1C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FA32089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=balena-io.20150623.gappssmtp.com header.i=@balena-io.20150623.gappssmtp.com header.b="ssYxovwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfJNMgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:36:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39037 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfJNMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:36:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so16578679wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 05:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balena-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eDkeFppLvtXNEBjxaPNFQTWHXCS+7nQeKuiOCaxy1ec=;
        b=ssYxovwKsDIeP3c/RVqTFZhBkQghIWyPnvYGzk8rrwA4Bw65MJw/MAnSKB2TBaSNwU
         e04KZH9QLlk8UObqTowakJlXm8ITG2qQQnOTsPO18Ydi7tGBA7NkaPtP3OINClJXyd1R
         SuXKtTnLlpZqFyA7dvSi4U0MB9QdNSuUFIMa+Vn2w/81gHA+d33XT4t1x7ywS3GIHSKC
         RBekuSS+oJh6ZVAt593TBlWFE16STTYaaiZuKXQZPlXFmXQyPfTQ8PGGeUeoU7jAUs2X
         WT4PS66Gq/MPj/pfUBlLKMWMUcDR53/rVwF2rwzunhVGkdfCBBEou2UAdfh+TL0VWcMl
         ejrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eDkeFppLvtXNEBjxaPNFQTWHXCS+7nQeKuiOCaxy1ec=;
        b=tBi0o/VQ3ZU2mlKuKuIkzDHw4Gd9i6tAsWgewgqfUpw0aQU+DvHgs74ngQ2SCpxEQy
         JunREMscB9XwRfoJFoOrJCZgJN0fP2OgtB9u+pLtlif5mn5o/Aja+AxXc9WL8NZUdJ43
         4v7pCC9Hr/L0h9XzB9EAZ626+yuFV61tH2yEjhP7Oo8s08U0mZNnmo0zSquUfrALx4DF
         1amp7sY83fkkpzXAGBFB9Ccd1gSfCAHYvAK5gYEgPVFblUpde3c4SWvfkCLYIOVcdTGy
         vV6I/if9kCmB1U21m5GvjF+Bc2ieMgRMt5UGdmBahTRQPwknkRkGhbyBqwa3LL0XkkO1
         KEbw==
X-Gm-Message-State: APjAAAWBmyGCO1basGeP7SVuFhirlr2vlw1ByiX2+hmZpvHyiiIipCzk
        Hn/YN6n3rcrOXxTyLGJLROY9Lg==
X-Google-Smtp-Source: APXvYqzhOsQrSP4FG7KJxxr+rJFiQ1Q8HlxkEau04jAoaFRBC6Wi8ub13Bh3YPcG7F8SOaH4M/OD0g==
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr999551wmd.138.1571056572564;
        Mon, 14 Oct 2019 05:36:12 -0700 (PDT)
Received: from majorz.localdomain ([85.130.115.21])
        by smtp.gmail.com with ESMTPSA id q22sm15906265wmj.5.2019.10.14.05.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:36:12 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:36:04 +0300
From:   Zahari Petkov <zahari@balena.io>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zahari Petkov <zahari@balena.io>
Subject: [PATCH] leds: pca963x: Fix open-drain initialization
Message-ID: <20191014123604.GA743117@majorz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OUTDRV setting (bit 2) of Mode register 2 has a default value of 1.
During initialization when open-drain is used, instead of setting
OUTDRV to 0, the driver keeps it as 1. OUTDRV setting is now correctly
initialized to 0 when open-drain is used.

Additionally the BIT macro is used for improved readibility.

Fixes: bb29b9cccd95 ("leds: pca963x: Add bindings to invert polarity")
Signed-off-by: Zahari Petkov <zahari@balena.io>
---
 drivers/leds/leds-pca963x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 4afc317901a8..e3da2156b385 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -438,12 +438,12 @@ static int pca963x_probe(struct i2c_client *client,
 						    PCA963X_MODE2);
 		/* Configure output: open-drain or totem pole (push-pull) */
 		if (pdata->outdrv == PCA963X_OPEN_DRAIN)
-			mode2 |= 0x01;
+			mode2 &= ~BIT(2);
 		else
-			mode2 |= 0x05;
+			mode2 |= BIT(2);
 		/* Configure direction: normal or inverted */
 		if (pdata->dir == PCA963X_INVERTED)
-			mode2 |= 0x10;
+			mode2 |= BIT(4);
 		i2c_smbus_write_byte_data(pca963x->chip->client, PCA963X_MODE2,
 					  mode2);
 	}
-- 
2.23.0

