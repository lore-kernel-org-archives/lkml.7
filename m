Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545BDC28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311EB2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfFFKoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:44:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37604 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFKoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:44:39 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYpsp-0003i8-AI; Thu, 06 Jun 2019 12:44:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: Split GPIO keys for veyron into multiple devices
Date:   Thu, 06 Jun 2019 12:44:34 +0200
Message-ID: <3394571.LkITImzWxP@phil>
In-Reply-To: <20190605204320.22343-1-mka@chromium.org>
References: <20190605204320.22343-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juni 2019, 22:43:19 CEST schrieb Matthias Kaehlcke:
> With a single device DT overrides can become messy, especially when
> keys are added or removed. Multiple devices also allow to
> enable/disable wakeup per key/group.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.3 with 2 minor changes, detailed below.

> ---
>  .../boot/dts/rk3288-veyron-chromebook.dtsi    | 26 +++++++------
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts    | 38 ++++++++++---------
>  arch/arm/boot/dts/rk3288-veyron-pinky.dts     |  2 +-
>  arch/arm/boot/dts/rk3288-veyron.dtsi          |  4 +-
>  4 files changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> index fbef34578100..c5f71af84a40 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> @@ -70,6 +70,20 @@
>  		pinctrl-0 = <&ac_present_ap>;
>  	};
>  
> +	lid_switch: lid-switch {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ap_lid_int_l>;

added a blank line here

> +		lid {
> +			label = "Lid";
> +			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> +			wakeup-source;
> +			linux,code = <0>; /* SW_LID */
> +			linux,input-type = <5>; /* EV_SW */

actually used the constants in the properties, we have the keycodes as
dt-binding header nowadays.


Heiko


