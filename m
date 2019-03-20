Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EDD21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IxZiFyfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCTOoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:44:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38440 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:44:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2KEiOmt064455;
        Wed, 20 Mar 2019 09:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553093064;
        bh=21XJBEUzYaEtEtGW1tH8M0L395mqIwwx2Kbu7w78btU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IxZiFyfbhvfb9dGt1QKl/NoHRitoLXL1YeMF/lA6JToiXZ6ZC6vORjdcfTw911zn7
         ZsNgvmlWqlou+I08ej+RXdJLlSL9bZfZWb1YMCa0K8eZTEUoqbJiIw3zmfe23jJDCv
         UXTZxGKg3haZmnrnUoe92kxMMzWaVVZauv8F+Fuw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2KEiOa5087943
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 09:44:24 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 09:44:24 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 09:44:24 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2KEiN6m025567;
        Wed, 20 Mar 2019 09:44:23 -0500
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        John Stultz <john.stultz@linaro.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Alistair Strachan <astrachan@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Marissa Wall <marissaw@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131309260.5023@lmark-linux.qualcomm.com>
 <CALAqxLUkGME+K=0g5QSja4CvN0w9z0WV60djy+5rRC+Dg-jCGg@mail.gmail.com>
 <CA+M3ks7q8QnNirk_WkaE5CmFWkEPn4uu5Hfb2kP+4d5qapHvrA@mail.gmail.com>
 <c51be371-086a-bd5b-b70a-5579f5b95320@ti.com>
 <CAF6AEGss21WmpF7sHGTxOEjuadSNpM6M_Z-WweK2W68FEHOFdA@mail.gmail.com>
 <CALAqxLVbdpj+T4u3jZ_5Uqda5La1Py-ZGpXSep_CCoLzWyap8A@mail.gmail.com>
 <CA+M3ks61BGPkPjNd01g32LV7YZfDpy8t100KxQhScOFgGO4KjA@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <d6f8092d-9f90-d5ff-2ab3-b1867f8f5700@ti.com>
Date:   Wed, 20 Mar 2019 09:44:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+M3ks61BGPkPjNd01g32LV7YZfDpy8t100KxQhScOFgGO4KjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 4:16 AM, Benjamin Gaignard wrote:
> Le mar. 19 mars 2019 à 23:36, John Stultz <john.stultz@linaro.org> a écrit :
>>
>> On Tue, Mar 19, 2019 at 2:58 PM Rob Clark <robdclark@gmail.com> wrote:
>>>
>>> On Tue, Mar 19, 2019 at 1:00 PM Andrew F. Davis <afd@ti.com> wrote:
>>>>
>>>> On 3/19/19 11:54 AM, Benjamin Gaignard wrote:
>>>>> Le mer. 13 mars 2019 à 23:31, John Stultz <john.stultz@linaro.org> a écrit :
>>>>>>
>>>>>> On Wed, Mar 13, 2019 at 1:11 PM Liam Mark <lmark@codeaurora.org> wrote:
>>>>>>> On Tue, 5 Mar 2019, John Stultz wrote:
>>>>>>>>
>>>>>>>> Eventual TODOS:
>>>>>>>> * Reimplement page-pool for system heap (working on this)
>>>>>>>> * Add stats accounting to system/cma heaps
>>>>>>>> * Make the kselftest actually useful
>>>>>>>> * Add other heaps folks see as useful (would love to get
>>>>>>>>   some help from actual carveout/chunk users)!
>>>>>>>
>>>>>>> We use a modified carveout heap for certain secure use cases.
>>>>>>
>>>>>> Cool! It would be great to see if you have any concerns about adding
>>>>>> such a secure-carveout heap to this framework. I suspect it would be
>>>>>> fairly similar to how its integrated into ION, but particularly I'd be
>>>>>> interested in issues around the lack of private flags and other
>>>>>> allocation arguments like alignment.
>>>>>>
>>>>>>> Although there would probably be some benefit in discssing how the dma-buf
>>>>>>> heap framework may want to support
>>>>>>> secure heaps in the future it is a large topic which I assume you don't
>>>>>>> want to tackle now.
>>>>>>
>>>>>> So I suspect others (Benjamin?) would have a more informed opinion on
>>>>>> the details, but the intent is to allow secure heap implementations.
>>>>>> I'm not sure what areas of concern you have for this allocation
>>>>>> framework in particular?
>>>>>
>>>>> yes I would be great to understand how you provide the information to
>>>>> tell that a dmabuf
>>>>> is secure (or not) since we can't add flag in dmabuf structure itself.
>>>>> An option is manage
>>>>> the access rights when a device attach itself to the dmabuf but in
>>>>> this case you need define
>>>>> a list of allowed devices per heap...
>>>>> If you have a good solution for secure heaps you are welcome :-)
>>>>>
>>>>
>>>> Do we really need any of that? A secure buffer is secured by the
>>>> hardware firewalls that keep out certain IP (including often the
>>>> processor running Linux). So the only thing we need to track internally
>>>> is that we should not allow mmap/kmap on the buffer. That can be done in
>>>> the per-heap layer, everything else stays the same as a standard
>>>> carveout heap.
>>>
>>> For at least some hw the importing driver needs to configure things
>>> differently for secure buffers :-/
>>
>> Does the import ioctl need/use a flag for that then? Userland already
>> has to keep meta-data about dmabufs around.
> 
> To secure a buffer you need to know who is allowed to write/read it and
> hardware block involved in the dataflow may need to know that the buffer
> is secure to configure themself.
> As example for a video decoding you allow hw video decoder to read in
> a buffer and display to read it. You can also allow cpu to write on the buffer
> to add subtitles. For that we need to be able to mmap/kmap the buffer.
> Using a carveout heap for secure buffer mean that you reserved a large
> memory region only for this purpose, that isn't possible on embedded device
> where we are always limited in memory so we use CMA.
> In the past I have used dmabuf's attach function to know who write into
> the buffer and then configure who will be able to read it. It was working well
> but the issue was how to in generic way this behavior.
> 

Okay, I think I see what you are saying now.

The way we handle secure playback is to firewall everything upfront and
it is up to the application to inform the hardware about what it can and
cannot do to the buffer, or simply not ask anything not allowed (E.g.
writeback the decrypted stream) else it will get a firewall exception.
The buffer itself doesn't have to carry any information.

It sounds like you want the hardware driver to be able to detect the
use-case based on the buffer itself and configure itself accordingly? Or
the exporter at attach time to check access permissions?

The first would need a change to DMA-BUF framework, maybe an added flag.
The second would just need a heap exporter with the system wide smarts,
but as you say that is not very generic..

Andrew

>>
>> thanks
>> -john
