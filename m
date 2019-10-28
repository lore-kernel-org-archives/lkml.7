Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A7BCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CCB21744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bvQwmEjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbfJ1OmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:42:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15113 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbfJ1OmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:42:02 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db6fe400000>; Mon, 28 Oct 2019 07:42:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 28 Oct 2019 07:42:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 28 Oct 2019 07:42:00 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 14:42:00 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 28 Oct 2019 14:41:59 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 7902243032; Mon, 28 Oct 2019 16:41:57 +0200 (EET)
Date:   Mon, 28 Oct 2019 16:41:57 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Prashant Gaikwad" <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clk: tegra: divider: Support enable-bit for Super
 clocks
Message-ID: <20191028144157.GD27141@pdeschrijver-desktop.Nvidia.com>
References: <20190723025245.27754-1-digetx@gmail.com>
 <20190723025245.27754-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190723025245.27754-2-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572273728; bh=06nnWkX/y2hBb/UJENOgGV/3SZIw81i3749bZO7gUGg=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=bvQwmEjcBJGTgHHPkQCfdBxKvgc4KtOOSQ6K6A6J2mBqC5wA7qZOIvgQW4reP1rlp
         5G9pBGCEBL1hWz6kV0Z/j1b1gpFEQ5MSXXgQvJ7nCk8u/siM6GE/4Mb0t8s5Z9ET2e
         9mB2MP991+31ePo9SdJ5XS2T86thlnvT0QE8JK/S1jVFB+FpGbYdh1VAaxXMe2lMuv
         1fZ+cL/Zyg6/u9sxgGa81R/ooiXhk7XrVOuw8MfCaB4zK9Rr5WroXSeF3zo9aqGeOs
         KiHwf+QGSN8n6AhYyZea4T7Qexqof4E5C37NMdMqtTl7/ffEUFYQycnUr+bnFDdfnh
         AflViycU0wQLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 05:52:45AM +0300, Dmitry Osipenko wrote:
> All Super clocks have a divider that has the enable bit.
> 

This is broken to begin with. The only clock of this type in upstream is SCLK
I think. However, this clock is not a normal divider, it's a skipper, so
the normal divider logic doesn't work for it. In practice this clock is
only used when scaling SCLK, which is not (yet) done in the upstream
kernel due to the complex DVFS relationship between sclk, hclk and pclk.
A driver for it can be found here:
https://nv-tegra.nvidia.com/gitweb/?p=linux-4.9.git;a=blob;f=drivers/clk/tegra/clk-skipper.c;h=f5da4f6ca44fe194c87f66be70c708e9791db74d;hb=eb8dd21affa2be45fc29be8c082194ac4032393a
As you can see in that tree, we eventually splitted sclk into three
clocks:

sclk_mux (controls SCLK_BURST_POLICY register)
sclk (controls SOURCE_SYS register which is like a normal peripheral
clock but without the mux)
sclk_skipper (controls SCLK_DIVIDER)

Peter.


> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: Improved commit's message.
> 
>  drivers/clk/tegra/clk-divider.c | 12 ++++++++++++
>  drivers/clk/tegra/clk-super.c   |  1 +
>  drivers/clk/tegra/clk.h         |  4 ++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> index f33c19045386..a980b9bddecd 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -17,6 +17,7 @@
>  #define get_max_div(d) div_mask(d)
>  
>  #define PERIPH_CLK_UART_DIV_ENB BIT(24)
> +#define SUPER_CLK_DIV_ENB BIT(31)
>  
>  static int get_div(struct tegra_clk_frac_div *divider, unsigned long rate,
>  		   unsigned long parent_rate)
> @@ -46,6 +47,10 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
>  	    !(reg & PERIPH_CLK_UART_DIV_ENB))
>  		return rate;
>  
> +	if ((divider->flags & TEGRA_DIVIDER_SUPER) &&
> +	    !(reg & SUPER_CLK_DIV_ENB))
> +		return rate;
> +
>  	div = (reg >> divider->shift) & div_mask(divider);
>  
>  	mul = get_mul(divider);
> @@ -96,6 +101,13 @@ static int clk_frac_div_set_rate(struct clk_hw *hw, unsigned long rate,
>  	val &= ~(div_mask(divider) << divider->shift);
>  	val |= div << divider->shift;
>  
> +	if (divider->flags & TEGRA_DIVIDER_SUPER) {
> +		if (div)
> +			val |= SUPER_CLK_DIV_ENB;
> +		else
> +			val &= ~SUPER_CLK_DIV_ENB;
> +	}
> +
>  	if (divider->flags & TEGRA_DIVIDER_UART) {
>  		if (div)
>  			val |= PERIPH_CLK_UART_DIV_ENB;
> diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
> index 39ef31b46df5..4d8e36b04f03 100644
> --- a/drivers/clk/tegra/clk-super.c
> +++ b/drivers/clk/tegra/clk-super.c
> @@ -220,6 +220,7 @@ struct clk *tegra_clk_register_super_clk(const char *name,
>  	super->frac_div.width = 8;
>  	super->frac_div.frac_width = 1;
>  	super->frac_div.lock = lock;
> +	super->frac_div.flags = TEGRA_DIVIDER_SUPER;
>  	super->div_ops = &tegra_clk_frac_div_ops;
>  
>  	/* Data in .init is copied by clk_register(), so stack variable OK */
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 905bf1096558..a4fbf55930aa 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -53,6 +53,9 @@ struct clk *tegra_clk_register_sync_source(const char *name,
>   * TEGRA_DIVIDER_UART - UART module divider has additional enable bit which is
>   *      set when divider value is not 0. This flags indicates that the divider
>   *      is for UART module.
> + * TEGRA_DIVIDER_SUPER - Super clock divider has additional enable bit which
> + *      is set when divider value is not 0. This flags indicates that the
> + *      divider is for super clock.
>   */
>  struct tegra_clk_frac_div {
>  	struct clk_hw	hw;
> @@ -70,6 +73,7 @@ struct tegra_clk_frac_div {
>  #define TEGRA_DIVIDER_FIXED BIT(1)
>  #define TEGRA_DIVIDER_INT BIT(2)
>  #define TEGRA_DIVIDER_UART BIT(3)
> +#define TEGRA_DIVIDER_SUPER BIT(4)
>  
>  extern const struct clk_ops tegra_clk_frac_div_ops;
>  struct clk *tegra_clk_register_divider(const char *name,
> -- 
> 2.22.0
> 
