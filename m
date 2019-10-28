Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C28CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF7220659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WHVplwL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfJ1O16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:27:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9916 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJ1O15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:27:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db6faf20003>; Mon, 28 Oct 2019 07:28:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Oct 2019 07:27:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 28 Oct 2019 07:27:57 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 14:27:56 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 28 Oct 2019 14:27:56 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id F352D42C6C; Mon, 28 Oct 2019 16:27:53 +0200 (EET)
Date:   Mon, 28 Oct 2019 16:27:53 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Prashant Gaikwad" <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] clk: tegra: divider: Add missing check for
 enable-bit on rate's recalculation
Message-ID: <20191028142753.GC27141@pdeschrijver-desktop.Nvidia.com>
References: <20190723025245.27754-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190723025245.27754-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572272882; bh=Mhj1wiVJEDOxWkpi52krED0OLh0170NOhW7y0wpgFsw=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=WHVplwL/GMMzf/na6Bvwo0v0+JgbD2dh9H+LllDesfjqN4EteMwr78RimXvb3zjtx
         IEgSBjCYy1lYxVAVteR2yiSj3hDzte4yZwLClVvCbXs+OelGQQU9Ef1ZOp/eaCEXua
         HE5m5W2MGU2FYXGOKVRlwJ3fTnD645wLV0q8p3EFpKwy4sJpThzeGdU5d7S0NlHGWM
         TNyTQ8BZF9LRxxgbu35T2vmIL3OYdBj0XIDf8WiHg5x6HtGjEGrauJ+RGbbT0lPnVB
         3kjZBOgGZzE5alwY82cAt5+aOn0xjlBjP00aJ6YPj2xz1O+XhQ2p3TzO7nIPkj+phM
         sG1OnMeOOAWiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 05:52:44AM +0300, Dmitry Osipenko wrote:
> Unset "enable" bit means that divider is in bypass mode, hence it doesn't
> have any effect in that case. Please note that there are no known bugs
> caused by the missing check.
> 

Technically this is not quite true, but for the purposes of CCF you can
treat it that way. This bits defines if the value in the lower 16 bits
of the divider register is used to configure the divider or if the
contents of the UART DLM/DLL registers is used. So the divider isn't
actually bypassed, it's just configured differently.
In practice this bit is only set when the divider is non-zero when doing
set rate. So the extra test isn't strictly needed as long as the sw
running before the kernel also ensures the bit is only set when the
divider is non-zero.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: Changed the commit's description from 'Fix' to 'Add' in response to the
>     Stephen's Boyd question about the need to backport the patch into stable
>     kernels. The backporting is not really needed.
> 
>  drivers/clk/tegra/clk-divider.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> index e76731fb7d69..f33c19045386 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -40,8 +40,13 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
>  	int div, mul;
>  	u64 rate = parent_rate;
>  
> -	reg = readl_relaxed(divider->reg) >> divider->shift;
> -	div = reg & div_mask(divider);
> +	reg = readl_relaxed(divider->reg);
> +
> +	if ((divider->flags & TEGRA_DIVIDER_UART) &&
> +	    !(reg & PERIPH_CLK_UART_DIV_ENB))
> +		return rate;
> +
> +	div = (reg >> divider->shift) & div_mask(divider);
>  
>  	mul = get_mul(divider);
>  	div += mul;
> -- 
> 2.22.0
> 
