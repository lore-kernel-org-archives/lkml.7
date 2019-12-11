Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF56C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EE42077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576032267;
	bh=8qaUnn5f1bStSxxUCek0D44SmTQ2zG8abc6aCt9cWFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lX1tZXa9oejtr5sO3zoD3o6vUZDH1sb+ZqrZ+xnUh6LZsO2HW61KUJZpuAzEhb3A1
	 teJKnXVb1r5bocYWJa9WsD4yT83ozr3Sm1/GDbyeSnr9lKCVzu5xYkuI7r/jBABjzp
	 2UdAvOI8GjAv97ivW/UBhW/lyCx3XxHNZf8LPyGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfLKCo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLKCoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:44:25 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECCE3205ED;
        Wed, 11 Dec 2019 02:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576032265;
        bh=8qaUnn5f1bStSxxUCek0D44SmTQ2zG8abc6aCt9cWFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9QafYOPVucohpc7g/4HFb+IQqTOr81zM6xoIsZZswbzpERCi7ycKiWoD1z50dig/
         kIFZOOodyicPyV2SBACli5JO0irzQdO6ew5wxYEZtowAeEcz1CDH0ohQDmdFHTNISs
         RaqQbCyhxcAcKtA7ZNEe0+9EnmGU0+BJYdfruHEA=
Date:   Wed, 11 Dec 2019 10:44:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, arnd@arndb.de,
        aisheng.dong@nxp.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D
Message-ID: <20191211024413.GF15858@dragon>
References: <1575358720-27624-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575358720-27624-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 03:38:40PM +0800, Anson Huang wrote:
> i.MX6UL and i.MX7D have Cortex-A7 inside, need to enable ARM_ERRATA_814220
> for proper workaround.

Can we briefly describe the ARM_ERRATA_814220 in the commit log?

Shawn

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 593bf15..4326c8f 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -520,6 +520,7 @@ config SOC_IMX6UL
>  	bool "i.MX6 UltraLite support"
>  	select PINCTRL_IMX6UL
>  	select SOC_IMX6
> +	select ARM_ERRATA_814220
>  
>  	help
>  	  This enables support for Freescale i.MX6 UltraLite processor.
> @@ -556,6 +557,7 @@ config SOC_IMX7D
>  	select PINCTRL_IMX7D
>  	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
>  	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
> +	select ARM_ERRATA_814220
>  	help
>  		This enables support for Freescale i.MX7 Dual processor.
>  
> -- 
> 2.7.4
> 
