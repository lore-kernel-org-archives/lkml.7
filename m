Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FACB2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCNSih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:38:37 -0400
Received: from foss.arm.com ([217.140.101.70]:48572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfCNSig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F85A78;
        Thu, 14 Mar 2019 11:38:36 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D1FF3F59C;
        Thu, 14 Mar 2019 11:38:35 -0700 (PDT)
Subject: Re: [PATCH 06/14] MIPS: entry: Remove unneeded need_resched() loop
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
 <20190311224752.8337-7-valentin.schneider@arm.com>
 <20190314181306.k6vxmaomyqalhi65@pburton-laptop>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e8b0f733-374d-7cc9-fc5b-e59341519836@arm.com>
Date:   Thu, 14 Mar 2019 18:38:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314181306.k6vxmaomyqalhi65@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 14/03/2019 18:13, Paul Burton wrote:
[...]
> 
> It looks to me like commit a18815abcdfd ("Use preempt_schedule_irq.")
> forgot the branch to restore_all, so would have fallen through to
> ret_from_fork() & done weird things.
> 
> Adding the branch to restore_all as you're doing here would have been a
> better fix than commit cdaed73afb61 ("Fix preemption bug.").
> 

I didn't notice the missing branch to restore_all in that first commit -
that makes (more) sense now.

[...]
>> @@ -66,7 +65,7 @@ need_resched:
>>  	andi	t0, 1
>>  	beqz	t0, restore_all
>>  	jal	preempt_schedule_irq
>> -	b	need_resched
>> +	j	restore_all
> 
> One nit - why change from branch to jump? 

No actual reason there, I most likely deleted the branch, looked around,
saw the "j restore_all" in @resume_userspace and went for that (shoddy
I know...)

> It's not a big deal, but I'd
> prefer we stick with the branch ("b") instruction for a few reasons:
> 
> - restore_all is nearby so there's no issue with it being out of range
>   of a branch in any variation of the MIPS ISA.
> 
> - It's more consistent with the future of the MIPS architecture, eg.
>   nanoMIPS in which branch instructions all use PC-relative immediate
>   offsets & jump instructions are always of the "register" variety where
>   the destination is specified by a register rather than an immediate
>   encoded in the instruction (the assembler will fix it up & emit a
>   branch anyway, but I generally prefer to invoke less magic in these
>   areas...).
> 
> - A PC-relative branch won't generate an extra reloc in a relocatable
>   kernel, whereas a jump will.
> 

Makes total sense, thanks for the detailed reasoning!

> Even better would be if we take advantage of this being a tail call & do
> this:
> 
> 	PTR_LA	ra, restore_all
> 	j	preempt_schedule_irq
> 
> (Where I left the call to preempt_schedule_irq using a jump because it
> may be further away.)
> 

Right, that's even better, I'll send a v2 with that.

> Though I don't mind if you wanna just s/j/b/ & leave the tail call
> optimisation for someone else to do as a later change.
> 
> Thanks,
>     Paul
> 
>>  #endif
>>  
>>  FEXPORT(ret_from_kernel_thread)
>> -- 
>> 2.20.1
>>
