Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2935321881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MjSCbIin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfHHLsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:48:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41691 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfHHLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:48:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808114839euoutp026280dfc1d9fa024b40b2214820cb6eb3~48Cal1BUd1681016810euoutp02c
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 11:48:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808114839euoutp026280dfc1d9fa024b40b2214820cb6eb3~48Cal1BUd1681016810euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565264919;
        bh=mNoIEJP8wFj/YD7d3kT9gabkXJXS62xIavwgNSe14EM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MjSCbIinNEclZq7DNpu7p6/7rjfhNJSk32Oo+pxGMOpPxQxnkWliSMnXB6oW7FCwH
         b37WIFq2EvxfLsjrKPffwwyhUS6KFPPNfL9YL28qyJduPrM1xxqGDPsgbucu8PJJ58
         4roNVF7d6FoBvwbTnek8Vx+yxf4e9YY0SpC5pcSU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808114838eucas1p1e7cd7898ee81321b7286d3bb3f98f051~48CZqxy0h3238232382eucas1p1R;
        Thu,  8 Aug 2019 11:48:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.14.04374.51C0C4D5; Thu,  8
        Aug 2019 12:48:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808114837eucas1p2addde94671ab500cd618c0bf96527312~48CYz4oPj2495324953eucas1p2e;
        Thu,  8 Aug 2019 11:48:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808114837eusmtrp2ff5acee78f200a02185afcc524c5d4ec~48CYlwnEs2809828098eusmtrp2Q;
        Thu,  8 Aug 2019 11:48:37 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-6e-5d4c0c1557e4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.26.04117.41C0C4D5; Thu,  8
        Aug 2019 12:48:37 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808114836eusmtip204101832cd8ab5bbd4164b87a623851e~48CYCXU2B2079220792eusmtip2C;
        Thu,  8 Aug 2019 11:48:36 +0000 (GMT)
Subject: Re: [PATCH 2/2] clk: samsung: exynos5800: Move MAU subsystem clocks
 to MAU sub-CMU
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>, sboyd@kernel.org,
        mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <eeba8348-4c41-32c5-39f2-c693aafe6c4f@samsung.com>
Date:   Thu, 8 Aug 2019 13:48:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807162456.28694-2-s.nawrocki@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87qiPD6xBn9vW1tsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxcVTrhaH37SzWvy7tpHFgcvj8rWLzB7vb7Sy
        e2xa1cnm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBmT/1sVtBlWrG4UaGDcrdHFyMkhIWAi
        8XrWYqYuRi4OIYEVjBJLLn1gh3C+MEos/rCNDcL5DOR83MgG0/L84WFWEFtIYDmjxLNllhBF
        bxkl+qYdZexi5OAQFoiVWPu4AqRGRCBGYsLrXhYQm1lgN6PEwd8pIDabgKFE19susJm8AnYS
        t+acYAaxWQRUJOavmcsOYosC9e5808MMUSMocXLmE7A5nAI2Ekc7zzFBzJSX2P52DjOELS5x
        68l8sHckBPaxS1y+uJEF4mgXiV13VjNC2MISr45vYYewZST+74RpaGaUeHhuLTuE08Mocblp
        BlSHtcTh4xdZQT5jFtCUWL9LHyLsKPG8awHYwxICfBI33gpCHMEnMWnbdGaIMK9ER5sQRLWa
        xKzj6+DWHrxwiXkCo9IsJK/NQvLOLCTvzELYu4CRZRWjeGppcW56arFxXmq5XnFibnFpXrpe
        cn7uJkZgajr97/jXHYz7/iQdYhTgYFTi4T1xyjtWiDWxrLgy9xCjBAezkgjvvTLPWCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MXVfnPpDWcV98SPXn
        WmObwmVPl3xumulbEz1zRiizRm18WejnCc+2sXEnX6+I4V9x5+6uqdIhZvPmpxl5vMphf+xS
        OdnyyNlPPcb68W+io7ybXNb8KjOzv7nLlIdZI0SW/XqvhNHUicet98nPu/KE45Ps/7VCP58V
        231dL3LRMd39n1T8doU+JZbijERDLeai4kQAgyai0kkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7qiPD6xBvvuMVlsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxcVTrhaH37SzWvy7tpHFgcvj8rWLzB7vb7Sy
        e2xa1cnm0bdlFaPH501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmT/1sVtBlWrG4UaGDcrdHFyMkhIWAi8fzhYVYQW0hgKaNE+0QmiLiM
        xMlpDawQtrDEn2tdbBA1rxklvs0u72Lk4BAWiJVY+7gCJCwiECPxe843sFZmgd2MEp9+cncx
        cgGVH2SU6Fp2lQUkwSZgKNH1FmIOr4CdxK05J5hBbBYBFYn5a+ayg9iiQIP2ndnODlEjKHFy
        5hOwXk4BG4mjneegFphJzNv8kBnClpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZ
        VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG4rZjP7fsYOx6F3yIUYCDUYmHt+CEd6wQa2JZ
        cWXuIUYJDmYlEd57ZZ6xQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTBJ5JfGGpobmFpaG
        5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY7b/NbbrL13mjZtHFqrnZ6nvarOZM
        4nlelWwnvKvu7dZrj9we5sv+9zQ8/2m/7aRlNjwBJ3gn90UY17ncdHuYtbf05+zYL9bt5+Wj
        hPZpzj/4nenJmQrPL0oXNmZ5C9do/Zby07zYFG2/PSayTeuz9A1G2U05puHfXfxuu1ezBjJe
        XM3uZuOjxFKckWioxVxUnAgAHewnWtoCAAA=
