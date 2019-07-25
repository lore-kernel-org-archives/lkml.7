Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9318121734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z5lSewpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbfGYOw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:52:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35766 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387646AbfGYOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:52:28 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6PEpwLH089026;
        Thu, 25 Jul 2019 09:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564066318;
        bh=6eVBtz7pC5rPsO60ddc64kp9iSy+XJZAc+HuTFyJ08s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z5lSewpCrBq60eVRn9ewoGY9sYcen7BfsGC5Ryho9b2zDeuf6W4TBq4LtUXOClE7A
         2oZ8CbyMXq+O9xHqPrGY9XK0VwlRgc3O8IvVZyPvOEUpCVodA9wMfpkYqkM/dhpr+2
         kRdTvW4xMnTvzmLV1QF/PUFQ+0el5ryqp5Nfs74Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6PEpwex070194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jul 2019 09:51:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Jul 2019 09:51:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Jul 2019 09:51:58 -0500
Received: from [10.250.86.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6PEpucs096397;
        Thu, 25 Jul 2019 09:51:57 -0500
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <8e6f8e4f-20fc-1f1f-2228-f4fd7c7c5c1f@ti.com>
 <20190725125014.GD20286@infradead.org>
 <0eae0024-1fdf-bd06-a8ff-1a41f0af3c69@ti.com>
 <20190725140448.GA25010@infradead.org>
 <8e2ec315-5d18-68b2-8cb5-2bfb8a116d1b@ti.com>
 <20190725141144.GA14609@infradead.org>
 <b2170efd-df80-b54b-9ffe-8183befe5e00@ti.com>
 <20190725143040.GA21894@infradead.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <ba731cf6-97cb-0499-e092-26031e202e55@ti.com>
Date:   Thu, 25 Jul 2019 10:51:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725143040.GA21894@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 10:30 AM, Christoph Hellwig wrote:
> On Thu, Jul 25, 2019 at 10:25:50AM -0400, Andrew F. Davis wrote:
>> On 7/25/19 10:11 AM, Christoph Hellwig wrote:
>>> On Thu, Jul 25, 2019 at 10:10:08AM -0400, Andrew F. Davis wrote:
>>>> Pages yes, but not "normal" pages from the kernel managed area.
>>>> page_to_pfn() will return bad values on the pages returned by this
>>>> allocator and so will any of the kernel sync/map functions. Therefor
>>>> those operations cannot be common and need special per-heap handling.
>>>
>>> Well, that means this thing is buggy and abuses the scatterlist API
>>> and we can't merge it anyway, so it is irrelevant.
>>>
>>
>> Since when do scatterlists need to only have kernel virtual backed
>> memory pages? Device memory is stored in scatterlists and
>> dma_sync_sg_for_* would fail just the same when the cache ops were
>> attempted.
> 
> I'm not sure what you mean with virtual backed memory pages, as we
> don't really have that concept.
> 
> But a page in the scatterlist needs to be able to be used everywhere
> we'd normally use a page, e.g. page_to_phys, page_to_pfn, kmap,
> page_address (if !highmem) as consumers including the dma mapping
> interface do all that.
> 
> If you want to dma map memory that does not have page backing you
> need to use dma_map_resource.
> 

I probably should have worded that better.

It does have page backing, what I meant by "page_to_pfn() will return
bad values" is not that it won't give you the correct pfn, it will, but
that then that pfn is not part of the normal memory space
(lowmem/highmem) it's device memory, so cache ops won't work. But you
should not be doing that on device memory anyway.

That is a problem with Ion I want to avoid, it assumed all buffers were
in DDR and so would do cache operations on them unconditionally, too
many assumptions were made as too much was moved into the common core
code and not enough was left for the heaps themselves to decide.
