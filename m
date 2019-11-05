Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9D2C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A87E2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i2X9SNHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbfKENat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:30:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59056 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388883AbfKENas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:30:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5DUeZa029559;
        Tue, 5 Nov 2019 07:30:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572960640;
        bh=X2r1E+5verQirY3pPc+pLDG8R8Z0eAEU6/97FnwaeJE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=i2X9SNHIaWyxje87ekrjovkH7KcKd8+Uv4zRDPgQqCS2KklVMgqThvsNrhGdccnO0
         toL/VNiqQXNlum/mc5Loj8mvMERyzATixCxGkR+dpj1HHw40/9OFdIeuLBmrsQM+Y8
         CPPptuc4zxsiS7Id6yM3FAGqjXt0hMah4inpCgxI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5DUeIA012898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 07:30:40 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 07:30:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 07:30:25 -0600
Received: from [10.250.45.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5DUdiv055261;
        Tue, 5 Nov 2019 07:30:39 -0600
Subject: Re: [RFC][PATCH 0/2] Allow DMA BUF heaps to be loaded as modules
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>, Yue Hu <huyue2@yulong.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191104095823.GD10326@phenom.ffwll.local>
 <CALAqxLW_CoAn-KXki0dGKK+vo-R4CTnjt1Azrw=mRdL8BUFGWw@mail.gmail.com>
 <20191105094259.GX10326@phenom.ffwll.local>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5b591240-43c8-495a-e9c9-881a2997c492@ti.com>
Date:   Tue, 5 Nov 2019 08:30:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105094259.GX10326@phenom.ffwll.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 4:42 AM, Daniel Vetter wrote:
> On Mon, Nov 04, 2019 at 10:57:44AM -0800, John Stultz wrote:
>> On Mon, Nov 4, 2019 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Fri, Oct 25, 2019 at 11:48:32PM +0000, John Stultz wrote:
>>>> Now that the DMA BUF heaps core code has been queued, I wanted
>>>> to send out some of the pending changes that I've been working
>>>> on.
>>>>
>>>> For use with Android and their GKI effort, it is desired that
>>>> DMA BUF heaps are able to be loaded as modules. This is required
>>>> for migrating vendors off of ION which was also recently changed
>>>> to support modules.
>>>>
>>>> So this patch series simply provides the necessary exported
>>>> symbols and allows the system and CMA drivers to be built
>>>> as modules.
>>>>
>>>> Due to the fact that dmabuf's allocated from a heap may
>>>> be in use for quite some time, there isn't a way to safely
>>>> unload the driver once it has been loaded. Thus these
>>>> drivers do no implement module_exit() functions and will
>>>> show up in lsmod as "[permanent]"
>>>>
>>>> Feedback and thoughts on this would be greatly appreciated!
>>>
>>> Do we actually want this?
>>
>> I guess that always depends on the definition of "we" :)
>>
>>> I figured if we just state that vendors should set up all the right
>>> dma-buf heaps in dt, is that not enough?
>>
>> So even if the heaps are configured via DT (which at the moment there
>> is no such binding, so that's not really a valid method yet), there's
>> still the question of if the heap is necessary/makes sense on the
>> device. And the DT would only control the availability of the heap
>> interface, not if the heap driver is loaded or not.
> 
> Hm I thought the cma regions are configured in DT? How does that work if
> it's not using DT?
> 
>> On the HiKey/HiKey960 boards, we have to allocate contiguous buffers
>> for the display framebuffer. So gralloc uses ION to allocate from the
>> CMA heap. However on the db845c, it has no such restrictions, so the
>> CMA heap isn't necessary.
> 
> Why do you have a CMA region for the 2nd board if you don't need it?
> _That_ sounds like some serious memory waster, not a few lines of code
> loaded for nothing :-)
> 
>> With Android's GKI effort, there needs to be one kernel that works on
>> all the devices, and they are using modules to try to minimize the
>> amount of memory spent on functionality that isn't universally needed.
>> So on devices that don't need the CMA heap, they'd probably prefer not
>> to load the CMA dmabuf heap driver, so it would be best if it could be
>> built as a module.  If we want to build the CMA heap as a module, the
>> symbols it uses need to be exported.
> 
> Yeah, I guess I'm disagreeing on whether dma-buf heaps are core or not.
> 
>>> Exporting symbols for no real in-tree users feels fishy.
>>
>> I'm submitting an in-tree user here. So I'm not sure what you mean?  I
>> suspect you're thinking there is some hidden/nefarious plan here, but
>> really there isn't.
> 
> I was working under the assumption that you're only exporting the symbols
> for other heaps, and keep the current ones in-tree. Are there even any
> out-of-tree dma-buf heaps still? out-of-tree and legit different use-case
> I mean ofc, not just out-of-tree because inertia :-)

Not sure what you mean here, hopefully all the heaps can be "in-tree"
some day.

https://patchwork.kernel.org/patch/10863957/

Plus some non-caching heaps and one that forces early allocation of our
PAT (gart like) IP.

All this stuff is going into our evil vendor tree next cycle (if not
upstream by then :)), if we want some of these "specialty" heaps to go
into generic kernel builds at some point they will need to be modules if
the core is.

Although I am still thinking Heaps should be always built in + system +
CMA heaps, then the rando heaps could be modules if needed.

Andrew

> -Daniel
> 
