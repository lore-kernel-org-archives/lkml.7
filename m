Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF28B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAgQSP17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbfDQOOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:14:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39443 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbfDQOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:14:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so32162200wrn.6;
        Wed, 17 Apr 2019 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0+qlDIopIblhTv5EGtACRfVgtZhfLlmTVOzDJZHNj4c=;
        b=cAgQSP17yfsaZ/McgcZ8iP8fPNHiU4bb/RjHjR8Hc9r/9FX0qjwH9i7fRnN9BRu2eA
         SoJyzyCqb5x1/zPbhhkAvJa/wSaXY6xD54wr1f0HYu2AXCSv5dUcAhjLkPq3sxuTngcX
         gux9/La82OEHPb60SREbhkb0IaAR7Ep6XnU2Pbtog017IcMVmfhzHb77txuM2KP2oBDO
         dHGJpMg38OotACfYacXuiIYQjBTiYgRu5ZVgOJRcGTl6tzkHczRC3ZTskfkWy1mHGXC7
         smeaAinmgBLCdYYt5c96F3yW42KbiRtbbwiOe5FI6AQQsFJ8kByRUhfN18AWLy3ktoNB
         4Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0+qlDIopIblhTv5EGtACRfVgtZhfLlmTVOzDJZHNj4c=;
        b=sOnIoSZnhu1tlD/RK6x9A7A5icXQa/+cCHhCiJ2BJXAk3ynpRDEn2Xe+1Arso97yov
         VrjbA1U/IKa0PCzc6DMNBjih4qOs6bAZM4wgyIUM7dm4ag45vpwPx82/qtI+XpdXb18d
         gLvvV5/kz0XJQXSVOiIKoD0bKXsIFzV+E9wFxct9y8qxytMVVAMSuJxSnga8rZv/WFZF
         XXKaWDHe3DlXOlMvR14sWltlH8Z0KTcqJe7B8xYMBEUzTl/j+wDL/BuzL0aqWC1/k7TA
         jSmq3qyBMtgulCfjCA1ajLIvMwAT4ob1C+9P6JK3H2H077be34iKBKzaBsUbjVF9HBZ0
         C3Qw==
X-Gm-Message-State: APjAAAUfQ1uqhUn+md4/XYjRU/fHGaTv0qDzzgtDa9TWbD492SBtN9N+
        ZiHiNxqDHL/UIRB8z9YPUNKycdGN
X-Google-Smtp-Source: APXvYqz/X+MotYvclhnjVP09N++4Yah8LtP7QrdxIF9fMsRoR5S7MYR5z1ku7vpWcKisJv4ch7JigA==
X-Received: by 2002:adf:ff91:: with SMTP id j17mr60176543wrr.114.1555510475632;
        Wed, 17 Apr 2019 07:14:35 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id z13sm80627828wrw.36.2019.04.17.07.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:14:34 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 03/12] dma-buf: lock the reservation object during
 (un)map_dma_buf v3
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-4-christian.koenig@amd.com>
 <20190417140804.GD13337@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e22d3797-30e4-f4fd-be9c-42aedf213c5e@gmail.com>
Date:   Wed, 17 Apr 2019 16:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417140804.GD13337@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.04.19 um 16:08 schrieb Daniel Vetter:
> On Tue, Apr 16, 2019 at 08:38:32PM +0200, Christian König wrote:
>> Make it mandatory for dynamic dma-buf callbacks to be called with the
>> reservation lock held.
>>
>> For static dma-buf exporters we still have the fallback of using cached sgt.
>>
>> v2: reordered
>> v3: rebased on sgt caching
>> v4: use the cached sgt when possible
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> I think there's a bit a rebase chaos going on:
> - some comments left behind with no_sgt_cache, which I can't find anymore
> - the function signature rework of dma_buf_attach should imo be split out

Ah, crap thought I've got all of those. Going to fix that.

> Next issue is that the reservation object locking is still in the path of
> dma_buf_map, so probably still going to result in tons of lockdep splats.
> Except the i915+amdgpu path should now work due to the fastpath.

I actually found a solution for that :)

The idea is now that we always cache the sgt in the attachment unless 
the dynamic flag (previously no_sgt_cache flag) is set. And this cached 
sgt is created without holding the lock.

We either need to document that really well or maybe split the mapping 
callbacks into map/unmap and map_lock/unmap_locked. Opinions?

