Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D7EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1821520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ku4JJO11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCFVqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:46:03 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37582 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCFVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:46:03 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x26Ljfou031139;
        Wed, 6 Mar 2019 15:45:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551908741;
        bh=3m1SfB8pS1+1+AtvhNYz5b7tpz37OPH8k9JJfNN68sY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ku4JJO11OkT4l60H+hci1rGVJ7VsqKu8jQq3hL9w5GMUx37YJdyzO3ohnGZhoPMpV
         xFqB1M33qtL/KFia1D43rSVD02FlsfIt6TCd/Agb1su8h4FDLcccHBkb8EvlAVccz+
         kJ1MBtBy5yBQRIpQMEcRXD5LH1DCSjNREbgKXCtU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x26Ljf5C071725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Mar 2019 15:45:41 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Mar 2019 15:45:41 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Mar 2019 15:45:41 -0600
Received: from [172.22.114.173] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x26Ljeif015938;
        Wed, 6 Mar 2019 15:45:40 -0600
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
 <a4fd1783-c0d8-8ed5-5cd0-522b0789998c@ti.com>
 <CALAqxLVh9zU-96ZpOVFztS=WtpMWPEOqAo=zj+fhVVK78W50BQ@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <62d91a79-58ee-b2a0-7fb8-d38f32660fd1@ti.com>
Date:   Wed, 6 Mar 2019 15:45:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVh9zU-96ZpOVFztS=WtpMWPEOqAo=zj+fhVVK78W50BQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 1:03 PM, John Stultz wrote:
> On Wed, Mar 6, 2019 at 10:18 AM Andrew F. Davis <afd@ti.com> wrote:
>>
>> On 3/5/19 2:54 PM, John Stultz wrote:
>>> From: "Andrew F. Davis" <afd@ti.com>
>>>
>>> This framework allows a unified userspace interface for dma-buf
>>> exporters, allowing userland to allocate specific types of
>>> memory for use in dma-buf sharing.
>>>
>>> Each heap is given its own device node, which a user can
>>> allocate a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
>>>
>>> This code is an evoluiton of the Android ION implementation,
>>> and a big thanks is due to its authors/maintainers over time
>>> for their effort:
>>>   Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
>>>   Laura Abbott, and many other contributors!
>>>
>>> Cc: Laura Abbott <labbott@redhat.com>
>>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>> Cc: Greg KH <gregkh@linuxfoundation.org>
>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>> Cc: Liam Mark <lmark@codeaurora.org>
>>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>>> Cc: Andrew F. Davis <afd@ti.com>
>>> Cc: Chenbo Feng <fengc@google.com>
>>> Cc: Alistair Strachan <astrachan@google.com>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>> [jstultz: reworded commit message, and lots of cleanups]
>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>> ---
>>> v2:
>>> * Folded down fixes I had previously shared in implementing
>>>   heaps
>>> * Make flags a u64 (Suggested by Laura)
>>> * Add PAGE_ALIGN() fix to the core alloc funciton
>>> * IOCTL fixups suggested by Brian
>>> * Added fixes suggested by Benjamin
>>> * Removed core stats mgmt, as that should be implemented by
>>>   per-heap code
>>> * Changed alloc to return a dma-buf fd, rather then a buffer
>>>   (as it simplifies error handling)
>>> ---
>>>  MAINTAINERS                   |  16 ++++
>>>  drivers/dma-buf/Kconfig       |   8 ++
>>>  drivers/dma-buf/Makefile      |   1 +
>>>  drivers/dma-buf/dma-heap.c    | 191 ++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/dma-heap.h      |  65 ++++++++++++++
>>>  include/uapi/linux/dma-heap.h |  52 ++++++++++++
>>>  6 files changed, 333 insertions(+)
>>>  create mode 100644 drivers/dma-buf/dma-heap.c
>>>  create mode 100644 include/linux/dma-heap.h
>>>  create mode 100644 include/uapi/linux/dma-heap.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ac2e518..a661e19 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4621,6 +4621,22 @@ F:     include/linux/*fence.h
>>>  F:   Documentation/driver-api/dma-buf.rst
>>>  T:   git git://anongit.freedesktop.org/drm/drm-misc
>>>
>>> +DMA-BUF HEAPS FRAMEWORK
>>> +M:   Laura Abbott <labbott@redhat.com>
>>> +R:   Liam Mark <lmark@codeaurora.org>
>>> +R:   Brian Starkey <Brian.Starkey@arm.com>
>>> +R:   "Andrew F. Davis" <afd@ti.com>
>>
>> Quotes not needed in maintainers file.
> 
> Whatever you say, "Andrew F. Davis", or whomever you really are! ;)
> 

 <_<
 >_>
> 
>>> +
>>> +             if (heap_allocation.fd ||
>>> +                 heap_allocation.reserved0 ||
>>> +                 heap_allocation.reserved1 ||
>>> +                 heap_allocation.reserved2) {
>>
>> Seems too many reserved, I can understand one, but if we ever needed all
>> of these we would be better off just adding another alloc ioctl.
> 
> Well, we have to have one u32 for padding. And I figured if we needed
> anything more then a u32, then we're in for 2 more.
> 
> And I think the potential of the alignment and heap-private flags, I
> worry we might want to  have something, but I guess we could just add
> a new ioctl and keep the support for the old one if folks prefer.
> 
>>> +int dma_heap_add(struct dma_heap *heap)
>>> +{
>>> +     struct device *dev_ret;
>>> +     int ret;
>>> +
>>> +     if (!heap->name || !strcmp(heap->name, "")) {
>>> +             pr_err("dma_heap: Cannot add heap without a name\n");
>>
>> As these names end up as the dev name in the file system we may want to
>> check for invalid names, there is probably a helper for that somewhere.
> 
> Hrm. I'll have to look.
> 
>>> +struct dma_heap {
>>> +     const char *name;
>>> +     struct dma_heap_ops *ops;
>>> +     unsigned int minor;
>>> +     dev_t heap_devt;
>>> +     struct cdev heap_cdev;
>>> +};
>>
>> Still not sure about this, all of the members in this struct are
>> strictly internally used by the framework. The users of this framework
>> should not have access to them and only need to deal with an opaque
>> pointer for tracking themselves (can store it in a private struct of
>> their own then container_of to get back out their struct).
>>
>> Anyway, not a big deal, and if it really bugs me enough I can always go
>> fix it later, it's all kernel internal so not a blocker here. :)
> 
> I guess I'd just move the include/linux/dma-heap.h to
> drivers/dma-buf/heaps/ and keep it localized there.
> But whichever. Feel free to also send a patch and I can fold it down.
> 

The dma-heap.h needs to stay where it is, I was thinking just move
struct dma_heap to inside drivers/dma-buf/dma-heap.c. I wouldn't worry
about changing anything right now though, I'll post a patch you can
squash in later one we confirm this whole dma-heap thing will get deemed
acceptable in the first place.

Thanks,
Andrew

> thanks
> -john
> 
