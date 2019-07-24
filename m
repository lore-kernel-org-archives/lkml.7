Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D211C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB87321738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MsOxbaLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGXPVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:21:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33166 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGXPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:21:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6OFKXTl129002;
        Wed, 24 Jul 2019 10:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563981633;
        bh=kV06TLoVNsUYXenFXygLoD1KHApkQKg0DKnf9mR/P54=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MsOxbaLsddGg8FBIp7Bu36HN2Mh9pwDYMGDPBW8eyabCV5R4FO8VEDo+1WznZ87Uv
         EK416RLdiWYKaO8XXSijoygp9AGH0yTfWZKy52cVWyE7nfnIUkzHdYT3PJnp6WeIPJ
         v5fhFY+Ee+Qn/c1hRF3Kxs5auR6KAImeb8DLo38Y=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6OFKXkl011982
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jul 2019 10:20:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Jul 2019 10:20:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Jul 2019 10:20:33 -0500
Received: from [10.250.86.29] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6OFKVIJ026870;
        Wed, 24 Jul 2019 10:20:32 -0500
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
To:     Christoph Hellwig <hch@infradead.org>,
        Rob Clark <robdclark@gmail.com>
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org>
 <20190718100654.GA19666@infradead.org>
 <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
 <CAF6AEGuM1+pimGNhyKHbYR0BdH=hH+Sai0es8RjGHE9jKHjngw@mail.gmail.com>
 <20190724065530.GA16225@infradead.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <3966dff1-864d-cad4-565f-7c7120301265@ti.com>
Date:   Wed, 24 Jul 2019 11:20:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724065530.GA16225@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/19 2:55 AM, Christoph Hellwig wrote:
> On Tue, Jul 23, 2019 at 01:09:55PM -0700, Rob Clark wrote:
>> On Mon, Jul 22, 2019 at 9:09 PM John Stultz <john.stultz@linaro.org> wrote:
>>>
>>> On Thu, Jul 18, 2019 at 3:06 AM Christoph Hellwig <hch@infradead.org> wrote:
>>>>
>>>> Is there any exlusion between mmap / vmap and the device accessing
>>>> the data?  Without that you are going to run into a lot of coherency
>>>> problems.
>>
>> dma_fence is basically the way to handle exclusion between different
>> device access (since device access tends to be asynchronous).  For
>> device<->device access, each driver is expected to take care of any
>> cache(s) that the device might have.  (Ie. device writing to buffer
>> should flush it's caches if needed before signalling fence to let
>> reading device know that it is safe to read, etc.)
>>
>> _begin/end_cpu_access() is intended to be the exclusion for CPU access
>> (which is synchronous)
> 
> What I mean is that we need a clear state machine (preferably including
> ownership tracking ala dma-debug) where a piece of memory has one
> owner at a time that can access it.  Only the owner can access is at
> that time, and at any owner switch we need to flush/invalidate all
> relevant caches.  And with memory that is vmaped and mapped to userspace
> that can get really complicated.
> 
> The above sounds like you have some of that in place, but we'll really
> need clear rules to make sure we don't have holes in the scheme.
> 

Well then lets think on this. A given buffer can have 3 owners states
(CPU-owned, Device-owned, and Un-owned). These are based on the caching
state from the CPU perspective.

If a buffer is CPU-owned then we (Linux) can write to the buffer safely
without worry that the data is stale or that it will be accessed by the
device without having been flushed. Device-owned buffers should not be
accessed by the CPU, and inter-device synchronization should be handled
by fencing as Rob points out. Un-owned is how a buffer starts for
consistency and to prevent unneeded cache operations on unwritten buffers.

We also need to track the mapping states, 4 states for this, CPU-mapped,
Device-mapped, CPU/Device-mapped, unmapped. Should be self explanatory,
map_dma_buf maps towards the device, mmap/vmap/kmap towards the CPU.
Leaving a buffer mapped by the CPU while device access takes place is
safe as long as ownership is taken before any access. One more point, we
assume reference counting for the below discussion, for instance
unmap_dma_buf refers to the last device unmapping, map_dma_buf refers
only to the first.

This gives 12 combined states, if we assume a buffer will always be
owned when it has someone mapping it, either CPU or device or both, then
we can drop 3 states. If a buffer is only mapped into one space, then
that space owns it, this drops 2 cross-owned states. Lastly if not
mapped by either space then the buffer becomes un-owned (and the backing
memory can be freed or migrated as needed). Leaving us 5 valid states.

