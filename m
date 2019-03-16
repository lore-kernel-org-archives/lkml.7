Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90784C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6C621871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0D+aQ2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCPCPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:15:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35978 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCPCPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:15:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id k130so6705074qke.3;
        Fri, 15 Mar 2019 19:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E79KXUnhP4o02hGiR6DT9/4NVN8LNyEneSndXO0JIsw=;
        b=h0D+aQ2Ju6xSelONwMt6gNSu83Ys9FhLReo4hICCKjL+UQ9ydsWlbygDpNdGSOfC0U
         VKAt9sU/H9olMbyHo3NGXjr0c5oEOOdLLO8NFhh4x3Gftc58BSZWZg5WXUe7uJPL+Xbm
         rx03bL92k1Csc96suTMEWzMt/CXiz9Cxyycp2oXOstvHXKM9NmtK+KF5v9EVHPPRLZLa
         e/oNHZkhygqNsP4Pn86IvzLvsI19tc/+gyeVrW1ZevdRwr3cxJiAa2sx4QGS3dltMKCF
         dFp0NsERGarU7YQJgR5S7GryVrkC0EzUqUSSB5AnqV29taGlpcvrDOikNgaYiKNx2BOv
         XMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E79KXUnhP4o02hGiR6DT9/4NVN8LNyEneSndXO0JIsw=;
        b=UOS9JXCpywBk3jzo4cXBghTs5z9H8bPi6IRZ5iuYz6/nk3LUXrxp+ukp82UMA7erwQ
         Vdt1Y1jEFTpKIC6CKTNWXdwbaN8TeCcWZFZmtUOCFgqWHm1lv8cEoxU5v/b8fykt656F
         /WINF7wtLAhniRu2RBfTlThFrZ5mlerclmkgSE3f8Ts3uMBsHUIhupE+bPNMm+VHKIIR
         pOLOxbTVqhvO+qpynRgMirmIpYeb0KKB4etScvZYDP0DSnL0qOJ4Ij6DUgTmpa+WpQrb
         Mu0xGCAnv1PN2R4qHBYLdM2bShDBWhMvyxyMeelyL7bOLrQfr+dZ1rR7+nodnLYy81Ox
         oZiw==
X-Gm-Message-State: APjAAAUWaP3PkyQkv6921iy8VNq0XmOdO/sGJs4RgSdYKwPD4xtYREWI
        NCM8fH7heqUEVSRCvvQdzJI=
X-Google-Smtp-Source: APXvYqxP6ldzgL1QfU4MzvsvoDUfkPWls0uA7OzJnTDyjpcEKIlMLkYnA8jYowvHpih9+KfFCc2cyQ==
X-Received: by 2002:a37:d6ce:: with SMTP id p75mr5100559qkl.286.1552702504574;
        Fri, 15 Mar 2019 19:15:04 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id v131sm2132489qka.95.2019.03.15.19.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:15:04 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:14:59 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 07/11] staging: iio: ad7780: move regulator to after GPIO
 init
Message-ID: <c018f41a8f21c0b2b25fe264cb58ba4bd2239505.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1552700652.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maintain consistency between ad7780_probe and ad7780_remove orders,
regulator initialization has been moved to after GPIO initializations.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 977b381c1260..568c5b4472ff 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -295,16 +295,6 @@ static int ad7780_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
 
-	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
-
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -321,6 +311,16 @@ static int ad7780_probe(struct spi_device *spi)
 	if (ret)
 		goto error_cleanup_buffer_and_trigger;
 
+	st->reg = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		return ret;
+	}
+
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
 		goto error_disable_reg;
-- 
2.21.0

