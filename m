Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C740C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375C62064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="buMFfUHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfGaOcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:32:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41014 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfGaOcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:32:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so31986257pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=GAr1BEHNQxhJUYgVePuc32NKfA5zxa9oUJazqUJbqpw=;
        b=buMFfUHDi/ELII84Tqhvq7rfSN30jOm9t8CdYOxSl3iB6CvlracmWrN1apkoDprNsN
         4FkNL3XZQln6GfsqM8qlTJd5OFqi2XYG3mydmhAbJfY/+HltX47/01XyG4H3QZZ8293S
         Lou7sFt25wZsztWuhVZJDop0zH83ywqzm1xVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=GAr1BEHNQxhJUYgVePuc32NKfA5zxa9oUJazqUJbqpw=;
        b=e6hTH8CN7/qtK1nwmKRD9dfpnciiwofL7U5MG0G5Uy+XyIe8V4OTFQ4D9BaH3RgLVs
         SotW5C7JuOknYDKtYulDNtPtOc3pUAJJuvlXbW7kuWAyeZv7HbcoXNYpqCfJJzg4KLFu
         7sbdTcFzq9nK8C3nPflSw+8yKXg/u7adPtdDuHdzPXY+bhtkpgdtzxNCL6fHyL4Wrz7A
         pFH0zJfQyGblmNG6r5B9REJWaCsscE0fWBYwuozF+WiFvdi5L3z5IGh+nEi1VB1Pkw6x
         qd5xp2/oNxizwjzk+7BJouUVDoLHx7IYhZdkmwTVsIDQtyGXeASmh9kGJlu0vcZd26r+
         EUcQ==
X-Gm-Message-State: APjAAAVZg3b82SGTVMDj+bNnSZrQ29jIDBRJl7uZ44gBUVmzZC4a6BAg
        MYuh61uOUktOlgnsT/uwIfx0kA==
X-Google-Smtp-Source: APXvYqzBQM3cfTMlEaDnW1judUAjdWFM9/cRO5Hq/6gQ7L2F8X9Dy9VHCexAIhmYKpayje5zCMi39A==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr3203610pjh.40.1564583534569;
        Wed, 31 Jul 2019 07:32:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v12sm1965608pjk.13.2019.07.31.07.32.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 07:32:13 -0700 (PDT)
Message-ID: <5d41a66d.1c69fb81.6d372.4c72@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f28e8440-a57d-e269-f3a8-5bf5b9fcd41f@electromag.com.au>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-20-swboyd@chromium.org> <f28e8440-a57d-e269-f3a8-5bf5b9fcd41f@electromag.com.au>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Phil Reid <preid@electromag.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 19/57] iio: Remove dev_err() usage after platform_get_irq()
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 07:32:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phil Reid (2019-07-30 23:42:16)
> G'day Stephen,
>=20
> A comment unrelated to your change.
>=20
> On 31/07/2019 02:15, Stephen Boyd wrote:
> ....
>=20
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 32f1c4a33b20..abe99856c823 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -1179,10 +1179,8 @@ static int at91_adc_probe(struct platform_device=
 *pdev)
> >       idev->info =3D &at91_adc_info;
> >  =20
> >       st->irq =3D platform_get_irq(pdev, 0);
> > -     if (st->irq < 0) {
> > -             dev_err(&pdev->dev, "No IRQ ID is designated\n");
> > +     if (st->irq < 0)
> >               return -ENODEV;
> Should this be returning st->irq instead of -ENODEV?
> eg: platform_get_irq can return -EPROBE_DEFER
>=20
> Pattern is repeated in a number of other places.

Probably? Here's a patch.

----8<----
From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] iio: Return error values from platform_get_irq*()

Sometimes platform_get_irq*() can return -EPROBE_DEFER, so it's best to
return the actual error value from calling this function instead of
overriding the value to something like -EINVAL or -ENXIO. Except for in
the case when the irq value is 0 and the driver knows that irq 0 isn't
valid. In such a situation, return whatever error value was returned
before this change.

Reported-by: Phil Reid <preid@electromag.com.au>
Cc: Phil Reid <preid@electromag.com.au>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/adc/at91_adc.c      | 2 +-
 drivers/iio/adc/bcm_iproc_adc.c | 2 +-
 drivers/iio/adc/fsl-imx25-gcq.c | 4 +---
 drivers/iio/adc/lpc32xx_adc.c   | 2 +-
 drivers/iio/adc/npcm_adc.c      | 2 +-
 drivers/iio/adc/spear_adc.c     | 2 +-
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index abe99856c823..2c604198c4b7 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1180,7 +1180,7 @@ static int at91_adc_probe(struct platform_device *pde=
v)
=20
 	st->irq =3D platform_get_irq(pdev, 0);
 	if (st->irq < 0)
-		return -ENODEV;
+		return st->irq;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
=20
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_ad=
c.c
index 646ebdc0a8b4..6c05ea510c40 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -541,7 +541,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
=20
 	adc_priv->irqno =3D platform_get_irq(pdev, 0);
 	if (adc_priv->irqno <=3D 0)
-		return -ENODEV;
+		return adc_priv->irqno;
=20
 	ret =3D regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA, 0);
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gc=
q.c
index fa71489195c6..ee20ab09abe5 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -340,9 +340,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
=20
 	priv->irq =3D platform_get_irq(pdev, 0);
 	if (priv->irq <=3D 0) {
-		ret =3D priv->irq;
-		if (!ret)
-			ret =3D -ENXIO;
+		ret =3D priv->irq ? : -ENXIO;
 		goto err_clk_unprepare;
 	}
=20
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index b896f7ff4572..edbb58212fba 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -173,7 +173,7 @@ static int lpc32xx_adc_probe(struct platform_device *pd=
ev)
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq <=3D 0)
-		return -ENXIO;
+		return irq ? : -ENXIO;
=20
 	retval =3D devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
 				  LPC32XXAD_NAME, st);
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 910f3585fa54..1e54a64a4534 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -225,7 +225,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq <=3D 0) {
-		ret =3D -EINVAL;
+		ret =3D irq ? : -EINVAL;
 		goto err_disable_clk;
 	}
=20
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 592b97c464da..9b16717ac7e7 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -301,7 +301,7 @@ static int spear_adc_probe(struct platform_device *pdev)
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq <=3D 0) {
-		ret =3D -EINVAL;
+		ret =3D irq ? : -EINVAL;
 		goto errout2;
 	}
=20
--=20
Sent by a computer through tubes