X-CMS-MailID: 20190808114837eucas1p2addde94671ab500cd618c0bf96527312
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908
References: <20190807162456.28694-1-s.nawrocki@samsung.com>
        <CGME20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908@eucas1p2.samsung.com>
        <20190807162456.28694-2-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 2019-08-07 18:24, Sylwester Nawrocki wrote:
> This patch fixes broken sound on Exynos5422/5800 platforms after
> system/suspend resume cycle in cases where the audio root clock
> is derived from MAU_EPLL_CLK.
>
> In order to preserve state of the USER_MUX_MAU_EPLL_CLK clock mux
> during system suspend/resume cycle for Exynos5800 we group the MAU
> block input clocks in "MAU" sub-CMU and add the clock mux control
> bit to .suspend_regs.  This ensures that user configuration of the mux
> is not lost after the PMU block changes the mux setting to OSC_DIV
> when switching off the MAU power domain.
>
> Adding the SRC_TOP9 register to exynos5800_clk_regs[] array is not
> sufficient as at the time of the syscore_ops suspend call MAU power
> domain is already turned off and we already save and subsequently
> restore an incorrect register's value.
>
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Reported-by: Jaafar Ali <jaafarkhalaf@gmail.com>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5420.c | 54 ++++++++++++++++++++++------
>   1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index fdb17c799aa5..b52daf5aa755 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -534,8 +534,6 @@ static const struct samsung_gate_clock exynos5800_gate_clks[] __initconst = {
>   				GATE_BUS_TOP, 24, 0, 0),
>   	GATE(CLK_ACLK432_SCALER, "aclk432_scaler", "mout_user_aclk432_scaler",
>   				GATE_BUS_TOP, 27, CLK_IS_CRITICAL, 0),
> -	GATE(CLK_MAU_EPLL, "mau_epll", "mout_user_mau_epll",
> -			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
>   };
>   
>   static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
> @@ -577,8 +575,13 @@ static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
>   
>   static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
>   	GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
> +	/* Maudio Block */
>   	GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
>   			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
> +	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
> +		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
> +	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
> +		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
>   };
>   
>   static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
> @@ -1017,12 +1020,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>   	GATE(CLK_SCLK_DP1, "sclk_dp1", "dout_dp1",
>   			GATE_TOP_SCLK_DISP1, 20, CLK_SET_RATE_PARENT, 0),
>   
> -	/* Maudio Block */
> -	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
> -		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
> -	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
> -		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
> -
>   	/* FSYS Block */
>   	GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
>   	GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> @@ -1281,6 +1278,20 @@ static struct exynos5_subcmu_reg_dump exynos5x_mfc_suspend_regs[] = {
>   	{ DIV4_RATIO, 0, 0x3 },			/* DIV dout_mfc_blk */
>   };
>   
> +
> +static const struct samsung_gate_clock exynos5800_mau_gate_clks[] __initconst = {
> +	GATE(CLK_MAU_EPLL, "mau_epll", "mout_user_mau_epll",
> +			SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
> +	GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
> +		GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
> +	GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
> +		GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
> +};
> +
> +static struct exynos5_subcmu_reg_dump exynos5800_mau_suspend_regs[] = {
> +	{ SRC_TOP9, 0, BIT(8) },
I would like to add a following comment:

/* MUX mout_user_mau_epll */

to the above line to indicate which clock it refers (like it is done for 
other sub-cmus).

> +};
> +
>   static const struct exynos5_subcmu_info exynos5x_disp_subcmu = {
>   	.div_clks	= exynos5x_disp_div_clks,
>   	.nr_div_clks	= ARRAY_SIZE(exynos5x_disp_div_clks),
> @@ -1311,12 +1322,27 @@ static const struct exynos5_subcmu_info exynos5x_mfc_subcmu = {
>   	.pd_name	= "MFC",
>   };
>   
> +static const struct exynos5_subcmu_info exynos5800_mau_subcmu = {
> +	.gate_clks	= exynos5800_mau_gate_clks,
> +	.nr_gate_clks	= ARRAY_SIZE(exynos5800_mau_gate_clks),
> +	.suspend_regs	= exynos5800_mau_suspend_regs,
> +	.nr_suspend_regs = ARRAY_SIZE(exynos5800_mau_suspend_regs),
> +	.pd_name	= "MAU",
> +};
> +
>   static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
>   	&exynos5x_disp_subcmu,
>   	&exynos5x_gsc_subcmu,
>   	&exynos5x_mfc_subcmu,
>   };
>   
> +static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
> +	&exynos5x_disp_subcmu,
> +	&exynos5x_gsc_subcmu,
> +	&exynos5x_mfc_subcmu,
> +	&exynos5800_mau_subcmu,
> +};
> +
>   static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
>   	PLL_35XX_RATE(24 * MHZ, 2000000000, 250, 3, 0),
>   	PLL_35XX_RATE(24 * MHZ, 1900000000, 475, 6, 0),
> @@ -1547,11 +1573,17 @@ static void __init exynos5x_clk_init(struct device_node *np,
>   	samsung_clk_extended_sleep_init(reg_base,
>   		exynos5x_clk_regs, ARRAY_SIZE(exynos5x_clk_regs),
>   		exynos5420_set_clksrc, ARRAY_SIZE(exynos5420_set_clksrc));
> -	if (soc == EXYNOS5800)
> +
> +	if (soc == EXYNOS5800) {
>   		samsung_clk_sleep_init(reg_base, exynos5800_clk_regs,
>   				       ARRAY_SIZE(exynos5800_clk_regs));
> -	exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5x_subcmus),
> -			     exynos5x_subcmus);
> +
> +		exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5800_subcmus),
> +				     exynos5800_subcmus);
> +	} else {
> +		exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5x_subcmus),
> +				     exynos5x_subcmus);
> +	}
>   
>   	samsung_clk_of_add_provider(np, ctx);
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

