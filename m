Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C58ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86589218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PSfZOqnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfJIS1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:27:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53108 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbfJIS1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:27:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x99IRGfN041028;
        Wed, 9 Oct 2019 13:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570645637;
        bh=czzkGRnOkqOrOyD9j1rwiX/b/j3aTg3xlt71OdRLPPc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PSfZOqnfwrtwxP78LZn+O7rpGYSux4yC+/wt6I9UN6zv18YZ4Esh0ydF+N5WEtNhV
         MqAyfHcVGLdma4W7sKYG9AQmcKW7sLrTTH2wFvjxwojw3RYBa4Dt6zDzYhJ02i4Ms9
         sUHHlg8m3if2C5uF2t8hk7u0YPGwnIpjPXaa2DXI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x99IRGBd059771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Oct 2019 13:27:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 13:27:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 13:27:13 -0500
Received: from [10.250.95.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x99IRFgj029849;
        Wed, 9 Oct 2019 13:27:15 -0500
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
CC:     nd <nd@arm.com>, Alistair Strachan <astrachan@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com>
Date:   Wed, 9 Oct 2019 14:27:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009173742.GA2682@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/19 1:37 PM, Ayan Halder wrote:
> On Tue, Sep 24, 2019 at 04:22:18PM +0000, Ayan Halder wrote:
>> On Thu, Sep 19, 2019 at 10:21:52PM +0530, Sumit Semwal wrote:
>>> Hello Christoph, everyone,
>>>
>>> On Sat, 7 Sep 2019 at 00:17, John Stultz <john.stultz@linaro.org> wrote:
>>>>
>>>> Here is yet another pass at the dma-buf heaps patchset Andrew
>>>> and I have been working on which tries to destage a fair chunk
>>>> of ION functionality.
>>>>
>>>> The patchset implements per-heap devices which can be opened
>>>> directly and then an ioctl is used to allocate a dmabuf from the
>>>> heap.
>>>>
>>>> The interface is similar, but much simpler then IONs, only
>>>> providing an ALLOC ioctl.
>>>>
>>>> Also, I've provided relatively simple system and cma heaps.
>>>>
>>>> I've booted and tested these patches with AOSP on the HiKey960
>>>> using the kernel tree here:
>>>>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
>>>>
>>>> And the userspace changes here:
>>>>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>>>>
>>>> Compared to ION, this patchset is missing the system-contig,
>>>> carveout and chunk heaps, as I don't have a device that uses
>>>> those, so I'm unable to do much useful validation there.
>>>> Additionally we have no upstream users of chunk or carveout,
>>>> and the system-contig has been deprecated in the common/andoid-*
>>>> kernels, so this should be ok.
>>>>
>>>> I've also removed the stats accounting, since any such accounting
>>>> should be implemented by dma-buf core or the heaps themselves.
>>>>
>>>> Most of the changes in this revision are adddressing the more
>>>> concrete feedback from Christoph (many thanks!). Though I'm not
>>>> sure if some of the less specific feedback was completely resolved
>>>> in discussion last time around. Please let me know!
>>>
>>> It looks like most of the feedback has been taken care of. If there's
>>> no more objection to this series, I'd like to merge it in soon.
>>>
>>> If there are any more review comments, may I request you to please provide them?
>>
>> I tested these patches using our internal test suite with Arm,komeda
>> driver and the following node in dts
>>
>>         reserved-memory {
>>                 #address-cells = <0x2>;
>>                 #size-cells = <0x2>;
>>                 ranges;
>>
>>                 framebuffer@60000000 {
>>                         compatible = "shared-dma-pool";
>>                         linux,cma-default;
>>                         reg = <0x0 0x60000000 0x0 0x8000000>;
>>                 };
>>         }
> Apologies for the confusion, this dts node is irrelevant as our tests were using
> the cma heap (via /dev/dma_heap/reserved).
> 
> That raises a question. How do we represent the reserved-memory nodes
> (as shown above) via the dma-buf heaps framework ?


The CMA driver that registers these nodes will have to be expanded to
export them using this framework as needed. We do something similar to
export SRAM nodes:

https://lkml.org/lkml/2019/3/21/575

Unlike the system/default-cma driver which can be centralized in the
tree, these extra exporters will probably live out in other subsystems
and so are added in later steps.

Andrew


>>
>> The tests went fine. Our tests allocates framebuffers of different
>> sizes, posts them on screen and the driver writes back to one of the
>> framebuffers. I havenot tested for any performance, latency or
>> cache management related stuff. So, it that looks appropriate, feel
>> free to add:-
>> Tested-by:- Ayan Kumar Halder <ayan.halder@arm.com>
>>
>> Are you planning to write some igt tests for it ?
>>>
>>>>
>>>> New in v8:
>>>> * Make struct dma_heap_ops consts (Suggested by Christoph)
>>>> * Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
>>>>   (suggested by Christoph)
>>>> * Condense dma_heap_buffer and heap_helper_buffer (suggested by
>>>>   Christoph)
>>>> * Get rid of needless struct system_heap (suggested by Christoph)
>>>> * Fix indentation by using shorter argument names (suggested by
>>>>   Christoph)
>>>> * Remove unused private_flags value
>>>> * Add forgotten include file to fix build issue on x86
>>>> * Checkpatch whitespace fixups
>>>>
>>>> Thoughts and feedback would be greatly appreciated!
>>>>
>>>> thanks
>>>> -john
>>> Best,
>>> Sumit.
>>>>
>>>> Cc: Laura Abbott <labbott@redhat.com>
>>>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>>> Cc: Liam Mark <lmark@codeaurora.org>
>>>> Cc: Pratik Patel <pratikp@codeaurora.org>
>>>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>>>> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
>>>> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
>>>> Cc: Andrew F. Davis <afd@ti.com>
>>>> Cc: Christoph Hellwig <hch@infradead.org>
>>>> Cc: Chenbo Feng <fengc@google.com>
>>>> Cc: Alistair Strachan <astrachan@google.com>
>>>> Cc: Hridya Valsaraju <hridya@google.com>
>>>> Cc: dri-devel@lists.freedesktop.org
>>>>
>>>>
>>>> Andrew F. Davis (1):
>>>>   dma-buf: Add dma-buf heaps framework
>>>>
>>>> John Stultz (4):
>>>>   dma-buf: heaps: Add heap helpers
>>>>   dma-buf: heaps: Add system heap to dmabuf heaps
>>>>   dma-buf: heaps: Add CMA heap to dmabuf heaps
>>>>   kselftests: Add dma-heap test
>>>>
>>>>  MAINTAINERS                                   |  18 ++
>>>>  drivers/dma-buf/Kconfig                       |  11 +
>>>>  drivers/dma-buf/Makefile                      |   2 +
>>>>  drivers/dma-buf/dma-heap.c                    | 250 ++++++++++++++++
>>>>  drivers/dma-buf/heaps/Kconfig                 |  14 +
>>>>  drivers/dma-buf/heaps/Makefile                |   4 +
>>>>  drivers/dma-buf/heaps/cma_heap.c              | 164 +++++++++++
>>>>  drivers/dma-buf/heaps/heap-helpers.c          | 269 ++++++++++++++++++
>>>>  drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
>>>>  drivers/dma-buf/heaps/system_heap.c           | 122 ++++++++
>>>>  include/linux/dma-heap.h                      |  59 ++++
>>>>  include/uapi/linux/dma-heap.h                 |  55 ++++
>>>>  tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
>>>>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 230 +++++++++++++++
>>>>  14 files changed, 1262 insertions(+)
>>>>  create mode 100644 drivers/dma-buf/dma-heap.c
>>>>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>>>>  create mode 100644 drivers/dma-buf/heaps/Makefile
>>>>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>>>>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>>>>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>>>>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>>>>  create mode 100644 include/linux/dma-heap.h
>>>>  create mode 100644 include/uapi/linux/dma-heap.h
>>>>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>>>>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>>>>
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
>>> -- 
>>> Thanks and regards,
>>>
>>> Sumit Semwal
>>> Linaro Consumer Group - Kernel Team Lead
>>> Linaro.org │ Open source software for ARM SoCs
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
