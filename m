Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24957C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF09620693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxU405xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbfDQTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:13:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDQTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:13:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so33344443wrq.8;
        Wed, 17 Apr 2019 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ozO2cnFnpOO3JZOOo92G1Ui3z45QZOTHusdUc6wSEeI=;
        b=XxU405xDbPQfGBgXXj61lw/EPI0thHWxJ2j/pwNKXZYS8lRG5hQcO+wyUIUctIdzhj
         KvaUSZm+xtEFpB/uZGNTAsjxAZuSb+KmBn/qpjgPBj4BXn2L4yljd/Gn/8p97HzxVbqV
         W8BSdgZ9WWQbbDkEKYgkZ7lKDPUtxkUdxa8T6SEwGiBkOgFgXH0yJ7oFOkLOxyPZjypc
         9c2dObYbJMBr71ixTI1KKxxr+wgen1ZC1t9Gs2gekt18r7QrbbygQMyoO8Ntovh5ZsPG
         2GU8SVOSEofZ+bnd9y4J/uj7EP5OJK9rtmp3K0blAsCxtVX+Jy/VpflbcZ7GdYr1UcS1
         kspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ozO2cnFnpOO3JZOOo92G1Ui3z45QZOTHusdUc6wSEeI=;
        b=p3BHVuymlxFjW0fixxhszVUN9+mXCdVBUbwdpUGfq1teG9jcvS8wTcjCKMeO1EXJTb
         yT9bEp1suLbJrKU/0dcasLpylVn1TJqMgfCW1n6Elu89BqwrPNMGiq98xywG/gGDPHT8
         1dVnvZKODnDch7NgKwXmoDqDF37N714CtwXPXp1g6vt3tKo1fB0A1So0WqK4esJWiy8l
         eEnuz86tDGhOn9L5SmyrF377KxSRFV3GB3ky5Xs5TJfWyPjJjQQHbSBHh6W0OAVg0726
         Ht1q6OFeSblve/hrvHHFdeMp8CFa4QRAXwC8lH1lWKq0AEiP9SrjRgHf+PZ+QULgai9H
         BQzw==
X-Gm-Message-State: APjAAAUSUxUVvLixHZ4aBY6JvEqmdqoA6VbAnyibUxs4puXyxEPz6zZJ
        c0czHEioJ/E6ywhnULyvtRCUZsoN
X-Google-Smtp-Source: APXvYqwvgUXKHUxGS7CAa06i2YTOR8LuRNV3GwfMTEjBVZyl2nJ/k6exnke1ak1zkNJucPko0UrvLA==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr58392436wrs.121.1555528403666;
        Wed, 17 Apr 2019 12:13:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id v184sm5609497wma.6.2019.04.17.12.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 12:13:23 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback
 v5
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-5-christian.koenig@amd.com>
 <20190417190719.GL13337@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <03a04d1d-9bc0-8f20-0436-b0f0017f0506@gmail.com>
Date:   Wed, 17 Apr 2019 21:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417190719.GL13337@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.04.19 um 21:07 schrieb Daniel Vetter:
> On Tue, Apr 16, 2019 at 08:38:33PM +0200, Christian König wrote:
>> Each importer can now provide an invalidate_mappings callback.
>>
>> This allows the exporter to provide the mappings without the need to pin
>> the backing store.
>>
>> v2: don't try to invalidate mappings when the callback is NULL,
>>      lock the reservation obj while using the attachments,
>>      add helper to set the callback
>> v3: move flag for invalidation support into the DMA-buf,
>>      use new attach_info structure to set the callback
>> v4: use importer_priv field instead of mangling exporter priv.
>> v5: drop invalidation_supported flag
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/dma-buf/dma-buf.c | 37 +++++++++++++++++++++++++++++++++++++
>>   include/linux/dma-buf.h   | 33 +++++++++++++++++++++++++++++++--
>>   2 files changed, 68 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 83c92bfd964c..a3738fab3927 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -563,6 +563,8 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
>>   
>>   	attach->dev = info->dev;
>>   	attach->dmabuf = dmabuf;
>> +	attach->importer_priv = info->importer_priv;
>> +	attach->invalidate = info->invalidate;
>>   
>>   	mutex_lock(&dmabuf->lock);
>>   
>> @@ -571,7 +573,9 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
>>   		if (ret)
>>   			goto err_attach;
>>   	}
>> +	reservation_object_lock(dmabuf->resv, NULL);
>>   	list_add(&attach->node, &dmabuf->attachments);
>> +	reservation_object_unlock(dmabuf->resv);
>>   
>>   	mutex_unlock(&dmabuf->lock);
>>   
>> @@ -615,7 +619,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
>>   					   DMA_BIDIRECTIONAL);
>>   
>>   	mutex_lock(&dmabuf->lock);
>> +	reservation_object_lock(dmabuf->resv, NULL);
>>   	list_del(&attach->node);
>> +	reservation_object_unlock(dmabuf->resv);
>>   	if (dmabuf->ops->detach)
>>   		dmabuf->ops->detach(dmabuf, attach);
>>   
>> @@ -653,7 +659,16 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
>>   	if (attach->sgt)
>>   		return attach->sgt;
>>   
>> +	/*
>> +	 * Mapping a DMA-buf can trigger its invalidation, prevent sending this
>> +	 * event to the caller by temporary removing this attachment from the
>> +	 * list.
>> +	 */
>> +	if (attach->invalidate)
>> +		list_del(&attach->node);
> Just noticed this: Why do we need this? invalidate needs the reservation
> lock, as does map_attachment. It should be impssoble to have someone else
> sneak in here.

