Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1168CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0802084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKKIZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:25:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:58224 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKIZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:25:12 -0500
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iU50L-00018h-TL; Mon, 11 Nov 2019 11:24:58 +0300
Subject: Re: [PATCH v3 1/2] kasan: detect negative size in memory operation
 function
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
References: <20191104020519.27988-1-walter-zh.wu@mediatek.com>
 <34bf9c08-d2f2-a6c6-1dbe-29b1456d8284@virtuozzo.com>
 <CACT4Y+bfGrJemwyMVqd2Kt19mF2i=3GwXRKHP0qGJaT_5OhSCA@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <20df03c5-e733-98b0-84e9-8d52ddce5c98@virtuozzo.com>
Date:   Mon, 11 Nov 2019 11:24:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bfGrJemwyMVqd2Kt19mF2i=3GwXRKHP0qGJaT_5OhSCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/19 10:57 AM, Dmitry Vyukov wrote:
> On Fri, Nov 8, 2019 at 11:32 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

>>> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
>>> index 36c645939bc9..52a92c7db697 100644
>>> --- a/mm/kasan/generic_report.c
>>> +++ b/mm/kasan/generic_report.c
>>> @@ -107,6 +107,24 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
>>>
>>>  const char *get_bug_type(struct kasan_access_info *info)
>>>  {
>>> +     /*
>>> +      * If access_size is negative numbers, then it has three reasons
>>> +      * to be defined as heap-out-of-bounds bug type.
>>> +      * 1) Casting negative numbers to size_t would indeed turn up as
>>> +      *    a large size_t and its value will be larger than ULONG_MAX/2,
>>> +      *    so that this can qualify as out-of-bounds.
>>> +      * 2) If KASAN has new bug type and user-space passes negative size,
>>> +      *    then there are duplicate reports. So don't produce new bug type
>>> +      *    in order to prevent duplicate reports by some systems
>>> +      *    (e.g. syzbot) to report the same bug twice.
>>> +      * 3) When size is negative numbers, it may be passed from user-space.
>>> +      *    So we always print heap-out-of-bounds in order to prevent that
>>> +      *    kernel-space and user-space have the same bug but have duplicate
>>> +      *    reports.
>>> +      */
>>
>> Completely fail to understand 2) and 3). 2) talks something about *NOT* producing new bug
>> type, but at the same time you code actually does that.
>> 3) says something about user-space which have nothing to do with kasan.
> 
> The idea was to use one of the existing bug titles so that syzbot does
> not produce 2 versions for OOBs where size is user-controlled. We
> don't know if it's overflow from heap, global or stack, but heap is
> the most common bug, so saying heap overflow will reduce chances of
> producing duplicates the most.
> But for all of this to work we do need to use one of the existing bug titles.

The "heap-out-of-bounds" is not one of the existing bug titles.
