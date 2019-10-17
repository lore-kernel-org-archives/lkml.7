Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73CECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F4620869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pFrbpnvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503547AbfJQT31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:29:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52144 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503522AbfJQT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:29:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9HJT8bD074406;
        Thu, 17 Oct 2019 14:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571340548;
        bh=FQw6tHtjutclhEra0bZ8lyV5GyV+9hIm6rM/wZiaztY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pFrbpnvYi4/9sJztFJOw7XPBz5mwhCGiScK6huQmaA0g6+DLer/EVPapviG6iQ380
         iWYH/F59Fd00zXWXejG+rpz2NJpxMxxOjfpS68IFDgqU6pVVQCOiNmpJ8MwoNf/U4w
         +Ky+ZAJzdT6NwRQb4WLJqC8bXG2LkSFecyqlsciE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9HJT8rD129768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Oct 2019 14:29:08 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 17
 Oct 2019 14:29:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 17 Oct 2019 14:29:07 -0500
Received: from [10.250.79.55] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9HJT7b5090136;
        Thu, 17 Oct 2019 14:29:07 -0500
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>
CC:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
Date:   Thu, 17 Oct 2019 15:29:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 3:14 PM, John Stultz wrote:
> On Wed, Oct 16, 2019 at 10:41 AM Andrew F. Davis <afd@ti.com> wrote:
>> On 10/14/19 5:07 AM, Brian Starkey wrote:
>>> Hi Andrew,
>>>
>>> On Wed, Oct 09, 2019 at 02:27:15PM -0400, Andrew F. Davis wrote:
>>>> The CMA driver that registers these nodes will have to be expanded to
>>>> export them using this framework as needed. We do something similar to
>>>> export SRAM nodes:
>>>>
>>>> https://lkml.org/lkml/2019/3/21/575
>>>>
>>>> Unlike the system/default-cma driver which can be centralized in the
>>>> tree, these extra exporters will probably live out in other subsystems
>>>> and so are added in later steps.
>>>>
>>>> Andrew
>>>
>>> I was under the impression that the "cma_for_each_area" loop in patch
>>> 4 would do that (add_cma_heaps). Is it not the case?
>>>
>>
>> For these cma nodes yes, I thought you meant reserved memory areas in
>> general.
> 
> Ok, sorry I didn't see this earlier, not only was I still dropped from
> the To list, but the copy I got from dri-devel ended up marked as
> spam.
> 
>> Just as a side note, I'm not a huge fan of the cma_for_each_area() to
>> begin with, it seems a bit out of place when they could be selectively
>> added as heaps as needed. Not sure how that will work with cma nodes
>> specifically assigned to devices, seems like we could just steal their
>> memory space from userspace with this..
> 
> So this would be a concern with ION as well, since it does the same
> thing because being able to allocate from multiple CMA heaps for
> device specific purpose is really useful.
> And at least with dmabuf heaps each heap can be given its own
> permissions so there's less likelihood for any abuse as you describe.
> 


Yes it was a problem with ION also, having individual files per heap
does help with some permissions, but my issue is what if I don't want my
CMA exported at all, cma_for_each_area() just grabs them all anyway.


> And it also allows various device cma nodes to still be allocated from
> using the same interface (rather then having to use a custom driver
> ioctl for each device).
> 


This is definitely the way to go, it's the implementation of how we get
the CMAs to export in the first place that is a bit odd.


> But if the objection stands, do you have a proposal for an alternative
> way to enumerate a subset of CMA heaps?
> 


When in staging ION had to reach into the CMA framework as the other
direction would not be allowed, so cma_for_each_area() was added. If
DMA-BUF heaps is not in staging then we can do the opposite, and have
the CMA framework register heaps itself using our framework. That way
the CMA system could decide what areas to export or not (maybe based on
a DT property or similar).

The end result is the same so we can make this change later (it has to
come after DMA-BUF heaps is in anyway).

Andrew


> thanks
> -john
> 
