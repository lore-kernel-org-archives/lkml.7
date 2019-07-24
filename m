Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4DBC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904DB21951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VzLnvQJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfGXPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:46:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53094 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfGXPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:46:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6OFk3g0070578;
        Wed, 24 Jul 2019 10:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563983163;
        bh=lOtsy9iEeGzWh5ylO4v/a04ehlOrwbMbdn7UL2Ddbrg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VzLnvQJdtFsU8gh8xZW4og7tS+2gLDEUOpGiPoFQzpyWkyjuKjgzj0Vh2fnuO2eeU
         91AiiB3Nwjs5rCppmcOgWSZJSm/aGHM+7v5odY7mugVWv05rjXMDQSF+9yVBR4FZOS
         QNVaFQCsOSQwQaOSYDxuLwyfM8iTvRK1+DHxihl8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6OFk3jV046078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jul 2019 10:46:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Jul 2019 10:46:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Jul 2019 10:46:03 -0500
Received: from [10.250.86.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6OFk2qF032690;
        Wed, 24 Jul 2019 10:46:02 -0500
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
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
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <8e6f8e4f-20fc-1f1f-2228-f4fd7c7c5c1f@ti.com>
Date:   Wed, 24 Jul 2019 11:46:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724065958.GC16225@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/19 2:59 AM, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 10:04:06PM -0700, John Stultz wrote:
>> Apologies, I'm not sure I'm understanding your suggestion here.
>> dma_alloc_contiguous() does have some interesting optimizations
>> (avoiding allocating single page from cma), though its focus on
>> default area vs specific device area doesn't quite match up the usage
>> model for dma heaps.  Instead of allocating memory for a single
>> device, we want to be able to allow userland, for a given usage mode,
>> to be able to allocate a dmabuf from a specific heap of memory which
>> will satisfy the usage mode for that buffer pipeline (across multiple
>> devices).
>>
>> Now, indeed, the system and cma heaps in this patchset are a bit
>> simple/trivial (though useful with my devices that require contiguous
>> buffers for the display driver), but more complex ION heaps have
>> traditionally stayed out of tree in vendor code, in many cases making
>> incompatible tweaks to the ION core dmabuf exporter logic.
> 
> So what would the more complicated heaps be?
> 


https://patchwork.kernel.org/patch/10863957/

It's actually a more simple heap type IMHO, but the logic inside is
incompatible with the system/CMA heaps, if you move any of their code
into the core framework then this heap stops working. Leading to out of
tree hacks on the core to get it back functional. I see the same for the
"complex" heaps with ION.

Andrew


>> That's why
>> dmabuf heaps is trying to destage ION in a way that allows heaps to
>> implement their exporter logic themselves, so we can start pulling
>> those more complicated heaps out of their vendor hidey-holes and get
>> some proper upstream review.
>>
>> But I suspect I just am confused as to what your suggesting. Maybe
>> could you expand a bit? Apologies for being a bit dense.
> 
> My suggestion is to merge the system and CMA heaps.  CMA (at least
> the system-wide CMA area) is really just an optimization to get
> large contigous regions more easily.  We should make use of it as
> transparent as possible, just like we do in the DMA code.
> 
