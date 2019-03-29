Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB025218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553875322;
	bh=hzmDGIrBrfjJp14dSLUxJEEtLN7tbFOqYWD83SmjARI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wZfm1KRAAIOynecZXerLg0ANKYxP1fovb2Oz8VX9beECk105z3opt8pZCikQY3uKp
	 YkDZMvX+vXSfEpRmDS/XNba15ncocvDo1qujAWSDBwmy6R/NQ/RdLVHPhQDHInIo/c
	 ZnDSRDTwNQGBweJ4p3l6R9130swH1/yonMHySuhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfC2QCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2QCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:02:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478532070B;
        Fri, 29 Mar 2019 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553875319;
        bh=hzmDGIrBrfjJp14dSLUxJEEtLN7tbFOqYWD83SmjARI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNPwJNx8T3aXLynIaodBWnZvdUrjNnYAnJm4hA+H4EGTYKd9IBI5+w1Z6zqyt9Jak
         tdPvSpW94q/lDRxX6UDHl6aahM9l2Qw5k6BGUj5s6skNK3NVnS8ED9ArsWU/4LjCeN
         Z0LH37m1OKCOzad92IqFwvxZs/9Uer9EipUi96Rk=
Date:   Fri, 29 Mar 2019 17:01:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     labbott@redhat.com, sumit.semwal@linaro.org,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Message-ID: <20190329160157.GA5906@kroah.com>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 02:40:16AM +0800, Zeng Tao wrote:
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
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>  drivers/staging/android/ion/ion.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 92c2914..e93fb49 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -387,13 +387,13 @@ static const struct dma_buf_ops dma_buf_ops = {
>  	.unmap = ion_dma_buf_kunmap,
>  };
>  
> -static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
> +struct dma_buf *ion_alloc(size_t len, unsigned int heap_id_mask,
> +			  unsigned int flags)
>  {
>  	struct ion_device *dev = internal_dev;
>  	struct ion_buffer *buffer = NULL;
>  	struct ion_heap *heap;
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> -	int fd;
>  	struct dma_buf *dmabuf;
>  
>  	pr_debug("%s: len %zu heap_id_mask %u flags %x\n", __func__,
> @@ -407,7 +407,7 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>  	len = PAGE_ALIGN(len);
>  
>  	if (!len)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	down_read(&dev->lock);
>  	plist_for_each_entry(heap, &dev->heaps, node) {
> @@ -421,10 +421,10 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>  	up_read(&dev->lock);
>  
>  	if (!buffer)
> -		return -ENODEV;
> +		return ERR_PTR(-ENODEV);
>  
>  	if (IS_ERR(buffer))
> -		return PTR_ERR(buffer);
> +		return ERR_PTR(PTR_ERR(buffer));
>  
>  	exp_info.ops = &dma_buf_ops;
>  	exp_info.size = buffer->size;
> @@ -432,17 +432,12 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>  	exp_info.priv = buffer;
>  
>  	dmabuf = dma_buf_export(&exp_info);
> -	if (IS_ERR(dmabuf)) {
> +	if (IS_ERR(dmabuf))
>  		_ion_buffer_destroy(buffer);
> -		return PTR_ERR(dmabuf);
> -	}
>  
> -	fd = dma_buf_fd(dmabuf, O_CLOEXEC);
> -	if (fd < 0)
> -		dma_buf_put(dmabuf);
> -
> -	return fd;
> +	return dmabuf;
>  }
> +EXPORT_SYMBOL(ion_alloc);

If you are going to do this (and personally I'm with Laura in that I
don't think you need it) this should be EXPORT_SYMBOL_GPL() please.

thanks,

greg k-h
