Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69222146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCSNFM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:05:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41327 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:05:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id a25so9304643edc.8;
        Tue, 19 Mar 2019 06:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9uRSWzmfG72MaXIqN4BpL7m7hOU+eBQKqeqSFmzO5w8=;
        b=Ny82CYBJQ0+uDvSzh21NPqNoNRRhi6BCB9wHkVAFkDuyM50nIpHudW067bXL4J4IfB
         4poYgEAUc8Mb+QOZ2wTFIX2mLjH5NrEs8vSsxVZNzMynkVbarxYccq0wGRfNzNprljof
         nnKmwV/29iOcw9QCKBKUDdOdYWrX+HI3ZhFcQeRfzcE4KcyRZv2qj4GrLUfyS9lGQdMK
         Lt8vbtKbC6CyQRyxCUyWszwx9z0Jin4EOaRbp4jVufDAlgHs+KPhpdAUt0SZbvgbt3KJ
         iX3pSs8C41I3zvZBadhPjx/WubQKyQk6+o2Eg9Ytt7HbmvFlPRYh3oCSUJ/YKoE+ANoD
         W/Gg==
X-Gm-Message-State: APjAAAVnz/42QlYyA0TXeuGXnoEDDIwlli1WGzMtdd0XBjD/0xR7tczp
        bluq3n+h4u0ahW+TXozO6ZclRFGRMQo=
X-Google-Smtp-Source: APXvYqzHqoF6utY+iVXy+eldsdzyb1bOJBJatUH0ZygUvOkrl1FMmTrfyUAqwZNlPYbHpYiVMHOGMA==
X-Received: by 2002:a17:906:1942:: with SMTP id b2mr14278029eje.5.1553000708725;
        Tue, 19 Mar 2019 06:05:08 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id g7sm3078304edl.51.2019.03.19.06.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 06:05:05 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id w1so15098890wrp.2;
        Tue, 19 Mar 2019 06:05:05 -0700 (PDT)
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr16065639wrw.87.1553000705161;
 Tue, 19 Mar 2019 06:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180830154518.29507-1-embed3d@gmail.com> <yw1xzhpryrku.fsf@mansr.com>
 <20190319123702.om4uh32noys4nwxv@flea>
In-Reply-To: <20190319123702.om4uh32noys4nwxv@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Mar 2019 21:04:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v67O5VuHNTXoCB140FHqptUoUv0BGXWq6Sbo+RSC69WRRw@mail.gmail.com>
Message-ID: <CAGb2v67O5VuHNTXoCB140FHqptUoUv0BGXWq6Sbo+RSC69WRRw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 00/30] IIO-based thermal sensor
 driver for Allwinner H3 and A83T SoC
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Philipp Rossak <embed3d@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        eugen.hristev@microchip.com, Randy Dunlap <rdunlap@infradead.org>,
        vilhelm.gray@gmail.com, LABBE Corentin <clabbe.montjoie@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        geert+renesas@glider.be, Lukas Wunner <lukas@wunner.de>,
        Icenowy Zheng <icenowy@aosc.io>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 8:37 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Mar 19, 2019 at 12:30:25PM +0000, Måns Rullgård wrote:
