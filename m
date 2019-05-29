Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490BEC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CB621019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfE2MZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:25:51 -0400
Received: from foss.arm.com ([217.140.101.70]:44752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfE2MZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:25:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B74B80D;
        Wed, 29 May 2019 05:25:49 -0700 (PDT)
Received: from [10.1.196.108] (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0206E3F59C;
        Wed, 29 May 2019 05:25:47 -0700 (PDT)
Subject: Re: [RFC 4/7] arm64: pmu: Add function implementation to update event
 index in userpage.
To:     Robin Murphy <robin.murphy@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-5-raphael.gault@arm.com>
 <20190529094659.GK2623@hirez.programming.kicks-ass.net>
 <42a937dd-5cf6-6738-6f69-005fce64138f@arm.com>
 <d6f40c6c-6a73-bd7f-e384-050bd9428631@arm.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <0100f2bd-7940-0b81-4c03-205b295a048f@arm.com>
Date:   Wed, 29 May 2019 13:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d6f40c6c-6a73-bd7f-e384-050bd9428631@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, Hi Peter,

On 5/29/19 11:50 AM, Robin Murphy wrote:
> On 29/05/2019 11:46, Raphael Gault wrote:
>> Hi Peter,
>>
>> On 5/29/19 10:46 AM, Peter Zijlstra wrote:
>>> On Tue, May 28, 2019 at 04:03:17PM +0100, Raphael Gault wrote:
>>>> +static int armv8pmu_access_event_idx(struct perf_event *event)
>>>> +{
>>>> +    if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
>>>> +        return 0;
>>>> +
>>>> +    /*
>>>> +     * We remap the cycle counter index to 32 to
>>>> +     * match the offset applied to the rest of
>>>> +     * the counter indeces.
>>>> +     */
>>>> +    if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
>>>> +        return 32;
>>>> +
>>>> +    return event->hw.idx;
>>>
>>> Is there a guarantee event->hw.idx is never 0? Or should you, just like
>>> x86, use +1 here?
>>>
>>
>> You are right, I should use +1 here. Thanks for pointing that out.
> 
> Isn't that already the case though, since we reserve index 0 for the 
> cycle counter? I'm looking at ARMV8_IDX_TO_COUNTER() here...
> 

Well the current behaviour is correct and takes care of the zero case 
with the ARMV8_IDX_CYCLE_COUNTER check. But using ARMV8_IDX_TO_COUNTER() 
and add 1 would also work. However this seems indeed redundant with the 
current value held in event->hw.idx.

> Robin.

-- 
Raphael Gault
