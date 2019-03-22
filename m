Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ED92083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfCVIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:31:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40272 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCVIbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:31:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A962A78;
        Fri, 22 Mar 2019 01:31:51 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98263F59C;
        Fri, 22 Mar 2019 01:31:49 -0700 (PDT)
Subject: Re: [PATCH] perf: Change PMCR write to read-modify-write
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     will.deacon@arm.com, mingo@redhat.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
References: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
 <bb4ece56-ac42-05f2-8475-38c49539999d@arm.com>
 <b2e82eca3dec9d1ea9053e9e69223db3@codeaurora.org>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <ec1bda5b-9068-56a7-3ed0-9a606036d60a@arm.com>
Date:   Fri, 22 Mar 2019 08:31:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b2e82eca3dec9d1ea9053e9e69223db3@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2019 20:02, Sodagudi Prasad wrote:
> On 2019-03-21 06:34, Julien Thierry wrote:
>> Hi Prasad,
>>
>> On 21/03/2019 02:07, Prasad Sodagudi wrote:
>>> Preserves the bitfields of PMCR_EL0(AArch64) during PMU reset.
>>> Reset routine should write a 1 to PMCR.C and PMCR.P fields only
>>> to reset the counters. Other fields should not be changed
>>> as they could be set before PMU initialization and their
>>> value must be preserved even after reset.
>>>
>>
>> Are there any particular bit you are concerned about? Apart from the RO
>> ones and the Res0 ones (to which we are already writing 0), I see:
>>
>> DP -> irrelevant for non-secure
>> X -> This one is the only potentially interesting, however it resets to
>> an architecturally unknown value, so unless we know for a fact it was
>> set before hand, we probably want to clear it
>> D -> ignored when we have LC set (and we do)
>> E -> Since this is the function we use to reset the PMU on the current
>> CPU, we probably want to set this bit to 0 regardless of its previous
>> value
>>
>> So, is there any issue this patch is solving?
> 
> Hi Julien,
> 
> Thanks for taking a look into this patch. Yes. On our Qualcomm
> platforms, observed that X bit is getting cleared by kernel.
> This bit is getting set by firmware for Qualcomm use cases and
> non-secure world is resetting without this patch.
> I think, changing that register this register modifications to
> read-modify-write style make sense.
> 

Maybe for the X bit, but for the E bit this seems like the wrong thing
to do. We want to set the E bit to 0 here.

And for platforms that don't have a firmware touching the X bit (or
rather the pmcr as a whole), I'd like to understand whether it would be
valid to leave this bit set to an architecturally unknown value and
preserving that value.

Thanks,

>>> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
>>> ---
>>>  arch/arm64/kernel/perf_event.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/perf_event.c
>>> b/arch/arm64/kernel/perf_event.c
>>> index 4addb38..0c1afdd 100644
>>> --- a/arch/arm64/kernel/perf_event.c
>>> +++ b/arch/arm64/kernel/perf_event.c
>>> @@ -868,8 +868,8 @@ static void armv8pmu_reset(void *info)
>>>       * Initialize & Reset PMNC. Request overflow interrupt for
>>>       * 64 bit cycle counter but cheat in armv8pmu_write_counter().
>>>       */
>>> -    armv8pmu_pmcr_write(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C |
>>> -                ARMV8_PMU_PMCR_LC);
>>> +    armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_P |
>>> +            ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC);
>>>  }
>>>
>>>  static int __armv8_pmuv3_map_event(struct perf_event *event,
>>>
> 

-- 
Julien Thierry
