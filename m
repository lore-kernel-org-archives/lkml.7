Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41DDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE75B20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfCSMa2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:30:28 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:38090 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfCSMa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:30:27 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 06C1714CEB; Tue, 19 Mar 2019 12:30:25 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/30] IIO-based thermal sensor driver for Allwinner H3 and A83T SoC
References: <20180830154518.29507-1-embed3d@gmail.com>
Date:   Tue, 19 Mar 2019 12:30:25 +0000
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com> (Philipp Rossak's
        message of "Thu, 30 Aug 2018 17:44:48 +0200")
Message-ID: <yw1xzhpryrku.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rossak <embed3d@gmail.com> writes:

> Allwiner H3 and A83T SoCs have a thermal sensor, which is a large refactored
> version of the old Allwinner "GPADC" (although it have already only
> thermal part left in A33).
>
> This patch tried to add support for the sensor in H3 and A83T based on
>
> This Patchtseries was in the beginning based on Icenowy Zengs v4 patchseries [1]. Since we decided to merge the mfd driver into the GPADC this changed. So only one patch could be reused.
>
> Patches that adds support for H5, A64, A80 and H6 SoCs are allready prepared,
> and will be upstreamed if this patchseries is applied and the testing is done.
>
> Sorry for delaying this.
>
> Regards,
> Philipp 
>
> changes since v2:
> 	* mfd driver is now merged into the gpadc driver
> 	* complete rework
>
> changes since v1:
> 	* collecting all acks 
> 	* rewording commits/fix typos
> 	* move code in place where it is used
> 	* fix naming conventions of defines
> 	* clarify commits
> 	* update documentation to cover the new nvmem calibraion
> 	* change nvmem calibration
>
> Icenowy Zheng (1):
>   iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain
>     A33
>
> Philipp Rossak (29):
>   mfd: Makefile: Remove build option for MFD:sun4i-gpadc
>   mfd: Kconfig: Remove MFD_SUN4I_GPADC config option
>   iio: adc: Remove ID table
>   iio: adc: Kconfig: Update Kconfig to new build options
>   iio: adc: move SUN4I_GPADC_CHANNEL define to header file
>   iio: adc: remove ofnode options
>   iio: adc: remove mfd_probe & sunwi_irq_init function
>   iio: adc: remove hwmon structure
>   iio: adc: Threat A33 as thermal sensor and remove non thermal sun4i
>     channel
>   iio: adc: rework irq and adc_channel handling
>   iio: adc: add new compatibles
>   mfd: Remove old mfd driver & Move sun4i-gpadc.h to iio/adc/
>   arm: config: Enable SUN4I_GPADC in defconfig
>   dt-bindings: update the Allwinner GPADC device tree binding for H3 &
>     A83T
>   iio: adc: sun4i-gpadc-iio: rework: readout temp_data
>   iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
>   iio: adc: sun4i-gpadc-iio: rework: support multiple sensors
>   iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
>   iio: adc: sun4i-gpadc-iio: rework: device specific suspend & resume
>   iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
>   iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
>   ARM: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
>   ARM: dts: sun8i: h3: add support for the thermal sensor in H3
>   ARM: dts: sun8i: h3: add thermal zone to H3
>   ARM: dts: sun8i: h3: enable H3 sid controller
>   ARM: dts: sun8i: h3: use calibration for ths
>   ARM: dts: sun8i: a83t: add support for the thermal sensor in A83T
>   ARM: dts: sun8i: a83t: add thermal zone to A83T
>   ARM: sun8i: a83t: full range OPP tables and CPUfreq
>
>  .../devicetree/bindings/iio/adc/sun4i-gpadc.txt    |  41 +-
>  arch/arm/boot/dts/sun8i-a83t.dtsi                  | 143 +++++
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  52 ++
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  10 +
>  arch/arm/configs/sunxi_defconfig                   |   1 +
>  drivers/iio/adc/Kconfig                            |  11 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c                  | 617 +++++++++++++--------
>  drivers/mfd/Kconfig                                |  17 -
>  drivers/mfd/Makefile                               |   1 -
>  drivers/mfd/sun4i-gpadc.c                          | 181 ------
>  include/linux/{mfd => iio/adc}/sun4i-gpadc.h       |  47 +-
>  11 files changed, 681 insertions(+), 440 deletions(-)
>  delete mode 100644 drivers/mfd/sun4i-gpadc.c
>  rename include/linux/{mfd => iio/adc}/sun4i-gpadc.h (72%)

What became of these patches?  I can't seem to find any follow-ups.  Was
the approach abandoned in favour of something else?

-- 
Måns Rullgård
