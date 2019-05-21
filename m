Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F84BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C92217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfEUSHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:07:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:43392 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbfEUSHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:07:31 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hT9Ad-00083b-Gp; Tue, 21 May 2019 21:07:27 +0300
Subject: Re: [PATCH v2] mm/kasan: Print frame description for stack bugs
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20190520154751.84763-1-elver@google.com>
 <ebec4325-f91b-b392-55ed-95dbd36bbb8e@virtuozzo.com>
 <CAG_fn=W+_Ft=g06wtOBgKnpD4UswE_XMXd61jw5ekOH_zeUVOQ@mail.gmail.com>
 <CANpmjNN177XBadNfoSmizQF7uZV61PNPQSftT7hPdc3HmdzSjA@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <292035fd-64b7-1767-3e8a-3a6cb50298b5@virtuozzo.com>
Date:   Tue, 21 May 2019 21:07:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNN177XBadNfoSmizQF7uZV61PNPQSftT7hPdc3HmdzSjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/19 7:07 PM, Marco Elver wrote:
> On Tue, 21 May 2019 at 17:53, Alexander Potapenko <glider@google.com> wrote:
>>
>> On Tue, May 21, 2019 at 5:43 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>
>>> On 5/20/19 6:47 PM, Marco Elver wrote:
>>>
>>>> +static void print_decoded_frame_descr(const char *frame_descr)
>>>> +{
>>>> +     /*
>>>> +      * We need to parse the following string:
>>>> +      *    "n alloc_1 alloc_2 ... alloc_n"
>>>> +      * where alloc_i looks like
>>>> +      *    "offset size len name"
>>>> +      * or "offset size len name:line".
>>>> +      */
>>>> +
>>>> +     char token[64];
>>>> +     unsigned long num_objects;
>>>> +
>>>> +     if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
>>>> +                               &num_objects))
>>>> +             return;
>>>> +
>>>> +     pr_err("\n");
>>>> +     pr_err("this frame has %lu %s:\n", num_objects,
>>>> +            num_objects == 1 ? "object" : "objects");
>>>> +
>>>> +     while (num_objects--) {
>>>> +             unsigned long offset;
>>>> +             unsigned long size;
>>>> +
>>>> +             /* access offset */
>>>> +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
>>>> +                                       &offset))
>>>> +                     return;
>>>> +             /* access size */
>>>> +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
>>>> +                                       &size))
>>>> +                     return;
>>>> +             /* name length (unused) */
>>>> +             if (!tokenize_frame_descr(&frame_descr, NULL, 0, NULL))
>>>> +                     return;
>>>> +             /* object name */
>>>> +             if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
>>>> +                                       NULL))
>>>> +                     return;
>>>> +
>>>> +             /* Strip line number, if it exists. */
>>>
>>>    Why?
> 
> The filename is not included, and I don't think it adds much in terms
> of ability to debug; nor is the line number included with all
> descriptions. I think, the added complexity of separating the line
> number and parsing is not worthwhile here. Alternatively, I could not
> pay attention to the line number at all, and leave it as is -- in that
> case, some variable names will display as "foo:123".
> 

Either way is fine by me. But explain why in comment if you decide
to keep current code.  Something like
	 /* Strip line number cause it's not very helpful. */


>>>
>>>> +             strreplace(token, ':', '\0');
>>>> +
>>>
>>> ...
>>>
>>>> +
>>>> +     aligned_addr = round_down((unsigned long)addr, sizeof(long));
>>>> +     mem_ptr = round_down(aligned_addr, KASAN_SHADOW_SCALE_SIZE);
>>>> +     shadow_ptr = kasan_mem_to_shadow((void *)aligned_addr);
>>>> +     shadow_bottom = kasan_mem_to_shadow(end_of_stack(current));
>>>> +
>>>> +     while (shadow_ptr >= shadow_bottom && *shadow_ptr != KASAN_STACK_LEFT) {
>>>> +             shadow_ptr--;
>>>> +             mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
>>>> +     }
>>>> +
>>>> +     while (shadow_ptr >= shadow_bottom && *shadow_ptr == KASAN_STACK_LEFT) {
>>>> +             shadow_ptr--;
>>>> +             mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
>>>> +     }
>>>> +
>>>
>>> I suppose this won't work if stack grows up, which is fine because it grows up only on parisc arch.
>>> But "BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROUWSUP))" somewhere wouldn't hurt.
>> Note that KASAN was broken on parisc from day 1 because of other
>> assumptions on the stack growth direction hardcoded into KASAN
>> (e.g. __kasan_unpoison_stack() and __asan_allocas_unpoison()).

It's not broken, it doesn't exist.

>> So maybe this BUILD_BUG_ON can be added in a separate patch as it's
>> not specific to what Marco is doing here?
> 

I think it's fine to add it in this patch because BUILD_BUG_ON() is just a hint for developers
that this particular function depends on growing down stack. So it's more a property of the function
rather than KASAN in general.

Other functions you mentioned can be marked with BUILD_BUG_ON()s as well, but not in this patch indeed.

> Happy to send a follow-up patch, or add here. Let me know what you prefer.
> 

Send v3 please.
