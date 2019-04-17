Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFCC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561F4206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CI9fn+gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbfDQTHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:07:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44537 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbfDQTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:07:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id i13so11224815edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=z15++fU+Z6dFYcV0A3NJ9wZHpJngLNG+5T60YrpfuYY=;
        b=CI9fn+gxm4d5QoL7ETPXGgxjMZ0hiRQNT1s/4zPwhEMwOaaalAq50ybB5zTRg8j8OJ
         JdbKyGUvtaFkpn6Ht+RQT60rQp8rqZV0hmA/2mN+V5fL+Kbx65F8Y9OE+Wgaqbrjp9zz
         y7ODNPsWiaQ1JWmXPDEvJH3ir85GMoRJZYw4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=z15++fU+Z6dFYcV0A3NJ9wZHpJngLNG+5T60YrpfuYY=;
        b=kIsEXdEO51dO+zz3eCOYA+3+DDxKI620o8h8APZmnAhxRo3nSI7XSwW0zV4uyoXgAb
         d0I0wqrXrgu645Mqd/BwjLEFOoyAjoHwHtvRgkKUSqAPdnVq1eoEh5ap7qwgsVJrTBtJ
         p0uydQQ8i1bdtYo0op+BfRPx2LbbDOmd4vLoOt8BJzVz7xLeKlKI+zNb8ukjIs2WwpIt
         QzfZmFO80SskxUkgLIvGAQNU0pakdr/ZVvsU6LUuaTLYwfqUVi+yPwLx66rtzoAeKY7Q
         an8YwRs6W7kkOcKBkh73l4Fz7pTo3dvAPOCk7ZoVujNgfKwVBmTzjRkgnb9pj8tCrXC6
         8cYg==
X-Gm-Message-State: APjAAAV5CEvOz+z+Rs/PGnVAKhqAqBRMfKlKsryun0biTQqNx/5Hn9zm
        H4nQCMRjsPJTi401gkLsDcYRWA==
X-Google-Smtp-Source: APXvYqzfCAIYFZswg2hfJ4bZgSLT+mhrAkhQ3hh0K7YKYimXj2xO0pkCKsqID1YgJfuE1VqDqE4+wA==
X-Received: by 2002:a17:906:54d:: with SMTP id k13mr49348312eja.207.1555528042452;
        Wed, 17 Apr 2019 12:07:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o25sm7829875ejc.87.2019.04.17.12.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 12:07:21 -0700 (PDT)
Date:   Wed, 17 Apr 2019 21:07:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback
 v5
Message-ID: <20190417190719.GL13337@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-5-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416183841.1577-5-christian.koenig@amd.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:38:33PM +0200, Christian König wrote:
> Each importer can now provide an invalidate_mappings callback.
> 
> This allows the exporter to provide the mappings without the need to pin
> the backing store.
> 
> v2: don't try to invalidate mappings when the callback is NULL,
>     lock the reservation obj while using the attachments,
>     add helper to set the callback
> v3: move flag for invalidation support into the DMA-buf,
>     use new attach_info structure to set the callback
> v4: use importer_priv field instead of mangling exporter priv.
> v5: drop invalidation_supported flag
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/dma-buf.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 33 +++++++++++++++++++++++++++++++--
>  2 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 83c92bfd964c..a3738fab3927 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -563,6 +563,8 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
>  
>  	attach->dev = info->dev;
>  	attach->dmabuf = dmabuf;
> +	attach->importer_priv = info->importer_priv;
> +	attach->invalidate = info->invalidate;
>  
>  	mutex_lock(&dmabuf->lock);
>  
> @@ -571,7 +573,9 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
>  		if (ret)
>  			goto err_attach;
>  	}
> +	reservation_object_lock(dmabuf->resv, NULL);
>  	list_add(&attach->node, &dmabuf->attachments);
> +	reservation_object_unlock(dmabuf->resv);
>  
>  	mutex_unlock(&dmabuf->lock);
>  
> @@ -615,7 +619,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
>  					   DMA_BIDIRECTIONAL);
>  
>  	mutex_lock(&dmabuf->lock);
> +	reservation_object_lock(dmabuf->resv, NULL);
>  	list_del(&attach->node);
> +	reservation_object_unlock(dmabuf->resv);
>  	if (dmabuf->ops->detach)
>  		dmabuf->ops->detach(dmabuf, attach);
>  
> @@ -653,7 +659,16 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
>  	if (attach->sgt)
>  		return attach->sgt;
>  
> +	/*
> +	 * Mapping a DMA-buf can trigger its invalidation, prevent sending this
> +	 * event to the caller by temporary removing this attachment from the
> +	 * list.
> +	 */
> +	if (attach->invalidate)
> +		list_del(&attach->node);

