Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C60BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50916213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NwYmYqiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGAKrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49072 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfGAKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x61AktDf015680;
        Mon, 1 Jul 2019 05:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561978015;
        bh=xkl2YSQgyzqKuqbU89N6vJgSH9uVy5rur2a274LLpx8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NwYmYqiH3UgHKJrXq/7XQnNew6YC+zoaqBdgWzE1BIesddbvTKMp7Gc9uxzEOtfx3
         cTDmboPaQf6L6xXhEVEIDuNr3X2GB3oy0Cn6okCurZj5oRn9CJtXIZ7W8fUmbQ9Olc
         O7jdhIMbKfFxkUg2zuDQ4dWstSyQjW0whzxaqTKs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x61AktWn101270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jul 2019 05:46:55 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Jul
 2019 05:46:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Jul 2019 05:46:54 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x61Akp51022662;
        Mon, 1 Jul 2019 05:46:52 -0500
Subject: Re: [PATCH] soc: ti: fix irq-ti-sci link error
To:     Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190617130149.1782930-1-arnd@arndb.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <2974ac02-287a-ab46-6716-2b768cca47c3@ti.com>
Date:   Mon, 1 Jul 2019 16:16:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617130149.1782930-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/06/19 6:31 PM, Arnd Bergmann wrote:
> The irqchip driver depends on the SoC specific driver, but we want
> to be able to compile-test it elsewhere:
> 
> WARNING: unmet direct dependencies detected for TI_SCI_INTA_MSI_DOMAIN
>   Depends on [n]: SOC_TI [=n]
>   Selected by [y]:
>   - TI_SCI_INTA_IRQCHIP [=y] && TI_SCI_PROTOCOL [=y]
> 
> drivers/irqchip/irq-ti-sci-inta.o: In function `ti_sci_inta_irq_domain_probe':
> irq-ti-sci-inta.c:(.text+0x204): undefined reference to `ti_sci_inta_msi_create_irq_domain'
> 
> Rearrange the Kconfig and Makefile so we build the soc driver whenever
> its users are there, regardless of the SOC_TI option.
> 
> Fixes: 49b323157bf1 ("soc: ti: Add MSI domain bus support for Interrupt Aggregator")
> Fixes: f011df6179bd ("irqchip/ti-sci-inta: Add msi domain support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks like this is a side effect of the patch  a6b112b04355b ("arm64: arch_k3:
Fix kconfig dependency warning"). $Patch looks good to me.

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> ---
>  drivers/soc/Makefile   | 2 +-
>  drivers/soc/ti/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 524ecdc2a9bb..2ec355003524 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -22,7 +22,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>  obj-y				+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
> -obj-$(CONFIG_SOC_TI)		+= ti/
> +obj-y				+= ti/
>  obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
>  obj-y				+= xilinx/
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index ea0859f7b185..d7d50d48d05d 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -75,10 +75,10 @@ config TI_SCI_PM_DOMAINS
>  	  called ti_sci_pm_domains. Note this is needed early in boot before
>  	  rootfs may be available.
>  
> +endif # SOC_TI
> +
>  config TI_SCI_INTA_MSI_DOMAIN
>  	bool
>  	select GENERIC_MSI_IRQ_DOMAIN
>  	help
>  	  Driver to enable Interrupt Aggregator specific MSI Domain.
> -
> -endif # SOC_TI
> 
