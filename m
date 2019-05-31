Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BAC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C15C26678
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfEaJKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:10:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48354 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:10:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACD39341;
        Fri, 31 May 2019 02:10:01 -0700 (PDT)
Received: from [10.162.42.223] (p8cg001049571a15.blr.arm.com [10.162.42.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF433F59C;
        Fri, 31 May 2019 02:09:58 -0700 (PDT)
Subject: Re: [PATCH 3/4] arm64/mm: Consolidate page fault information capture
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <1559133285-27986-4-git-send-email-anshuman.khandual@arm.com>
 <20190529145312.GG31777@lakrids.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4d799bda-dfde-8ba5-9aeb-aa38550f6103@arm.com>
Date:   Fri, 31 May 2019 14:40:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190529145312.GG31777@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2019 08:23 PM, Mark Rutland wrote:
> On Wed, May 29, 2019 at 06:04:44PM +0530, Anshuman Khandual wrote:
>> This consolidates page fault information capture and move them bit earlier.
>> While here it also adds an wrapper is_write_abort(). It also saves some
>> cycles by replacing multiple user_mode() calls into a single one earlier
>> during the fault.
> 
> To be honest, I doubt this has any measureable impact, but I agree that
> using variables _may_ make the flow control easier to understand.
> 
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com> 
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/mm/fault.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index da02678..170c71f 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -435,6 +435,11 @@ static bool is_el0_instruction_abort(unsigned int esr)
>>  	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
>>  }
>>  
>> +static bool is_write_abort(unsigned int esr)
>> +{
>> +	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
>> +}
> 
> In off-list review, I mentioned that this isn't true for EL1, and I
> think that we should name this 'is_el0_write_abort()' or add a comment
> explaining the caveats if factored into a helper.
> 
> Thanks,
> Mark.

Okay will change the wrapper name to is_el0_write_abort() and add a comment
explaining how this is only applicable to aborts originating from EL0.
