Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD08EC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930FB214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575249470;
	bh=r++ufhdV5NVlSi05PmMJPmTLWPGMRkuNwvrCIPM7vWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o3VIEIyBqHg6KcUoBhPAz3++oH6eudwIubRtavsD+/tDO8FRVWXuebGTMz+0p4NXC
	 gWXvMuD87zqWZ5cbiE/elb8b1cl70mhAfB6vnOY4p78wocYyLLNwQ8imf9ICx8Ye4M
	 eBZ2hEKnuYyS4G/pXZg8gZ/Wh46OR7g9fPfJ8Ejk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLBBRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 20:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfLBBRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 20:17:48 -0500
Received: from dragon (li2093-158.members.linode.com [172.105.159.158])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F972146E;
        Mon,  2 Dec 2019 01:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575249467;
        bh=r++ufhdV5NVlSi05PmMJPmTLWPGMRkuNwvrCIPM7vWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBh24tZKD/7zjoNqX/NGFOhKLsn/+CaaH6xJ3LPngO06Ux87Flqd/FQZcn/gD86TC
         PXD0O7Ra/Us4zbtu5wLWVxbed0ogucnybU2uYKmfnrm2+MhEXa2aLS8IBync2gsJdP
         Jo+cRbi2jWVEXggGXxMViRUsGUUwX3ebLPAmux4k=
Date:   Mon, 2 Dec 2019 09:17:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Message-ID: <20191202011721.GA17574@dragon>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
 <1572356175-24950-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572356175-24950-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:40:54PM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Switch the imx_clk_pll14xx function to clk_hw based API, rename
> accordingly and add a macro for clk based legacy. This allows us to
> move closer to a clear split between consumer and provider clk APIs.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-pll14xx.c | 22 +++++++++++++---------
>  drivers/clk/imx/clk.h         |  8 ++++++--
>  2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 5c458199060a..fa76e04251c4 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -369,13 +369,14 @@ static const struct clk_ops clk_pll1443x_ops = {
>  	.set_rate	= clk_pll1443x_set_rate,
>  };
>  
> -struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
> -			    void __iomem *base,
> -			    const struct imx_pll14xx_clk *pll_clk)
> +struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
> +				  void __iomem *base,
> +				  const struct imx_pll14xx_clk *pll_clk)
>  {
>  	struct clk_pll14xx *pll;
> -	struct clk *clk;
> +	struct clk_hw *hw;
>  	struct clk_init_data init;
> +	int ret;
>  	u32 val;
>  
>  	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> @@ -412,12 +413,15 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
>  	val &= ~BYPASS_MASK;
>  	writel_relaxed(val, pll->base + GNRL_CTL);
>  
> -	clk = clk_register(NULL, &pll->hw);
> -	if (IS_ERR(clk)) {
> -		pr_err("%s: failed to register pll %s %lu\n",
> -			__func__, name, PTR_ERR(clk));
> +	hw = &pll->hw;
> +
> +	ret = clk_hw_register(NULL, hw);
> +	if (ret) {
> +		pr_err("%s: failed to register pll %s %d\n",
> +			__func__, name, ret);
>  		kfree(pll);
> +		return ERR_PTR(ret);
>  	}
>  
> -	return clk;
> +	return hw;
>  }
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index bc5bb6ac8636..5038622f1a72 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -97,8 +97,12 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
>  #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \
>  	imx_clk_hw_mux(name, reg, shift, width, parents, num_parents)->clk
>  
> -struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
> -		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
> +#define imx_clk_pll14xx(name, parent_name, base, pll_clk) \
> +	imx_clk_hw_pll14xx(name, parent_name, base, pll_clk)->clk
> +

I would suggest to use an inline function for this, which will be more
readable and complying to kernel coding style.

Shawn

> +struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
> +				  void __iomem *base,
> +				  const struct imx_pll14xx_clk *pll_clk);
>  
>  struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
>  		const char *parent, void __iomem *base);
> -- 
> 2.16.4
> 
