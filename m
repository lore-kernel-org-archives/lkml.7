Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6792CC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BAD216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558937314;
	bh=whtFdsckGzCPEkaQlXnqUsZh6c2LH490Sb3G6lofpws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JKpsJ2Q7kDSKxvi0XA50rzuCBoaD7sPJrc19Mpg+/h1w/bkGcekQfodsILohVyeLY
	 oYuhk0eCZzMNm9Trp7quWS5dmN+Mz3nk8IKOkpPed825c5lD4J+jBEceVAJbljnpYR
	 gpOhcNkxxZiy4NLKaV7o3W5LKJANeHE9L8ifT+Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfE0GId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfE0GIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:08:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B6E2075E;
        Mon, 27 May 2019 06:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558937311;
        bh=whtFdsckGzCPEkaQlXnqUsZh6c2LH490Sb3G6lofpws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x743Qp7sU13eieitAhmmIsWD1+3gSc4TduX14oZisxlV6Aa6RK8T/hJiS3VxrZ9QR
         P1PmSH9O01f82B/AttB8RnGoXzbufqHoiuc8X5S9MWfkuvrG3TZDgIvOnjF0FpJWv+
         yvbZ3EfZSeVuFlpF5YhQ1j3Qju0TffhuRqMRuRtQ=
Date:   Mon, 27 May 2019 08:08:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Subject: Re: [PATCH v3 2/2] arm64: cacheinfo: Update cache_line_size detected
 from DT or PPTT
Message-ID: <20190527060829.GA8106@kroah.com>
References: <1558922768-29155-1-git-send-email-zhangshaokun@hisilicon.com>
 <1558922768-29155-2-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558922768-29155-2-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 10:06:08AM +0800, Shaokun Zhang wrote:
> cache_line_size is derived from CTR_EL0.CWG field and is called mostly
> for I/O device drivers. For HiSilicon certain plantform, like the
> Kunpeng920 server SoC, cache line sizes are different between L1/2
> cache and L3 cache while L1 cache line size is 64-byte and L3 is 128-byte,
> but CTR_EL0.CWG is misreporting using L1 cache line size.
> 
> We shall correct the right value which is important for I/O performance.
> Let's update the cache line size if it is detected from DT or PPTT
> information.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
> Reported-by: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  arch/arm64/include/asm/cache.h |  6 +-----
>  arch/arm64/kernel/cacheinfo.c  | 11 +++++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index 926434f413fa..758af6340314 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -91,11 +91,7 @@ static inline u32 cache_type_cwg(void)
>  
>  #define __read_mostly __attribute__((__section__(".data..read_mostly")))
>  
> -static inline int cache_line_size(void)
> -{
> -	u32 cwg = cache_type_cwg();
> -	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
> -}
> +int cache_line_size(void);
>  
>  /*
>   * Read the effective value of CTR_EL0.
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index 0bf0a835122f..3d54b0024246 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -28,6 +28,17 @@
>  #define CLIDR_CTYPE(clidr, level)	\
>  	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
>  
> +int cache_line_size(void)
> +{
> +	u32 cwg = cache_type_cwg();
> +
> +	if (coherency_max_size != 0)
> +		return coherency_max_size;

Ah, you use it here.

> +
> +	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;

Shouldn't you set the variable if it is 0 here as well?

> +}
> +EXPORT_SYMBOL(cache_line_size);

EXPORT_SYMBOL_GPL()?

thanks,

greg k-h
