Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D352175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ICKRfZ//";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LNuzlWzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfCUUC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:02:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfCUUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:02:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16A63608FC; Thu, 21 Mar 2019 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553198548;
        bh=xenGAl2NHl8X7iP879+uW3awyNqe6NGTDdJhQWw9rkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ICKRfZ//3qfKeVZr21+0SuAGPaSpbRnfIDT1zrsikAhtxFsbEpT9NLH3T/Nl0RO3K
         lHOLA19TPZ9gJy5fGPLbTudj5vqbniwiRmnCM4GC3vGyvF05OAerBgPbSolxqPE9WI
         ORnnblsYb/gfmcSPlRC3tHzS1RWU6jqDXvxpnrDw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 44BD4608FC;
        Thu, 21 Mar 2019 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553198547;
        bh=xenGAl2NHl8X7iP879+uW3awyNqe6NGTDdJhQWw9rkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LNuzlWzv6u/F4HqZjjFZ/ZDnQwSnnXGLfkI1DAlLA1v+vvDo1qRu6J6ZWkRMYP0DT
         ecojn3keh6ieLpi7uVtDc/DYUgP/ZcjLZkSVKvxANBPIyccbNM842qzUOEaS+igfOI
         P4pF3k8oEy9UrSWZoaasK4vCu8AOoDoR/OBsfYoM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Mar 2019 13:02:27 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     will.deacon@arm.com, mingo@redhat.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Change PMCR write to read-modify-write
In-Reply-To: <bb4ece56-ac42-05f2-8475-38c49539999d@arm.com>
References: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
 <bb4ece56-ac42-05f2-8475-38c49539999d@arm.com>
Message-ID: <b2e82eca3dec9d1ea9053e9e69223db3@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-21 06:34, Julien Thierry wrote:
> Hi Prasad,
> 
> On 21/03/2019 02:07, Prasad Sodagudi wrote:
>> Preserves the bitfields of PMCR_EL0(AArch64) during PMU reset.
>> Reset routine should write a 1 to PMCR.C and PMCR.P fields only
>> to reset the counters. Other fields should not be changed
>> as they could be set before PMU initialization and their
>> value must be preserved even after reset.
>> 
> 
> Are there any particular bit you are concerned about? Apart from the RO
> ones and the Res0 ones (to which we are already writing 0), I see:
> 
> DP -> irrelevant for non-secure
> X -> This one is the only potentially interesting, however it resets to
> an architecturally unknown value, so unless we know for a fact it was
> set before hand, we probably want to clear it
> D -> ignored when we have LC set (and we do)
> E -> Since this is the function we use to reset the PMU on the current
> CPU, we probably want to set this bit to 0 regardless of its previous 
> value
> 
> So, is there any issue this patch is solving?

Hi Julien,

Thanks for taking a look into this patch. Yes. On our Qualcomm 
platforms, observed that X bit is getting cleared by kernel.
This bit is getting set by firmware for Qualcomm use cases and 
non-secure world is resetting without this patch.
I think, changing that register this register modifications to 
read-modify-write style make sense.

-Thanks, Prasad

> 
> Thanks,
> 
>> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
>> ---
>>  arch/arm64/kernel/perf_event.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/kernel/perf_event.c 
>> b/arch/arm64/kernel/perf_event.c
>> index 4addb38..0c1afdd 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -868,8 +868,8 @@ static void armv8pmu_reset(void *info)
>>  	 * Initialize & Reset PMNC. Request overflow interrupt for
>>  	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
>>  	 */
>> -	armv8pmu_pmcr_write(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C |
>> -			    ARMV8_PMU_PMCR_LC);
>> +	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_P |
>> +			ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC);
>>  }
>> 
>>  static int __armv8_pmuv3_map_event(struct perf_event *event,
>> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
