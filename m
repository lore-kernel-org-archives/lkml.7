Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1BA20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CMM1xB66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCSRAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:00:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38756 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCSRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:00:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JGxvue020945;
        Tue, 19 Mar 2019 11:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553014797;
        bh=NRtg6594FkNOvXP+rO/epHu61LR22qv+OM9Gih7OxXw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CMM1xB66N5z2JRpGwszoc2ZtTXNUpZjMFilTDk9xx6hHYEiSvHAdpq7QjOuLFn6So
         t74VwVmxV3XjhvbzTyFXvQ7sWCj9qgsievmaiCFnnELyXVmflt7Rv8Yc1sgbznA2eD
         UKE/A3RIhxP/rT3z9KrUh07zgH75t+hjx4XtYkTo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JGxv1V049282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 11:59:57 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 11:59:57 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 11:59:57 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JGxuQg009304;
        Tue, 19 Mar 2019 11:59:56 -0500
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        John Stultz <john.stultz@linaro.org>
CC:     Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Marissa Wall <marissaw@google.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
 <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
 <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com>
Date:   Tue, 19 Mar 2019 11:59:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 11:54 AM, Benjamin Gaignard wrote:
> Le mer. 13 mars 2019 à 23:31, John Stultz <john.stultz@linaro.org> a écrit :
>>
>> On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> wrote:
>>> On Tue, 5 Mar 2019, John Stultz wrote:
>>>>
>>>> Eventual TODOS:
>>>> * Reimplement page-pool for system heap (working on this)
>>>> * Add stats accounting to system/cma heaps
>>>> * Make the kselftest actually useful
>>>> * Add other heaps folks see as useful (would love to get
>>>>   some help from actual carveout/chunk users)!
>>>
>>> We use a modified carveout heap for certain secure use cases.
>>
>> Cool! It would be great to see if you have any concerns about adding
>> such a secure-carveout heap to this framework. I suspect it would be
>> fairly similar to how its integrated into ION, but particularly I'd be
>> interested in issues around the lack of private flags and other
>> allocation arguments like alignment.
>>
>>> Although there would probably be some benefit in discssing how the dma-buf
>>> heap framework may want to support
>>> secure heaps in the future it is a large topic which I assume you don't
>>> want to tackle now.
>>
>> So I suspect others (Benjamin?) would have a more informed opinion on
>> the details, but the intent is to allow secure heap implementations.
>> I'm not sure what areas of concern you have for this allocation
>> framework in particular?
> 
> yes I would be great to understand how you provide the information to
> tell that a dmabuf
> is secure (or not) since we can't add flag in dmabuf structure itself.
> An option is manage
> the access rights when a device attach itself to the dmabuf but in
> this case you need define
> a list of allowed devices per heap...
> If you have a good solution for secure heaps you are welcome :-)
> 

Do we really need any of that? A secure buffer is secured by the
hardware firewalls that keep out certain IP (including often the
processor running Linux). So the only thing we need to track internally
is that we should not allow mmap/kmap on the buffer. That can be done in
the per-heap layer, everything else stays the same as a standard
carveout heap.

Andrew

> Benjamin
>>
>>> We don't have any non-secure carveout heap use cases but the client use
>>> case I have seen usually revolve around
>>> wanting large allocations to succeed very quickly.
>>> For example I have seen camera use cases which do very large allocations
>>> on camera bootup from the carveout heap, these allocations would come from
>>> the carveout heap and fallback to the system heap when the carveout heap
>>> was full.
>>> Actual non-secure carveout heap can perhaps provide more detail.
>>
>> Yea, I'm aware that folks still see carveout as preferable to CMA due
>> to more consistent/predictable allocation latency.  I think we still
>> have the issue that we don't have bindings to establish/configure
>> carveout regions w/ dts, and I'm not really wanting to hold up the
>> allocation API on that issue.
>>
>>
>>> Since we are making some fundamental changes to how ION worked and since
>>> Android is likely also be the largest user of the dma-buf heaps framework
>>> I think it would be good
>>> to have a path to resolve the issues which are currently preventing
>>> commercial Android releases from moving to the upstream version of ION.
>>
>> Yea, I do see solving the cache management efficiency issues as
>> critical for the dmabuf heaps to be actually usable (my previous
>> version of this patchset accidentally had my hacks to improve
>> performance rolled in!).  And there are discussions going on in
>> various channels to try to figure out how to either change Android to
>> use dma-bufs more in line with how upstream expects, or what more
>> generic dma-buf changes we may need to allow Android to use dmabufs
>> with the expected performance they need.
>>
>>> I can understand if you don't necessarily want to put all/any of these
>>> changes into the dma-buf heaps framework as part of this series, but my
>>> hope is we can get
>>> the upstream community and the Android framework team to agree on what
>>> upstreamable changes to dma-buf heaps framework, and/or the Android
>>> framework, would be required in order for Android to move to the upstream
>>> dma-buf heaps framework for commercial devices.
>>
>> Yes. Though I also don't want to get the bigger dma-buf usage
>> discussion (which really affects all dmabuf exporters) too tied up
>> with this patch sets attempt to provide a usable allocation interface.
>> Part of the problem that I think we've seen with ION is that there is
>> a nest of of related issues, and the entire thing is just too big to
>> address at once, which I think is part of why ION has sat in staging
>> for so long. This patchset just tries to provide an dmabuf allocation
>> interface, and a few example exporter heap types.
>>
>>> I don't mean to make this specific to Android, but my assumption is that
>>> many of the ION/dma-buf heaps issues which affect Android would likely
>>> affect other new large users of the dma-buf heaps framework, so if we
>>> resolve it for Android we would be helping these future users as well.
>>> And I do understand that some the issues facing Android may need to be
>>> resolved by making changes to Android framework.
>>
>> While true, I also think some of the assumptions in how the dma-bufs
>> are used (pre-attachment of all devices, etc) are maybe not so
>> realistic given how Android is using them.  I do want to explore if
>> Android can change how they use dma-bufs, but I also worry that we
>> need to think about how we could loosen the expectations for dma-bufs,
>> as well as trying to figure out how to support things folks have
>> brought up like partial cache maintenance.
>>
>>> I think it would be helpful to try and get as much of this agreed upon as
>>> possible before the dma-buf heaps framework moves out of staging.
>>>
>>> As part of my review I will highlight some of the issues which would
>>> affect Android.
>>> In my comments I will apply them to the system heap since that is what
>>> Android currently uses for a lot of its use cases.
>>> I realize that this new framework provides more flexibility to heaps, so
>>> perhaps some of these issues can be solved by creating a new type of
>>> system heap which Android can use, but even if the solution involves
>>> creating a new system heap I would like to make sure that this "new"
>>> system heap is upstreamable.
>>
>> So yea, I do realize I'm dodging the hard problem here, but I think
>> the cache-management/usage issue is far more generic.
>>
>> You're right that this implementation give a lot of flexibility to the
>> exporter heaps in how they implement the dmabuf ops (just like how
>> other device drivers that are dmabuf exporters have the same
>> flexibility), but I very much agree we don't want to add a system and
>> then later a "system-android" heap. So yea, a reasonable amount of
>> caution is warranted here.
>>
>> Thanks so much for the review and feedback! I'll try to address things
>> as I can as I'm traveling this week (so I may be a bit spotty).
>>
>> thanks
>> -john
