Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA785CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A0221E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eSNWnwv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfKDKYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:24:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34701 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:24:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id e6so14530279wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hvkk7RONc9SrfQNrWrK3s3UYcl8AIEq79yP2mzZcaZA=;
        b=eSNWnwv3fB7Fj0a7kurApPAHHox5dFhx/NM3EAsFGjte7RLs9BE5V64dy8FlNtLzEW
         6KxCKQQP9FfDdFQbjmXcpbvyWk+JY0eAuXm+Rq3ubuLbfl43Nx0vFV+MWOsHq//iw+ZO
         0iYtdKt8PWGTGIndD4hc5wcMHW+maRs2aRUlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Hvkk7RONc9SrfQNrWrK3s3UYcl8AIEq79yP2mzZcaZA=;
        b=VxgUUTjSLaJzYySc+T67D1OMJdWsHvE3VhHOrAuQtZULWYjua2CBUEv+/fCOgART9R
         6trHXaqdQkKJvsFUu92y1CoZuhMujXWgS+M0vWWnJHGQvBV8LQI12TVvwEsFpiiJkA4s
         bOZ8GdPOfMeT1zZ5TDI6agslOG4oIXPArJZKEnknSRkahIsmKi+wXTN9Gi4n7Pc9e6F6
         mV+F7d0qzrR8TEhLp6R/e/LrGOgcmjlwDJsnklUE8JldkY7XPt+d+51b4WcBkyys7SmB
         9xyN4p32H6shoqbUJTObOS+rcMadPcTmeFXdbMdTS208f5fN0dGbQ+6FxBKlY4vfqDiM
         2nLg==
X-Gm-Message-State: APjAAAXF730+cH8A6I9xUEEcvzeMm0yKClVQ7bmePmdb3jwtn0bQCotp
        CtCci5bOkgytUxJ+ZACasYGiEw==
X-Google-Smtp-Source: APXvYqyrMVjUdiJaQjzgMyOTS8FWPykBYXOG+rwf6O+oLUfiLei6jNj6k8cIGflHK7qS8E+0dnsDOg==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr20907185wrn.24.1572863087835;
        Mon, 04 Nov 2019 02:24:47 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id v16sm17579034wrc.84.2019.11.04.02.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 02:24:47 -0800 (PST)
Date:   Mon, 4 Nov 2019 11:24:45 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel@lists.freedesktop.org, "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [RFC][PATCH 2/2] dma-buf: heaps: Allow system & cma heaps to be
 configured as a modules
Message-ID: <20191104102445.GE10326@phenom.ffwll.local>
Mail-Followup-To: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel@lists.freedesktop.org, "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025234834.28214-3-john.stultz@linaro.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:48:34PM +0000, John Stultz wrote:
> Allow loading system and cma heap as a module instead of just as
> a statically built in heap.
> 
> Since there isn't a good mechanism for dmabuf lifetime tracking
> it isn't safe to allow the heap drivers to be unloaded, so these
> drivers do not implement any module unloading functionality and
> will show up in lsmod as "[permanent]".

dma-buf itself has all the try_module_get we'll need ... why is this not
possible?
-Daniel

> 
> This patch also exports key functions from dmabuf heaps core and
> the heap helper functions so they can be accessed by the module.
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yue Hu <huyue2@yulong.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/dma-buf/dma-heap.c           | 2 ++
>  drivers/dma-buf/heaps/Kconfig        | 4 ++--
>  drivers/dma-buf/heaps/heap-helpers.c | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 9a41b73e54b4..2c4ac71a715b 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -161,6 +161,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
>  {
>  	return heap->priv;
>  }
> +EXPORT_SYMBOL_GPL(dma_heap_get_drvdata);
>  
>  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>  {
> @@ -243,6 +244,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>  	kfree(heap);
>  	return err_ret;
>  }
> +EXPORT_SYMBOL_GPL(dma_heap_add);
>  
>  static char *dma_heap_devnode(struct device *dev, umode_t *mode)
>  {
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> index a5eef06c4226..e273fb18feca 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -1,12 +1,12 @@
>  config DMABUF_HEAPS_SYSTEM
> -	bool "DMA-BUF System Heap"
> +	tristate "DMA-BUF System Heap"
>  	depends on DMABUF_HEAPS
>  	help
>  	  Choose this option to enable the system dmabuf heap. The system heap
>  	  is backed by pages from the buddy allocator. If in doubt, say Y.
>  
>  config DMABUF_HEAPS_CMA
> -	bool "DMA-BUF CMA Heap"
> +	tristate "DMA-BUF CMA Heap"
>  	depends on DMABUF_HEAPS && DMA_CMA
>  	help
>  	  Choose this option to enable dma-buf CMA heap. This heap is backed
> diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
> index 750bef4e902d..fb9835126893 100644
> --- a/drivers/dma-buf/heaps/heap-helpers.c
> +++ b/drivers/dma-buf/heaps/heap-helpers.c
> @@ -24,6 +24,7 @@ void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
>  	INIT_LIST_HEAD(&buffer->attachments);
>  	buffer->free = free;
>  }
> +EXPORT_SYMBOL_GPL(init_heap_helper_buffer);
>  
>  struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
>  					  int fd_flags)
> @@ -37,6 +38,7 @@ struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
>  
>  	return dma_buf_export(&exp_info);
>  }
> +EXPORT_SYMBOL_GPL(heap_helper_export_dmabuf);
>  
>  static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
>  {
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
