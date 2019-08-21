Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9351CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECED2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfHUI57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:57:59 -0400
Received: from foss.arm.com ([217.140.110.172]:54748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfHUI57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:57:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 082D1337;
        Wed, 21 Aug 2019 01:57:56 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC303F246;
        Wed, 21 Aug 2019 01:57:55 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Queue jobs on the hardware
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190816093107.30518-2-steven.price@arm.com>
 <CAL_JsqJKm7n=SuQrPTxfWR=Cgqn-gR-bgOrOdTVyR_XCae0FQg@mail.gmail.com>
 <CAL_JsqL2oeKDKqv0DSQkMmM_=0sN0eY37xi4Y4oComX_v4U9oQ@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2dbb2b86-c409-1f58-275d-bec054da4dd5@arm.com>
Date:   Wed, 21 Aug 2019 09:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL2oeKDKqv0DSQkMmM_=0sN0eY37xi4Y4oComX_v4U9oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2019 18:02, Rob Herring wrote:
> On Mon, Aug 19, 2019 at 11:58 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Fri, Aug 16, 2019 at 4:31 AM Steven Price <steven.price@arm.com> wrote:
>>>
>>> The hardware has a set of '_NEXT' registers that can hold a second job
>>> while the first is executing. Make use of these registers to enqueue a
>>> second job per slot.
>>>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>> Note that this is based on top of Rob Herring's "per FD address space"
>>> patch[1].
>>>
>>> [1] https://marc.info/?i=20190813150115.30338-1-robh%20()%20kernel%20!%20org
>>>
>>>  drivers/gpu/drm/panfrost/panfrost_device.h |  4 +-
>>>  drivers/gpu/drm/panfrost/panfrost_job.c    | 76 ++++++++++++++++++----
>>>  drivers/gpu/drm/panfrost/panfrost_mmu.c    |  2 +-
>>>  3 files changed, 67 insertions(+), 15 deletions(-)
>>
>> LGTM, but I'll give Tomeu a chance to comment.
> 
> Though checkpatch reports some style nits:

Gah! Sorry - I probably should have pushed this out as an RFC anyway. My
DDK-on-Panfrost investigation showed a decent performance improvement,
but I hadn't actually tested with the Mesa driver. And as Tomeu has
discovered that it actually slows down I guess we need to investigate
that before merging.

Steve

> -:46: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
> "!pfdev->jobs[slot][0]"
> #46: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:143:
> +       if (pfdev->jobs[slot][0] == NULL)
> 
> -:48: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
> "!pfdev->jobs[slot][1]"
> #48: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:145:
> +       if (pfdev->jobs[slot][1] == NULL)
> 
> -:53: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
> #53: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:150:
> +static struct panfrost_job *panfrost_dequeue_job(
> 
> -:67: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
> "!pfdev->jobs[slot][0]"
> #67: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:164:
> +       if (pfdev->jobs[slot][0] == NULL) {
> 
> -:71: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
> "pfdev->jobs[slot][1]"
> #71: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:168:
> +       WARN_ON(pfdev->jobs[slot][1] != NULL);
> 
> -:160: ERROR:SPACING: space prohibited before that '--' (ctx:WxO)
> #160: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:497:
> +                       jobs --;
>                              ^
> 
> -:165: ERROR:SPACING: space required one side of that '--' (ctx:WxW)
> #165: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:500:
> +               while (jobs -- > active) {
>                             ^
> 
> -:204: CHECK:SPACING: spaces preferred around that '*' (ctx:VxV)
> #204: FILE: drivers/gpu/drm/panfrost/panfrost_mmu.c:150:
> +               WARN_ON(en >= NUM_JOB_SLOTS*2);
>                                            ^
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

