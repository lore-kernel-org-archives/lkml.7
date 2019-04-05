Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_TVD_FUZZY_SECURITIES autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FDC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A4020700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfDEQmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:42:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfDEQmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:42:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BF8168F;
        Fri,  5 Apr 2019 09:42:37 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CCA93F68F;
        Fri,  5 Apr 2019 09:42:35 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        iommu@lists.linux-foundation.org,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <20190405161632.GA9160@rosenzweig.io>
From:   Steven Price <steven.price@arm.com>
Message-ID: <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
Date:   Fri, 5 Apr 2019 17:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405161632.GA9160@rosenzweig.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 17:16, Alyssa Rosenzweig wrote:
>> I'm also somewhat surprised that you don't need loads of other
>> properties from the GPU - in particular knowing the number of shader
>> cores is useful for allocating the right amount of memory for TLS (and
>> can't be obtained purely from the GPU_ID).
> 
> Since I have no idea what TLS is (and in my notes, I've come across the

Sorry - "Thread Local Storage" - e.g. registers spilled to memory from a
shader program.

> acronym once ever and have it as a "??"), I'm not sure how to respond to
> that... We don't know how to allocate memory for the GPU-internal data
> structures (the tiler heap, for instance, but also a few others I've
> just named "misc_0" and "scratchpad" -- guessing one of those is for
> "TLS"). With kbase, I took the worst-case strategy of allocating
> gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
> With the new driver, well, our memory consumption is scary since
> implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
> and isn't expected to hit the 5.2 window.

Yes GROW_ON_GPF is pretty much required for the tiler heap - it's not
(reasonably) possible to determine how big it should be. The Arm user
space driver does the same approach (tiny commit count, but allow it to
grow).

> 
> Given this is kernel facing, I'm hoping 're able to share some answers
> here?

At the moment I don't have any permission to share details which aren't
already public in the kbase driver. Hopefully that situation will
change. I'm also very much not an expert on anything but the kernel
driver (I tried to stay away from shader compilers and all that graphics
knowledge...). The details of the job descriptors is only really
publicly documented in terms of the "replay workaround" which is quite
limited.

> 
>> I think this comment might have survived since the very earliest version
>> of the Midgard driver! :)
> 
> ^_^
> 
>> But I'm not sure anything will attempt to lock a region spanning two
>> pages like that.
> 
> At least at the moment, I align everything kernel-facing to page
> granularity in userspace, so it's not a cornercase I'm going to hit
> anytime soon. Still probably better to have it technically correct.
> 
>> To be fair only for BASE_HW_ISSUE_6367/T60X - but yes it's not a
>> pleasant workaround. There's no way on that hardware to reliably drain
>> the write buffer other than waiting.
> 
> *wishing T60X disappeared intensifies* ;)

I think we all felt like that :) Still the Nexus 10 wasn't a bad tablet,
and the Chromebook was an exciting first!

> Granted there are enough other errata specific to it that aren't worked
> around here that, well, it makes you wonder ;)

A lot of the errata are things you only hit with soak testing. So to a
large extent you "get lucky".

>> Do we have a good way of user space determining which requirements are
>> supported by the driver? At the moment it's just the one. kbase outgeew
>> the original u16 and has an ugly "compat_core_req", so I suspect you're
>> going to need to add several more along the way.
> 
> Oh, so that's why compat_/core_req is split off! I thought somebody just
> thought it would be "fun" to break the UABI ;)

No that's a case of us actually not breaking the UABI for once :)

> I've definitely issues using the wrong core_req field for the kbase I
> had setup, that set me back a little bit on RK3399/T860 bringup *purses
> lips*
> 
> To be fair, bunches of the kbase reqs are for soft jobs, which I don't
> feel are a good fit for how the Panfrost kernel works. If we need to
> implement functionality corresponding to softjobs, that would likely be
> done with dedicated ioctl(s), instead of affecting the core_req field.
> 
> On that note
> 
>> You might also want to consider being able to submit more than one job
>> chain at a time - but that could easily be implemented using a new ioctl
>> in the future.
> 
> The issue with that at the bottom is having to introduce something akin
> to kbase's annoyingly intra-job-chain dependency management (read: I
> still don't understand how FBOs are supposed to work with kbase ;) ),
> which AFAIK we push off to userspace right now via standard fencing. If
> we want to submit batches at a time, we would potentially need to
> express those somewhat complex dependency trees, which is a lot of work
> for diminishing returns at this stage. Future ioctl indeed...

You should be able to express the dependencies using fences. At the time
kbase was started there was no fence mechanism in the kernel. We
invented horrible things like UMP[1] and KDS[2] for cross-driver sharing.

It all comes down to how small your job chains are - if you don't need
to squeeze too many through the hardware you should be fine. But there's
going to be some performance gain to be had implementing it.

[1] I forget what it actually stands for, but was an attempt to do
something like dma_buf

[2] "Kernel Dependency System" - a not-so-good version of dma_fence

>> There's no SUBMIT_CL in this posting? I think you just need s/_CL//.
> 
> +1
> 
>> You are probably going to want flags for at least:
>>
>>  * No execute/No read/No write (good for security, especially with
>> buffer sharing between processes)
>>
>>  * Alignment (shader programs have quite strict alignment requirements,
>> I believe kbase just ensures that the shader memory block doesn't cross
>> a 16MB boundary which covers most cases).
>>
>>  * Page fault behaviour (kbase has GROW_ON_GPF)
>>
>>  * Coherency management
> 
> +1 for all of these. This is piped through in userspace (for kbase), but
> the corresponding functionality isn't there yet in the Panfrost kernel.
> You're right there should at least be a flags field for future use.
> 
>> One issue that I haven't got to the bottom of is that I can trigger a
>> lockdep splat:
> 
> Oh, "fun"...
> 
>> This is with the below simple reproducer:
> 
> @Rob, ideas?
> 
>> Other than that in my testing (on a Firefly RK3288) I didn't experience
>> any problems pushing jobs from the ARM userspace blob through it.
> 
> Nice!
> 
> Besides what was mentioned above, any other functionality you'll need
> for that? (e.g. the infamous replay workaround...)

If you don't implement the replay workaround I'm very happy :)

The main missing part for the Arm user space is feature registers. That
and the lack of SAME_VA is horrible to emulate (keep allocating until it
happens to land in a free area of user space memory).

Arm user space also makes use of cached memory with explicit cache sync
operations. It of course works fine with uncached and ignoring the sync,
but again I'm not sure how much performance is being lost.

Steve
