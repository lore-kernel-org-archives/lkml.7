Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAF82064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfDJGYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:24:18 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:47724 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfDJGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:24:18 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.161])
        by regular1.263xmail.com (Postfix) with ESMTP id 7AAC8342;
        Wed, 10 Apr 2019 14:23:28 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26203T140493257189120S1554877405083848_;
        Wed, 10 Apr 2019 14:23:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ae1f322d03c2d86bbafb34e687d84f8f>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 1/3] Revert "clk: rockchip: mark noc and some special clk
 as critical on rk3288"
To:     Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        ryandcase@chromium.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190409204707.150347-1-dianders@chromium.org>
 <20190409204707.150347-2-dianders@chromium.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <b7093a17-b30c-cdec-b02c-c6bc5a8d08c9@rock-chips.com>
Date:   Wed, 10 Apr 2019 14:23:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409204707.150347-2-dianders@chromium.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

ÔÚ 2019/4/10 ÉÏÎç4:47, Douglas Anderson Ð´µÀ:
> This reverts commit 55bb6a633c33caf68ab470907ecf945289cb733d.
>
> The clocks that were enabled by that patch are pretty questionable.
> Specifically looking at what has been shipping on rk3288-veyron
> Chromebooks almost all of these clocks are safely turned off and cause
> no apparent problems.  If some boards need these clocks turned on for
> some reason then it seems like we should figure out how to do that at
> a board level.
>
> NOTE: turning these clocks off doesn't seem to do a whole lot in terms
> of power savings (checking the power on the logic rail).  It appears
> to save maybe 1-2mW.  ...but still it seems like we should turn the
> clocks off if they aren't needed.
>
> Digging into the clocks here to describe why they shouldn't need to be
> left on:
>
> atclk: No documentation about this clock other than that it goes to
> the CPU.  CPU functions fine without it on.
>
> jtag: Presumably this clock is only needed if you're debugging with
> JTAG.  It doesn't seem like it makes sense to waste power for every
> rk3288 user.  Perhaps this could be turned on with a CONFIG option?
>
> pclk_dbg, pclk_core_niu: On veyron Chromebooks we turn these two
> clocks on only during kernel panics in order to access some coresight
> registers.  Since nothing in the upstream kernel does this we should
> be able to leave them off safely.
>
> hsicphy12m_xin12m: There is no indication of why this clock would need
> to be turned on for boards that don't use HSIC.
>
> pclk_ddrupctl[0-1], pclk_publ0[0-1]: On veyron Chromebooks we turn
> these 4 clocks on only when doing DDR transitions and they are off
> otherwise.  I see no reason why they'd need to be on in the upstream
> kernel which doesn't support DDRFreq.
>
> pmu_hclk_otg0: A "chip design defect" is mentioned in the original
> patch but no details.  This clock has always been gated in shipping
> veyron Chromebooks so presumably this chip defect doesn't affect all
> boards.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/clk/rockchip/clk-rk3288.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 5a67b7869960..06287810474e 100644
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
CLK_IGNORE_UNUSED:
Whether to close the unused clk after clk init complete. not affect 
there own enable/disable.
JTAG is not have device node, when need jtag to debug, may be the system 
is crashed, there is no way to turn on this clk.
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
> @@ -837,12 +837,6 @@ static const char *const rk3288_critical_clocks[] __initconst = {
>   	"pclk_alive_niu",
>   	"pclk_pd_pmu",
>   	"pclk_pmu_niu",
> -	"pclk_core_niu",
> -	"pclk_ddrupctl0",
> -	"pclk_publ0",
> -	"pclk_ddrupctl1",
> -	"pclk_publ1",
These clks needed enable, device node not use this clk, so we mark it as 
critical.
> -	"pmu_hclk_otg0",
It's a soc bug, pmu_hclk_otg0 must always on.
>   };
>   
>   static void __iomem *rk3288_cru_base;


