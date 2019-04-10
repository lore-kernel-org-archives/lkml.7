Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E41C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5720830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfDJK2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:28:31 -0400
Received: from foss.arm.com ([217.140.101.70]:51432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfDJK2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:28:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D65EB15BE;
        Wed, 10 Apr 2019 03:28:30 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872D73F59C;
        Wed, 10 Apr 2019 03:28:28 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
 <CAAObsKCnycxxKWA+bUeU9vOu53eT9WZVkzdZ0KCtW9Xj9cV8Cw@mail.gmail.com>
 <CAL_Jsq+qcLRFX0xyKuFEDW3+n6oukfmgemtO4MumCFp_-qqcUg@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <9036b1e7-bb1b-d681-829b-10088bc4c227@arm.com>
Date:   Wed, 10 Apr 2019 11:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+qcLRFX0xyKuFEDW3+n6oukfmgemtO4MumCFp_-qqcUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 17:15, Rob Herring wrote:
> On Tue, Apr 9, 2019 at 10:56 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>
>> On Mon, 8 Apr 2019 at 23:04, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Fri, Apr 5, 2019 at 7:30 AM Steven Price <steven.price@arm.com> wrote:
>>>>
>>>> On 01/04/2019 08:47, Rob Herring wrote:
>>>>> This adds the initial driver for panfrost which supports Arm Mali
>>>>> Midgard and Bifrost family of GPUs. Currently, only the T860 and
>>>>> T760 Midgard GPUs have been tested.
>>>
>>> [...]
>>>>> +
>>>>> +             if (status & JOB_INT_MASK_ERR(j)) {
>>>>> +                     job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
>>>>> +                     job_write(pfdev, JS_COMMAND(j), JS_COMMAND_HARD_STOP_0);
>>>>
>>>> Hard-stopping an already completed job isn't likely to do very much :)
>>>> Also you are using the "_0" version which is only valid when "job chain
>>>> disambiguation" is present.
>>
>> Yeah, guess that can be removed.
> 
> Steven, TBC, are you suggesting removing both lines or leaving
> JS_COMMAND_NOP? I don't think we can ever have a pending job at this
> point as there's no queuing. So the NOP probably isn't needed, but
> doesn't hurt to have it either.

Both lines are redundant and can be removed. But equally neither will
cause any problems.

Writing NOP into the next register is basically only needed if you know
there's a job there which you no longer want to execute.

kbase does this in certain situations. The main one is on a GPU without
command chain disambiguation if you want to kill a particular job
there's a potential race. For example:

 * Submit job A, followed by job B to slot 0. Job A is currently
executing, job B is waiting in the _NEXT registers.

 * Kernel decides it wants to kill job A (it's taking too long, or the
application has quit).

 * Simply executing a JS_COMMAND_HARD_STOP is racy. If job A finishes
just before doing the register write, then it's actually job B that gets
killed (and it's not always safe to just re-execute a killed job).

 * Instead write NOP to JS_COMMAND_NEXT, then check (again) whether the
job currently running is the one you want. When you then HARD_STOP you
either hit the correct job, or 'miss' and do nothing.

Job chain disambiguation solves this problem by allowing the kernel to
tag each job with a flag, the hard-stop can then be targetted at the job
with the correct flag. Writing NOP into JS_COMMAND_NEXT is also useful
if in the above situation you want to kill job B. In that case you can't
hard-stop it (it hasn't start), so you simply want to remove it from the
_NEXT registers.

>>>> I suspect in this case you should also be signalling the fence? At the
>>>> moment you rely on the GPU timeout recovering from the fault.
>>>
>>> I'll defer to Tomeu who wrote this (IIRC).
>>
>> Yes, that would be an improvement.
> 
> Actually, I think that would break recovery because the job timeout
> will bail out if the done fence is signaled already. Perhaps we want
> to timeout immediately if that is possible with the scheduler.

Ideally you would signal the fence with an error code (which is
presumably what recovery does). There's no actual need to trigger a
timeout. I'm not sure quite how the DRM infrastructure handles this though.

Steve
