Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E4DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843A20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HFFVFrQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfJVQHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:07:45 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57016 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfJVQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:07:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MG1hM9045898;
        Tue, 22 Oct 2019 11:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571760103;
        bh=LZyB5uaXD1KikcWwUwkOFBR1+mNt4OjW/LVueBf2enQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HFFVFrQYbEFsaJNzAPzULxvygJJDUHpOS+7uOC4yPs9BMAE6reZOu4JxtrU+64e8T
         B1Y8S4qx7xrza5DzuTptqUFgIFC/jXzrz4WoUdIoo6ErVwYEGoqh49CZHjKI2pn8mQ
         6jry/4LsMznIMIO3GVH5A5n6zTjLnIJWn8yvbw6E=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MG1hJQ079926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 11:01:43 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 11:01:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 11:01:42 -0500
Received: from [156.117.59.23] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9MG1ggo078978;
        Tue, 22 Oct 2019 11:01:42 -0500
Subject: Re: [PATCH v13 0/5] DMA-BUF Heaps (destaging ION)
To:     Neil Armstrong <narmstrong@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Hillf Danton <hdanton@sina.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191021190310.85221-1-john.stultz@linaro.org>
 <be7286c7-3e67-4ffb-73b1-2622391d7c15@baylibre.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <0e22ffb9-10ac-821b-2f32-a3d8304ca072@ti.com>
Date:   Tue, 22 Oct 2019 11:01:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <be7286c7-3e67-4ffb-73b1-2622391d7c15@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/19 3:21 AM, Neil Armstrong wrote:
> Hi John,
> 
> On 21/10/2019 21:03, John Stultz wrote:
>> Lucky number 13! :)
>>
>> Last week in v12 I had re-added some symbol exports to support
>> later patches I have pending to enable loading heaps from
>> modules. He reminded me that back around v3 (its been awhile!) I
>> had removed those exports due to concerns about the fact that we
>> don't support module removal.
>>
>> So I'm respinning the patches, removing the exports again. I'll
>> submit a patch to re-add them in a later series enabling moduels
>> which can be reviewed indepently.
>>
>> With that done, lets get on to the boilerplate!
>>
>> The patchset implements per-heap devices which can be opened
>> directly and then an ioctl is used to allocate a dmabuf from the
>> heap.
>>
>> The interface is similar, but much simpler then IONs, only
>> providing an ALLOC ioctl.
>>
>> Also, I've provided relatively simple system and cma heaps.
>>
>> I've booted and tested these patches with AOSP on the HiKey960
>> using the kernel tree here:
>>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> 
> Do you have a 4.19 tree with the changes ? I tried but the xarray idr replacement
> is missing... so I can't test with our android-amlogic-bmeson-4.19 tree.
> 


Just a note, we switched to xarray around v4 time frame of this series,
so you may be able to find the IDR based code and plug it in for a 4.19
port.

Andrew


> If you can provide, I'll be happy to test the serie and the gralloc changes.
> 
> Neil
> 
>>
>> And the userspace changes here:
>>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>>
>> Compared to ION, this patchset is missing the system-contig,
>> carveout and chunk heaps, as I don't have a device that uses
>> those, so I'm unable to do much useful validation there.
>> Additionally we have no upstream users of chunk or carveout,
>> and the system-contig has been deprecated in the common/andoid-*
>> kernels, so this should be ok.
>>
>> I've also removed the stats accounting, since any such
>> accounting should be implemented by dma-buf core or the heaps
>> themselves.
>>
>> New in v13:
>> * Re-remove symbol exports, per discussion with Brian. I'll
>>   resubmit these separately in a later patch so they can be
>>   independently reviewed
>>
>> thanks
>> -john
>>
>> Cc: Laura Abbott <labbott@redhat.com>
>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>> Cc: Liam Mark <lmark@codeaurora.org>
>> Cc: Pratik Patel <pratikp@codeaurora.org>
>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
>> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
>> Cc: Andrew F. Davis <afd@ti.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: Chenbo Feng <fengc@google.com>
>> Cc: Alistair Strachan <astrachan@google.com>
>> Cc: Hridya Valsaraju <hridya@google.com>
>> Cc: Hillf Danton <hdanton@sina.com>
>> Cc: dri-devel@lists.freedesktop.org
>>
>>
>>
>> Andrew F. Davis (1):
>>   dma-buf: Add dma-buf heaps framework
>>
>> John Stultz (4):
>>   dma-buf: heaps: Add heap helpers
>>   dma-buf: heaps: Add system heap to dmabuf heaps
>>   dma-buf: heaps: Add CMA heap to dmabuf heaps
>>   kselftests: Add dma-heap test
>>
>>  MAINTAINERS                                   |  18 ++
>>  drivers/dma-buf/Kconfig                       |  11 +
>>  drivers/dma-buf/Makefile                      |   2 +
>>  drivers/dma-buf/dma-heap.c                    | 269 ++++++++++++++++++
>>  drivers/dma-buf/heaps/Kconfig                 |  14 +
>>  drivers/dma-buf/heaps/Makefile                |   4 +
>>  drivers/dma-buf/heaps/cma_heap.c              | 178 ++++++++++++
>>  drivers/dma-buf/heaps/heap-helpers.c          | 268 +++++++++++++++++
>>  drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
>>  drivers/dma-buf/heaps/system_heap.c           | 124 ++++++++
>>  include/linux/dma-heap.h                      |  59 ++++
>>  include/uapi/linux/dma-heap.h                 |  55 ++++
>>  tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
>>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 ++++++++++++++++
>>  14 files changed, 1304 insertions(+)
>>  create mode 100644 drivers/dma-buf/dma-heap.c
>>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>>  create mode 100644 drivers/dma-buf/heaps/Makefile
>>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>>  create mode 100644 include/linux/dma-heap.h
>>  create mode 100644 include/uapi/linux/dma-heap.h
>>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>>
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
