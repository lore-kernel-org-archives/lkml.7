Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC0C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7862321882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfI2VV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:21:56 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45862 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfI2VVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 17:21:55 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iEgdL-0001at-6x; Sun, 29 Sep 2019 23:21:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Levin Du <djw@t-chip.com.cn>, Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: Fix rk3399-roc-pc pwm2 pin
Date:   Sun, 29 Sep 2019 23:21:34 +0200
Message-ID: <6797961.eJj5WIFbM9@phil>
In-Reply-To: <20190919052822.10403-2-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com> <20190919052822.10403-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am Donnerstag, 19. September 2019, 07:28:17 CEST schrieb Jagan Teki:
> ROC-PC is not able to boot linux console if PWM2_d is
> unattached to any pinctrl logic.
> 
> To be precise the linux boot hang with last logs as,
> ...
> .....
> [    0.003367] Console: colour dummy device 80x25
> [    0.003788] printk: console [tty0] enabled
> [    0.004178] printk: bootconsole [uart8250] disabled
> 
> In ROC-PC the PWM2_d pin is connected to LOG_DVS_PWM of
> VDD_LOG. So, for normal working operations this needs to
> active and pull-down.
> 
> This patch fix, by attaching pinctrl active and pull-down
> the pwm2.

This looks highly dubious on first glance. The pwm subsystem nor
the Rockchip pwm driver do not do any pinctrl handling.

So I don't really see where that "active" pinctrl state is supposed
to come from.

Comparing with the pwm driver in the vendor tree I see that there
is such a state defined there. But that code there also looks strange
as that driver never again leaves this active state after entering it.

Also for example all the Gru devices run with quite a number of pwm-
regulators without needing additional fiddling with the pwm itself, so
I don't really see why that should be different here.

Heiko

> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> index 19f7732d728c..c53f3d571620 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -548,6 +548,8 @@
>  };
>  
>  &pwm2 {
> +	pinctrl-names = "active";
> +	pinctrl-0 = <&pwm2_pin_pull_down>;
>  	status = "okay";
>  };
>  
> 




