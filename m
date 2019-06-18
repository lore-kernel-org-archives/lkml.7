Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9A5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190B32084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560865444;
	bh=jpwi1yqOwmzINvYa264hjoNAwgtlAPkdvF2LHsGZuSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DJXQvAQvXH5KrC1qL4VT7Zxhr3++8t5CWyRcUBEaDK11TaN+IuCZ/HB33FTOq/Nyj
	 lBd8OMx+MAJ+mc+hlZQIaDvlY3UF7Os4JS27jVNcaSNG67t1sqQ4TK9fLhvoZQ0O8T
	 zMvQdm8bDgvVOoQWW46BcHzB7AQG7N+SOxZ7qZ2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfFRNoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFRNoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:44:01 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B70A2084B;
        Tue, 18 Jun 2019 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560865441;
        bh=jpwi1yqOwmzINvYa264hjoNAwgtlAPkdvF2LHsGZuSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlTPHTxwnt6PhDNTjiSnVbxHAQANydojYv4DrMm3pkhiAXugUYFIMnhX+G7B2B7Wx
         IG8xYOWcz/LHNiHMjHJYNcz/eV7MO8/42BaSqdopxg+ZmAT3HztnggMQ4JswjFOzPp
         YkXA7B1KnSAyciFqCVVrG3o61qq6FrwjrNCZv4R8=
Date:   Tue, 18 Jun 2019 21:42:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] clk: imx6q: Annotate imx6q_obtain_fixed_clk_hw with
 __init
Message-ID: <20190618134253.GK1959@dragon>
References: <20190618022405.27952-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618022405.27952-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 07:24:05PM -0700, Nathan Chancellor wrote:
> When building with clang, the following modpost warning occurs:
> 
> WARNING: vmlinux.o(.text+0x974dbc): Section mismatch in reference from
> the function imx6q_obtain_fixed_clk_hw() to the function
> .init.text:imx_obtain_fixed_clock_hw()
> The function imx6q_obtain_fixed_clk_hw() references
> the function __init imx_obtain_fixed_clock_hw().
> This is often because imx6q_obtain_fixed_clk_hw lacks a __init
> annotation or the annotation of imx_obtain_fixed_clock_hw is wrong.
> 
> imx6q_obtain_fixed_clk_hw is only used in imx6q_clocks_init, which is
> marked __init so do that to imx6q_obtain_fixed_clk_hw to avoid this
> warning.
> 
> Fixes: 992b703b5b38 ("clk: imx6q: Switch to clk_hw based API")
> Link: https://github.com/ClangBuiltLinux/linux/issues/541
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch, Nathan.  But we already queued up a patch [1]
from Arnd for that.

Shawn

[1] https://lkml.org/lkml/2019/6/17/317

> ---
>  drivers/clk/imx/clk-imx6q.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index 2caa71e91119..18914e0a1850 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -418,8 +418,9 @@ static void disable_anatop_clocks(void __iomem *anatop_base)
>  	writel_relaxed(reg, anatop_base + CCM_ANALOG_PLL_VIDEO);
>  }
>  
> -static struct clk_hw *imx6q_obtain_fixed_clk_hw(struct device_node *np,
> -						const char *name, unsigned long rate)
> +static struct clk_hw __init *imx6q_obtain_fixed_clk_hw(struct device_node *np,
> +							const char *name,
> +							unsigned long rate)
>  {
>  	struct clk *clk = of_clk_get_by_name(np, name);
>  	struct clk_hw *hw;
> -- 
> 2.22.0
> 
