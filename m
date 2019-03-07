Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2152BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850C20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCGUQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:16:02 -0500
Received: from relay.sw.ru ([185.231.240.75]:57738 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGUQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:16:01 -0500
Received: from [192.168.15.234]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1h1zQg-0003at-Th; Thu, 07 Mar 2019 23:15:47 +0300
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6a4875bd-2b22-91e4-cbe2-b01c12786a1b@virtuozzo.com>
Date:   Thu, 7 Mar 2019 23:15:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/19 8:41 PM, Peter Zijlstra wrote:
> On Thu, Mar 07, 2019 at 08:33:26AM -0800, Linus Torvalds wrote:
>> On Thu, Mar 7, 2019 at 3:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> XXX: are we sure we want __memset marked AC-safe?
>>
>> It's certainly one of the safer functions to call with AC set, but it
>> sounds wrong anyway. It's not like it's likely to leak kernel data
>> (most memset's are with 0, and even the non-zero ones I can't imagine
>> are sensitive - more like poison values etc).
>>
>> What's the call site that made you go "just add __memset() to the list"?
> 
> __asan_{,un}poinson_stack_memory()

These two can be called only with CONFIG_KASAN_EXTRA=y which 
was removed very recently, so it should be safe to delete these functions.

>   kasan_{,un}poison_shadow()
>     __memset()
> 
> 
