Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12808C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FE322C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uGcHOF0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390537AbfGYNrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:47:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53422 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390490AbfGYNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:47:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6PDlCSU120551;
        Thu, 25 Jul 2019 08:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564062432;
        bh=w+T9dlJYQaD9FfO7esnlLeCqS7R5uSui0ZKYuPaxp58=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uGcHOF0YgoXt79Yfr7hLsqm1JY3HTVLxjgkOILT/UaHSLWFV3ZaSmTVWbJziwnDRc
         BMagzBiPV3eu0wESHj12ybXkPTZuyJwm+5ZdPgibV9ewt0aPzmLYDA8uzTe1ZxzFuK
         1IwKDp01j1CbNfwK/+VJr6dVH6ehHecyGvmXWmaM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6PDlCMr050293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jul 2019 08:47:12 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Jul 2019 08:47:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Jul 2019 08:47:12 -0500
Received: from [10.250.86.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6PDlBud103612;
        Thu, 25 Jul 2019 08:47:11 -0500
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
 <25353c4f-5389-0352-b34e-78698b35e588@redhat.com>
 <20190725124820.GC20286@infradead.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <18975c1a-7e4e-fab3-eec8-387fbf9dcfe5@ti.com>
Date:   Thu, 25 Jul 2019 09:47:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725124820.GC20286@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 8:48 AM, Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 07:38:07AM -0400, Laura Abbott wrote:
>> It's not just an optimization for Ion though. Ion was designed to
>> let the callers choose between system and multiple CMA heaps.
> 
> Who cares about ion?  That some out of tree android crap that should
> not be relevant for upstream except as an example for how not to design
> things..
> 

Tell us how you really feel about ION :)

>> On other
>> systems there may be multiple CMA regions dedicated to a specific
>> purpose or placed at a specific address. The callers need to
>> be able to choose exactly whether they want a particular CMA region
>> or discontiguous regions.
> 
> At least in cma is only used either with the global pool or a per-device
> cma pool.  I think if you want to make this new dma-buf API fit in with
> the rest with the kernel you follow that model, and pass in a struct
> device to select the particular cma area, similar how the DMA allocator
> works.
> 

This is a central allocator, it is not tied to any one device. If we
knew the one device ahead of time we would just use the existing dma_alloc.

We might be able to solve some of that with late mapping after all the
devices attach to the buffer, but even then, which device's CMA area
would we chose to use from all the attached devices?

I can agree that allocating from per-device CMA using Heaps doesn't make
much sense, but for global pools I'm not sure I see any way to allow
devices to select which pool is right for a specific use. They don't
have the full use-case information like the application does, the
selection needs to be made from the application.

Andrew
