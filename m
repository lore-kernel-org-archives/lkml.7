Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D1CCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335D4222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UTSqZc6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJSNlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 09:41:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53760 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfJSNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 09:41:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9JDfTkN125035;
        Sat, 19 Oct 2019 08:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571492489;
        bh=DmYO2V942wLpuwNiTtTayFpdllmo+iJzhiSMhP26u/g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UTSqZc6r8krYXrHmy1ZpIhPO9ccuvhSPNmb3tebs+a0piJ+Vymf9PgSztOX+ZQwpr
         PqZm1gzUNxYkBexVB9jWRWK0K8lJNuCYbiot3hIJpgwSTb8Ur17dlYfgCoNw+H1O3q
         lm6/zxBJJ20WIG0UvCVFkqw4g+HCxjUIOALy7ZVc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9JDfTfn021037;
        Sat, 19 Oct 2019 08:41:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 19
 Oct 2019 08:41:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 19 Oct 2019 08:41:20 -0500
Received: from [10.250.79.55] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9JDfRi3035486;
        Sat, 19 Oct 2019 08:41:27 -0500
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     Ayan Halder <Ayan.Halder@arm.com>,
        John Stultz <john.stultz@linaro.org>
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
        Pratik Patel <pratikp@codeaurora.org>
References: <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
 <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com>
 <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
 <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
 <20191018095516.inwes5avdeixl5nr@DESKTOP-E1NTVVP.localdomain>
 <20191018184123.GA10634@arm.com>
 <CALAqxLXzOjyD1MpGeuZKLz+RNz1Utd8QpbvtSOodeqT-gCu6kA@mail.gmail.com>
 <20191018185723.GA27993@arm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <2c60496c-d536-05e7-bbf6-ca718b8142bd@ti.com>
Date:   Sat, 19 Oct 2019 09:41:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018185723.GA27993@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/19 2:57 PM, Ayan Halder wrote:
> On Fri, Oct 18, 2019 at 11:49:22AM -0700, John Stultz wrote:
>> On Fri, Oct 18, 2019 at 11:41 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
>>> On Fri, Oct 18, 2019 at 09:55:17AM +0000, Brian Starkey wrote:
>>>> On Thu, Oct 17, 2019 at 01:57:45PM -0700, John Stultz wrote:
>>>>> On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote:
>>>>>> On 10/17/19 3:14 PM, John Stultz wrote:
>>>>>>> But if the objection stands, do you have a proposal for an alternative
>>>>>>> way to enumerate a subset of CMA heaps?
>>>>>>>
>>>>>> When in staging ION had to reach into the CMA framework as the other
>>>>>> direction would not be allowed, so cma_for_each_area() was added. If
>>>>>> DMA-BUF heaps is not in staging then we can do the opposite, and have
>>>>>> the CMA framework register heaps itself using our framework. That way
>>>>>> the CMA system could decide what areas to export or not (maybe based on
>>>>>> a DT property or similar).
>>>>>
>>>>> Ok. Though the CMA core doesn't have much sense of DT details either,
>>>>> so it would probably have to be done in the reserved_mem logic, which
>>>>> doesn't feel right to me.
>>>>>
>>>>> I'd probably guess we should have some sort of dt binding to describe
>>>>> a dmabuf cma heap and from that node link to a CMA node via a
>>>>> memory-region phandle. Along with maybe the default heap as well? Not
>>>>> eager to get into another binding review cycle, and I'm not sure what
>>>>> non-DT systems will do yet, but I'll take a shot at it and iterate.
>>>>>
>>>>>> The end result is the same so we can make this change later (it has to
>>>>>> come after DMA-BUF heaps is in anyway).
>>>>>
>>>>> Well, I'm hesitant to merge code that exposes all the CMA heaps and
>>>>> then add patches that becomes more selective, should anyone depend on
>>>>> the initial behavior. :/
>>>>
>>>> How about only auto-adding the system default CMA region (cma->name ==
>>>> "reserved")?
>>>>
>>>> And/or the CMA auto-add could be behind a config option? It seems a
>>>> shame to further delay this, and the CMA heap itself really is useful.
>>>>
>>> A bit of a detour, comming back to the issue why the following node
>>> was not getting detected by the dma-buf heaps framework.
>>>
>>>         reserved-memory {
>>>                 #address-cells = <2>;
>>>                 #size-cells = <2>;
>>>                 ranges;
>>>
>>>                 display_reserved: framebuffer@60000000 {
>>>                         compatible = "shared-dma-pool";
>>>                         linux,cma-default;
>>>                         reusable; <<<<<<<<<<<<-----------This was missing in our
>>> earlier node
>>>                         reg = <0 0x60000000 0 0x08000000>;
>>>                 };
>>
>> Right. It has to be a CMA region for us to expose it from the cma heap.
>>
>>
>>> With 'reusable', rmem_cma_setup() succeeds , but the kernel crashes as follows :-
>>>
>>> [    0.450562] WARNING: CPU: 2 PID: 1 at mm/cma.c:110 cma_init_reserved_areas+0xec/0x22c
>>
>> Is the value 0x60000000 you're using something you just guessed at? It
>> seems like the warning here is saying the pfn calculated from the base
>> address isn't valid.
> It is a valid memory region we use to allocate framebuffers.


But does it have a valid kernel virtual mapping? Most ARM systems (just
assuming you are working on ARM :)) that I'm familiar with have the DRAM
space starting at 0x80000000 and so don't start having valid pfns until
that point. Is this address you are reserving an SRAM?

Andrew


>>
>> thanks
>> -john