I was having problems with self triggered invalidations.

E.g. client A tries to map an attachment, that in turn causes the buffer 
to move to a new place and client A is informed about that movement with 
an invalidation.

Christian.

> -Daniel
>
>>   	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
>> +	if (attach->invalidate)
>> +		list_add(&attach->node, &attach->dmabuf->attachments);
>>   	if (!sg_table)
>>   		sg_table = ERR_PTR(-ENOMEM);
>>   
>> @@ -751,6 +766,26 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
>>   }
>>   EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment);
>>   
>> +/**
>> + * dma_buf_invalidate_mappings - invalidate all mappings of this dma_buf
>> + *
>> + * @dmabuf:	[in]	buffer which mappings should be invalidated
>> + *
>> + * Informs all attachmenst that they need to destroy and recreated all their
>> + * mappings.
>> + */
>> +void dma_buf_invalidate_mappings(struct dma_buf *dmabuf)
>> +{
>> +	struct dma_buf_attachment *attach;
>> +
>> +	reservation_object_assert_held(dmabuf->resv);
>> +
>> +	list_for_each_entry(attach, &dmabuf->attachments, node)
>> +		if (attach->invalidate)
>> +			attach->invalidate(attach);
>> +}
>> +EXPORT_SYMBOL_GPL(dma_buf_invalidate_mappings);
>> +
>>   /**
>>    * DOC: cpu access
>>    *
>> @@ -1163,10 +1198,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>>   		seq_puts(s, "\tAttached Devices:\n");
>>   		attach_count = 0;
>>   
>> +		reservation_object_lock(buf_obj->resv, NULL);
>>   		list_for_each_entry(attach_obj, &buf_obj->attachments, node) {
>>   			seq_printf(s, "\t%s\n", dev_name(attach_obj->dev));
>>   			attach_count++;
>>   		}
>> +		reservation_object_unlock(buf_obj->resv);
>>   
>>   		seq_printf(s, "Total %d devices attached\n\n",
>>   				attach_count);
>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>> index 7e23758db3a4..ece4638359a8 100644
>> --- a/include/linux/dma-buf.h
>> +++ b/include/linux/dma-buf.h
>> @@ -324,6 +324,7 @@ struct dma_buf {
>>    * @dev: device attached to the buffer.
>>    * @node: list of dma_buf_attachment.
>>    * @priv: exporter specific attachment data.
>> + * @importer_priv: importer specific attachment data.
>>    *
>>    * This structure holds the attachment information between the dma_buf buffer
>>    * and its user device(s). The list contains one attachment struct per device
>> @@ -340,6 +341,29 @@ struct dma_buf_attachment {
>>   	struct list_head node;
>>   	void *priv;
>>   	struct sg_table *sgt;
>> +	void *importer_priv;
>> +
>> +	/**
>> +	 * @invalidate:
>> +	 *
>> +	 * Optional callback provided by the importer of the dma-buf.
>> +	 *
>> +	 * If provided the exporter can avoid pinning the backing store while
>> +	 * mappings exists.
>> +	 *
>> +	 * The function is called with the lock of the reservation object
>> +	 * associated with the dma_buf held and the mapping function must be
>> +	 * called with this lock held as well. This makes sure that no mapping
>> +	 * is created concurrently with an ongoing invalidation.
>> +	 *
>> +	 * After the callback all existing mappings are still valid until all
>> +	 * fences in the dma_bufs reservation object are signaled, but should be
>> +	 * destroyed by the importer as soon as possible.
>> +	 *
>> +	 * New mappings can be created immediately, but can't be used before the
>> +	 * exclusive fence in the dma_bufs reservation object is signaled.
>> +	 */
>> +	void (*invalidate)(struct dma_buf_attachment *attach);
>>   };
>>   
>>   /**
>> @@ -378,8 +402,10 @@ struct dma_buf_export_info {
>>   
>>   /**
>>    * struct dma_buf_attach_info - holds information needed to attach to a dma_buf
>> - * @dmabuf:	the exported dma_buf
>> - * @dev:	the device which wants to import the attachment
>> + * @dmabuf:		the exported dma_buf
>> + * @dev:		the device which wants to import the attachment
>> + * @importer_priv:	private data of importer to this attachment
>> + * @invalidate:		callback to use for invalidating mappings
>>    *
>>    * This structure holds the information required to attach to a buffer. Used
>>    * with dma_buf_attach() only.
>> @@ -387,6 +413,8 @@ struct dma_buf_export_info {
>>   struct dma_buf_attach_info {
>>   	struct dma_buf *dmabuf;
>>   	struct device *dev;
>> +	void *importer_priv;
>> +	void (*invalidate)(struct dma_buf_attachment *attach);
>>   };
>>   
>>   /**
>> @@ -423,6 +451,7 @@ void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *,
>>   				     enum dma_data_direction);
>>   void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
>>   				enum dma_data_direction);
>> +void dma_buf_invalidate_mappings(struct dma_buf *dma_buf);
>>   int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
>>   			     enum dma_data_direction dir);
>>   int dma_buf_end_cpu_access(struct dma_buf *dma_buf,
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

