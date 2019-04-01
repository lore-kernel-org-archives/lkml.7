Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6763D213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfDAQDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:03:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35601 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDAQDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:03:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id a71so5967330qkg.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UReHT3oq3rSq44Jr2SDibP3RCioNSCsqZcLVVWzyaMY=;
        b=SOvAY9nM7/FLtY0BEdoJFP3RrEmaT9e3xcu37R+XT3Ec/Joz+K9idrwAjJ7eO3ByzM
         wxcAjSJWWbq97KU6j9ipWEt7ykb9lm+j4QB0zmGe5BH1W4FZBCxGQbJ7ggHTCTI3k50J
         fjU3lFpDm4XaViANyDqLmBT3slYb/+DR2p7A+h5sJCWSb0pZCk5bcOH8fioozyd+E32V
         3GOBAFo0tQcB85AmqoasupGqMWLM3qOKhbXr0CbnEKhTyO+x9foilEKnHYyD7boW1YKO
         GyGYM5VEwu1borHFnuMEErTN/CEEDKIM7vsOVIeEtJLqXHq/LLuuaVGPi9kUBXiEniEQ
         ucYA==
X-Gm-Message-State: APjAAAU1Xn2j/u2cvECQBsFhLtjV8jT2+/cp6KuvXy4PsALmPX653Yw8
        VRJnN4yHjvFEYdY/ZA/k0to0VKSbBZo=
X-Google-Smtp-Source: APXvYqzgumu6RrKD3up0odNFHgdqf2BZ3LvDnucsxVvUQGSaRrMawYkNkAYL60JaQkaEJS9EH0c4Bg==
X-Received: by 2002:a05:620a:1315:: with SMTP id o21mr30842463qkj.228.1554134591150;
        Mon, 01 Apr 2019 09:03:11 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::fa4a? ([2601:602:9800:dae6::fa4a])
        by smtp.gmail.com with ESMTPSA id z20sm5669520qkb.52.2019.04.01.09.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:03:10 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
 <e8c45ba1-dfe9-a929-acf5-2e7c61ab7b1c@redhat.com>
 <678F3D1BB717D949B966B68EAEB446ED24EBCE09@DGGEMM506-MBS.china.huawei.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <9c28dcbb-0c9d-ec00-97cd-bec66116a5fd@redhat.com>
