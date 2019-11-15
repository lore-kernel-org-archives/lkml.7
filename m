Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DC4C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8FB2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfKOBKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:10:32 -0500
Received: from foss.arm.com ([217.140.110.172]:51420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfKOBKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:10:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 411DB31B;
        Thu, 14 Nov 2019 17:10:31 -0800 (PST)
Received: from [10.37.9.126] (unknown [10.37.9.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0783F52E;
        Thu, 14 Nov 2019 17:10:28 -0800 (PST)
Subject: Re: [PATCH 0/5] arm64: Add workaround for Cortex-A77 erratum 1542418
To:     will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        maz@kernel.org
References: <20191114145918.235339-1-suzuki.poulose@arm.com>
 <20191114163948.GA5158@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <14773d6b-96d5-b894-7fc4-17c54f15ee30@arm.com>
Date:   Fri, 15 Nov 2019 01:14:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191114163948.GA5158@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will

On 11/14/2019 04:39 PM, Will Deacon wrote:
> Hi Suzuki,
> 
> On Thu, Nov 14, 2019 at 02:59:13PM +0000, Suzuki K Poulose wrote:
>> This series adds workaround for Arm erratum 1542418 which affects
> 
> Searching for that erratum number doesn't find me a description :(

I believe this was published in the Cortex-A77 SDEN v9.0. I will chase
it internally.

> 
>> Cortex-A77 cores (r0p0 - r1p0). Affected cores may execute stale
>> instructions from the L0 macro-op cache violating the
>> prefetch-speculation-protection guaranteed by the architecture.
>> This happens when the when the branch predictor bases its predictions
>> on a branch at this address on the stale history due to ASID or VMID
>> reuse.
> 
> Two immediate questions:
> 
>   1. Can we disable the L0 MOP cache?
Yes, but it hurts performance.

>   2. Can we invalidate the branch predictor? If Spectre-v2 taught us
>      anything it's that removing those instructions was a mistake!

The workaround suggested is actually invalidating the branch history
but in a costly way. I am unaware of any.
> Moving on...
> 
> Have you reproduced this at top-level? If I recall the
> prefetch-speculation-protection, it's designed to protect against the
> case where you have a direct branch:

No, see below.

> 
> addr:	B	foo
> 
> and another CPU writes out a new function:
> 
> bar:
> 	insn0
> 	...
> 	insnN
> 
> before doing any necessary maintenance and then patches the original
> branch to:
> 
> addr:	B	bar
> 
> The idea is that a concurrently executing CPU could mispredict the original
> branch to point at 'bar', fetch the instructions before they've been written
> out and then confirm the prediction by looking at the newly written branch
> instruction. Even without the prefetch-speculation-protection, that's
> fairly difficult to achieve in practice: you'd need to be doing something
> like reusing memory to hold the instructions so that the initial
> misprediction occurs.
> 
> How does A77 stop this from occurring when the ASID is not reallocated (e.g.
> the example above)? Is the MOP cache flushed somehow?

IIUC, The MOP cache is flushed on I-cache invalidate, thus it is fine.	

> 
> With this erratum, it sounds like you have to end up reusing an ASID from
> a task that had a branch at 'addr' in its address space that branched to
> the address of 'bar' (again. in its address space). Is that right? That
> sounds super rare to me, particularly with ASLR: not only does the aliasing

AFAICS, yes and on top of that, it should also miss "addr" in MOP-cache
and hit "bar" before the I-cache invalidate is received. This may cause
the "bar" to be fetched from mop (and is not canceled even though there
was a mop-flush triggered by the i-cache invalidate after the hit) and
"addr" should miss in I-cache, causing it to fetch the updated instruction.

Also this means that the new context must not have executed "addr"
(which would give a hit in MOP-cache) while "bar" was fetched. So,
this adds on more constraints to actually hit it.

> branch need to exist, but it needs to be held in the branch predictor while
> we cycle through 64k ASIDs *and* the race with the writer needs to happen
> so that we get stale instructions from the MOP cache.
> 
> Is there something I'm missing that makes this remotely plausible?

No :-)

Cheers
Suzuki

