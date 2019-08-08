Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B03421873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wO9Xh2PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfHHC7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:59:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37493 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfHHC7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:59:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so42917571plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 19:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=M46+rRD9490JDPK9ddkL3Wmb4Wh5zKQCmCDCkR+q5kg=;
        b=wO9Xh2PXrpg9lU0IsFaORz0XFZmPbM1HXodeJlUo0SCuE2yy7Fj3+g4OIoXK82mHy+
         +ArgkMosO7hF6RtLc2jyV+Cr6Tofxyig1mge9yOHd4ZmHmSIWyKwUYvrOjphOfaBVkDQ
         ipcx6WXAHaLsSjeOYnpBqtwfWDHIa+oJkCKMnTy68/gMwLB0i49RwxdXcEjI7ylsvXbE
         wkpmdCR37V3yqabyJT0Qq1g4kiEX4ehM5uArO4F8lh3Fh2BWxA61kuVyLzyJ3fg7fc2Z
         3NAYzY8Li9PFoC7jsf3b1GAhDygCDA6COvp++KwnIjMdcT5YpWzt3KZjt6foFcDHqu5B
         BDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=M46+rRD9490JDPK9ddkL3Wmb4Wh5zKQCmCDCkR+q5kg=;
        b=jEVnvcCNvChUC2h4hFDIy3J41N4iwngXsfhAfAzswtQ85H9AhL51wHdcCO3YoYIy3/
         sT9/Ec9z9uRoCIhLOrT1Hvzd0zPr5AlOc+PfV4X9Uk5EdVlOAA16uSs/M89JuzqG/nEX
         KPkpOFu3sbK7E1rPd3aH9sJU/88c82oMqdNGBtW9Cs/eamP37WUF07PzipcaYCKrvzEY
         7edm8cZX/KT28C5TAv4Ye4B5MnbYE3dtIZ/n/EaBVKsGRf0s5TuCVJnMuTT+Q9/ycVZb
         mFKqnDyoubWYuPWodqPwAruDOK4UqjN6Hs0G0NXLjCsLdD3s/j+wGf8HX4EztKmuyo7k
         Uqow==
X-Gm-Message-State: APjAAAUnPsA/UcYvDUIkjNkeisFDoOlet/xmYR2ZE0hNHxWIdccrrnCV
        dig/iAGfvdWhSSDbLYY3A+1Mxw==
X-Google-Smtp-Source: APXvYqydfCMfjzlAEJHfPHmY2ccUh+xmD8VV6YjY9PVxun1Oekki1EK+6Uzfy4f1k1yFW/OMQeiMjw==
X-Received: by 2002:a17:902:f089:: with SMTP id go9mr11197346plb.81.1565233185039;
        Wed, 07 Aug 2019 19:59:45 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id j20sm88282137pfr.113.2019.08.07.19.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 19:59:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/6] thermal: amlogic: Add thermal driver to support G12 SoCs
In-Reply-To: <CAFBinCB3ZBPVEJKV2Rfh_w-zWrhoToYdoYE6Wox+JeB-YH+Khw@mail.gmail.com>
References: <20190731153529.30159-1-glaroque@baylibre.com> <20190731153529.30159-3-glaroque@baylibre.com> <CAFBinCDGSJABnS1L1ULueyeXZaV38qrxEA0a12gB-uyRC_TvPQ@mail.gmail.com> <14e14cd9-46bd-0d43-654c-6db64397f5c7@baylibre.com> <CAFBinCB3ZBPVEJKV2Rfh_w-zWrhoToYdoYE6Wox+JeB-YH+Khw@mail.gmail.com>
Date:   Wed, 07 Aug 2019 19:59:43 -0700
Message-ID: <7hblx0fjkw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Guillaume,
>
> On Mon, Aug 5, 2019 at 2:48 PM guillaume La Roque <glaroque@baylibre.com> wrote:
>>
>> Hi Martin,
>>
>> again thanks for your review.
> you're welcome - thank you for working on the driver :-)
>
> [...]
>> > The IP block has more functionality, which may be added to this driver
>> > in the future:
>> > - reading up to 16 stored temperature samples
>>
>> it's not working, you can verify it if you check the regmap define in the driver. in fact temp is only write in one register, it's confirmed by amlogic.
> I missed that - so please skip this part
>
> [...]
>> >> +config AMLOGIC_THERMAL
>> > we typically use "MESON" in the Kconfig symbols:
>> > $ grep -c AMLOGIC .config
>> > 1
>> > $ grep -c MESON .config
>> > 33
>> >
>> > I also wonder if we should add G12 or G12A so we don't conflict with
>> > upcoming thermal sensors with a different design (assuming that this
>> > will be a thing).
>> > for example we already have three different USB2 PHY drivers
>> >
>> > [...]
>>
>> i check with Neil and for new family it's better to use Amlogic instead of meson.
> can you please share the considerations behind this decision?
> if new drivers should use AMLOGIC_* Kconfig symbols instead of MESON_*
> then we all should know about it
>
>> i don't add G12 because we already know it's same sensors for SM1 SoC family [0].
> my idea behind this was to avoid conflicts in the future
> in case of the thermal driver we may be fine with using a generic name
> assuming that Amlogic will not switch to a new IP block in the next
> years
> I'm not saying you have to change the name - I'm bringing this up so
> you can decide for yourself based on examples from the past
>
> here are a few examples:
> - when Kevin upstreamed the MMC driver for GX he decided to use
> MMC_MESON_GX for the Kconfig symbol name. it turns out that this is
> smart because there are at least two other MMC controller IPs on the
> 32-bit SoCs. due to him including GX in the name the drivers are easy
> to differentiate (MMC_MESON_MX_SDIO and MMC_MESON_MX_SDHC being the
> other ones, while the latter is not upstream yet)
> - when Carlo upstreamed the eFuse driver he decided to use MESON_EFUSE
> for the Kconfig symbol name. I found out much later that the 32-bit
> SoCs use a different IP (or at least direct register access instead of
> going through Secure Monitor). the driver for the 32-bit SoCs now uses
> MESON_MX_EFUSE. if you don't know which driver applies where then it's
> easy to mix up MESON_EFUSE and MESON_MX_EFUSE
> - when Jerome upstreamed the ALSA driver for AXG (which is also used
> on G12A and G12B) he decided to use the SND_MESON_AXG_* prefix for the
> Kconfig symbol names. in my opinion this was a good choice because GXM
> and everything earlier (including the 32-bit SoCs) use a different
> audio IP block. we won't have a Kconfig symbol name clash when a
> driver for the "older" SoCs is upstreamed
> - (there are more examples, Meson8b USB PHY driver, Meson8b DWMAC
> glue, ... - just like there's many examples where the IP block is
> mostly compatible with older generations: SAR ADC, RNG, SPI, ...)

While these are all good examples, you can see it can go both ways, so
there's really no way know up front what is the "right" way.  We only
know after the fact.  Unfortunately, we simply have no visibility into
future chips and where IP blocks may be shared or not (there are other
examples where vendors add a new version of an IP *and* keep the old
version. ;)

Even having worked inside a (different) SoC vendor and having some
knowledge about what IPs are shared, it's difficult to get this right.

> I'm not sure what driver naming rules other mainline SoC teams use
> to me it seems that the rule for Allwinner driver names is to use the
> "code-name of the first SoC the IP block appeared in"

That's a good rule of thumb (and one we generally follow) but I don't
feel it's important enough to enforce strictly either.

Kevin
