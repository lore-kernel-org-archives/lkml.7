Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75242C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D66C2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhZZN4Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfFPJRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 05:17:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39125 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfFPJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 05:17:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so4082724pgc.6;
        Sun, 16 Jun 2019 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WsOS9W6MkxWVUF6PRCv1rpiLrmIxWx7oq/nfwUHXQV4=;
        b=bhZZN4ZoB10Na0Ic8RGp22L9+faJUjyGlbtTqC3QZGcBGJuewiHIW8tipif4QS7JJa
         1nrwmgqclU0DIUK1lkjTTcUGhz54dyjqnkBu47eV2Gqxs1j6CHp1U+YLu4EAfw/CAjF1
         N4Mx0ailxADXlnEYbdKSlfJzz1zls4lLkPIdBQJTSClQ4r1iGVc+xfs0MQuBRfpvwO9k
         gu8vFQfMyie1SGDmstzys5iH9BtPM5Bh+9RYlpG24Inaj/skYMoNRLkXj6mCNXw8w51x
         eAcug1S/tqUfOOwe3BZd+VoHBqNwLp+FIOwyB1hK2SzoGYVonIeSrUcHAXxJsyxiRCAl
         RVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WsOS9W6MkxWVUF6PRCv1rpiLrmIxWx7oq/nfwUHXQV4=;
        b=r0wHhR7IUf16BBFIQId+KVyXk2s0SlofaFLGzUAxTsHBuZkPywBmcq8vHZrp2nPJJA
         ASwm2KdcMCmUzqEVGgjst1Ifhefl8y9tKnQy68v8EmdY1R/Wdp0hQ7/yZsLO7tfae9Rx
         54Od+K3ogTdn3F/odA8dTkF08MF55HD2hf2YIl7RDsxlGQjvsInXdsQ23StfjPK6RUJn
         Vez39PYd9F7vR32W6JCSL2okrNZjtufm4FUhyCW2GgkXi2tiE6QFMyUc63ko/1LJfwmS
         bD8E4hke9KIONPmDngMUQgaT0L7Pf/PcXpfY3h1QphUI4kuCUxeyrUVPWShYF/UQRfDI
         NlSw==
X-Gm-Message-State: APjAAAWxBOfoV4gFWnw5U6xmzfGOiPQFPQT/MjlPurW6fJZdS/DDN1y8
        Gw/3KqglaNHCRBz+s3Tm52o3h/dkdiE=
X-Google-Smtp-Source: APXvYqzC4p9c3ZsPQStMlz2hbBAY7Gw8pOpqyBR6LQ5uQv6ZdwfBVqV2rU83/Y0doH7WTm6gXf728g==
X-Received: by 2002:a65:56c5:: with SMTP id w5mr43407043pgs.434.1560676649025;
        Sun, 16 Jun 2019 02:17:29 -0700 (PDT)
Received: from localhost (g30.211-19-85.ppp.wakwak.ne.jp. [211.19.85.30])
        by smtp.gmail.com with ESMTPSA id q144sm10986713pfc.103.2019.06.16.02.17.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 02:17:28 -0700 (PDT)
Date:   Sun, 16 Jun 2019 18:17:24 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Helge Deller <deller@gmx.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] openrisc: remove the partial DMA_ATTR_NON_CONSISTENT
 support
Message-ID: <20190616091724.GL2358@lianli.shorne-pla.net>
References: <20190614144431.21760-1-hch@lst.de>
 <20190614144431.21760-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614144431.21760-4-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:44:27PM +0200, Christoph Hellwig wrote:
> The openrisc DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but
> does not provide a cache_sync operation.  This means any user of it
> will never be able to actually transfer cache ownership and thus cause
> coherency bugs.

The below looks good.  I am always happy to what looks like legacy copy & paste
cruft.

Acked-by: Stafford Horne <shorne@gmail.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/openrisc/kernel/dma.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index f79457cb3741..9f25fd0fbb5d 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -98,15 +98,13 @@ arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  
>  	va = (unsigned long)page;
>  
> -	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
> -		/*
> -		 * We need to iterate through the pages, clearing the dcache for
> -		 * them and setting the cache-inhibit bit.
> -		 */
> -		if (walk_page_range(va, va + size, &walk)) {
> -			free_pages_exact(page, size);
> -			return NULL;
> -		}
> +	/*
> +	 * We need to iterate through the pages, clearing the dcache for
> +	 * them and setting the cache-inhibit bit.
> +	 */
> +	if (walk_page_range(va, va + size, &walk)) {
> +		free_pages_exact(page, size);
> +		return NULL;
>  	}
>  
>  	return (void *)va;
> @@ -122,10 +120,8 @@ arch_dma_free(struct device *dev, size_t size, void *vaddr,
>  		.mm = &init_mm
>  	};
>  
> -	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
> -		/* walk_page_range shouldn't be able to fail here */
> -		WARN_ON(walk_page_range(va, va + size, &walk));
> -	}
> +	/* walk_page_range shouldn't be able to fail here */
> +	WARN_ON(walk_page_range(va, va + size, &walk));
>  
>  	free_pages_exact(vaddr, size);
>  }
> -- 
> 2.20.1
> 
