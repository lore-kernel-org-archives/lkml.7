Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC74218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553159478;
	bh=28qAqVoFdBiu3V9bam+dmQS/oH4gOWAuy9KodkPpn9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UobT4BEDc3pCsCeW0gij9yWU14Xert+UI//mv3aYv3f+3Vnolpd8pp2L2h6SFxJrl
	 baSq7ZRKgOfeaJjZe1gYU4TWeA85n/7RyV6hz6y2oukJhPv2mF4J8I81zKPetuBkrw
	 Ji4tFwBJx2nnufuR4kdlX1xT4Q2JSbsDxVBjr44I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfCUJLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfCUJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:11:16 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A968F20850;
        Thu, 21 Mar 2019 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553159475;
        bh=28qAqVoFdBiu3V9bam+dmQS/oH4gOWAuy9KodkPpn9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vsq7RpkFJyT2Ik8keJi9osawTkLmwZYrZr608XjApAnaGUxtqL1ZRRNUiZJooms2P
         RHvzeSKTlKF0YuLYLvTXDa/2dmgQ5tO5s2G0BouvGgknl5RrbFDJxuUMmcrNijsw3m
         BhO0BOZ1W1VLHYTJ21at1Fn542g0cz1DoPYX6J3Q=
Date:   Thu, 21 Mar 2019 17:10:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Message-ID: <20190321091049.GH12513@dragon>
References: <20190313091757.16410-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313091757.16410-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:05:52AM +0000, Peng Fan wrote:
> "arch_initcall_sync(of_platform_default_populate_init);" could be

The code change looks good.  But can you please mention commit
44a7185c2ae6 ("of/platform: Add common method to populate default bus")
in the commit log, so that we will be more clear about the story.

Shawn

> used to populate the device tree, there is no need to call
> of_platform_default_populate in machine code.
> 
> Tested on i.MX6Q-SDB i.MX6SL-EVK i.MX6UL-EVK board.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c  | 2 --
>  arch/arm/mach-imx/mach-imx6sl.c | 2 --
>  arch/arm/mach-imx/mach-imx6sx.c | 2 --
>  arch/arm/mach-imx/mach-imx6ul.c | 1 -
>  4 files changed, 7 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 7d80a0ae723c..655398c20256 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -278,8 +278,6 @@ static void __init imx6q_init_machine(void)
>  
>  	imx6q_enet_phy_init();
>  
> -	of_platform_default_populate(NULL, NULL, parent);
> -
>  	imx_anatop_init();
>  	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
>  	imx6q_1588_init();
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 99be4225297a..9743bdbb68fa 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -56,8 +56,6 @@ static void __init imx6sl_init_machine(void)
>  	if (parent == NULL)
>  		pr_warn("failed to initialize soc device\n");
>  
> -	of_platform_default_populate(NULL, NULL, parent);
> -
>  	if (cpu_is_imx6sl())
>  		imx6sl_fec_init();
>  	imx_anatop_init();
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
> index 7f52d9b1e8a4..19b9f2dd309e 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -72,8 +72,6 @@ static void __init imx6sx_init_machine(void)
>  	if (parent == NULL)
>  		pr_warn("failed to initialize soc device\n");
>  
> -	of_platform_default_populate(NULL, NULL, parent);
> -
>  	imx6sx_enet_init();
>  	imx_anatop_init();
>  	imx6sx_pm_init();
> diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
> index 6cb8a22b617d..c57b9df791b1 100644
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -65,7 +65,6 @@ static void __init imx6ul_init_machine(void)
>  	if (parent == NULL)
>  		pr_warn("failed to initialize soc device\n");
>  
> -	of_platform_default_populate(NULL, NULL, parent);
>  	imx6ul_enet_init();
>  	imx_anatop_init();
>  	imx6ul_pm_init();
> -- 
> 2.16.4
> 
