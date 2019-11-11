Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF45C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2F52075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKJab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:30:31 -0500
Received: from relay.sw.ru ([185.231.240.75]:60582 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfKKJab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:30:31 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iU61K-0001Yc-OX; Mon, 11 Nov 2019 12:30:02 +0300
Subject: Re: [PATCH v3 1/2] kasan: detect negative size in memory operation
 function
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
References: <20191104020519.27988-1-walter-zh.wu@mediatek.com>
 <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com>
 <1573456464.20611.45.camel@mtksdccf07>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <757f0296-7fa0-0e5e-8490-3eca52da41ad@virtuozzo.com>
Date:   Mon, 11 Nov 2019 12:29:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573456464.20611.45.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/19 10:14 AM, Walter Wu wrote:
> On Sat, 2019-11-09 at 01:31 +0300, Andrey Ryabinin wrote:
>>
>> On 11/4/19 5:05 AM, Walter Wu wrote:
>>
>>>
>>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>>> index 6814d6d6a023..4ff67e2fd2db 100644
>>> --- a/mm/kasan/common.c
>>> +++ b/mm/kasan/common.c
>>> @@ -99,10 +99,14 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
>>>  }
>>>  EXPORT_SYMBOL(__kasan_check_write);
>>>  
>>> +extern bool report_enabled(void);
>>> +
>>>  #undef memset
>>>  void *memset(void *addr, int c, size_t len)
>>>  {
>>> -	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
>>> +	if (report_enabled() &&
>>> +	    !check_memory_region((unsigned long)addr, len, true, _RET_IP_))
>>> +		return NULL;
>>>  
>>>  	return __memset(addr, c, len);
>>>  }
>>> @@ -110,8 +114,10 @@ void *memset(void *addr, int c, size_t len)
>>>  #undef memmove
>>>  void *memmove(void *dest, const void *src, size_t len)
>>>  {
>>> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
>>> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>>> +	if (report_enabled() &&
>>> +	   (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
>>> +	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_)))
>>> +		return NULL;
>>>  
>>>  	return __memmove(dest, src, len);
>>>  }
>>> @@ -119,8 +125,10 @@ void *memmove(void *dest, const void *src, size_t len)
>>>  #undef memcpy
>>>  void *memcpy(void *dest, const void *src, size_t len)
>>>  {
>>> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
>>> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>>> +	if (report_enabled() &&
>>
>>             report_enabled() checks seems to be useless.
>>
> 
> Hi Andrey,
> 
> If it doesn't have report_enable(), then it will have below the error.
> We think it should be x86 shadow memory is invalid value before KASAN
> initialized, it will have some misjudgments to do directly return when
> it detects invalid shadow value in memset()/memcpy()/memmove(). So we
> add report_enable() to avoid this happening. but we should only use the
> condition "current->kasan_depth == 0" to determine if KASAN is
> initialized. And we try it is pass at x86.
> 

Ok, I see. It just means that check_memory_region() return incorrect result in early stages of boot.
So, the right way to deal with this would be making kasan_report() to return bool ("false" if no report and "true" if reported)
and propagate this return value up to check_memory_region().


>>> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
>>> index 36c645939bc9..52a92c7db697 100644
>>> --- a/mm/kasan/generic_report.c
>>> +++ b/mm/kasan/generic_report.c
>>> @@ -107,6 +107,24 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
>>>  
>>>  const char *get_bug_type(struct kasan_access_info *info)
>>>  {
>>> +	/*
>>> +	 * If access_size is negative numbers, then it has three reasons
>>> +	 * to be defined as heap-out-of-bounds bug type.
>>> +	 * 1) Casting negative numbers to size_t would indeed turn up as
>>> +	 *    a large size_t and its value will be larger than ULONG_MAX/2,
>>> +	 *    so that this can qualify as out-of-bounds.
>>> +	 * 2) If KASAN has new bug type and user-space passes negative size,
>>> +	 *    then there are duplicate reports. So don't produce new bug type
>>> +	 *    in order to prevent duplicate reports by some systems
>>> +	 *    (e.g. syzbot) to report the same bug twice.
>>> +	 * 3) When size is negative numbers, it may be passed from user-space.
>>> +	 *    So we always print heap-out-of-bounds in order to prevent that
>>> +	 *    kernel-space and user-space have the same bug but have duplicate
>>> +	 *    reports.
>>> +	 */
>>  
>> Completely fail to understand 2) and 3). 2) talks something about *NOT* producing new bug
>> type, but at the same time you code actually does that.
>> 3) says something about user-space which have nothing to do with kasan.
>>
> about 2)
> We originally think the heap-out-of-bounds is similar to
> heap-buffer-overflow, maybe we should change the bug type to
> heap-buffer-overflow.

There is no "heap-buffer-overflow".

> 
> about 3)
> Our idea is just to always print "heap-out-of-bounds" and don't
> differentiate if the size come from user-space or not.

Still doesn't make sence to me. KASAN doesn't differentiate if the size coming from user-space
or not. It simply doesn't have any way of knowing from where is the size coming from.
