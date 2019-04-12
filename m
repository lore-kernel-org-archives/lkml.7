Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75BC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156112186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDLB5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:57:06 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:43350 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:57:04 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.233])
        by regular1.263xmail.com (Postfix) with ESMTP id 782242B9;
        Fri, 12 Apr 2019 09:56:59 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30989T139769707656960S1555034217136668_;
        Fri, 12 Apr 2019 09:56:58 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <17317645d7da87014d296fcc409dd801>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 1/5] clk: rockchip: Turn on "aclk_dmac1" for suspend
To:     Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dbasehore@chromium.org, amstan@chromium.org,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190411232157.55125-1-dianders@chromium.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <3ae87289-a359-16cb-69fd-ecf48c17fb8d@rock-chips.com>
Date:   Fri, 12 Apr 2019 09:56:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411232157.55125-1-dianders@chromium.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

ÔÚ 2019/4/12 ÉÏÎç7:21, Douglas Anderson Ð´µÀ:
> Experimentally it can be seen that going into deep sleep (specifically
> setting PMU_CLR_DMA and PMU_CLR_BUS in RK3288_PMU_PWRMODE_CON1)
> appears to fail unless "aclk_dmac1" is on.  The failure is that the
> system never signals that it made it into suspend on the GLOBAL_PWROFF
> pin and it just hangs.
>
> NOTE that it's confirmed that it's the actual suspend that fails, not
> one of the earlier calls to read/write registers.  Specifically if you
> comment out the "PMU_GLOBAL_INT_DISABLE" setting in
> rk3288_slp_mode_set() and then comment out the "cpu_do_idle()" call in
> rockchip_lpmode_enter() then you can exercise the whole suspend path
> without any crashing.
>
> This is currently not a problem with suspend upstream because there is
> no current way to exercise the deep suspend code.  However, anyone
> trying to make it work will run into this issue.
>
> This was not a problem on shipping rk3288-based Chromebooks because
> those devices all ran on an old kernel based on 3.14.  On that kernel
> "aclk_dmac1" appears to be left on all the time.
>
> There are several ways to skin this problem.
>
> A) We could add "aclk_dmac1" to the list of critical clocks and that
> apperas to work, but presumably that wastes power.
>
> B) We could keep a list of "struct clk" objects to enable at suspend
> time in clk-rk3288.c and use the standard clock APIs.
>
> C) We could make the rk3288-pmu driver keep a list of clocks to enable
> at suspend time.  Presumably this would require a dts and bindings
> change.
>
> D) We could just whack the clock on in the existing syscore suspend
> function where we whack a bunch of other clocks.  This is particularly
> easy because we know for sure that the clock's only parent
> ("aclk_cpu") is a critical clock so we don't need to do anything more
> than ungate it.
>
> In this case I have chosen D) because it seemed like the least work,
> but any of the other options would presumably also work fine.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/clk/rockchip/clk-rk3288.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 5a67b7869960..b245367393cd 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -859,6 +859,9 @@ static const int rk3288_saved_cru_reg_ids[] = {
>   	RK3288_CLKSEL_CON(10),
>   	RK3288_CLKSEL_CON(33),
>   	RK3288_CLKSEL_CON(37),
> +
> +	/* We turn aclk_dmac1 on for suspend; this will restore it */
> +	RK3288_CLKGATE_CON(10),
>   };
>   
>   static u32 rk3288_saved_cru_regs[ARRAY_SIZE(rk3288_saved_cru_reg_ids)];
> @@ -874,6 +877,14 @@ static int rk3288_clk_suspend(void)
>   				readl_relaxed(rk3288_cru_base + reg_id);
>   	}
>   
> +	/*
> +	 * Going into deep sleep (specifically setting PMU_CLR_DMA in
> +	 * RK3288_PMU_PWRMODE_CON1) appears to fail unless
> +	 * "aclk_dmac1" is on.
> +	 */
> +	writel_relaxed(1 << (12 + 16),
> +		       rk3288_cru_base + RK3288_CLKGATE_CON(10));
> +
>   	/*
>   	 * Switch PLLs other than DPLL (for SDRAM) to slow mode to
>   	 * avoid crashes on resume. The Mask ROM on the system will

Thank you for your correction.

Reviewed-by: Elaine Zhang<zhangqing@rock-chips.com>