> > Philipp Rossak <embed3d@gmail.com> writes:
> >
> > > Allwiner H3 and A83T SoCs have a thermal sensor, which is a large refactored
> > > version of the old Allwinner "GPADC" (although it have already only
> > > thermal part left in A33).
> > >
> > > This patch tried to add support for the sensor in H3 and A83T based on
> > >
> > > This Patchtseries was in the beginning based on Icenowy Zengs v4 patchseries [1]. Since we decided to merge the mfd driver into the GPADC this changed. So only one patch could be reused.
> > >
> > > Patches that adds support for H5, A64, A80 and H6 SoCs are allready prepared,
> > > and will be upstreamed if this patchseries is applied and the testing is done.
> > >
> > > Sorry for delaying this.
> > >
> > > Regards,
> > > Philipp
> > >
> > > changes since v2:
> > >     * mfd driver is now merged into the gpadc driver
> > >     * complete rework
> > >
> > > changes since v1:
> > >     * collecting all acks
> > >     * rewording commits/fix typos
> > >     * move code in place where it is used
> > >     * fix naming conventions of defines
> > >     * clarify commits
> > >     * update documentation to cover the new nvmem calibraion
> > >     * change nvmem calibration
> > >
> > > Icenowy Zheng (1):
> > >   iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain
> > >     A33
> > >
> > > Philipp Rossak (29):
> > >   mfd: Makefile: Remove build option for MFD:sun4i-gpadc
> > >   mfd: Kconfig: Remove MFD_SUN4I_GPADC config option
> > >   iio: adc: Remove ID table
> > >   iio: adc: Kconfig: Update Kconfig to new build options
> > >   iio: adc: move SUN4I_GPADC_CHANNEL define to header file
> > >   iio: adc: remove ofnode options
> > >   iio: adc: remove mfd_probe & sunwi_irq_init function
> > >   iio: adc: remove hwmon structure
> > >   iio: adc: Threat A33 as thermal sensor and remove non thermal sun4i
> > >     channel
> > >   iio: adc: rework irq and adc_channel handling
> > >   iio: adc: add new compatibles
> > >   mfd: Remove old mfd driver & Move sun4i-gpadc.h to iio/adc/
> > >   arm: config: Enable SUN4I_GPADC in defconfig
> > >   dt-bindings: update the Allwinner GPADC device tree binding for H3 &
> > >     A83T
> > >   iio: adc: sun4i-gpadc-iio: rework: readout temp_data
> > >   iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
> > >   iio: adc: sun4i-gpadc-iio: rework: support multiple sensors
> > >   iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
> > >   iio: adc: sun4i-gpadc-iio: rework: device specific suspend & resume
> > >   iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
> > >   iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
> > >   ARM: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
> > >   ARM: dts: sun8i: h3: add support for the thermal sensor in H3
> > >   ARM: dts: sun8i: h3: add thermal zone to H3
> > >   ARM: dts: sun8i: h3: enable H3 sid controller
> > >   ARM: dts: sun8i: h3: use calibration for ths
> > >   ARM: dts: sun8i: a83t: add support for the thermal sensor in A83T
> > >   ARM: dts: sun8i: a83t: add thermal zone to A83T
> > >   ARM: sun8i: a83t: full range OPP tables and CPUfreq
> > >
> > >  .../devicetree/bindings/iio/adc/sun4i-gpadc.txt    |  41 +-
> > >  arch/arm/boot/dts/sun8i-a83t.dtsi                  | 143 +++++
> > >  arch/arm/boot/dts/sun8i-h3.dtsi                    |  52 ++
> > >  arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  10 +
> > >  arch/arm/configs/sunxi_defconfig                   |   1 +
> > >  drivers/iio/adc/Kconfig                            |  11 +-
> > >  drivers/iio/adc/sun4i-gpadc-iio.c                  | 617 +++++++++++++--------
> > >  drivers/mfd/Kconfig                                |  17 -
> > >  drivers/mfd/Makefile                               |   1 -
> > >  drivers/mfd/sun4i-gpadc.c                          | 181 ------
> > >  include/linux/{mfd => iio/adc}/sun4i-gpadc.h       |  47 +-
> > >  11 files changed, 681 insertions(+), 440 deletions(-)
> > >  delete mode 100644 drivers/mfd/sun4i-gpadc.c
> > >  rename include/linux/{mfd => iio/adc}/sun4i-gpadc.h (72%)
> >
> > What became of these patches?  I can't seem to find any follow-ups.  Was
> > the approach abandoned in favour of something else?
>
> It didn't, I don't think we ever got any follow-up to that series so
> that's the main reason it's been held back.

IIRC it was blocked by a disagreement on how to handle the calibration data
in the SID. Hopefully this is now resolved.

ChenYu
