Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D8C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E420675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXrQbgNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbfDQRKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:10:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40280 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:10:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so32947940wre.7;
        Wed, 17 Apr 2019 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9CP27iTYtmXmc5G/CNCdvzzhtigy7vNfiFxnXbukxQ8=;
        b=KXrQbgNyW1JvUAnTsPR5rIZAFFQjOiQa2muqRgY+nG57oqR9cckRWwE3vP6YidjFQX
         RU4hbMNXYISYuleZUq0iXiDcJTHxJhXzoYrw4EBlS4D3v5TrLhgMhUwzpP9n/IbX+CIJ
         wvoPmXaO7n/xLOfGpViioLSvn62qqaT9FNd8A0LC97TNLZj3ucMVgAJbVWEyW/FRCMhG
         npSi7Tx9Kru0A39FaDf/tAY0sgmG6NtvJPVLLile0tfLisX+gB+Ffvtr9EHWJSyU7ewS
         R6tnhvOgtu9WDOP84o6IRPUpo9wjdPZ/uFtESyzSKBEDAfSp4mf9hU3SF6crNDA+J/i9
         zKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9CP27iTYtmXmc5G/CNCdvzzhtigy7vNfiFxnXbukxQ8=;
        b=t74pzgBPVuTeAFv4q7tjjlBIntkm4SoRjAxtP/tffjS8MFXZbLSY38utudtH7PpSM9
         f6tJvazoNzKrOgFGuzogkMQkejXR9kUnXi3BbXAOFZZUfKHou/z1/iWl6L8rUVk38HnI
         UJHMA0dQTs7wdmAvaBJiIBK3bT7+nvnpjtXt2xvEP508+IJxdiOQbHAWyi2z0i9218DX
         Nq/qtS7C4qUdZxNVWZMmqN5NHlcyPfR4AQAjWcELEIk1uaz8NESwMR+SVtuagdJ4MjdK
         JS1turK6Rfc/WHOgWswG5vQ1uRX1gYa6nnsRZYyHX0HJy73nw4MvVsMXQYxh+WGcEgN0
         8ULQ==
X-Gm-Message-State: APjAAAUXsGsCTWRewpyxy/JkvpFgGByYxl+p6FcmTzZ1Fj/jt9YxfWCf
        LV6uvTZRA6t0uUOrFwnSrHM=
X-Google-Smtp-Source: APXvYqzalf7zd58XIsl63rUXoD8nT5N1aTNHkuOWDB58M9nhPzA/IF+G8/MNjWVVvz+Xu32FIDwZ+A==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr57526334wrn.193.1555521044433;
        Wed, 17 Apr 2019 10:10:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id s1sm45717105wrt.43.2019.04.17.10.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:10:43 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 03/12] dma-buf: lock the reservation object during
 (un)map_dma_buf v3
To:     christian.koenig@amd.com, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-4-christian.koenig@amd.com>
 <20190417140804.GD13337@phenom.ffwll.local>
 <e22d3797-30e4-f4fd-be9c-42aedf213c5e@gmail.com>
 <20190417142632.GF13337@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <adc8c3ca-0837-0b7a-6421-4ecb5cc272ca@gmail.com>
Date:   Wed, 17 Apr 2019 19:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417142632.GF13337@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.04.19 um 16:26 schrieb Daniel Vetter:
> On Wed, Apr 17, 2019 at 04:14:32PM +0200, Christian König wrote:
>> Am 17.04.19 um 16:08 schrieb Daniel Vetter:
>>> On Tue, Apr 16, 2019 at 08:38:32PM +0200, Christian König wrote:
>>>> Make it mandatory for dynamic dma-buf callbacks to be called with the
>>>> reservation lock held.
>>>>
>>>> For static dma-buf exporters we still have the fallback of using cached sgt.
>>>>
>>>> v2: reordered
>>>> v3: rebased on sgt caching
>>>> v4: use the cached sgt when possible
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> I think there's a bit a rebase chaos going on:
>>> - some comments left behind with no_sgt_cache, which I can't find anymore
>>> - the function signature rework of dma_buf_attach should imo be split out
>> Ah, crap thought I've got all of those. Going to fix that.
>>
>>> Next issue is that the reservation object locking is still in the path of
>>> dma_buf_map, so probably still going to result in tons of lockdep splats.
>>> Except the i915+amdgpu path should now work due to the fastpath.
>> I actually found a solution for that :)
>>
>> The idea is now that we always cache the sgt in the attachment unless the
>> dynamic flag (previously no_sgt_cache flag) is set. And this cached sgt is
>> created without holding the lock.
> Yeah I think that idea works.
>
>> We either need to document that really well or maybe split the mapping
>> callbacks into map/unmap and map_lock/unmap_locked. Opinions?
> I think the implementation doesn't. Exporter can't decide on its own
> whether dynamic/static is what's needed, we need to decide that for each
> attachment, taking both exporter and importer capabilities into account.