Date:   Mon, 1 Apr 2019 09:03:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED24EBCE09@DGGEMM506-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 7:26 PM, Zengtao (B) wrote:
> Hi laura:
> 
>> -----Original Message-----
>> From: Laura Abbott [mailto:labbott@redhat.com]
>> Sent: Friday, March 29, 2019 9:27 PM
>> To: Zengtao (B) <prime.zeng@hisilicon.com>; sumit.semwal@linaro.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Arve Hjønnevåg
>> <arve@android.com>; Todd Kjos <tkjos@android.com>; Martijn Coenen
>> <maco@android.com>; Joel Fernandes <joel@joelfernandes.org>;
>> Christian Brauner <christian@brauner.io>; devel@driverdev.osuosl.org;
>> dri-devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
>> driver use
>>
>> On 3/29/19 11:40 AM, Zeng Tao wrote:
>>> There are two reasons for this patch:
>>> 1. There are some potential requirements for ion_alloc in kernel
>>> space, some media drivers need to allocate media buffers from ion
>>> instead of buddy or dma framework, this is more convient and clean
>>> very for media drivers. And In that case, ion is the only media buffer
>>> provider, it's more easier to maintain.
>>> 2. Fd is only needed by user processes, not the kernel space, so
>>> dma_buf should be returned instead of fd for kernel space, and
>>> dma_buf_fd should be called only for userspace api.
>>>
>>
>> I really want to just NAK this because it doesn't seem like something
>> that's necessary. The purpose of Ion is to provide buffers to userspace
>> because there's no other way for userspace to get access to the memory.
>> The kernel already has other APIs to access the memory. This also
>> complicates the re-work that's been happening where the requirement is
>> only userspace.
>>
>> Can you be more detailed about which media drivers you are referring to
>> and why they can't just use other APIs?
>>
> 
> I think I 've got your point, the ION is designed for usespace, but for kernel
>   space, we are really lacking of someone which plays the same role,(allocate
> media memory, share the memory using dma_buf, provide debug and statistics
> for media memory).
> 
> In fact, for kernel space, we have the dma framework, dma-buf, etc..
> And we can work on top of such apis, but some duplicate jobs(everyone has
>   to maintain its own buffer sharing, debug and statistics).
> So we need to have some to do the common things(ION's the best choice now)
> 

Keep in mind that Ion is a thin shell of what it was as most of the
debugging and statistics was removed because it was buggy. Most of that
should end up going at the dma_buf layer since it's really a dma_buf allocation
API.

> When the ION was introduced, a lot of media memory frameworks existed, the
> dma framework was not so good, so ION heaps, integrated buffer sharing, statistics
> and usespace api were the required features, but now dma framework is more powerful,
> we don't even need ION heaps now, but the userspace api, buffer sharing, statistics are
> still needed, and the buffer sharing, statistics can be re-worked and export to kernel space,
> not only used by userspace, , and that is my point.
> 

I see what you are getting at but I don't think the same thing
applies to the kernel as it does userspace. We can enforce a
single way of using the dma_buf fd in userspace but the kernel
has a variety of ways to use dma_buf because each driver and
framework has its own needs. I'm still not convinced that adding
Ion APIs in the kernel is the right option since as you point out
we don't really need the heaps. That mostly leaves Ion as a wrapper
to handle doing the export. Maybe we could benefit from that
but I think it might require more thought.

I'd rather see a proposal in the media API itself showing what
you think is necessary but without using Ion. That would be
a good start so we could fully review what might make sense to
pull out of Ion into something common.

Thanks,
Laura

>>
>>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
>>> ---
>>>    drivers/staging/android/ion/ion.c | 32
>> +++++++++++++++++---------------
>>>    1 file changed, 17 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/staging/android/ion/ion.c
>>> b/drivers/staging/android/ion/ion.c
>>> index 92c2914..e93fb49 100644
>>> --- a/drivers/staging/android/ion/ion.c
>>> +++ b/drivers/staging/android/ion/ion.c
>>> @@ -387,13 +387,13 @@ static const struct dma_buf_ops
>> dma_buf_ops = {
>>>    	.unmap = ion_dma_buf_kunmap,
>>>    };
>>>
>>> -static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned
>>> int flags)
>>> +struct dma_buf *ion_alloc(size_t len, unsigned int heap_id_mask,
>>> +			  unsigned int flags)
>>>    {
>>>    	struct ion_device *dev = internal_dev;
>>>    	struct ion_buffer *buffer = NULL;
>>>    	struct ion_heap *heap;
>>>    	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>> -	int fd;
>>>    	struct dma_buf *dmabuf;
>>>
>>>    	pr_debug("%s: len %zu heap_id_mask %u flags %x\n", __func__,
>> @@
>>> -407,7 +407,7 @@ static int ion_alloc(size_t len, unsigned int
>> heap_id_mask, unsigned int flags)
>>>    	len = PAGE_ALIGN(len);
>>>
>>>    	if (!len)
>>> -		return -EINVAL;
>>> +		return ERR_PTR(-EINVAL);
>>>
>>>    	down_read(&dev->lock);
>>>    	plist_for_each_entry(heap, &dev->heaps, node) { @@ -421,10
>> +421,10
>>> @@ static int ion_alloc(size_t len, unsigned int heap_id_mask,
>> unsigned int flags)
>>>    	up_read(&dev->lock);
>>>
>>>    	if (!buffer)
>>> -		return -ENODEV;
>>> +		return ERR_PTR(-ENODEV);
>>>
>>>    	if (IS_ERR(buffer))
>>> -		return PTR_ERR(buffer);
>>> +		return ERR_PTR(PTR_ERR(buffer));
>>>
>>>    	exp_info.ops = &dma_buf_ops;
>>>    	exp_info.size = buffer->size;
>>> @@ -432,17 +432,12 @@ static int ion_alloc(size_t len, unsigned int
>> heap_id_mask, unsigned int flags)
>>>    	exp_info.priv = buffer;
>>>
>>>    	dmabuf = dma_buf_export(&exp_info);
>>> -	if (IS_ERR(dmabuf)) {
>>> +	if (IS_ERR(dmabuf))
>>>    		_ion_buffer_destroy(buffer);
>>> -		return PTR_ERR(dmabuf);
>>> -	}
>>>
>>> -	fd = dma_buf_fd(dmabuf, O_CLOEXEC);
>>> -	if (fd < 0)
>>> -		dma_buf_put(dmabuf);
>>> -
>>> -	return fd;
>>> +	return dmabuf;
>>>    }
>>> +EXPORT_SYMBOL(ion_alloc);
>>>
>>>    static int ion_query_heaps(struct ion_heap_query *query)
>>>    {
>>> @@ -539,12 +534,19 @@ static long ion_ioctl(struct file *filp, unsigned
>> int cmd, unsigned long arg)
>>>    	case ION_IOC_ALLOC:
>>>    	{
>>>    		int fd;
>>> +		struct dma_buf *dmabuf;
>>>
>>> -		fd = ion_alloc(data.allocation.len,
>>> +		dmabuf = ion_alloc(data.allocation.len,
>>>    			       data.allocation.heap_id_mask,
>>>    			       data.allocation.flags);
>>> -		if (fd < 0)
>>> +		if (IS_ERR(dmabuf))
>>> +			return PTR_ERR(dmabuf);
>>> +
>>> +		fd = dma_buf_fd(dmabuf, O_CLOEXEC);
>>> +		if (fd < 0) {
>>> +			dma_buf_put(dmabuf);
>>>    			return fd;
>>> +		}
>>>
>>>    		data.allocation.fd = fd;
>>>
>>>
> 