* Un-Owned Un-Mapped
* Device-Owned Device-Mapped
* Device-Owned CPU/Device-Mapped
* CPU-Owned CPU-Mapped
* CPU-Owned CPU/Device-Mapped

There are 6 DMA-BUF operations (classes) on a buffer:

* map_dma_buf
* unmap_dma_buf
* begin_cpu_access
* end_cpu_access
* mmap/vmap/kmap
* ummanp/vunmap/kunmap

From all this I've suggest the following state-machine(in DOT language):

Note: Buffers start in "Un-Owned Un-Mapped" and can only be freed from
that state.

Note: Commented out states/transitions are not valid but here to prove
completeness

-------------------------------------------------------------------

digraph dma_buf_buffer_states
{
	label = "DMA-BUF Buffer states";

	uo_um [ label="Un-Owned\nUn-Mapped" ];
//	uo_dm [ label="Un-Owned\nDevice-Mapped" ];
//	uo_cm [ label="Un-Owned\nCPU-Mapped" ];
//	uo_cdm [ label="Un-Owned\nCPU/Device-Mapped" ];

//	do_um [ label="Device-Owned\nUn-Mapped" ];
	do_dm [ label="Device-Owned\nDevice-Mapped" ];
//	do_cm [ label="Device-Owned\nCPU-Mapped" ];
	do_cdm [ label="Device-Owned\nCPU/Device-Mapped" ];

//	co_um [ label="CPU-Owned\nUn-Mapped" ];
//	co_dm [ label="CPU-Owned\nDevice-Mapped" ];
	co_cm [ label="CPU-Owned\nCPU-Mapped" ];
	co_cdm [ label="CPU-Owned\nCPU/Device-Mapped" ];

	/* From Un-Owned Un-Mapped */
		uo_um -> do_dm		[ label="map_dma_buf" ];
//		uo_um ->		[ label="unmap_dma_buf" ];
//		uo_um -> 		[ label="begin_cpu_access" ];
//		uo_um ->		[ label="end_cpu_access" ];
		uo_um -> co_cm		[ label="mmap/vmap/kmap" ];
//		uo_um -> 		[ label="ummanp/vunmap/kunmap" ];

	/* From Device-Owned Device-Mapped */
		do_dm -> do_dm		[ label="map_dma_buf" ];
		do_dm -> uo_um		[ label="unmap_dma_buf" ];
//		do_dm -> 		[ label="begin_cpu_access" ];
//		do_dm ->		[ label="end_cpu_access" ];
		do_dm -> do_cdm		[ label="mmap/vmap/kmap" ];
//		do_dm -> 		[ label="ummanp/vunmap/kunmap" ];

	/* From Device-Owned CPU/Device-Mapped */
		do_cdm -> do_cdm	[ label="map_dma_buf" ];
		do_cdm -> co_cm		[ label="unmap_dma_buf" ];
		do_cdm -> co_cdm	[ label="begin_cpu_access" ];
//		do_cdm ->		[ label="end_cpu_access" ];
		do_cdm -> do_cdm	[ label="mmap/vmap/kmap" ];
		do_cdm -> do_dm		[ label="ummanp/vunmap/kunmap" ];

	/* From CPU-Owned CPU-Mapped */
		co_cm -> co_cdm		[ label="map_dma_buf" ];
//		co_cm -> 		[ label="unmap_dma_buf" ];
//		co_cm -> 		[ label="begin_cpu_access" ];
		co_cm -> co_cm		[ label="end_cpu_access" ];
//		co_cm ->		[ label="mmap/vmap/kmap" ];
		co_cm -> uo_um		[ label="ummanp/vunmap/kunmap" ];

	/* From CPU-Owned CPU/Device-Mapped */
		co_cdm -> co_cdm	[ label="map_dma_buf" ];
		co_cdm -> co_cm		[ label="unmap_dma_buf" ];
//		co_cdm -> 		[ label="begin_cpu_access" ];
		co_cdm -> do_cdm	[ label="end_cpu_access" ];
		co_cdm -> co_cdm	[ label="mmap/vmap/kmap" ];
//		co_cdm ->		[ label="ummanp/vunmap/kunmap" ];

	{
		rank = same;
		co_cm -> do_dm [ style=invis ];
		rankdir = LR;
	}

	{
		rank = same;
		co_cdm -> do_cdm [ style=invis ];
		rankdir = LR;
	}
}

-------------------------------------------------------------------

If we consider this the "official" model, then we can start optimizing
cache operations, and start forbidding some nonsensical operations.

What do y'all think?

Andrew
