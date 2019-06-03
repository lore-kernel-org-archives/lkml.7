Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15E3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C725A3D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfFCPE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:04:56 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53873 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbfFCPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:04:56 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A018B40008;
        Mon,  3 Jun 2019 15:04:49 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ellie Reeves <ellierevves@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: armada-3720-espressobin: correct spi node
In-Reply-To: <20190527111614.3694-1-tmn505@gmail.com>
References: <20190527111614.3694-1-tmn505@gmail.com>
Date:   Mon, 03 Jun 2019 17:04:49 +0200
Message-ID: <87h896k8vi.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Maciej Nowak <tmn505@gmail.com> writes:

> The manufacturer of this board, ships it with various SPI NOR chips and
> increments U-Boot bootloader version along the time. There is no way to
> tell which is placed on the board since no revision bump takes place.
> This creates two issues.
>
> The first, cosmetic. Since the NOR chip may differ, there's message on
> boot stating that kernel expected w25q32dw and found different one. To
> correct this, remove optional device-specific compatible string. Being
> here lets replace bogus "spi-flash" compatible string with proper one.
>
> The second is linked to partitions layout, it changed after commit:
> 81e7251252 ("arm64: mvebu: config: move env to the end of the 4MB boot
> device") in Marvells downstream U-Boot fork [1], shifting environment
> location to the end of boot device. Since the new boards will have U-Boot
> with this change, it'll lead to improper results writing or reading from
> these partitions. We can't tell if users will update bootloader to recent
> version provided on manufacturer website, so lets drop partitons layout.
>
> 1. https://github.com/MarvellEmbeddedProcessors/u-boot-marvell.git
>
> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  .../dts/marvell/armada-3720-espressobin.dts    | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 6be019e1888e..fbcf03f86c96 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -95,25 +95,9 @@
>  
>  	flash@0 {
>  		reg = <0>;
> -		compatible = "winbond,w25q32dw", "jedec,spi-flash";
> +		compatible = "jedec,spi-nor";
>  		spi-max-frequency = <104000000>;
>  		m25p,fast-read;
> -
> -		partitions {
> -			compatible = "fixed-partitions";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			partition@0 {
> -				label = "uboot";
> -				reg = <0 0x180000>;
> -			};
> -
> -			partition@180000 {
> -				label = "ubootenv";
> -				reg = <0x180000 0x10000>;
> -			};
> -		};
>  	};
>  };
>  
> -- 
> 2.21.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
