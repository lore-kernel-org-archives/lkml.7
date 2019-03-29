Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BF22183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfC2N1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:27:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37590 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfC2N1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:27:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id c1so1331565qkk.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 06:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7e5Q9Ti8TiacMjqfNeYCqFACxYIKO5gcweQdTSalm/Q=;
        b=dkFOLW5x0DTALZZDAAqKw1dh5PCUX6wN561mWPnH12Modd8rLufWqts40prI9K3/Vy
         XdhLFKTU1o+N9Oq8yFFpHXRHliehCPq/pEzAVqAwNBWAoBE7M3piAcbtxW5Xr70ISvi1
         9AyPZx9ZVrixTbh2LOM8X45v+I1xlQeo46TLSVpMQWuZHc8YMBkfVVbHXJnybjpR5VGS
         TqHDik259IAPJNQV9tp65jHBMqAHRRIZRUV+L9eH/ZmkqW/4OMOLWbzfw/eOzyjCodwr
         mFORZl9lZjhf41Ru2x2K0KANZvCyNBP8yMl3anjJdirRwvJoOJDzpoQ6SMI6ahHrbE6q
         OVSw==
X-Gm-Message-State: APjAAAVhCYOVJ37wmhaEmPq4ugULOycvQQMON2vvlhZDP4Pj8opR68/y
        hTP+Y8wWta8MrduJ2XT+7cvPhEhJ+Lk=
X-Google-Smtp-Source: APXvYqx4eM3YbPYq/ZFBUGl+9LACvUWiakU8W9RBO0fH0WitAzAlTI9Q/lh+yOA4m0rSjgMJhsW4IQ==
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr4365478qkj.221.1553866041182;
        Fri, 29 Mar 2019 06:27:21 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::fa4a? ([2601:602:9800:dae6::fa4a])
        by smtp.gmail.com with ESMTPSA id y18sm1288365qty.78.2019.03.29.06.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 06:27:20 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
To:     Zeng Tao <prime.zeng@hisilicon.com>, sumit.semwal@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <e8c45ba1-dfe9-a929-acf5-2e7c61ab7b1c@redhat.com>
Date:   Fri, 29 Mar 2019 06:27:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 11:40 AM, Zeng Tao wrote:
> There are two reasons for this patch:
> 1. There are some potential requirements for ion_alloc in kernel space,
> some media drivers need to allocate media buffers from ion instead of
> buddy or dma framework, this is more convient and clean very for media
> drivers. And In that case, ion is the only media buffer provider, it's
> more easier to maintain.
> 2. Fd is only needed by user processes, not the kernel space, so dma_buf
> should be returned instead of fd for kernel space, and dma_buf_fd should
> be called only for userspace api.
> 

I really want to just NAK this because it doesn't seem like something
that's necessary. The purpose of Ion is to provide buffers to userspace
because there's no other way for userspace to get access to the memory.
The kernel already has other APIs to access the memory. This also
complicates the re-work that's been happening where the requirement
is only userspace.

Can you be more detailed about which media drivers you are referring
to and why they can't just use other APIs?


> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>   drivers/staging/android/ion/ion.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 92c2914..e93fb49 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -387,13 +387,13 @@ static const struct dma_buf_ops dma_buf_ops = {
>   	.unmap = ion_dma_buf_kunmap,
>   };
>   
> -static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
> +struct dma_buf *ion_alloc(size_t len, unsigned int heap_id_mask,
> +			  unsigned int flags)
>   {
>   	struct ion_device *dev = internal_dev;
>   	struct ion_buffer *buffer = NULL;
>   	struct ion_heap *heap;
>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> -	int fd;
>   	struct dma_buf *dmabuf;
>   
>   	pr_debug("%s: len %zu heap_id_mask %u flags %x\n", __func__,
> @@ -407,7 +407,7 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>   	len = PAGE_ALIGN(len);
>   
>   	if (!len)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   
>   	down_read(&dev->lock);
>   	plist_for_each_entry(heap, &dev->heaps, node) {
> @@ -421,10 +421,10 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>   	up_read(&dev->lock);
>   
>   	if (!buffer)
> -		return -ENODEV;
> +		return ERR_PTR(-ENODEV);
>   
>   	if (IS_ERR(buffer))
> -		return PTR_ERR(buffer);
> +		return ERR_PTR(PTR_ERR(buffer));
>   
>   	exp_info.ops = &dma_buf_ops;
>   	exp_info.size = buffer->size;
> @@ -432,17 +432,12 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>   	exp_info.priv = buffer;
>   
>   	dmabuf = dma_buf_export(&exp_info);
> -	if (IS_ERR(dmabuf)) {
> +	if (IS_ERR(dmabuf))
>   		_ion_buffer_destroy(buffer);
> -		return PTR_ERR(dmabuf);
> -	}
>   
> -	fd = dma_buf_fd(dmabuf, O_CLOEXEC);
> -	if (fd < 0)
> -		dma_buf_put(dmabuf);
> -
> -	return fd;
> +	return dmabuf;
>   }
> +EXPORT_SYMBOL(ion_alloc);
>   
>   static int ion_query_heaps(struct ion_heap_query *query)
>   {
> @@ -539,12 +534,19 @@ static long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   	case ION_IOC_ALLOC:
>   	{
>   		int fd;
> +		struct dma_buf *dmabuf;
>   
> -		fd = ion_alloc(data.allocation.len,
> +		dmabuf = ion_alloc(data.allocation.len,
>   			       data.allocation.heap_id_mask,
>   			       data.allocation.flags);
> -		if (fd < 0)
> +		if (IS_ERR(dmabuf))
> +			return PTR_ERR(dmabuf);
> +
> +		fd = dma_buf_fd(dmabuf, O_CLOEXEC);
> +		if (fd < 0) {
> +			dma_buf_put(dmabuf);
>   			return fd;
> +		}
>   
>   		data.allocation.fd = fd;
>   
> 

