Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B028C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35800206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKUWUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:47 -0500
Received: from relay.sw.ru ([185.231.240.75]:55856 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUWUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:46 -0500
Received: from [192.168.15.154]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iXuoL-0007nb-4j; Fri, 22 Nov 2019 01:20:25 +0300
Subject: Re: [PATCH v4 1/2] kasan: detect negative size in memory operation
 function
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
 <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
 <CACT4Y+botuVF6KanfRrudDguw7HGkJ1mrwvxYZQQF0eWoo-Lxw@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <ad1aa63b-38d7-4c8d-00c0-bd215cf9b66e@virtuozzo.com>
Date:   Fri, 22 Nov 2019 01:18:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+botuVF6KanfRrudDguw7HGkJ1mrwvxYZQQF0eWoo-Lxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/19 10:58 PM, Dmitry Vyukov wrote:
> On Thu, Nov 21, 2019 at 1:27 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>>> index 6814d6d6a023..4bfce0af881f 100644
>>> --- a/mm/kasan/common.c
>>> +++ b/mm/kasan/common.c
>>> @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
>>>  #undef memset
>>>  void *memset(void *addr, int c, size_t len)
>>>  {
>>> -     check_memory_region((unsigned long)addr, len, true, _RET_IP_);
>>> +     if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
>>> +             return NULL;
>>>
>>>       return __memset(addr, c, len);
>>>  }
>>> @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
>>>  #undef memmove
>>>  void *memmove(void *dest, const void *src, size_t len)
>>>  {
>>> -     check_memory_region((unsigned long)src, len, false, _RET_IP_);
>>> -     check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>>> +     if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
>>> +         !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
>>> +             return NULL;
>>>
>>>       return __memmove(dest, src, len);
>>>  }
>>> @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t len)
>>>  #undef memcpy
>>>  void *memcpy(void *dest, const void *src, size_t len)
>>>  {
>>> -     check_memory_region((unsigned long)src, len, false, _RET_IP_);
>>> -     check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>>> +     if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
>>> +         !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
>>> +             return NULL;
>>>
>>
>> I realized that we are going a wrong direction here. Entirely skipping mem*() operation on any
>> poisoned shadow value might only make things worse. Some bugs just don't have any serious consequences,
>> but skipping the mem*() ops entirely might introduce such consequences, which wouldn't happen otherwise.
>>
>> So let's keep this code as this, no need to check the result of check_memory_region().
> 
> I suggested it.
> 
> For our production runs it won't matter, we always panic on first report.
> If one does not panic, there is no right answer. You say: _some_ bugs
> don't have any serious consequences, but skipping the mem*() ops
> entirely might introduce such consequences. The opposite is true as
> well, right? :) And it's not hard to come up with a scenario where
> overwriting memory after free or out of bounds badly corrupts memory.
> I don't think we can somehow magically avoid bad consequences in all
> cases.
>

Absolutely right. My point was that if it's bad consequences either way,
than there is no point in complicating this code, it doesn't buy us anything.

 
> What I was thinking about is tests. We need tests for this. And we
> tried to construct tests specifically so that they don't badly corrupt
> memory (e.g. OOB/UAF reads, or writes to unused redzones, etc), so
> that it's possible to run all of them to completion reliably. Skipping
> the actual memory options allows to write such tests for all possible
> scenarios. That's was my motivation.

But I see you point now. No objections to the patch in that case.
