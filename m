Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27790C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D1320651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F9uV7Mji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfGJOqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:46:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37622 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfGJOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:46:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so2077487qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZOo+HIvtnGeDjn4M9ja4kY1nWK9vaSMpBmDscZRAu/o=;
        b=F9uV7MjikC39N7Z+mGrSWIh/WJjoQEa3TFGorbASmstt1fOczlcFWWfpxmOSVWfZ85
         JD/XNAVlipIovCqNDZFwtuP91XvcG1HtnmePpr3s2PFcIfs+iJFuO384oIJDXARkfWgs
         5Gs5ansx5gY9m1G5yUl14dSjku2aqKWfuLsQ1xCpKPXYhHz9s9u0MWfs0itlqK022TPz
         X/zhUNL3Khr9V7qMBqwFR+XIr2X1/0jHM5u4YjKMmxNnbbVeVhFKjJeZYmcM7josFQ8L
         Ys5wq33297sygc5sQYerkz4uAJ8k5rX5hwkwPQimxPEqvM0XHfGWqNzMtryvMXrZzTlg
         6odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOo+HIvtnGeDjn4M9ja4kY1nWK9vaSMpBmDscZRAu/o=;
        b=lbbzbJcV8Y1beVSJVIHN9MYoKMeFNVQE+Whe4RtLGd59Ei4g9CRP7HC4MghleFEvvA
         41+onh6yqyt9gnwI9Ct8xoVhOmJ1/my4CoW9HnNEec4p1eem8+a13k7+SfuDvYjCFKsP
         tHoXoReZnZdF1+21WNAV4d8YqcshSjQQgiO0PEJuHfgCUxeLZNySmnXhfzW+BTo8l2DG
         ZaH3tnTDAbc04N6R7XvA4FwNOqmxnOn/SRB48NLsxYocB0EvLQ9lkbGXZJoKAILRz/2/
         1+nvo3Q58abjLx+h3FMTstO78qcEuR3H/7ZccIv04ALLn62gZYk2wya+NPhvszQYUu3G
         RPwg==
X-Gm-Message-State: APjAAAVO1MQ1i0URnx9nqzRhosFVMnUObOAWGqFNQxuCzwA9GC7r/BAD
        cgKZlvrTI+sbnsrXb7862k02+A==
X-Google-Smtp-Source: APXvYqzgAsqcicTC3uYfs0bv1X70M1RUqm2tfrYF9UoRPj0OHibx5L7ZXAAsXar79xXLNpgRyLGW/Q==
X-Received: by 2002:a05:620a:124f:: with SMTP id a15mr24276909qkl.173.1562769997487;
        Wed, 10 Jul 2019 07:46:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u126sm1100041qkf.132.2019.07.10.07.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 07:46:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlDrg-0002WC-LU; Wed, 10 Jul 2019 11:46:36 -0300
Date:   Wed, 10 Jul 2019 11:46:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH -next] rdma/siw: Add missing dependencies on LIBCRC32C
 and DMA_VIRT_OPS
Message-ID: <20190710144636.GC4051@ziepe.ca>
References: <20190710133930.26591-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710133930.26591-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 03:39:30PM +0200, Geert Uytterhoeven wrote:
> If LIBCRC32C and DMA_VIRT_OPS are not enabled:
> 
>     drivers/infiniband/sw/siw/siw_main.o: In function `siw_newlink':
>     siw_main.c:(.text+0x35c): undefined reference to `dma_virt_ops'
>     drivers/infiniband/sw/siw/siw_qp_rx.o: In function `siw_csum_update':
>     siw_qp_rx.c:(.text+0x16): undefined reference to `crc32c'
> 
> Fix the first issue by adding a select of DMA_VIRT_OPS.
> Fix the second issue by replacing the unneeded dependency on
> CRYPTO_CRC32 by a dependency on LIBCRC32C.
> 
> Reported-by: noreply@ellerman.id.au (first issue)
> Fixes: c0cf5bdde46c664d ("rdma/siw: addition to kernel build environment")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>  drivers/infiniband/sw/siw/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
> index 94f684174ce3556e..b622fc62f2cd6d46 100644
> +++ b/drivers/infiniband/sw/siw/Kconfig
> @@ -1,6 +1,7 @@
>  config RDMA_SIW
>  	tristate "Software RDMA over TCP/IP (iWARP) driver"
> -	depends on INET && INFINIBAND && CRYPTO_CRC32
> +	depends on INET && INFINIBAND && LIBCRC32C

Is this the best practice? 

siw is using both the libcrc32c API and the
'crypto_alloc_shash("crc32c", 0, 0);' version. Is it right to get that
transitively through LIBCRC32C?

Jason
