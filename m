Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B66C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC3C218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfB1QBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:01:39 -0500
Received: from relay.sw.ru ([185.231.240.75]:35320 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfB1QBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:01:39 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gzO7n-0000vF-MM; Thu, 28 Feb 2019 19:01:31 +0300
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190228154551.GE32494@hirez.programming.kicks-ass.net>
 <CACT4Y+aEx5-8g-YDoK37gtntCxy8_8sSWdG7FeU+fc=B3C3axA@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a8b9e933-d7e5-e34f-b395-0be48347f9cc@virtuozzo.com>
Date:   Thu, 28 Feb 2019 19:01:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aEx5-8g-YDoK37gtntCxy8_8sSWdG7FeU+fc=B3C3axA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/19 6:52 PM, Dmitry Vyukov wrote:
> On Thu, Feb 28, 2019 at 4:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Feb 28, 2019 at 04:22:04PM +0100, Dmitry Vyukov wrote:
>>> On Thu, Feb 28, 2019 at 4:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>> Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
>>>> UACCESS context, and kasan_report() is most definitely _NOT_ safe to
>>>> be called from there, move it into an exception much like BUG/WARN.
>>>>
>>>> *compile tested only*
>>>
>>>
>>> Please test it by booting KASAN kernel and then loading module
>>> produced by CONFIG_TEST_KASAN=y. There are too many subtle aspects to
>>> rely on "compile tested only", reviewers can't catch all of them
>>> either.
>>
>> Sure, I'll do that. I just wanted to share the rest of the patches.
>>
>> A quick test shows it dies _REAAAAAAAALY_ early, as in:
>>
>> "Booting the kernel."
>>
>> is the first and very last thing it says... I wonder how I did that :-)
> 
> One thing is that during early boot kasan_report is called multiple
> times, but these are false positives related to the fact that we don't
> have a proper shadow yet (setup later). So during early boot we set
> kasan_disable=1 (or some global or per-task flag), and then
> kasan_report checks it and returns.
> Once we setup proper shadow, the flag is reset and from now on
> kasan_report actually reports bug.
> 

Yup, see report_enabled() function.
