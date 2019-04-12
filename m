Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF82F2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDLR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:58:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfDLR6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:58:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58592374;
        Fri, 12 Apr 2019 10:58:38 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6403B3F718;
        Fri, 12 Apr 2019 10:58:36 -0700 (PDT)
Subject: Re: [PATCH v2] clk: rockchip: undo several noc and special clocks as
 critical on rk3288
To:     Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mka@chromium.org, ryandcase@chromium.org,
        Caesar Wang <caesar.wang@rock-chips.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190412161747.107107-1-dianders@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6d877246-c59a-151c-973e-ad1161417d39@arm.com>
Date:   Fri, 12 Apr 2019 18:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412161747.107107-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 17:17, Douglas Anderson wrote:
> This is mostly a revert of commit 55bb6a633c33 ("clk: rockchip: mark
> noc and some special clk as critical on rk3288") except that we're
> keeping "pmu_hclk_otg0" as critical still.
> 
> NOTE: turning these clocks off doesn't seem to do a whole lot in terms
> of power savings (checking the power on the logic rail).  It appears
> to save maybe 1-2mW.  ...but still it seems like we should turn the
> clocks off if they aren't needed.
> 
> About "pmu_hclk_otg0" (the one clock from the original commit we're
> still keeping critical) from an email thread:
> 
>> pmu ahb clock
>>
>> Function: Clock to pmu module when hibernation and/or ADP is
>> enabled. Must be greater than or equal to 30 MHz.
>>
>> If the SOC design does not support hibernation/ADP function, only have
>> hclk_otg, this clk can be switched according to the usage of otg.
>> If the SOC design support hibernation/ADP, has two clocks, hclk_otg and
>> pmu_hclk_otg0.
>> Hclk_otg belongs to the closed part of otg logic, which can be switched
>> according to the use of otg.
>>
>> pmu_hclk_otg0 belongs to the always on part.
>>
>> As for whether pmu_hclk_otg0 can be turned off when otg is not in use,
>> we have not tested. IC suggest make pmu_hclk_otg0 always on.
> 
> For the rest of the clocks:
> 
> atclk: No documentation about this clock other than that it goes to
> the CPU.  CPU functions fine without it on.  Maybe needed for JTAG?

FWIW, the two brief references in the TRM imply that's the ATB clock, 
which would make it part of the CoreSight tracing gubbins[1] - I can't 
see any evidence that RK3288 has an ETR or ETB for self-hosted tracing, 
so it may well only be relevant for external trace hardware (wherein 
GRF_SOC_CON7 suggests that it might spew trace data out of the parallel 
LCD interface pins).

> jtag: Presumably this clock is only needed if you're debugging with
> JTAG.  It doesn't seem like it makes sense to waste power for every
> rk3288 user.  In any case to do JTAG you'd need private patches to
> adjust the pinctrl the mux the JTAG out anyway.
> 
> pclk_dbg, pclk_core_niu: On veyron Chromebooks we turn these two
> clocks on only during kernel panics in order to access some coresight
> registers.  Since nothing in the upstream kernel does this we should
> be able to leave them off safely.  Maybe also needed for JTAG?

Similarly, pclk_dbg sounds like the APB clock for the CPU external debug 
interface[2] (which I suspect is probably somewhere in that "A17_Debug" 
region at 0xffb80000 that the DT doesn't even go near).

I would imagine that as long as a hardware debugger can establish a 
JTAG/SWD connection to the DAP, it would then have an initialisation 
script which knows what values to poke where in order to configure 
additional pinmux/clocks/CoreSight components/etc. to the appropriate 
state, so I'd hope that Linux shouldn't have to care about those details 
either way.

Robin.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0535b/CHDJFFCH.html
[2] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0535b/BABBCDGE.html

> hsicphy12m_xin12m: There is no indication of why this clock would need
> to be turned on for boards that don't use HSIC.
> 
> pclk_ddrupctl[0-1], pclk_publ0[0-1]: On veyron Chromebooks we turn
> these 4 clocks on only when doing DDR transitions and they are off
> otherwise.  I see no reason why they'd need to be on in the upstream
> kernel which doesn't support DDRFreq.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Now keep pmu_hclk_otg0 as critical.
> - Updated description since this isn't a clean revert.
> - PWM patches have landed, so just one patch in the series now.
> 
>   drivers/clk/rockchip/clk-rk3288.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index f47d514cba36..13668ad59f2e 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -313,13 +313,13 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>   	COMPOSITE_NOMUX(0, "aclk_core_mp", "armclk", CLK_IGNORE_UNUSED,
>   			RK3288_CLKSEL_CON(0), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
>   			RK3288_CLKGATE_CON(12), 6, GFLAGS),
> -	COMPOSITE_NOMUX(0, "atclk", "armclk", CLK_IGNORE_UNUSED,
> +	COMPOSITE_NOMUX(0, "atclk", "armclk", 0,
>   			RK3288_CLKSEL_CON(37), 4, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
>   			RK3288_CLKGATE_CON(12), 7, GFLAGS),
>   	COMPOSITE_NOMUX(0, "pclk_dbg_pre", "armclk", CLK_IGNORE_UNUSED,
>   			RK3288_CLKSEL_CON(37), 9, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
>   			RK3288_CLKGATE_CON(12), 8, GFLAGS),
> -	GATE(0, "pclk_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
> +	GATE(0, "pclk_dbg", "pclk_dbg_pre", 0,
>   			RK3288_CLKGATE_CON(12), 9, GFLAGS),
>   	GATE(0, "cs_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
>   			RK3288_CLKGATE_CON(12), 10, GFLAGS),
> @@ -647,7 +647,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>   	INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
>   			RK3288_CLKSEL_CON(22), 7, IFLAGS),
>   
> -	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
> +	GATE(0, "jtag", "ext_jtag", 0,
>   			RK3288_CLKGATE_CON(4), 14, GFLAGS),
>   
>   	COMPOSITE_NODIV(SCLK_USBPHY480M_SRC, "usbphy480m_src", mux_usbphy480m_p, 0,
> @@ -656,7 +656,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
>   	COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy480m_p, 0,
>   			RK3288_CLKSEL_CON(29), 0, 2, MFLAGS,
>   			RK3288_CLKGATE_CON(3), 6, GFLAGS),
> -	GATE(0, "hsicphy12m_xin12m", "xin12m", CLK_IGNORE_UNUSED,
> +	GATE(0, "hsicphy12m_xin12m", "xin12m", 0,
>   			RK3288_CLKGATE_CON(13), 9, GFLAGS),
>   	DIV(0, "hsicphy12m_usbphy", "sclk_hsicphy480m", 0,
>   			RK3288_CLKSEL_CON(11), 8, 6, DFLAGS),
> @@ -837,11 +837,6 @@ static const char *const rk3288_critical_clocks[] __initconst = {
>   	"pclk_alive_niu",
>   	"pclk_pd_pmu",
>   	"pclk_pmu_niu",
> -	"pclk_core_niu",
> -	"pclk_ddrupctl0",
> -	"pclk_publ0",
> -	"pclk_ddrupctl1",
> -	"pclk_publ1",
>   	"pmu_hclk_otg0",
>   	/* pwm-regulators on some boards, so handoff-critical later */
>   	"pclk_rkpwm",
> 
