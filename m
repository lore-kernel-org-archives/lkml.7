Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62F7C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E172187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfKGElC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:41:02 -0500
Received: from foss.arm.com ([217.140.110.172]:49702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbfKGElC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:41:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069AE7A7;
        Wed,  6 Nov 2019 20:41:01 -0800 (PST)
Received: from [10.162.42.33] (a075563-lin.blr.arm.com [10.162.42.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430353F71A;
        Wed,  6 Nov 2019 20:40:56 -0800 (PST)
Subject: Re: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        deller@gmx.de, duwe@suse.de, James.Bottomley@HansenPartnership.com,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-2-mark.rutland@arm.com>
 <daad0785-a33f-3cfb-cf0f-657b6c677257@arm.com>
 <20191104133657.GE45140@lakrids.cambridge.arm.com>
 <8e68de1f-f961-752d-9c07-ce41ce624d35@arm.com>
 <20191106141530.GC50610@lakrids.cambridge.arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <77ba9a77-7971-77b6-c3f9-e3e0adf6cf54@arm.com>
Date:   Thu, 7 Nov 2019 10:10:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191106141530.GC50610@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/19 7:45 PM, Mark Rutland wrote:
> On Tue, Nov 05, 2019 at 12:17:26PM +0530, Amit Kachhap wrote:
>> On 11/4/19 7:06 PM, Mark Rutland wrote:
>>> On Sat, Nov 02, 2019 at 05:49:00PM +0530, Amit Daniel Kachhap wrote:
>>>> On 10/29/19 10:28 PM, Mark Rutland wrote:
>>>>> +/**
>>>>> + * ftrace_init_nop - initialize a nop call site
>>>>> + * @mod: module structure if called by module load initialization
>>>>> + * @rec: the call site record (e.g. mcount/fentry)
>>>>> + *
>>>>> + * This is a very sensitive operation and great care needs
>>>>> + * to be taken by the arch.  The operation should carefully
>>>>> + * read the location, check to see if what is read is indeed
>>>>> + * what we expect it to be, and then on success of the compare,
>>>>> + * it should write to the location.
>>>>> + *
>>>>> + * The code segment at @rec->ip should contain the contents created by
>>>>> + * the compiler
>>>> Nit: Will it be better to write it as "@rec->ip should store the adjusted
>>>> ftrace entry address of the call site" or something like that.
>>>
>>> This was the specific wording requested by Steve, and it's trying to
>>> describe the instructions at rec->ip, rather than the value of rec->ip,
>>> so I think it's better to leave this as-is.
>> ok Its fine this way too. Actually from the comment, I could not understand
>> which one of the compiler contents this points to as in this case there are
>> 2 nops.
> 
> We can't say what the compiler contents will be. An architecture may use
> this callback if it's using mcount, mfentry, patchable-function-entry,
> or some other mechanism we're not aware of today. Depending on the
> architecture and mechanism, the callsite could contain a number of
> distinct things.
> 
> All the comment is trying to say is that when ftrace_init_nop() is
> called, the callsite has not been modified in any way since being
> compiled, so we can expect the contents to be whatever the compiler
> generated.

ok. Your details seems reasonable.

Thanks,
Amit Daniel
> 
> Thanks,
> Mark.
> 
