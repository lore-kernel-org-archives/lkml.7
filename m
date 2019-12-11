Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA7BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72051208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576069151;
	bh=qiT+xSbAZvNk4JKVs9YsOP6T2z7d+7SiVART93y9REw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=InMmmWdTEP6I/qUI8nrjDkE8ZcjyTJ3SL5TscIJWnfyX9DJRvgw0WgPZiZbHTn/wC
	 3ySeNF8VAf6SsLzHTOyH7PHudlUPm0aZc8jo7brLYzURkawySnuZiYGqa2JcZraJDp
	 JrKe18+0w9T9B1hfFtTPyEU1M3fh6xgNbxfNH9eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfLKM7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:59:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfLKM7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:59:10 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D1062077B;
        Wed, 11 Dec 2019 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576069149;
        bh=qiT+xSbAZvNk4JKVs9YsOP6T2z7d+7SiVART93y9REw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+yblEiw4zA7nSQwN9zoBEaTpnJNvwnFK6kGbSNdGSSsUh47Z6aP9z+ZQZjXsg6CM
         lAxPzRkLxMn/X8mYoyzYL/49c+WFOcYc7EJnid7Ikamc5RGKMoUaRIlWuN2UdCZ11Q
         D0kzUxiU0RcwGQ/han+2LdHO2vbI5NekX2MZt9MQ=
Date:   Wed, 11 Dec 2019 20:58:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [RESEND v2 00/11] clk: imx: Trivial cleanups for clk_hw based API
Message-ID: <20191211112029.GY15858@dragon>
References: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:25:39AM +0200, Abel Vesa wrote:
> Shawn, just rebased on your clk/imx branch as requested.
> 
> Abel Vesa (11):
>   clk: imx: Add correct failure handling for clk based helpers
>   clk: imx: Rename the SCCG to SSCG
>   clk: imx: Replace all the clk based helpers with macros
>   clk: imx: pllv1: Switch to clk_hw based API
>   clk: imx: pllv2: Switch to clk_hw based API
>   clk: imx: imx7ulp composite: Rename to show is clk_hw based
>   clk: imx: Rename sccg and frac pll register to suggest clk_hw
>   clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw based
>   clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw based
>   clk: imx: Rename the imx_clk_divider_gate to imply it's clk_hw based
>   clk: imx7up: Rename the clks to hws

Applied all, thanks.
