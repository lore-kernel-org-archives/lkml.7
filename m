Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E93DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AC62177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EvnrgSgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbfDQOUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:20:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37522 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:20:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so19572363ede.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IckmlwlCYuYebAcm4zShyTjyGza8QayjzJCK2BIDC8A=;
        b=EvnrgSgwKziWe2cW4rkAUzKIQplJ10lLdiJ83Vt1Mn1sXfJfIy+XzMDFUVurZUAxN1
         +CzrKwnU4OAhVw7rltEruRDSpvijL7SbddL9ijUHuLEcTy2ZEtOox7/G6tXmcvD983dN
         Ycg2CEczhicwhkacHk4LFCoHwsShyHoUc6fqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IckmlwlCYuYebAcm4zShyTjyGza8QayjzJCK2BIDC8A=;
        b=DMiCqSP7mRb05qsITUwBpsnvq/p5h7gCde1Hitg6CF1+mpQqtMNsR/7Kf3FSHKo4BC
         y3NeDQ+RQGDRxuaLw2H6L9vx91mLQPzJ771lKF1E79u9KR8LwDY9mi00H3LKJw/5FIEx
         A+QxecFwOoeak0rU5kXHTgemEiblCDJmakQRkRyK8K2aJkt21rddYQdAKWs98uXZylih
         vO5ojT2s+3JL6efErfiTvOrlX/ATikJDEMpt3amtHeFqFHw+KcSZC7Cp33pyzeaN2VW6
         CcO/d1rhiV46CzohUMH3HajzcD3mkqRKNudqUt2cg7vlpE8xUlcTNIhtI7FGhpO4+QDV
         BOrA==
X-Gm-Message-State: APjAAAXsqCXFyGPjddtaCJmPUBgjzJ58TW816PUqC4sWWCpqeG7JzbDb
        P+TC88ehjUvTv8jHp7yRbMsWLA==
X-Google-Smtp-Source: APXvYqyheS+LMtUGXq44aXxVzKb+GydoNsHhKC1b6fYaB+qqgFFyDv0RDHiAmrb75q/3tAQ5vq/2hg==
X-Received: by 2002:a17:906:3e85:: with SMTP id a5mr48593940ejj.272.1555510804861;
        Wed, 17 Apr 2019 07:20:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w58sm17267091edd.69.2019.04.17.07.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 07:20:04 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:20:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 05/12] dma-buf: add explicit buffer pinning
Message-ID: <20190417142002.GE13337@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-6-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416183841.1577-6-christian.koenig@amd.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:38:34PM +0200, Christian König wrote:
> Add optional explicit pinning callbacks instead of implicitly assume the
> exporter pins the buffer when a mapping is created.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Don't we need this together with the invalidate callback and the dynamic
stuff? Also I'm assuming that pin/unpin is pretty much required for
dynamic bo, so could we look at these callbacks instead of the dynamic
flag you add in patch 1.

I'm assuming following rules hold:
no pin/upin from exporter:

dma-buf is not dynamic, and pinned for the duration of map/unmap. I'm
not 100% sure whether really everyone wants the mapping to be cached for
the entire attachment, only drm_prime does that. And that's not the only
dma-buf importer.

pin/unpin calls are noops.

pin/unpin exist in the exporter, but importer has not provided an
invalidate callback:

We map at attach time, and we also have to pin, since the importer can't
handle the buffer disappearing, at attach time. We unmap/unpin at detach.

pin/unpin from exporter, invalidate from importer:

Full dynamic mapping. We assume the importer will do caching, attach
fences as needed, and pin the underlying bo when it needs it it
permanently, without attaching fences (i.e. the scanout case).

Assuming I'm not terribly off with my understanding, then I think it'd be
best to introduce the entire new dma-buf api in the first patch, and flesh
it out later. Instead of spread over a few patches. Plus the above (maybe
prettier) as a nice kerneldoc overview comment for how dynamic dma-buf is
supposed to work really.
-Daniel

