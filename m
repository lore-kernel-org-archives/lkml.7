Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02236CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD08820679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571662393;
	bh=uxGrhZDbF2L+yKtpe/kGnfAuBpoA1iG6MrGYbfiPYMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M09ttt7CC2pCu522kzJIyeCk4wlNd3SS4lXHXU6pKa2026cff6/OYGCfOP7bVJ8vD
	 bdoz9MiDTIhDqLy5mV7J+407yRsagAoP7BzcJ5dNeVgTPoPc+jNvWpoBZJ58n9f7T+
	 xCKdgTIbnFYDci1VyxJunkhea317El2Chpg7+unI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfJUMxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfJUMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:53:12 -0400
Received: from localhost (unknown [122.167.89.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B670620679;
        Mon, 21 Oct 2019 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571662391;
        bh=uxGrhZDbF2L+yKtpe/kGnfAuBpoA1iG6MrGYbfiPYMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4RWmmBtxaaFlwYYdg07Nv47t0QfQGlkcWuDFsx6GsS0CtyZEscBs7zvcW94wE2ML
         BNBUeJJjg8osPhmy2fXtxoHyXLMXEyHRJZqzRrhO1JJ5un+YrSWsDexBCaz+UPxZh+
         hxu8etsF5EOf8X+0KJ6IXR8K5+0b/UgnABbLKzQI=
Date:   Mon, 21 Oct 2019 18:23:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v1 3/3] clk: qcom: clk-rpmh: Add support for RPMHCC for
 SC7180
Message-ID: <20191021125307.GF2654@vkoul-mobl>
References: <1571393364-32697-1-git-send-email-tdas@codeaurora.org>
 <1571393364-32697-4-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571393364-32697-4-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 15:39, Taniya Das wrote:
> Add support for clock RPMh driver to vote for ARC and VRM managed
> clock resources.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 96a36f6..7301c77 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -391,6 +391,24 @@ static const struct clk_rpmh_desc clk_rpmh_sm8150 = {
>  	.num_clks = ARRAY_SIZE(sm8150_rpmh_clocks),
>  };
> 
> +static struct clk_hw *sc7180_rpmh_clocks[] = {
> +	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
> +	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
> +	[RPMH_LN_BB_CLK2]	= &sdm845_ln_bb_clk2.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &sdm845_ln_bb_clk2_ao.hw,
> +	[RPMH_LN_BB_CLK3]	= &sdm845_ln_bb_clk3.hw,
> +	[RPMH_LN_BB_CLK3_A]	= &sdm845_ln_bb_clk3_ao.hw,
> +	[RPMH_RF_CLK1]		= &sdm845_rf_clk1.hw,
> +	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
> +	[RPMH_RF_CLK2]		= &sdm845_rf_clk2.hw,
> +	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sc7180 = {
> +	.clks = sc7180_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sc7180_rpmh_clocks),
> +};
> +
>  static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>  					 void *data)
>  {
> @@ -471,6 +489,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>  static const struct of_device_id clk_rpmh_match_table[] = {
>  	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
>  	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
> +	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},

Is the table above not same as sm8150, if so cant we reuse that for
sc7180?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.

-- 
~Vinod
