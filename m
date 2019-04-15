Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C65FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D8820675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfDOJaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:30:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59124 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfDOJaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:30:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DB7C374;
        Mon, 15 Apr 2019 02:30:18 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6578F3F557;
        Mon, 15 Apr 2019 02:30:16 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        iommu@lists.linux-foundation.org,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <20190405161632.GA9160@rosenzweig.io>
 <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
 <20190415091837.GV2665@phenom.ffwll.local>
From:   Steven Price <steven.price@arm.com>
Message-ID: <50682635-4134-f36b-dcb0-2a4d98eedb3c@arm.com>
Date:   Mon, 15 Apr 2019 10:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415091837.GV2665@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2019 10:18, Daniel Vetter wrote:
> On Fri, Apr 05, 2019 at 05:42:33PM +0100, Steven Price wrote:
>> On 05/04/2019 17:16, Alyssa Rosenzweig wrote:
>>> acronym once ever and have it as a "??"), I'm not sure how to respond to
>>> that... We don't know how to allocate memory for the GPU-internal data
>>> structures (the tiler heap, for instance, but also a few others I've
>>> just named "misc_0" and "scratchpad" -- guessing one of those is for
>>> "TLS"). With kbase, I took the worst-case strategy of allocating
>>> gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
>>> With the new driver, well, our memory consumption is scary since
>>> implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
>>> and isn't expected to hit the 5.2 window.
>>
>> Yes GROW_ON_GPF is pretty much required for the tiler heap - it's not
>> (reasonably) possible to determine how big it should be. The Arm user
>> space driver does the same approach (tiny commit count, but allow it to
>> grow).
> 
> Jumping in here with a drive through comment ...
> 
> Growing gem bo and dma-buf is going to be endless amounts of fun, since we
> hard-coded that their size is invariant.
> 
> I think the only reasonable way to implement this is if you allocate a
> really huge bo, map it, but only put the pages in on faulting. Or when
> really evil userspace tries to export it. Actually changing the underlying
> buffer size is not going to work I think.

Yes the idea is that you allocate a large amount of virtual address
space, but only put a few physical pages in. If the GPU needs more you
fault them in as necessary. The "buffer size" (i.e. virtual address
region) never changes size.

> Note: I didn't read kbase, so might be totally wrong in how GROW_ON_GPF
> works.

For kbase we simply don't support exporting this type of memory, and are
fairly restrictive about mapping it into user space (user space
shouldn't normally need to read it).

Since Panfrost is using GEM BO it will have to deal with malicious user
space. But it would be sufficient to simply fully back the region in
that case.

Recent version of kbase also support what is termed JIT (Just In Time
memory allocation). Basically this involves the kernel driver
allocating/freeing memory regions just before the job is loaded onto the
GPU. These regions might also be GROW_ON_GPF. The intention is that when
there isn't memory pressure these regions can be kept between jobs, but
under memory pressure they can be discarded and recreated if they turn
out to be needed again.

Given the differences between the Panfrost and the proprietary user
space I'm not sure exactly what form this will need to be for Panfrost,
but Vulkan makes memory management "more interesting"! Allocating
upfront for the worst case can become prohibitively expensive.

Steve
