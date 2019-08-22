Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEBCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F465233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbfHVRIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:08:10 -0400
Received: from relay.sw.ru ([185.231.240.75]:60454 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388772AbfHVRIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:10 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1i0qYx-0000iY-OZ; Thu, 22 Aug 2019 20:07:51 +0300
Subject: Re: [PATCH 2/2] riscv: Add KASAN support
To:     Nick Hu <nickhu@andestech.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     =?UTF-8?B?QWxhbiBRdWV5LUxpYW5nIEthbyjpq5jprYHoia8p?= 
        <alankao@andestech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        =?UTF-8?B?6Zui6IG3Wm9uZyBab25nLVhpYW4gTGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
References: <cover.1565161957.git.nickhu@andestech.com>
 <88358ef8f7cfcb7fd01b6b989eccaddbe00a1e57.1565161957.git.nickhu@andestech.com>
 <20190812151050.GJ26897@infradead.org> <20190814074417.GA21929@andestech.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <cf7a4259-afa5-53e6-f8f2-c243339cc3e9@virtuozzo.com>
Date:   Thu, 22 Aug 2019 20:08:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814074417.GA21929@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/19 10:44 AM, Nick Hu wrote:

>>
>>> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>>> index 23cd1a9..9700980 100644
>>> --- a/arch/riscv/kernel/vmlinux.lds.S
>>> +++ b/arch/riscv/kernel/vmlinux.lds.S
>>> @@ -46,6 +46,7 @@ SECTIONS
>>>  		KPROBES_TEXT
>>>  		ENTRY_TEXT
>>>  		IRQENTRY_TEXT
>>> +		SOFTIRQENTRY_TEXT
>>
>> Hmm.  What is the relation to kasan here?  Maybe we should add this
>> separately with a good changelog?
>>
> There is a commit for it:
> 
> Author: Alexander Potapenko <glider@google.com>
> Date:   Fri Mar 25 14:22:05 2016 -0700
> 
>     arch, ftrace: for KASAN put hard/soft IRQ entries into separate sections
> 
>     KASAN needs to know whether the allocation happens in an IRQ handler.
>     This lets us strip everything below the IRQ entry point to reduce the
>     number of unique stack traces needed to be stored.
> 
>     Move the definition of __irq_entry to <linux/interrupt.h> so that the
>     users don't need to pull in <linux/ftrace.h>.  Also introduce the
>     __softirq_entry macro which is similar to __irq_entry, but puts the
>     corresponding functions to the .softirqentry.text section.
> 
> After reading the patch I understand that soft/hard IRQ entries should be
> separated for KASAN to work, but why?
> 

KASAN doesn't need soft/hard IRQ entries separated. KASAN wants to know the entry
point of IRQ (hard or soft) to filter out random non-irq part of the stacktrace before feeding it to
stack_depot_save. See filter_irq_stacks().


