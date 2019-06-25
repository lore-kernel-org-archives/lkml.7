Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2800EC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CB320663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5N+TG2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFYU4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:56:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36874 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfFYUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:54:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id y8so37536pgl.4;
        Tue, 25 Jun 2019 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7GqGJNKIasLUZ24jo+8ov0SucMXFw8AagDpW/9PlO7E=;
        b=E5N+TG2UKD42ufRtfER2wNK6hWUjGD9iweQETAc6Pv0/FV9nwzLNOqtNKO+VPdHqm4
         4jB32B31y5Q9xvQq/peFaRouKEh8069QRsLGTYjbvYGaZGa0INeeqJ2tNmavqbWOaHyH
         L4AIwIbiqKwy7qkVCU4ADNpfABiPTuHMqRPjvzUoe9ffV5g9WjttmYvR1pijgoAmb2YN
         PpPkkQcuN5lvHN85K0fbeD49WFhVuEd537bs/PTs/QN/qevIs77OjPIA66mzU6xUqgXr
         Ufg9ELR/qK3nWrXTQc039/EirjKkab8HB7xGTsIAC0trafA/CXcP3/8swu3sh6jD+tvZ
         4+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7GqGJNKIasLUZ24jo+8ov0SucMXFw8AagDpW/9PlO7E=;
        b=FB/QAjoWgm5+fj5/vxfmO4d/XXJrFnyxAXkgLpg75NQuOYUXklqy3fZfC624OgFZK9
         aNYmkJBMiRqTaNw8A7t8jQf4licbRcSufwftkRJCmTt7A1Jh0JsRNYIrr8m59RvwW0ZL
         +mySvVZa19Na1+gB56iaywpcJF6sDjegLJrPMfhA300v6qhHcqmIHmbMh3d2f9NUpTu9
         HgYD4wANJDOBWVnUCJdn1N+6HA1Hot1uHHwuWPSUZ2mC2pbXvh84HELizb+ZegR0tUB8
         sMtkv0uTcZ2wpYbew4xv64PVXFQpba3jjsOD6fEzPdxRki3RI76gnCsI7zkW09YLaPQB
         hH0w==
X-Gm-Message-State: APjAAAXIrj6qfL+6IyIqt/pqaKZP5z4hk7eCmjJNIpG6auuokFAebghh
        BsfxSpCKsFVDlAq5hTdrRvQ=
X-Google-Smtp-Source: APXvYqwGz8NVy2m2jo1H85o12QWHCGtXTdQYECHiCFho4gQUSKudkOSyraRg5dQrQlEMvltzQTpp/g==
X-Received: by 2002:a17:90a:25e6:: with SMTP id k93mr932016pje.100.1561496070866;
        Tue, 25 Jun 2019 13:54:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k22sm17047332pfg.77.2019.06.25.13.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 13:54:29 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:54:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Christoph Hellwig <hch@lst.de>, laurentiu.tudor@nxp.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        JuergenUrban@gmx.de
Subject: Re: [PATCH 1/2] lib/genalloc.c: Add algorithm, align and zeroed
 family of DMA allocators
Message-ID: <20190625205428.GA7449@roeck-us.net>
References: <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
 <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
 <20190614142816.GA2574@sx9>
 <20190624063515.GA3296@lst.de>
 <20190624125916.GA2516@sx9>
 <20190625060000.GA28986@lst.de>
 <20190625150558.GA2560@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625150558.GA2560@sx9>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 05:05:58PM +0200, Fredrik Noring wrote:
> Provide the algorithm option to DMA allocators as well, along with
> convenience variants for zeroed and aligned memory. The following
> four functions are added:
> 
> - gen_pool_dma_alloc_algo()
> - gen_pool_dma_alloc_align()
> - gen_pool_dma_zalloc_algo()
> - gen_pool_dma_zalloc_align()
> 
> Signed-off-by: Fredrik Noring <noring@nocrew.org>