> ---
>  drivers/dma-buf/dma-buf.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 37 +++++++++++++++++++++++++++++++------
>  2 files changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index a3738fab3927..f23ff8355505 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -630,6 +630,41 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_detach);
>  
> +/**
> + * dma_buf_pin - Lock down the DMA-buf
> + *
> + * @dmabuf:	[in]	DMA-buf to lock down.
> + *
> + * Returns:
> + * 0 on success, negative error code on failure.
> + */
> +int dma_buf_pin(struct dma_buf *dmabuf)
> +{
> +	int ret = 0;
> +
> +	reservation_object_assert_held(dmabuf->resv);
> +
> +	if (dmabuf->ops->pin)
> +		ret = dmabuf->ops->pin(dmabuf);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_pin);
> +
> +/**
> + * dma_buf_unpin - Remove lock from DMA-buf
> + *
> + * @dmabuf:	[in]	DMA-buf to unlock.
> + */
> +void dma_buf_unpin(struct dma_buf *dmabuf)
> +{
> +	reservation_object_assert_held(dmabuf->resv);
> +
> +	if (dmabuf->ops->unpin)
> +		dmabuf->ops->unpin(dmabuf);
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_unpin);
> +
>  /**
>   * dma_buf_map_attachment_locked - Maps the buffer into _device_ address space
>   * with the reservation lock held. Is a wrapper for map_dma_buf() of the
> @@ -666,6 +701,8 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
>  	 */
>  	if (attach->invalidate)
>  		list_del(&attach->node);
> +	else
> +		dma_buf_pin(attach->dmabuf);
>  	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
>  	if (attach->invalidate)
>  		list_add(&attach->node, &attach->dmabuf->attachments);
> @@ -735,6 +772,8 @@ void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *attach,
>  
>  	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
>  						direction);
> +	if (!attach->invalidate)
> +		dma_buf_unpin(attach->dmabuf);
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment_locked);
>  
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index ece4638359a8..a615b74e5894 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -100,14 +100,40 @@ struct dma_buf_ops {
>  	 */
>  	void (*detach)(struct dma_buf *, struct dma_buf_attachment *);
>  
> +	/**
> +	 * @pin_dma_buf:
> +	 *
> +	 * This is called by dma_buf_pin and lets the exporter know that an
> +	 * importer assumes that the DMA-buf can't be invalidated any more.
> +	 *
> +	 * This is called with the dmabuf->resv object locked.
> +	 *
> +	 * This callback is optional.
> +	 *
> +	 * Returns:
> +	 *
> +	 * 0 on success, negative error code on failure.
> +	 */
> +	int (*pin)(struct dma_buf *);
> +
> +	/**
> +	 * @unpin_dma_buf:
> +	 *
> +	 * This is called by dma_buf_unpin and lets the exporter know that an
> +	 * importer doesn't need to the DMA-buf to stay were it is any more.
> +	 *
> +	 * This is called with the dmabuf->resv object locked.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	void (*unpin)(struct dma_buf *);
> +
>  	/**
>  	 * @map_dma_buf:
>  	 *
>  	 * This is called by dma_buf_map_attachment() and is used to map a
>  	 * shared &dma_buf into device address space, and it is mandatory. It
> -	 * can only be called if @attach has been called successfully. This
> -	 * essentially pins the DMA buffer into place, and it cannot be moved
> -	 * any more
> +	 * can only be called if @attach has been called successfully.
>  	 *
>  	 * This call may sleep, e.g. when the backing storage first needs to be
>  	 * allocated, or moved to a location suitable for all currently attached
> @@ -148,9 +174,6 @@ struct dma_buf_ops {
>  	 *
>  	 * This is called by dma_buf_unmap_attachment() and should unmap and
>  	 * release the &sg_table allocated in @map_dma_buf, and it is mandatory.
> -	 * It should also unpin the backing storage if this is the last mapping
> -	 * of the DMA buffer, it the exporter supports backing storage
> -	 * migration.
>  	 *
>  	 * This is always called with the dmabuf->resv object locked when
>  	 * no_sgt_cache is true.
> @@ -442,6 +465,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>  struct dma_buf *dma_buf_get(int fd);
>  void dma_buf_put(struct dma_buf *dmabuf);
>  
> +int dma_buf_pin(struct dma_buf *dmabuf);
> +void dma_buf_unpin(struct dma_buf *dmabuf);
>  struct sg_table *dma_buf_map_attachment_locked(struct dma_buf_attachment *,
>  					       enum dma_data_direction);
>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
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
