Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6795C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7589521897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="aynYSKF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfIBOD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:03:26 -0400
Received: from vps.xff.cz ([195.181.215.36]:37646 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbfIBOD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1567433004; bh=PIZR0w2A/4yebx5N98JZFq5HnRwp3i+09UDZyZKFhJg=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=aynYSKF6bVmhcvJuC139QvR0C8HJJb5VJKWPq7VfJaFlkBnvBYDScjhMpL0Scs1cv
         keN8Ong6vJuGEaVrZczvmiZBmYwVOQuNBvImPWvyXrUOhDKD78dPfdDISy+3l5SOwn
         Sd6zcnfIZJWzynwdBsycqGIUQoUuBE+1perL7TJ0=
Date:   Mon, 2 Sep 2019 16:03:23 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 00/10] arm64: dts: allwinner: h5: Enable CPU DVFS
 (cpufreq)
Message-ID: <20190902140323.fgfrifyow5qgoce4@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, Sergey Matyukevich <geomatsi@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 30, 2019 at 04:41:53PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series enables DVFS for the CPU cores (aka cpufreq) on the
> Allwinner H5 SoC. The OPP table was taken from Armbian, with minor
> tweaks to the maximum voltage to account for slightly increased voltage
> on some of the boards.
> 
> This has been tested on the Bananapi M2+ v1.2 and Libre Computer
> ALL-H3-CC H5 ver..  I do not have the remaining boards so I've CC-ed
> people who did the original submission or have modified the board
> specifically later on.
> 
> Patch 1 fixes the voltages specified for the GPIO-controlled regulator
> on the Bananapi M2+ v1.2. The voltages are slightly higher than what
> was originally written.
> 
> Patch 2 adds a fixed regulator for the CPU on the original Bananapi M2+.
> This is for the retail version, not the engineering samples that had an
> even higher voltage setting.
> 
> Patch 3 hooks up the CPU regulator supply for H5 boards that already
> define the regulator, but were missing the property to tie it to the
> CPUs.
> 
> Patch 4 ~ 8 adds the CPU regulator for boards that don't have it
> defined. This is based on each vendor's schematics. I need people
> to test each of these specifically and the whole series.
> 
> Patch 9 ties the CPU clock to the CPU cores.
> 
> Patch 10 adds the OPP table, based on the one from Armbian.
> 
> Please have a look and please help test this.

Looks like this patch series got forgotten. Or is it waiting for some
user testing?

regards,
	o.

> 
> Regards
> ChenYu
> 
> 
> Chen-Yu Tsai (10):
>   ARM: dts: sunxi: bananapi-m2-plus-v1.2: Fix CPU supply voltages
>   ARM: dts: bananapi-m2-plus: Add CPU supply regulator
>   arm64: dts: allwinner: h5: Hook up cpu regulator supplies
>   arm64: dts: allwinner: h5: nanopi-neo2: Add CPU regulator supply
>   arm64: dts: allwinner: h5: orange-pi-zero-plus: Add CPU regulator
>     supply
>   arm64: dts: allwinner: h5: orange-pi-zero-plus2: Add CPU regulator
>     supply
>   arm64: dts: allwinner: h5: orange-pi-pc2: Add CPU regulator supply
>   arm64: dts: allwinner: h5: orange-pi-prime: Add CPU regulator supply
>   arm64: dts: allwinner: h5: Add clock to CPU cores
>   arm64: dts: allwinner: h5: Add CPU Operating Performance Points table
> 
>  .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 30 +++-----
>  arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 14 ++++
>  .../sun50i-h5-emlid-neutis-n5-devboard.dts    |  4 +
>  .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  |  4 +
>  .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 20 +++++
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 28 +++++++
>  .../allwinner/sun50i-h5-orangepi-prime.dts    | 28 +++++++
>  .../sun50i-h5-orangepi-zero-plus.dts          | 20 +++++
>  .../sun50i-h5-orangepi-zero-plus2.dts         | 20 +++++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 75 +++++++++++++++++++
>  10 files changed, 224 insertions(+), 19 deletions(-)
> 
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