The series fixes the problem I had observed in linux-next.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> Hi Christoph,
> 
> This patch is based on my v5.0.21 branch, with Laurentiu Tudor's other
> local memory changes.
> 
> Fredrik
> ---
>  include/linux/genalloc.h |  10 +++-
>  lib/genalloc.c           | 100 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 105 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@ -121,7 +121,15 @@ extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
>  		genpool_algo_t algo, void *data);
>  extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
>  		dma_addr_t *dma);
> -void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
> +extern void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, genpool_algo_t algo, void *data);
> +extern void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, int align);
> +extern void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
> +extern void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, genpool_algo_t algo, void *data);
> +extern void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, int align);
>  extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
>  extern void gen_pool_for_each_chunk(struct gen_pool *,
>  	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
> diff --git a/lib/genalloc.c b/lib/genalloc.c
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -347,13 +347,35 @@ EXPORT_SYMBOL(gen_pool_alloc_algo);
>   * Return: virtual address of the allocated memory, or %NULL on failure
>   */
>  void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
> +{
> +	return gen_pool_dma_alloc_algo(pool, size, dma, pool->algo, pool->data);
> +}
> +EXPORT_SYMBOL(gen_pool_dma_alloc);
> +
> +/**
> + * gen_pool_dma_alloc_algo - allocate special memory from the pool for DMA
> + * usage with the given pool algorithm
> + * @pool: pool to allocate from
> + * @size: number of bytes to allocate from the pool
> + * @dma: DMA-view physical address return value. Use %NULL if unneeded.
> + * @algo: algorithm passed from caller
> + * @data: data passed to algorithm
> + *
> + * Allocate the requested number of bytes from the specified pool. Uses the
> + * given pool allocation function. Can not be used in NMI handler on
> + * architectures without NMI-safe cmpxchg implementation.
> + *
> + * Return: virtual address of the allocated memory, or %NULL on failure
> + */
> +void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, genpool_algo_t algo, void *data)
>  {
>  	unsigned long vaddr;
>  
>  	if (!pool)
>  		return NULL;
>  
> -	vaddr = gen_pool_alloc(pool, size);
> +	vaddr = gen_pool_alloc_algo(pool, size, algo, data);
>  	if (!vaddr)
>  		return NULL;
>  
> @@ -362,7 +384,31 @@ void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
>  
>  	return (void *)vaddr;
>  }
> -EXPORT_SYMBOL(gen_pool_dma_alloc);
> +EXPORT_SYMBOL(gen_pool_dma_alloc_algo);
> +
> +/**
> + * gen_pool_dma_alloc_align - allocate special memory from the pool for DMA
> + * usage with the given alignment
> + * @pool: pool to allocate from
> + * @size: number of bytes to allocate from the pool
> + * @dma: DMA-view physical address return value. Use %NULL if unneeded.
> + * @align: alignment in bytes for starting address
> + *
> + * Allocate the requested number bytes from the specified pool, with the given
> + * alignment restriction. Can not be used in NMI handler on architectures
> + * without NMI-safe cmpxchg implementation.
> + *
> + * Return: virtual address of the allocated memory, or %NULL on failure
> + */
> +void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, int align)
> +{
> +	struct genpool_data_align data = { .align = align };
> +
> +	return gen_pool_dma_alloc_algo(pool, size, dma,
> +			gen_pool_first_fit_align, &data);
> +}
> +EXPORT_SYMBOL(gen_pool_dma_alloc_align);
>  
>  /**
>   * gen_pool_dma_zalloc - allocate special zeroed memory from the pool for
> @@ -380,14 +426,60 @@ EXPORT_SYMBOL(gen_pool_dma_alloc);
>   */
>  void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
>  {
> -	void *vaddr = gen_pool_dma_alloc(pool, size, dma);
> +	return gen_pool_dma_zalloc_algo(pool, size, dma, pool->algo, pool->data);
> +}
> +EXPORT_SYMBOL(gen_pool_dma_zalloc);
> +
> +/**
> + * gen_pool_dma_zalloc_algo - allocate special zeroed memory from the pool for
> + * DMA usage with the given pool algorithm
> + * @pool: pool to allocate from
> + * @size: number of bytes to allocate from the pool
> + * @dma: DMA-view physical address return value. Use %NULL if unneeded.
> + * @algo: algorithm passed from caller
> + * @data: data passed to algorithm
> + *
> + * Allocate the requested number of zeroed bytes from the specified pool. Uses
> + * the given pool allocation function. Can not be used in NMI handler on
> + * architectures without NMI-safe cmpxchg implementation.
> + *
> + * Return: virtual address of the allocated zeroed memory, or %NULL on failure
> + */
> +void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, genpool_algo_t algo, void *data)
> +{
> +	void *vaddr = gen_pool_dma_alloc_algo(pool, size, dma, algo, data);
>  
>  	if (vaddr)
>  		memset(vaddr, 0, size);
>  
>  	return vaddr;
>  }
> -EXPORT_SYMBOL(gen_pool_dma_zalloc);
> +EXPORT_SYMBOL(gen_pool_dma_zalloc_algo);
> +
> +/**
> + * gen_pool_dma_zalloc_align - allocate special zeroed memory from the pool for
> + * DMA usage with the given alignment
> + * @pool: pool to allocate from
> + * @size: number of bytes to allocate from the pool
> + * @dma: DMA-view physical address return value. Use %NULL if unneeded.
> + * @align: alignment in bytes for starting address
> + *
> + * Allocate the requested number of zeroed bytes from the specified pool,
> + * with the given alignment restriction. Can not be used in NMI handler on
> + * architectures without NMI-safe cmpxchg implementation.
> + *
> + * Return: virtual address of the allocated zeroed memory, or %NULL on failure
> + */
> +void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t size,
> +		dma_addr_t *dma, int align)
> +{
> +	struct genpool_data_align data = { .align = align };
> +
> +	return gen_pool_dma_zalloc_algo(pool, size, dma,
> +			gen_pool_first_fit_align, &data);
> +}
> +EXPORT_SYMBOL(gen_pool_dma_zalloc_align);
>  
>  /**
>   * gen_pool_free - free allocated special memory back to the pool
> -- 
> 2.21.0
> 
