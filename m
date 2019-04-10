Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D39EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462632083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfDJGm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:42:29 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:33798 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDJGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:42:28 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.154])
        by regular1.263xmail.com (Postfix) with ESMTP id A66E83DD;
        Wed, 10 Apr 2019 14:42:24 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P23470T140084141602560S1554878540938362_;
        Wed, 10 Apr 2019 14:42:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <201c2b2e56731f95e4aa6c62ecc02898>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 2/3] clk: rockchip: Make rkpwm a critical clock on rk3288
To:     Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        ryandcase@chromium.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190409204707.150347-1-dianders@chromium.org>
 <20190409204707.150347-3-dianders@chromium.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <50b744cd-b8d9-79ca-ba2d-6765808aa5e5@rock-chips.com>
Date:   Wed, 10 Apr 2019 14:42:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409204707.150347-3-dianders@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

在 2019/4/10 上午4:47, Douglas Anderson 写道:
> Most rk3288-based boards are derived from the EVB and thus use a PWM
> regulator for the logic rail.  However, most rk3288-based boards don't
> specify the PWM regulator in their device tree.  We'll deal with that
> by making it critical.
>
> NOTE: it's important to make it critical and not just IGNORE_UNUSED
> because all PWMs in the system share the same clock.  We don't want
> another PWM user to turn the clock on and off and kill the logic rail.
>
> This change is in preparation for actually having the PWMs in the
> rk3288 device tree actually point to the proper PWM clock.  Up until
> now they've all pointed to the clock for the old IP block and they've
> all worked due to the fact that rkpwm was IGNORE_UNUSED and that the
> clock rates for both clocks were the same.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/clk/rockchip/clk-rk3288.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 06287810474e..c3321eade23e 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -697,7 +697,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>   	GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 3, GFLAGS),
>   	GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 9, GFLAGS),
>   	GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 10, GFLAGS),
> -	GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 11, GFLAGS),
> +	GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 11, GFLAGS),
>   
>   	/* ddrctrl [DDR Controller PHY clock] gates */
>   	GATE(0, "nclk_ddrupctl0", "ddrphy", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 4, GFLAGS),
> @@ -837,6 +837,7 @@ static const char *const rk3288_critical_clocks[] __initconst = {
>   	"pclk_alive_niu",
>   	"pclk_pd_pmu",
>   	"pclk_pmu_niu",
> +	"pclk_rkpwm",

pwm have device node, can enable and disable it in the pwm drivers.

pwm regulator use pwm node as:

pwms = <&pwm2 0 25000 1>

when set Logic voltage:

pwm_regulator_set_voltage()

     --> pwm_apply_state()

         -->clk_enable()

         -->pwm_enable()

         -->pwm_config()

         -->pinctrl_select()

         --....

For mark pclk_rkpwm as critical,do you have any questions, or provides 
some log or more information.

>   };
>   
>   static void __iomem *rk3288_cru_base;


