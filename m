Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14D3214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JP3ldUWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfCLJ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:28:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34824 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCLJ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:28:49 -0400
Received: from zn.tnic (unknown [IPv6:2003:ec:2f09:5700:f135:3193:b053:76cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26F441EC0324;
        Tue, 12 Mar 2019 10:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1552382927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wasXZt4wz3g1Y1fQFWK6MO5JGxZ4OlHYf5kdyysXjP8=;
        b=JP3ldUWLZ61kYQrbC9bwtEDx1z55mSvPaGCZbLMUtAdGp6M82xFgHpcBSKAup4V9ilp5oZ
        g96j949yzmz5VWaVM8IShhAzme65Oqn9RE9NSQbiRNMNl9YlcpOGXyf4Kc/bWbs1lrC+7g
        GB1nhyyFqzymRk6Li8eabNPr6TDE7uk=
Date:   Tue, 12 Mar 2019 10:28:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] sifive: edac: Add EDAC driver for Sifive l2 Cache
 Controller
Message-ID: <20190312092842.GC28589@zn.tnic>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1552382461-13051-3-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:51:01PM +0530, Yash Shah wrote:
> Add driver for the SiFive L2 cache controller
> on the HiFive Unleashed board
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/Kconfig            |   1 +
>  drivers/edac/Kconfig          |   7 +
>  drivers/edac/Makefile         |   1 +
>  drivers/edac/sifive_edac-l2.c | 292 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 drivers/edac/sifive_edac-l2.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 515fc3c..fede4b6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -49,6 +49,7 @@ config RISCV
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select ARCH_HAS_PTE_SPECIAL
> +	select EDAC_SUPPORT
>  
>  config MMU
>  	def_bool y
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index e286b5b..63ccdf1 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -440,6 +440,13 @@ config EDAC_ALTERA_SDMMC
>  	  Support for error detection and correction on the
>  	  Altera SDMMC FIFO Memory for Altera SoCs.
>  
> +config EDAC_SIFIVE_L2
> +	tristate "Sifive L2 Cache"
> +	depends on RISCV
> +	help
> +	  Support for error detection and correction on the SiFive L2
> +	  cache controller.

Please no EDAC drivers for a single functional unit with RAS
capabilities. Rather, a sifive_edac or riscv_edac driver which covers
the whole platform or even architecture and contains support for all the
RAS functionality there. See altera_edac, for example.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
