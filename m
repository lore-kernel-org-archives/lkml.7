Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE9C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED84021874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565241255;
	bh=uTQbu9mGSxVTJETQA4FUVAen+xLMIIOIE1bWzh+FlNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lnZpz0zoWhosvUd+1VsVUnKbeq7Kps2W8rV3cXUClj8M7mvMQrCtlZ4QVzexPUrOX
	 pXtoShKmdTan+LrrnlXonUz9ATBBrelXkUjxERrFbT8wLlqs91t+ot0oIi05IpYtSq
	 HED122bn5fixiPU/5hPrPwTTmmy8OxGAwzBNz+Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfHHFOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfHHFON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:14:13 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18022186A;
        Thu,  8 Aug 2019 05:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565241252;
        bh=uTQbu9mGSxVTJETQA4FUVAen+xLMIIOIE1bWzh+FlNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GntMZuHjbR72qZbxMF3Y4KDcZuAsLd/9O+2tfW3Q5tK1auI7H/nH3dVqWsRPAu34r
         3iPb4UGv9B/HPyejvqHjx0GTuNYqTXRfgvmIhzdeiN58f3rBJ+FxiBAX/AUxEpSGks
         BhLEIpap271YTHWqbkMlUx8RhCv5r3swH2UPWE/o=
Date:   Thu, 8 Aug 2019 10:43:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v1 2/2] clk: qcom: Add Global Clock controller (GCC)
 driver for SC7180
Message-ID: <20190808051301.GL12733@vkoul-mobl.Dlink>
References: <20190807181301.15326-1-tdas@codeaurora.org>
 <20190807181301.15326-3-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807181301.15326-3-tdas@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-08-19, 23:43, Taniya Das wrote:

> +static struct clk_alpha_pll gpll0;
> +static struct clk_alpha_pll gpll1;
> +static struct clk_alpha_pll gpll4;
> +static struct clk_alpha_pll gpll6;
> +static struct clk_alpha_pll gpll7;
> +static struct clk_alpha_pll_postdiv gpll0_out_even;

I am not sure we need these, reordering code and getting rid of them
should be easy enough (i did that for sm8150)

> +static const struct parent_map gcc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +	{ P_GPLL0_OUT_EVEN, 6 },
> +	{ P_CORE_BI_PLL_TEST_SE, 7 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_0[] = {
> +	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
> +	{ .hw = &gpll0.clkr.hw },
> +	{ .hw = &gpll0_out_even.clkr.hw },
> +	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },

This is legacy test, so we would want only fw_name being there

> +static struct clk_branch gcc_camera_ahb_clk = {
> +	.halt_reg = 0xb008,
> +	.halt_check = BRANCH_HALT,
> +	.hwcg_reg = 0xb008,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0xb008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camera_ahb_clk",
> +			.flags = CLK_IS_CRITICAL,

It would help to explain why this clk is critical

> +static struct clk_branch gcc_disp_gpll0_div_clk_src = {
> +	.halt_check = BRANCH_HALT_DELAY,

And why this needs a delay
-- 
~Vinod
