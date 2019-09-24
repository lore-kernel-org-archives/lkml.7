Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B2CC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43123214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440732AbfIXKsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:48:41 -0400
Received: from foss.arm.com ([217.140.110.172]:57354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438486AbfIXKsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:48:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F10142F;
        Tue, 24 Sep 2019 03:48:40 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12A363F67D;
        Tue, 24 Sep 2019 03:48:39 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] microblaze: entry: Remove unneeded need_resched()
 loop
To:     Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
References: <20190923143620.29334-1-valentin.schneider@arm.com>
 <20190923143620.29334-6-valentin.schneider@arm.com>
 <feebf264-a311-9777-cd9b-5d227e8f6d3c@monstr.eu>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7131ee8e-d632-a6e4-b974-e2ad2df3bbda@arm.com>
Date:   Tue, 24 Sep 2019 11:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <feebf264-a311-9777-cd9b-5d227e8f6d3c@monstr.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2019 11:30, Michal Simek wrote:
> On 23. 09. 19 16:36, Valentin Schneider wrote:
>> Since the enabling and disabling of IRQs within preempt_schedule_irq()
>> is contained in a need_resched() loop, we don't need the outer arch
>> code loop.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> ---
>>  arch/microblaze/kernel/entry.S | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
>> index 4e1b567becd6..de7083bd1d24 100644
>> --- a/arch/microblaze/kernel/entry.S
>> +++ b/arch/microblaze/kernel/entry.S
>> @@ -738,14 +738,9 @@ no_intr_resched:
>>  	andi	r5, r5, _TIF_NEED_RESCHED;
>>  	beqi	r5, restore /* if zero jump over */
>>  
>> -preempt:
>>  	/* interrupts are off that's why I am calling preempt_chedule_irq */
>>  	bralid	r15, preempt_schedule_irq
>>  	nop
>> -	lwi	r11, CURRENT_TASK, TS_THREAD_INFO;	/* get thread info */
>> -	lwi	r5, r11, TI_FLAGS;		/* get flags in thread info */
>> -	andi	r5, r5, _TIF_NEED_RESCHED;
>> -	bnei	r5, preempt /* if non zero jump to resched */
>>  restore:
>>  #endif
>>  	VM_OFF /* MS: turn off MMU */
>>
> 
> Looks reasonable and also tested on HW. I expect you want me to take it
> via microblaze tree that's why applied.
> 

Yes, please. Thanks!

> Thanks,
> Michal
> 
