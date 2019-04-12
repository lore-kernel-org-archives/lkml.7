Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D71DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DB02171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfDLLwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:52:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39274 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfDLLwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:52:30 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEujK-0005IA-Id; Fri, 12 Apr 2019 13:52:26 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Finley Xiao <finley.xiao@rock-chips.com>,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH v1 1/6] clk: rockchip: Add supprot to limit input rate for fractional divider
Date:   Fri, 12 Apr 2019 13:52:25 +0200
Message-ID: <8338364.h4JqnAax9Z@diego>
In-Reply-To: <1554284549-24916-2-git-send-email-zhangqing@rock-chips.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com> <1554284549-24916-2-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Am Mittwoch, 3. April 2019, 11:42:24 CEST schrieb Elaine Zhang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> From Rockchips fractional divider usage, some clocks can be generated
> by fractional divider, but the input clock frequency of fractional
> divider should be less than a specified value.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

can you tell me where these maximum input values come from?

I talked to Christoph from Theobroma (Cc'ed) last week and he mentioned
that they're using the fractional divider with a higher input frequency
to create a very specific frequency [some details are gone from my memory
though] they can't get otherwise.

So I really don't want to break their working setup by introducing barriers
that are not strictly necessary.

@Christoph: can you describe the bits from your fractional setup that
I've forgotten please?


Thanks
Heiko


> diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
> index 601a77f1af78..ccabce35580b 100644
> --- a/drivers/clk/rockchip/clk-px30.c
> +++ b/drivers/clk/rockchip/clk-px30.c
> @@ -21,6 +21,7 @@
>  #include "clk.h"
>  
>  #define PX30_GRF_SOC_STATUS0		0x480
> +#define PX30_FRAC_MAX_PRATE		600000000


> diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
> index 7c4d242f19c1..67c2da5e7d61 100644
> --- a/drivers/clk/rockchip/clk-rk3368.c
> +++ b/drivers/clk/rockchip/clk-rk3368.c
> @@ -20,6 +20,9 @@
>  #include "clk.h"
>  
>  #define RK3368_GRF_SOC_STATUS0	0x480
> +#define RK3368_I2S_FRAC_MAX_PRATE       600000000
> +#define RK3368_UART_FRAC_MAX_PRATE	600000000
> +#define RK3368_SPDIF_FRAC_MAX_PRATE	600000000

> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index 5a628148f3f0..1d81382bd3e0 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -21,6 +21,12 @@
>  #include <dt-bindings/clock/rk3399-cru.h>
>  #include "clk.h"
>  
> +#define RK3399_I2S_FRAC_MAX_PRATE       600000000
> +#define RK3399_UART_FRAC_MAX_PRATE	600000000
> +#define RK3399_SPDIF_FRAC_MAX_PRATE	600000000
> +#define RK3399_VOP_FRAC_MAX_PRATE	600000000
> +#define RK3399_WIFI_FRAC_MAX_PRATE	600000000
> +