>
> Not sure that's a solution that really works, just hides that
> fundamentally we still have that issue of incompatible locking chains
> between different drivers.

We can now make a slow transition between static and dynamic DMA-buf 
handling, so only driver who can do the locking will be affected.

Christian.

> -Daniel
>
>> ---
>>   drivers/dma-buf/dma-buf.c                     | 24 ++++++++++---------
>>   drivers/gpu/drm/armada/armada_gem.c           |  6 ++++-
>>   drivers/gpu/drm/drm_prime.c                   |  6 ++++-
>>   drivers/gpu/drm/i915/i915_gem_dmabuf.c        |  6 ++++-
>>   drivers/gpu/drm/tegra/gem.c                   |  6 ++++-
>>   drivers/gpu/drm/udl/udl_dmabuf.c              |  6 ++++-
>>   .../common/videobuf2/videobuf2-dma-contig.c   |  6 ++++-
>>   .../media/common/videobuf2/videobuf2-dma-sg.c |  6 ++++-
>>   drivers/staging/media/tegra-vde/tegra-vde.c   |  6 ++++-
>>   include/linux/dma-buf.h                       | 23 ++++++++++++++++--
>>   10 files changed, 74 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index ef480e5fb239..83c92bfd964c 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -532,8 +532,9 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
>>   /**
>>    * dma_buf_attach - Add the device to dma_buf's attachments list; optionally,
>>    * calls attach() of dma_buf_ops to allow device-specific attach functionality
>> - * @dmabuf:	[in]	buffer to attach device to.
>> - * @dev:	[in]	device to be attached.
>> + * @info:	[in]	holds all the attach related information provided
>> + *			by the importer. see &struct dma_buf_attach_info
>> + *			for further details.
>>    *
>>    * Returns struct dma_buf_attachment pointer for this attachment. Attachments
>>    * must be cleaned up by calling dma_buf_detach().
>> @@ -547,20 +548,20 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
>>    * accessible to @dev, and cannot be moved to a more suitable place. This is
>>    * indicated with the error code -EBUSY.
>>    */
>> -struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
>> -					  struct device *dev)
>> +struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info)
>>   {
>> +	struct dma_buf *dmabuf = info->dmabuf;
>>   	struct dma_buf_attachment *attach;
>>   	int ret;
>>   
>> -	if (WARN_ON(!dmabuf || !dev))
>> +	if (WARN_ON(!dmabuf || !info->dev))
>>   		return ERR_PTR(-EINVAL);
>>   
>>   	attach = kzalloc(sizeof(*attach), GFP_KERNEL);
>>   	if (!attach)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	attach->dev = dev;
>> +	attach->dev = info->dev;
>>   	attach->dmabuf = dmabuf;
>>   
>>   	mutex_lock(&dmabuf->lock);
>> @@ -688,9 +689,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
>>   	if (attach->sgt)
>>   		return attach->sgt;
>>   
>> -	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
>> -	if (!sg_table)
>> -		sg_table = ERR_PTR(-ENOMEM);
>> +	reservation_object_lock(attach->dmabuf->resv, NULL);
>> +	sg_table = dma_buf_map_attachment_locked(attach, direction);
>> +	reservation_object_unlock(attach->dmabuf->resv);
>>   
>>   	return sg_table;
>>   }
>> @@ -744,8 +745,9 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
>>   	if (attach->sgt == sg_table)
>>   		return;
>>   
>> -	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
>> -						direction);
>> +	reservation_object_lock(attach->dmabuf->resv, NULL);
>> +	dma_buf_unmap_attachment_locked(attach, sg_table, direction);
>> +	reservation_object_unlock(attach->dmabuf->resv);
>>   }
>>   EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment);
>>   
>> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
>> index 642d0e70d0f8..19c47821032f 100644
>> --- a/drivers/gpu/drm/armada/armada_gem.c
>> +++ b/drivers/gpu/drm/armada/armada_gem.c
>> @@ -501,6 +501,10 @@ armada_gem_prime_export(struct drm_device *dev, struct drm_gem_object *obj,
>>   struct drm_gem_object *
>>   armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = dev->dev,
>> +		.dmabuf = buf
>> +	};
>>   	struct dma_buf_attachment *attach;
>>   	struct armada_gem_object *dobj;
>>   
>> @@ -516,7 +520,7 @@ armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
>>   		}
>>   	}
>>   
>> -	attach = dma_buf_attach(buf, dev->dev);
>> +	attach = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(attach))
>>   		return ERR_CAST(attach);
>>   
>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>> index 231e3f6d5f41..1fadf5d5ed33 100644
>> --- a/drivers/gpu/drm/drm_prime.c
>> +++ b/drivers/gpu/drm/drm_prime.c
>> @@ -709,6 +709,10 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>   					    struct dma_buf *dma_buf,
>>   					    struct device *attach_dev)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = attach_dev,
>> +		.dmabuf = dma_buf
>> +	};
>>   	struct dma_buf_attachment *attach;
>>   	struct sg_table *sgt;
>>   	struct drm_gem_object *obj;
>> @@ -729,7 +733,7 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>   	if (!dev->driver->gem_prime_import_sg_table)
>>   		return ERR_PTR(-EINVAL);
>>   
>> -	attach = dma_buf_attach(dma_buf, attach_dev);
>> +	attach = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(attach))
>>   		return ERR_CAST(attach);
>>   
>> diff --git a/drivers/gpu/drm/i915/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
>> index 82e2ca17a441..aa7f685bd6ca 100644
>> --- a/drivers/gpu/drm/i915/i915_gem_dmabuf.c
>> +++ b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
>> @@ -277,6 +277,10 @@ static const struct drm_i915_gem_object_ops i915_gem_object_dmabuf_ops = {
>>   struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
>>   					     struct dma_buf *dma_buf)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = dev->dev,
>> +		.dmabuf = dma_buf
>> +	};
>>   	struct dma_buf_attachment *attach;
>>   	struct drm_i915_gem_object *obj;
>>   	int ret;
>> @@ -295,7 +299,7 @@ struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
>>   	}
>>   
>>   	/* need to attach */
>> -	attach = dma_buf_attach(dma_buf, dev->dev);
>> +	attach = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(attach))
>>   		return ERR_CAST(attach);
>>   
>> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
>> index 4f80100ff5f3..8e6b6c879add 100644
>> --- a/drivers/gpu/drm/tegra/gem.c
>> +++ b/drivers/gpu/drm/tegra/gem.c
>> @@ -332,6 +332,10 @@ struct tegra_bo *tegra_bo_create_with_handle(struct drm_file *file,
>>   static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
>>   					struct dma_buf *buf)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = drm->dev,
>> +		.dmabuf = buf
>> +	};
>>   	struct tegra_drm *tegra = drm->dev_private;
>>   	struct dma_buf_attachment *attach;
>>   	struct tegra_bo *bo;
>> @@ -341,7 +345,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
>>   	if (IS_ERR(bo))
>>   		return bo;
>>   
>> -	attach = dma_buf_attach(buf, drm->dev);
>> +	attach = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(attach)) {
>>   		err = PTR_ERR(attach);
>>   		goto free;
>> diff --git a/drivers/gpu/drm/udl/udl_dmabuf.c b/drivers/gpu/drm/udl/udl_dmabuf.c
>> index 556f62662aa9..86b928f9742f 100644
>> --- a/drivers/gpu/drm/udl/udl_dmabuf.c
>> +++ b/drivers/gpu/drm/udl/udl_dmabuf.c
>> @@ -226,6 +226,10 @@ static int udl_prime_create(struct drm_device *dev,
>>   struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
>>   				struct dma_buf *dma_buf)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = dev->dev,
>> +		.dmabuf = dma_buf
>> +	};
>>   	struct dma_buf_attachment *attach;
>>   	struct sg_table *sg;
>>   	struct udl_gem_object *uobj;
>> @@ -233,7 +237,7 @@ struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
>>   
>>   	/* need to attach */
>>   	get_device(dev->dev);
>> -	attach = dma_buf_attach(dma_buf, dev->dev);
>> +	attach = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(attach)) {
>>   		put_device(dev->dev);
>>   		return ERR_CAST(attach);
>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>> index aff0ab7bf83d..1f2687b5eb0e 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>> @@ -676,6 +676,10 @@ static void vb2_dc_detach_dmabuf(void *mem_priv)
>>   static void *vb2_dc_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>   	unsigned long size, enum dma_data_direction dma_dir)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = dev,
>> +		.dmabuf = dbuf
>> +	};
>>   	struct vb2_dc_buf *buf;
>>   	struct dma_buf_attachment *dba;
>>   
>> @@ -691,7 +695,7 @@ static void *vb2_dc_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>   
>>   	buf->dev = dev;
>>   	/* create attachment for the dmabuf with the user device */
>> -	dba = dma_buf_attach(dbuf, buf->dev);
>> +	dba = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(dba)) {
>>   		pr_err("failed to attach dmabuf\n");
>>   		kfree(buf);
>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> index 015e737095cd..cbd626d2393a 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> @@ -608,6 +608,10 @@ static void vb2_dma_sg_detach_dmabuf(void *mem_priv)
>>   static void *vb2_dma_sg_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>   	unsigned long size, enum dma_data_direction dma_dir)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = dev,
>> +		.dmabuf = dbuf
>> +	};
>>   	struct vb2_dma_sg_buf *buf;
>>   	struct dma_buf_attachment *dba;
>>   
>> @@ -623,7 +627,7 @@ static void *vb2_dma_sg_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>   
>>   	buf->dev = dev;
>>   	/* create attachment for the dmabuf with the user device */
>> -	dba = dma_buf_attach(dbuf, buf->dev);
>> +	dba = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(dba)) {
>>   		pr_err("failed to attach dmabuf\n");
>>   		kfree(buf);
>> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
>> index aa6c6bba961e..5a10c1facc27 100644
>> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
>> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
>> @@ -568,6 +568,10 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
>>   				   size_t *size,
>>   				   enum dma_data_direction dma_dir)
>>   {
>> +	struct dma_buf_attach_info attach_info = {
>> +		.dev = dev,
>> +		.dmabuf = dmabuf
>> +	};
>>   	struct dma_buf_attachment *attachment;
>>   	struct dma_buf *dmabuf;
>>   	struct sg_table *sgt;
>> @@ -591,7 +595,7 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
>>   		return -EINVAL;
>>   	}
>>   
>> -	attachment = dma_buf_attach(dmabuf, dev);
>> +	attachment = dma_buf_attach(&attach_info);
>>   	if (IS_ERR(attachment)) {
>>   		dev_err(dev, "Failed to attach dmabuf\n");
>>   		err = PTR_ERR(attachment);
>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>> index 18a78be53541..7e23758db3a4 100644
>> --- a/include/linux/dma-buf.h
>> +++ b/include/linux/dma-buf.h
>> @@ -128,6 +128,9 @@ struct dma_buf_ops {
>>   	 * any other kind of sharing that the exporter might wish to make
>>   	 * available to buffer-users.
>>   	 *
>> +	 * This is always called with the dmabuf->resv object locked when
>> +	 * no_sgt_cache is true.
>> +	 *
>>   	 * Returns:
>>   	 *
>>   	 * A &sg_table scatter list of or the backing storage of the DMA buffer,
>> @@ -148,6 +151,9 @@ struct dma_buf_ops {
>>   	 * It should also unpin the backing storage if this is the last mapping
>>   	 * of the DMA buffer, it the exporter supports backing storage
>>   	 * migration.
>> +	 *
>> +	 * This is always called with the dmabuf->resv object locked when
>> +	 * no_sgt_cache is true.
>>   	 */
>>   	void (*unmap_dma_buf)(struct dma_buf_attachment *,
>>   			      struct sg_table *,
>> @@ -370,6 +376,19 @@ struct dma_buf_export_info {
>>   	struct dma_buf_export_info name = { .exp_name = KBUILD_MODNAME, \
>>   					 .owner = THIS_MODULE }
>>   
>> +/**
>> + * struct dma_buf_attach_info - holds information needed to attach to a dma_buf
>> + * @dmabuf:	the exported dma_buf
>> + * @dev:	the device which wants to import the attachment
>> + *
>> + * This structure holds the information required to attach to a buffer. Used
>> + * with dma_buf_attach() only.
>> + */
>> +struct dma_buf_attach_info {
>> +	struct dma_buf *dmabuf;
>> +	struct device *dev;
>> +};
>> +
>>   /**
>>    * get_dma_buf - convenience wrapper for get_file.
>>    * @dmabuf:	[in]	pointer to dma_buf
>> @@ -384,8 +403,8 @@ static inline void get_dma_buf(struct dma_buf *dmabuf)
>>   	get_file(dmabuf->file);
>>   }
>>   
>> -struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
>> -							struct device *dev);
>> +struct dma_buf_attachment *
>> +dma_buf_attach(const struct dma_buf_attach_info *info);
>>   void dma_buf_detach(struct dma_buf *dmabuf,
>>   				struct dma_buf_attachment *dmabuf_attach);
>>   
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

