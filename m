Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05877C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E32133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFNJfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:35:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38044 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfFNJfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:35:40 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbicI-00048J-FR; Fri, 14 Jun 2019 11:35:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        manivannan.sadhasivam@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>, dianders@chromium.org,
        robin.murphy@arm.com
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Fix multiple thermal zones conflict in rk3399.dtsi
Date:   Fri, 14 Jun 2019 11:35:25 +0200
Message-ID: <5188064.YWmxIpmbGp@phil>
In-Reply-To: <20190604165802.7338-1-daniel.lezcano@linaro.org>
References: <20190604165802.7338-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am Dienstag, 4. Juni 2019, 18:57:57 CEST schrieb Daniel Lezcano:
> Currently the common thermal zones definitions for the rk3399 assumes
> multiple thermal zones are supported by the governors. This is not the
> case and each thermal zone has its own governor instance acting
> individually without collaboration with other governors.
> 
> As the cooling device for the CPU and the GPU thermal zones is the
> same, each governors take different decisions for the same cooling
> device leading to conflicting instructions and an erratic behavior.
> 
> As the cooling-maps is about to become an optional property, let's
> remove the cpu cooling device map from the GPU thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 196ac9b78076..e1357e0f60f7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -821,15 +821,6 @@
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&gpu_alert0>;
> -					cooling-device =
> -						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  	};

my knowledge of the thermal framework is not that big, but what about the
rk3399-devices which further detail the cooling-maps like rk3399-gru-kevin
and the rk3399-nanopc-t4 with its fan-handling in the cooling-maps?


Heiko


