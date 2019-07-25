Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A61FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F672190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ip6hXMPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbfGYNcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:32:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50898 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387632AbfGYNcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:32:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6PDVqIt074564;
        Thu, 25 Jul 2019 08:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564061512;
        bh=B/ntLJ2e1bIKShYP2qLtMwAe3jOvq47HHoEw6r4s2ZA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ip6hXMPL4GiG/YNz0lIukcvAkp/BqHTNVXLtqtwTWZvDh3xsO4c9kteivrfZmAiEB
         QUzcDPwqZj9HSlvBM+ZyC7PovEIcxAsqzqfVowgMbmbsJACjBO4EdlBZa5c257g+EK
         vbtBslAD/tq6XsA/Cjk9N9zv7D04+VmLjp19dKT0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6PDVql1073481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jul 2019 08:31:52 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Jul 2019 08:31:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Jul 2019 08:31:51 -0500
Received: from [10.250.86.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6PDVo6N082317;
        Thu, 25 Jul 2019 08:31:50 -0500
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
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
 <20190724065958.GC16225@infradead.org>
 <8e6f8e4f-20fc-1f1f-2228-f4fd7c7c5c1f@ti.com>
 <20190725125014.GD20286@infradead.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <0eae0024-1fdf-bd06-a8ff-1a41f0af3c69@ti.com>
Date:   Thu, 25 Jul 2019 09:31:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725125014.GD20286@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 8:50 AM, Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 11:46:01AM -0400, Andrew F. Davis wrote:
>> https://patchwork.kernel.org/patch/10863957/
>>
>> It's actually a more simple heap type IMHO, but the logic inside is
>> incompatible with the system/CMA heaps, if you move any of their code
>> into the core framework then this heap stops working. Leading to out of
>> tree hacks on the core to get it back functional. I see the same for the
>> "complex" heaps with ION.
> 
> Well, this mostly is just another allocator (gen_pool).  And given that
> the whole dma-buf infrastucture assumes things are backed by pages we
> really shouldn't need much more than an alloc and a free callback (and
> maybe the pgprot to map it) and handle the rest in common code.
> 

But that's just it, dma-buf does not assume buffers are backed by normal
kernel managed memory, it is up to the buffer exporter where and when to
allocate the memory. The memory backed by this SRAM buffer does not have
the normal struct page backing. So moving the map, sync, etc functions
to common code would fail for this and many other heap types. This was a
major problem with Ion that prompted this new design.

Each heap type may need to do something different depending on its
backing memory, moving everything to common code that is common to
System and CMA heaps is would lead those being the only upstreamable heaps.

Andrew
