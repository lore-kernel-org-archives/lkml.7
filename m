Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAFFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4CF21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="lnngHubg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfDELS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:18:57 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:33073 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfDELS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=Kofxb1wt5zrj3v80/zxQ1m5JRDpt+XxmK2Tb3N01jYY=;
        b=lnngHubgvSZmSK198Kod1WanWJxIa+tIPw5P6/j91Zw8/lLqNgYLYXvDlo2l60wt43uAhoUgrCqIZxTzxPteU8GpWjHG2AGME8dHiqvq8tygwBha5s58kJH0jWmvAgBsDK9vytip8xoZLcVhmDg/znj61J3IMnuIhxQX3dYxB0AtUxkHnwkTa0V+/EwdmCRPTuwjyQF1OzFvbbcXMOoldbsIDW40DsGaf57ZPbSnadqWIjb3ZN7xDDsRpQ4QYS74YHSoeHpqeLSmzfnse2C0YuiNrINm7oZBqm/TfMyOM5LQ6DThdaCwApuv93FEqw9ELOQBhRoWfzpthiBNykfFWQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:59045 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hCMs2-0002g3-RX; Fri, 05 Apr 2019 13:18:54 +0200
Subject: Re: [PATCH] drm: aspeed: Select CMA only if available
To:     Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20190405052830.27899-1-joel@jms.id.au>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <aae72ebf-2c9c-8cc4-4598-e8bb896b9a24@tronnes.org>
Date:   Fri, 5 Apr 2019 13:18:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405052830.27899-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 05.04.2019 07.28, skrev Joel Stanley:
> When building this driver for architectures where CMA is not available.
> 
> Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> This fixes the build break.
> 
> Another question is if we need to select this at all, as we have a
> reserved memory region to allocate from. I am not familiar with this
> area, so advice is welcome.
> 
>  drivers/gpu/drm/aspeed/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
> index 42b74d18a41b..1775fb85ec74 100644
> --- a/drivers/gpu/drm/aspeed/Kconfig
> +++ b/drivers/gpu/drm/aspeed/Kconfig
> @@ -4,8 +4,8 @@ config DRM_ASPEED_GFX
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_PANEL
> -	select DMA_CMA
> -	select CMA
> +	select DMA_CMA if HAVE_DMA_CONTIGUOUS
> +	select CMA if HAVE_DMA_CONTIGUOUS

I'm no expert on this, but the rule is that you should not select
options that are user visible which both of these are. The user should
select them. So I believe that you should remove them.

Docs: Documentation/kbuild/kconfig-language.txt

Noralf.

>  	select MFD_SYSCON
>  	help
>  	  Chose this option if you have an ASPEED AST2500 SOC Display
> 
