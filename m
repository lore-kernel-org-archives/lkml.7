Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF71C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2028820730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKOSOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:14:53 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54462 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfKOSOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:14:52 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iVg7B-0001eB-99; Fri, 15 Nov 2019 19:14:37 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     matwey.kornilov@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board
Date:   Fri, 15 Nov 2019 19:14:36 +0100
Message-ID: <1708909.MJzrS8JzXa@diego>
In-Reply-To: <20191115180825.10526-1-matwey@sai.msu.ru>
References: <20191115180825.10526-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matwey,

Am Freitag, 15. November 2019, 19:08:21 CET schrieb Matwey V. Kornilov:
> Radxa Rock Pi 4 is equipped with M.2 PCIe slot,
> so enable PCIe for the board.
> 
> The changes has been tested with Intel SSD 660p series device.
> 
>     01:00.0 Class 0108: Device 8086:f1a8 (rev 03)
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> index 1ae1ebd4efdd..9c2927faba41 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> @@ -463,6 +463,20 @@
>  	pmu1830-supply = <&vcc_3v0>;
>  };
>  
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +
> +	ep-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
> +	num-lanes = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_clkreqnb_cpm>;
> +	max-link-speed = <2>;

the RockPi schematics should be available, so could you also check
the supply regulators and add them please?

Thanks
Heiko


> +};
> +
>  &pinctrl {
>  	bt {
>  		bt_enable_h: bt-enable-h {
> 




