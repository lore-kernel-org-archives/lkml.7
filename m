Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B056C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479DB214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575274804;
	bh=ugPnad4csUtS5gu9gvNWiYsom6nlpl/ToMIjVCWJbZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G9R2z0dSqAxV04twTp8ipSnhAVk5zmXkrcgxfnUywCiBXRl9PC3dLQVRtYm5WbRKB
	 oGRTzIPCah0yFCKV//VovdwdtGy+DxcyO5Xru5rK4M+uZrusAC2u6Exaqw0sNcVXc3
	 hpeFP4oRri4k9EgZ+KwXdiDk6veBwD+MFVPek56g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfLBIUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBIUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:20:03 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D7F20833;
        Mon,  2 Dec 2019 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575274802;
        bh=ugPnad4csUtS5gu9gvNWiYsom6nlpl/ToMIjVCWJbZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4VYe/+Oc3UZ1KYFtA1wTahHsh8T/DkBKOAjLV3QmxJ9AQZJD9FuVuoz0zBVP5cJd
         6WDmgdCr0jLI3LnyltUWtEHaHuXSyO4G91iqUGfsOATVp3kxz/wVXVVS13AVMy9U59
         VhUdzsyRQVt1jlLwjP9WO0TNt/hw0WpXKTJtvAd0=
Date:   Mon, 2 Dec 2019 16:19:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
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
Subject: Re: [PATCH] clk: imx: clk-composite-8m: add lock to gate/mux
Message-ID: <20191202081948.GD9767@dragon>
References: <1572603166-24594-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572603166-24594-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:16:19AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is a lock to diviver in the composite driver, but that's not

s/diviver/divider

> enought. lock to gate/mux are also needed to provide exclusive access

s/enought/enough

> to the register.
> 
> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Other than above typos,

Acked-by: Shawn Guo <shawnguo@kernel.org>

Stephen,

I assume you will take it a fix.  Otherwise, please let me know.

Shawn

> ---
>  drivers/clk/imx/clk-composite-8m.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index e0f25983e80f..20f7c91c03d2 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -142,6 +142,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>  	mux->reg = reg;
>  	mux->shift = PCG_PCS_SHIFT;
>  	mux->mask = PCG_PCS_MASK;
> +	mux->lock = &imx_ccm_lock;
>  
>  	div = kzalloc(sizeof(*div), GFP_KERNEL);
>  	if (!div)
> @@ -161,6 +162,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>  	gate_hw = &gate->hw;
>  	gate->reg = reg;
>  	gate->bit_idx = PCG_CGC_SHIFT;
> +	gate->lock = &imx_ccm_lock;
>  
>  	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
>  			mux_hw, &clk_mux_ops, div_hw,
> -- 
> 2.16.4
> 