Just noticed this: Why do we need this? invalidate needs the reservation
lock, as does map_attachment. It should be impssoble to have someone else
sneak in here.
-Daniel

>  	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
> +	if (attach->invalidate)
> +		list_add(&attach->node, &attach->dmabuf->attachments);
>  	if (!sg_table)
>  		sg_table = ERR_PTR(-ENOMEM);
>  
> @@ -751,6 +766,26 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment);
>  
> +/**
> + * dma_buf_invalidate_mappings - invalidate all mappings of this dma_buf
> + *
> + * @dmabuf:	[in]	buffer which mappings should be invalidated
> + *
> + * Informs all attachmenst that they need to destroy and recreated all their
> + * mappings.
> + */
> +void dma_buf_invalidate_mappings(struct dma_buf *dmabuf)
> +{
> +	struct dma_buf_attachment *attach;
> +
> +	reservation_object_assert_held(dmabuf->resv);
> +
> +	list_for_each_entry(attach, &dmabuf->attachments, node)
> +		if (attach->invalidate)
> +			attach->invalidate(attach);
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_invalidate_mappings);
> +
>  /**
>   * DOC: cpu access
>   *
> @@ -1163,10 +1198,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  		seq_puts(s, "\tAttached Devices:\n");
>  		attach_count = 0;
>  
> +		reservation_object_lock(buf_obj->resv, NULL);
>  		list_for_each_entry(attach_obj, &buf_obj->attachments, node) {
>  			seq_printf(s, "\t%s\n", dev_name(attach_obj->dev));
>  			attach_count++;
>  		}
> +		reservation_object_unlock(buf_obj->resv);
>  
>  		seq_printf(s, "Total %d devices attached\n\n",
>  				attach_count);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 7e23758db3a4..ece4638359a8 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -324,6 +324,7 @@ struct dma_buf {
>   * @dev: device attached to the buffer.
>   * @node: list of dma_buf_attachment.
>   * @priv: exporter specific attachment data.
> + * @importer_priv: importer specific attachment data.
>   *
>   * This structure holds the attachment information between the dma_buf buffer
>   * and its user device(s). The list contains one attachment struct per device
> @@ -340,6 +341,29 @@ struct dma_buf_attachment {
>  	struct list_head node;
>  	void *priv;
>  	struct sg_table *sgt;
> +	void *importer_priv;
> +
> +	/**
> +	 * @invalidate:
> +	 *
> +	 * Optional callback provided by the importer of the dma-buf.
> +	 *
> +	 * If provided the exporter can avoid pinning the backing store while
> +	 * mappings exists.
> +	 *
> +	 * The function is called with the lock of the reservation object
> +	 * associated with the dma_buf held and the mapping function must be
> +	 * called with this lock held as well. This makes sure that no mapping
> +	 * is created concurrently with an ongoing invalidation.
> +	 *
> +	 * After the callback all existing mappings are still valid until all
> +	 * fences in the dma_bufs reservation object are signaled, but should be
> +	 * destroyed by the importer as soon as possible.
> +	 *
> +	 * New mappings can be created immediately, but can't be used before the
> +	 * exclusive fence in the dma_bufs reservation object is signaled.
> +	 */
> +	void (*invalidate)(struct dma_buf_attachment *attach);
>  };
>  
>  /**
> @@ -378,8 +402,10 @@ struct dma_buf_export_info {
>  
>  /**
>   * struct dma_buf_attach_info - holds information needed to attach to a dma_buf
> - * @dmabuf:	the exported dma_buf
> - * @dev:	the device which wants to import the attachment
> + * @dmabuf:		the exported dma_buf
> + * @dev:		the device which wants to import the attachment
> + * @importer_priv:	private data of importer to this attachment
> + * @invalidate:		callback to use for invalidating mappings
>   *
>   * This structure holds the information required to attach to a buffer. Used
>   * with dma_buf_attach() only.
> @@ -387,6 +413,8 @@ struct dma_buf_export_info {
>  struct dma_buf_attach_info {
>  	struct dma_buf *dmabuf;
>  	struct device *dev;
> +	void *importer_priv;
> +	void (*invalidate)(struct dma_buf_attachment *attach);
>  };
>  
>  /**
> @@ -423,6 +451,7 @@ void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *,
>  				     enum dma_data_direction);
>  void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
>  				enum dma_data_direction);
> +void dma_buf_invalidate_mappings(struct dma_buf *dma_buf);
>  int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
>  			     enum dma_data_direction dir);
>  int dma_buf_end_cpu_access(struct dma_buf *dma_buf,
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
