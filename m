Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E436C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667EC2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfDLMVe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:21:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39688 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfDLMVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:21:33 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEvBL-0005TL-57; Fri, 12 Apr 2019 14:21:23 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph =?ISO-8859-1?Q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v1 1/6] clk: rockchip: Add supprot to limit input rate for fractional divider
Date:   Fri, 12 Apr 2019 14:21:22 +0200
Message-ID: <3395739.hcHkC3K37q@diego>
In-Reply-To: <818a6e0a-d99b-7350-9c4a-9e0a0d12122a@theobroma-systems.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com> <8338364.h4JqnAax9Z@diego> <818a6e0a-d99b-7350-9c4a-9e0a0d12122a@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am Freitag, 12. April 2019, 14:12:52 CEST schrieb Christoph Müllner:
> On 12.04.19 13:52, Heiko Stübner wrote:
> > Am Mittwoch, 3. April 2019, 11:42:24 CEST schrieb Elaine Zhang:
> >> From: Finley Xiao <finley.xiao@rock-chips.com>
> >>
> >> From Rockchips fractional divider usage, some clocks can be generated
> >> by fractional divider, but the input clock frequency of fractional
> >> divider should be less than a specified value.
> >>
> >> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> >> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > 
> > can you tell me where these maximum input values come from?
> > 
> > I talked to Christoph from Theobroma (Cc'ed) last week and he mentioned
> > that they're using the fractional divider with a higher input frequency
> > to create a very specific frequency [some details are gone from my memory
> > though] they can't get otherwise.
> > 
> > So I really don't want to break their working setup by introducing barriers
> > that are not strictly necessary.
> > 
> > @Christoph: can you describe the bits from your fractional setup that
> > I've forgotten please?
> 
> We need to set the I2S0 clock to 24.56 MHz.
> 
> When restricting the input frequency to a maximum of 600 Mhz,
> we could use the integer divider to get 400 Mhz (dividing by 2).
> However, with the 400 Mhz as input to the frac divider,
> we run into the problem, that the maximum possible output frequency
> is 20 MHz (there is another restriction which states that the
> fraction input : output frequency must be >= 20).

just for clarification, what is the current input frequency you
already use sucessfully?


Heiko

> > 
> >> diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
> >> index 601a77f1af78..ccabce35580b 100644
> >> --- a/drivers/clk/rockchip/clk-px30.c
> >> +++ b/drivers/clk/rockchip/clk-px30.c
> >> @@ -21,6 +21,7 @@
> >>  #include "clk.h"
> >>  
> >>  #define PX30_GRF_SOC_STATUS0		0x480
> >> +#define PX30_FRAC_MAX_PRATE		600000000
> > 
> > 
> >> diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
> >> index 7c4d242f19c1..67c2da5e7d61 100644
> >> --- a/drivers/clk/rockchip/clk-rk3368.c
> >> +++ b/drivers/clk/rockchip/clk-rk3368.c
> >> @@ -20,6 +20,9 @@
> >>  #include "clk.h"
> >>  
> >>  #define RK3368_GRF_SOC_STATUS0	0x480
> >> +#define RK3368_I2S_FRAC_MAX_PRATE       600000000
> >> +#define RK3368_UART_FRAC_MAX_PRATE	600000000
> >> +#define RK3368_SPDIF_FRAC_MAX_PRATE	600000000
> > 
> >> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> >> index 5a628148f3f0..1d81382bd3e0 100644
> >> --- a/drivers/clk/rockchip/clk-rk3399.c
> >> +++ b/drivers/clk/rockchip/clk-rk3399.c
> >> @@ -21,6 +21,12 @@
> >>  #include <dt-bindings/clock/rk3399-cru.h>
> >>  #include "clk.h"
> >>  
> >> +#define RK3399_I2S_FRAC_MAX_PRATE       600000000
> >> +#define RK3399_UART_FRAC_MAX_PRATE	600000000
> >> +#define RK3399_SPDIF_FRAC_MAX_PRATE	600000000
> >> +#define RK3399_VOP_FRAC_MAX_PRATE	600000000
> >> +#define RK3399_WIFI_FRAC_MAX_PRATE	600000000
> >> +
> > 
> > 
> > 
> 