Well that's what the pin/unpin callbacks are good for :)

Essentially we have to handle the following cases:
a) dynamic exporter and dynamic importer
         Nothing special here and we don't need the sgt caching nor pinning.

b) dynamic exporter and static importer
         The pin/unpin callbacks are used to inform the exporter that it 
needs to keep the buffer in the current place.

c) static exporter and dynamic importer
         We use the sgt caching to avoid calling the exporter with the 
common lock held.

d) static exporter and static importer
         We use the sgt caching, but that is actually only optional.

> I think if we do that, then it should work out. I replied on the pin/unpin
> interface patch with some more concrete thoughts. Maybe best to continue
> that discussion there, with more context.

Yeah, that is probably a good idea.

Regards,
Christian.


> -Daniel
>
>>> Not sure that's a solution that really works, just hides that
>>> fundamentally we still have that issue of incompatible locking chains
>>> between different drivers.
>> We can now make a slow transition between static and dynamic DMA-buf
>> handling, so only driver who can do the locking will be affected.
>>
>> Christian.
>>
>>> -Daniel
>>>
>>>> ---
>>>>    drivers/dma-buf/dma-buf.c                     | 24 ++++++++++---------
>>>>    drivers/gpu/drm/armada/armada_gem.c           |  6 ++++-
>>>>    drivers/gpu/drm/drm_prime.c                   |  6 ++++-
>>>>    drivers/gpu/drm/i915/i915_gem_dmabuf.c        |  6 ++++-
>>>>    drivers/gpu/drm/tegra/gem.c                   |  6 ++++-
>>>>    drivers/gpu/drm/udl/udl_dmabuf.c              |  6 ++++-
>>>>    .../common/videobuf2/videobuf2-dma-contig.c   |  6 ++++-
>>>>    .../media/common/videobuf2/videobuf2-dma-sg.c |  6 ++++-
>>>>    drivers/staging/media/tegra-vde/tegra-vde.c   |  6 ++++-
>>>>    include/linux/dma-buf.h                       | 23 ++++++++++++++++--
>>>>    10 files changed, 74 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>>> index ef480e5fb239..83c92bfd964c 100644
>>>> --- a/drivers/dma-buf/dma-buf.c
>>>> +++ b/drivers/dma-buf/dma-buf.c
>>>> @@ -532,8 +532,9 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
>>>>    /**
>>>>     * dma_buf_attach - Add the device to dma_buf's attachments list; optionally,
>>>>     * calls attach() of dma_buf_ops to allow device-specific attach functionality
>>>> - * @dmabuf:	[in]	buffer to attach device to.
>>>> - * @dev:	[in]	device to be attached.
>>>> + * @info:	[in]	holds all the attach related information provided
>>>> + *			by the importer. see &struct dma_buf_attach_info
>>>> + *			for further details.
>>>>     *
>>>>     * Returns struct dma_buf_attachment pointer for this attachment. Attachments
>>>>     * must be cleaned up by calling dma_buf_detach().
>>>> @@ -547,20 +548,20 @@ EXPORT_SYMBOL_GPL(dma_buf_put);
>>>>     * accessible to @dev, and cannot be moved to a more suitable place. This is
>>>>     * indicated with the error code -EBUSY.
>>>>     */
>>>> -struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
>>>> -					  struct device *dev)
>>>> +struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info)
>>>>    {
>>>> +	struct dma_buf *dmabuf = info->dmabuf;
>>>>    	struct dma_buf_attachment *attach;
>>>>    	int ret;
>>>> -	if (WARN_ON(!dmabuf || !dev))
>>>> +	if (WARN_ON(!dmabuf || !info->dev))
>>>>    		return ERR_PTR(-EINVAL);
>>>>    	attach = kzalloc(sizeof(*attach), GFP_KERNEL);
>>>>    	if (!attach)
>>>>    		return ERR_PTR(-ENOMEM);
>>>> -	attach->dev = dev;
>>>> +	attach->dev = info->dev;
>>>>    	attach->dmabuf = dmabuf;
>>>>    	mutex_lock(&dmabuf->lock);
>>>> @@ -688,9 +689,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
>>>>    	if (attach->sgt)
>>>>    		return attach->sgt;
>>>> -	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
>>>> -	if (!sg_table)
>>>> -		sg_table = ERR_PTR(-ENOMEM);
>>>> +	reservation_object_lock(attach->dmabuf->resv, NULL);
>>>> +	sg_table = dma_buf_map_attachment_locked(attach, direction);
>>>> +	reservation_object_unlock(attach->dmabuf->resv);
>>>>    	return sg_table;
>>>>    }
>>>> @@ -744,8 +745,9 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
>>>>    	if (attach->sgt == sg_table)
>>>>    		return;
>>>> -	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
>>>> -						direction);
>>>> +	reservation_object_lock(attach->dmabuf->resv, NULL);
>>>> +	dma_buf_unmap_attachment_locked(attach, sg_table, direction);
>>>> +	reservation_object_unlock(attach->dmabuf->resv);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment);
>>>> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
>>>> index 642d0e70d0f8..19c47821032f 100644
>>>> --- a/drivers/gpu/drm/armada/armada_gem.c
>>>> +++ b/drivers/gpu/drm/armada/armada_gem.c
>>>> @@ -501,6 +501,10 @@ armada_gem_prime_export(struct drm_device *dev, struct drm_gem_object *obj,
>>>>    struct drm_gem_object *
>>>>    armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = dev->dev,
>>>> +		.dmabuf = buf
>>>> +	};
>>>>    	struct dma_buf_attachment *attach;
>>>>    	struct armada_gem_object *dobj;
>>>> @@ -516,7 +520,7 @@ armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
>>>>    		}
>>>>    	}
>>>> -	attach = dma_buf_attach(buf, dev->dev);
>>>> +	attach = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(attach))
>>>>    		return ERR_CAST(attach);
>>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>>> index 231e3f6d5f41..1fadf5d5ed33 100644
>>>> --- a/drivers/gpu/drm/drm_prime.c
>>>> +++ b/drivers/gpu/drm/drm_prime.c
>>>> @@ -709,6 +709,10 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>>>    					    struct dma_buf *dma_buf,
>>>>    					    struct device *attach_dev)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = attach_dev,
>>>> +		.dmabuf = dma_buf
>>>> +	};
>>>>    	struct dma_buf_attachment *attach;
>>>>    	struct sg_table *sgt;
>>>>    	struct drm_gem_object *obj;
>>>> @@ -729,7 +733,7 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>>>    	if (!dev->driver->gem_prime_import_sg_table)
>>>>    		return ERR_PTR(-EINVAL);
>>>> -	attach = dma_buf_attach(dma_buf, attach_dev);
>>>> +	attach = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(attach))
>>>>    		return ERR_CAST(attach);
>>>> diff --git a/drivers/gpu/drm/i915/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
>>>> index 82e2ca17a441..aa7f685bd6ca 100644
>>>> --- a/drivers/gpu/drm/i915/i915_gem_dmabuf.c
>>>> +++ b/drivers/gpu/drm/i915/i915_gem_dmabuf.c
>>>> @@ -277,6 +277,10 @@ static const struct drm_i915_gem_object_ops i915_gem_object_dmabuf_ops = {
>>>>    struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
>>>>    					     struct dma_buf *dma_buf)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = dev->dev,
>>>> +		.dmabuf = dma_buf
>>>> +	};
>>>>    	struct dma_buf_attachment *attach;
>>>>    	struct drm_i915_gem_object *obj;
>>>>    	int ret;
>>>> @@ -295,7 +299,7 @@ struct drm_gem_object *i915_gem_prime_import(struct drm_device *dev,
>>>>    	}
>>>>    	/* need to attach */
>>>> -	attach = dma_buf_attach(dma_buf, dev->dev);
>>>> +	attach = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(attach))
>>>>    		return ERR_CAST(attach);
>>>> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
>>>> index 4f80100ff5f3..8e6b6c879add 100644
>>>> --- a/drivers/gpu/drm/tegra/gem.c
>>>> +++ b/drivers/gpu/drm/tegra/gem.c
>>>> @@ -332,6 +332,10 @@ struct tegra_bo *tegra_bo_create_with_handle(struct drm_file *file,
>>>>    static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
>>>>    					struct dma_buf *buf)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = drm->dev,
>>>> +		.dmabuf = buf
>>>> +	};
>>>>    	struct tegra_drm *tegra = drm->dev_private;
>>>>    	struct dma_buf_attachment *attach;
>>>>    	struct tegra_bo *bo;
>>>> @@ -341,7 +345,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
>>>>    	if (IS_ERR(bo))
>>>>    		return bo;
>>>> -	attach = dma_buf_attach(buf, drm->dev);
>>>> +	attach = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(attach)) {
>>>>    		err = PTR_ERR(attach);
>>>>    		goto free;
>>>> diff --git a/drivers/gpu/drm/udl/udl_dmabuf.c b/drivers/gpu/drm/udl/udl_dmabuf.c
>>>> index 556f62662aa9..86b928f9742f 100644
>>>> --- a/drivers/gpu/drm/udl/udl_dmabuf.c
>>>> +++ b/drivers/gpu/drm/udl/udl_dmabuf.c
>>>> @@ -226,6 +226,10 @@ static int udl_prime_create(struct drm_device *dev,
>>>>    struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
>>>>    				struct dma_buf *dma_buf)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = dev->dev,
>>>> +		.dmabuf = dma_buf
>>>> +	};
>>>>    	struct dma_buf_attachment *attach;
>>>>    	struct sg_table *sg;
>>>>    	struct udl_gem_object *uobj;
>>>> @@ -233,7 +237,7 @@ struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
>>>>    	/* need to attach */
>>>>    	get_device(dev->dev);
>>>> -	attach = dma_buf_attach(dma_buf, dev->dev);
>>>> +	attach = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(attach)) {
>>>>    		put_device(dev->dev);
>>>>    		return ERR_CAST(attach);
>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>>>> index aff0ab7bf83d..1f2687b5eb0e 100644
>>>> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>>>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>>>> @@ -676,6 +676,10 @@ static void vb2_dc_detach_dmabuf(void *mem_priv)
>>>>    static void *vb2_dc_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>>>    	unsigned long size, enum dma_data_direction dma_dir)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = dev,
>>>> +		.dmabuf = dbuf
>>>> +	};
>>>>    	struct vb2_dc_buf *buf;
>>>>    	struct dma_buf_attachment *dba;
>>>> @@ -691,7 +695,7 @@ static void *vb2_dc_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>>>    	buf->dev = dev;
>>>>    	/* create attachment for the dmabuf with the user device */
>>>> -	dba = dma_buf_attach(dbuf, buf->dev);
>>>> +	dba = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(dba)) {
>>>>    		pr_err("failed to attach dmabuf\n");
>>>>    		kfree(buf);
>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>>>> index 015e737095cd..cbd626d2393a 100644
>>>> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>>>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>>>> @@ -608,6 +608,10 @@ static void vb2_dma_sg_detach_dmabuf(void *mem_priv)
>>>>    static void *vb2_dma_sg_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>>>    	unsigned long size, enum dma_data_direction dma_dir)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = dev,
>>>> +		.dmabuf = dbuf
>>>> +	};
>>>>    	struct vb2_dma_sg_buf *buf;
>>>>    	struct dma_buf_attachment *dba;
>>>> @@ -623,7 +627,7 @@ static void *vb2_dma_sg_attach_dmabuf(struct device *dev, struct dma_buf *dbuf,
>>>>    	buf->dev = dev;
>>>>    	/* create attachment for the dmabuf with the user device */
>>>> -	dba = dma_buf_attach(dbuf, buf->dev);
>>>> +	dba = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(dba)) {
>>>>    		pr_err("failed to attach dmabuf\n");
>>>>    		kfree(buf);
>>>> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
>>>> index aa6c6bba961e..5a10c1facc27 100644
>>>> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
>>>> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
>>>> @@ -568,6 +568,10 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
>>>>    				   size_t *size,
>>>>    				   enum dma_data_direction dma_dir)
>>>>    {
>>>> +	struct dma_buf_attach_info attach_info = {
>>>> +		.dev = dev,
>>>> +		.dmabuf = dmabuf
>>>> +	};
>>>>    	struct dma_buf_attachment *attachment;
>>>>    	struct dma_buf *dmabuf;
>>>>    	struct sg_table *sgt;
>>>> @@ -591,7 +595,7 @@ static int tegra_vde_attach_dmabuf(struct device *dev,
>>>>    		return -EINVAL;
>>>>    	}
>>>> -	attachment = dma_buf_attach(dmabuf, dev);
>>>> +	attachment = dma_buf_attach(&attach_info);
>>>>    	if (IS_ERR(attachment)) {
>>>>    		dev_err(dev, "Failed to attach dmabuf\n");
>>>>    		err = PTR_ERR(attachment);
>>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>>> index 18a78be53541..7e23758db3a4 100644
>>>> --- a/include/linux/dma-buf.h
>>>> +++ b/include/linux/dma-buf.h
>>>> @@ -128,6 +128,9 @@ struct dma_buf_ops {
>>>>    	 * any other kind of sharing that the exporter might wish to make
>>>>    	 * available to buffer-users.
>>>>    	 *
>>>> +	 * This is always called with the dmabuf->resv object locked when
>>>> +	 * no_sgt_cache is true.
>>>> +	 *
>>>>    	 * Returns:
>>>>    	 *
>>>>    	 * A &sg_table scatter list of or the backing storage of the DMA buffer,
>>>> @@ -148,6 +151,9 @@ struct dma_buf_ops {
>>>>    	 * It should also unpin the backing storage if this is the last mapping
>>>>    	 * of the DMA buffer, it the exporter supports backing storage
>>>>    	 * migration.
>>>> +	 *
>>>> +	 * This is always called with the dmabuf->resv object locked when
>>>> +	 * no_sgt_cache is true.
>>>>    	 */
>>>>    	void (*unmap_dma_buf)(struct dma_buf_attachment *,
>>>>    			      struct sg_table *,
>>>> @@ -370,6 +376,19 @@ struct dma_buf_export_info {
>>>>    	struct dma_buf_export_info name = { .exp_name = KBUILD_MODNAME, \
>>>>    					 .owner = THIS_MODULE }
>>>> +/**
>>>> + * struct dma_buf_attach_info - holds information needed to attach to a dma_buf
>>>> + * @dmabuf:	the exported dma_buf
>>>> + * @dev:	the device which wants to import the attachment
>>>> + *
>>>> + * This structure holds the information required to attach to a buffer. Used
>>>> + * with dma_buf_attach() only.
>>>> + */
>>>> +struct dma_buf_attach_info {
>>>> +	struct dma_buf *dmabuf;
>>>> +	struct device *dev;
>>>> +};
>>>> +
>>>>    /**
>>>>     * get_dma_buf - convenience wrapper for get_file.
>>>>     * @dmabuf:	[in]	pointer to dma_buf
>>>> @@ -384,8 +403,8 @@ static inline void get_dma_buf(struct dma_buf *dmabuf)
>>>>    	get_file(dmabuf->file);
>>>>    }
>>>> -struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
>>>> -							struct device *dev);
>>>> +struct dma_buf_attachment *
>>>> +dma_buf_attach(const struct dma_buf_attach_info *info);
>>>>    void dma_buf_detach(struct dma_buf *dmabuf,
>>>>    				struct dma_buf_attachment *dmabuf_attach);
>>>> -- 
>>>> 2.17.1
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

