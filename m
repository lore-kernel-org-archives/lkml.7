Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CD6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D241120881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9Fp01ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfEOQsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:48:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33766 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfEOQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:48:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id y3so162257plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAmM7t9L5FMpWArr+XZL1VMYifzyuZh9O9R86wfoN2Q=;
        b=i9Fp01ee3cpiAALGgeu13VG7tby0ZhpT0P1MJveFUU2dS8KmRBsypy/ZjXem7MH+iF
         pvaF+6YOeK/EGGDG8s2XUuwsLZAl15aNIVlzDwlXgBKN0Yyg8/Kt4K8KTCR5R2L0yPVB
         X0l2VCVDzhoR5X8jSqGsAdZWxjlo+P8eK5xEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAmM7t9L5FMpWArr+XZL1VMYifzyuZh9O9R86wfoN2Q=;
        b=IOPGqiwUW+1Hft1iHCzzcbp3Hw5PSktbmd+m9uCeVOBTKJjAK7k9E5lGYEpRyAgVb/
         +PUFDHFC9qDpONc++ELznYUOWJ/z/GZNA3/sm+njU3Gj4rsqUDrDwP5cm+e4XxX/Zg2o
         Cld4l9CD0ALS7p6bEBA17FuOrPdd4xukgZeJ1MyfHiyH4QIrstEQK6DG88rb2gGib7Ay
         iqAcgoy+ST2D5bE0xddQNaW7JvothsQ1jFhHGC+XyQfGeMAoSG5RmGo00lfx7Y8fXXI9
         kMqGUnlQOYO65oJDTTdUBRCPvSxHXXmYP/DZALlpBvRwZnTyjarYDfkvam+pOulUmTHN
         jMdg==
X-Gm-Message-State: APjAAAXL9Awsd6nJvriBLeTtpk9pKVLEtWrXvdoPvUr2IXHi9smjXdAH
        2zeUoISjG48BetpIJhVpv+T0aQ==
X-Google-Smtp-Source: APXvYqzMXvxNl7/rjW0EYESFViIiw/YEYqxM6GoGqqV2ZlNRyaXG+L154AlqZyiAX+ayj6tCqnFFrQ==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr43570705plr.245.1557938924335;
        Wed, 15 May 2019 09:48:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h16sm6914595pfj.114.2019.05.15.09.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:48:43 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] platform/chrome: cros_ec_spi: Request the SPI thread be realtime
Date:   Wed, 15 May 2019 09:48:13 -0700
Message-Id: <20190515164814.258898-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190515164814.258898-1-dianders@chromium.org>
References: <20190515164814.258898-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All currently known ECs in the wild are very sensitive to timing.
Specifically the ECs are known to drop a transfer if more than 8 ms
passes from the assertion of the chip select until the transfer
finishes.

Let's use the new feature introduced in the patch (spi: Allow SPI
devices to request the pumping thread be realtime") to request the SPI
pumping thread be realtime.  This means that if we get shunted off to
the SPI thread for whatever reason we won't get downgraded to low
priority.

NOTES:
- We still need to keep ourselves as high priority since the SPI core
  doesn't guarantee that all transfers end up on the pumping thread
  (in fact, it tries pretty hard to do them in the calling context).
- If future Chrome OS ECs ever fix themselves to be less sensitive
  then we could consider adding a property (or compatible string) to
  not set this property.  For now we need it across the board.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v4: None
Changes in v3:
- Updated description and variable name since we no longer force.

Changes in v2:
- Renamed variable to "force_rt_transfers".

 drivers/platform/chrome/cros_ec_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 1e38a885c539..daf3119191c8 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -740,6 +740,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
 	spi->bits_per_word = 8;
 	spi->mode = SPI_MODE_0;
+	spi->rt = true;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;
-- 
2.21.0.1020.gf2820cf01a-goog

