Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE1F2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLTWCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:02:18 -0500
Received: from foss.arm.com ([217.140.110.172]:55124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfLTWCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:02:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893BF30E;
        Fri, 20 Dec 2019 14:02:17 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CCEC3F67D;
        Fri, 20 Dec 2019 14:02:15 -0800 (PST)
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
 <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
 <20191220171359.GP2827@hirez.programming.kicks-ass.net>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b2e0e322-a4e7-af26-d64a-1ba226e48476@arm.com>
Date:   Fri, 20 Dec 2019 22:02:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220171359.GP2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 5:13 pm, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 03:01:03PM +0000, Robin Murphy wrote:
>> On 2019-12-20 2:06 pm, Peter Zijlstra wrote:
> 
>>> 	data = kmalloc(size + sizeof(struct devres), GFP_KERNEL);

[ afterthought: size could also legitimately be smaller than a pointer 
or some odd length such that the necessary alignment of struct devres 
itself isn't met ]

>> At this point, you'd still need to special-case devm_kmalloc() to ensure
>> size is rounded up to the next ARCH_KMALLOC_MINALIGN granule, or you'd go
>> back to the original problem of the struct devres fields potentially sharing
>> a cache line with the data buffer. That needs to be avoided, because if the
>> devres list is modified while the buffer is mapped for noncoherent DMA
>> (which could legitimately happen as they are nominally distinct allocations
>> with different owners) there's liable to be data corruption one way or the
>> other.
> 
> Wait up, why are you allowing non-coherent DMA at less than page size
> granularity? Is that really sane? Is this really supported behaviour for
> devm ?

There are two DMA APIs - the coherent (or "consistent") API for 
allocating buffers which are guaranteed safe for random access at any 
time *is* page-based, and on non-coherent architectures typically 
involves a non-cacheable remap. There is also the streaming API for 
one-off transfers of data already existing at a given kernel address 
(think network packets, USB URBs, etc), which on non-coherent 
architectures is achieved with explicit cache maintenance plus an API 
contract that buffers must not be explicitly accessed by CPUs for the 
duration of the mapping. Addresses from kmalloc() are explicitly valid 
for dma_map_single() (and indeed are about the only thing you'd ever 
reasonably feed it), which is the primary reason why 
ARCH_KMALLOC_MINALIGN gets so big on architectures which can be 
non-coherent and also suffer from creative cache designs.

See DMA-API.txt and DMA-API-HOWTO.txt in Documentation/ for more details 
if you like.

Robin.
