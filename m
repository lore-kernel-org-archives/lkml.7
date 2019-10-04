Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14167C32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A2B2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfJDABR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 20:01:17 -0400
Received: from foss.arm.com ([217.140.110.172]:59354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbfJDABQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 20:01:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 144A915A1;
        Thu,  3 Oct 2019 17:01:16 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49D153F534;
        Thu,  3 Oct 2019 17:01:15 -0700 (PDT)
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: fix RockPro64 sdmmc settings
To:     Soeren Moch <smoch@web.de>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191003215036.15023-1-smoch@web.de>
 <20191003215036.15023-3-smoch@web.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <31181f3c-20ec-e717-1f7e-8b35cd54d96d@arm.com>
Date:   Fri, 4 Oct 2019 01:01:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003215036.15023-3-smoch@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-03 10:50 pm, Soeren Moch wrote:
> According to the RockPro64 schematic [1] the rk3399 sdmmc controller is
> connected to a microSD (TF card) slot, which cannot be switched to 1.8V.

Really? AFAICS the SDMMC0 wiring looks pretty much identical to the 
NanoPC-T4 schematic (it's the same reference design, after all), and I 
know that board can happily drive a UHS-I microSD card with 1.8v I/Os, 
because mine's doing so right now.

Robin.

> So also configure the vcc_sdio regulator, which drives the i/o voltage
> of the sdmmc controller, accordingly.
> 
> While at it, also remove the cap-mmc-highspeed property of the sdmmc
> controller, since no mmc card can be connected here.
> 
> [1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> 
> Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
> Signed-off-by: Soeren Moch <smoch@web.de>
> ---
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> index 2e44dae4865a..084f1d994a50 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -353,7 +353,7 @@
>   				regulator-name = "vcc_sdio";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> +				regulator-min-microvolt = <3000000>;
>   				regulator-max-microvolt = <3000000>;
>   				regulator-state-mem {
>   					regulator-on-in-suspend;
> @@ -624,7 +624,6 @@
> 
>   &sdmmc {
>   	bus-width = <4>;
> -	cap-mmc-highspeed;
>   	cap-sd-highspeed;
>   	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
>   	disable-wp;
> --
> 2.17.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
