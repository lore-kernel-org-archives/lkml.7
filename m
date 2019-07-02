Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED25C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A32206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfGBJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:49:33 -0400
Received: from foss.arm.com ([217.140.110.172]:46874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfGBJtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:49:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C71344;
        Tue,  2 Jul 2019 02:49:32 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 677CC3F718;
        Tue,  2 Jul 2019 02:49:31 -0700 (PDT)
Subject: Re: [RFC V3 12/18] arm64: assembler: Add macro to annotate asm
 function having non standard stack-frame.
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, will.deacon@arm.com,
        julien.thierry@arm.com
References: <20190624095548.8578-1-raphael.gault@arm.com>
 <20190624095548.8578-13-raphael.gault@arm.com>
 <20190701144039.GD21774@arrakis.emea.arm.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <7ddc9d27-e4ea-c07a-ad12-3fac59aeb4fc@arm.com>
Date:   Tue, 2 Jul 2019 10:49:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701144039.GD21774@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/1/19 3:40 PM, Catalin Marinas wrote:
> On Mon, Jun 24, 2019 at 10:55:42AM +0100, Raphael Gault wrote:
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -752,4 +752,17 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>>   .Lyield_out_\@ :
>>   	.endm
>>   
>> +	/*
>> +	 * This macro is the arm64 assembler equivalent of the
>> +	 * macro STACK_FRAME_NON_STANDARD define at
>> +	 * ~/include/linux/frame.h
>> +	 */
>> +	.macro	asm_stack_frame_non_standard	func
>> +#ifdef	CONFIG_STACK_VALIDATION
>> +	.pushsection ".discard.func_stack_frame_non_standard"
>> +	.8byte	\func
> 
> Nitpicks:
> 
> Does .quad vs .8byte make any difference?
> 

No it doesn't, I'll use .quad then.

> Could we place this in include/linux/frame.h directly with a generic
> name (and some __ASSEMBLY__ guards)? It doesn't look to be arm specific.
> 

It might be more consistent indeed, I'll do that.

Thanks,

-- 
Raphael Gault
