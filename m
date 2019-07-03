Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA998C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BC321881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfGCOKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:10:44 -0400
Received: from foss.arm.com ([217.140.110.172]:48946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfGCOKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:10:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B3752B;
        Wed,  3 Jul 2019 07:10:43 -0700 (PDT)
Received: from [10.162.42.95] (p8cg001049571a15.blr.arm.com [10.162.42.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15DD03F718;
        Wed,  3 Jul 2019 07:10:41 -0700 (PDT)
Subject: Re: [DRAFT] mm/kprobes: Add generic kprobe_fault_handler() fallback
 definition
To:     Guenter Roeck <linux@roeck-us.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
References: <78863cd0-8cb5-c4fd-ed06-b1136bdbb6ef@arm.com>
 <1561973757-5445-1-git-send-email-anshuman.khandual@arm.com>
 <8c6b9525-5dc5-7d17-cee1-b75d5a5121d6@roeck-us.net>
 <fc68afaa-32e1-a265-aae2-e4a9440f4c95@arm.com>
 <8a5eb5d5-32f0-01cd-b2fe-890ebb98395b@roeck-us.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a0a0e277-ec1a-6c49-4852-c945ad64a1fd@arm.com>
Date:   Wed, 3 Jul 2019 19:41:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a5eb5d5-32f0-01cd-b2fe-890ebb98395b@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2019 06:29 PM, Guenter Roeck wrote:
> On 7/2/19 10:35 PM, Anshuman Khandual wrote:
>>
>>
>> On 07/01/2019 06:58 PM, Guenter Roeck wrote:
>>> On 7/1/19 2:35 AM, Anshuman Khandual wrote:
>>>> Architectures like parisc enable CONFIG_KROBES without having a definition
>>>> for kprobe_fault_handler() which results in a build failure. Arch needs to
>>>> provide kprobe_fault_handler() as it is platform specific and cannot have
>>>> a generic working alternative. But in the event when platform lacks such a
>>>> definition there needs to be a fallback.
>>>>
>>>> This adds a stub kprobe_fault_handler() definition which not only prevents
>>>> a build failure but also makes sure that kprobe_page_fault() if called will
>>>> always return negative in absence of a sane platform specific alternative.
>>>>
>>>> While here wrap kprobe_page_fault() in CONFIG_KPROBES. This enables stud
>>>> definitions for generic kporbe_fault_handler() and kprobes_built_in() can
>>>> just be dropped. Only on x86 it needs to be added back locally as it gets
>>>> used in a !CONFIG_KPROBES function do_general_protection().
>>>>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> I am planning to go with approach unless we just want to implement a stub
>>>> definition for parisc to get around the build problem for now.
>>>>
>>>> Hello Guenter,
>>>>
>>>> Could you please test this in your parisc setup. Thank you.
>>>>
>>>
>>> With this patch applied on top of next-20190628, parisc:allmodconfig builds
>>> correctly. I scheduled a full build for tonight for all architectures.
>>
>> How did that come along ? Did this pass all build tests ?
>>
> 
> Let's say it didn't find any failures related to this patch. I built on top of
> next-20190701 which was quite badly broken for other reasons. Unfortunately,
> next-20190702 is much worse, so retesting would not add any value at this time.
> I'd say go for it.
> 
> Guenter
> 

Sure thanks, will post it out soon.
