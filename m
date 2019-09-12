Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74526C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AF22081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfILRFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:05:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:49202 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbfILRFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:05:31 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1i8SWx-0001JP-U8; Thu, 12 Sep 2019 20:05:16 +0300
Subject: Re: [PATCH v3] mm/kasan: dump alloc and free stack for page allocator
To:     Vlastimil Babka <vbabka@suse.cz>,
        Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Qian Cai <cai@lca.pw>, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20190911083921.4158-1-walter-zh.wu@mediatek.com>
 <5E358F4B-552C-4542-9655-E01C7B754F14@lca.pw>
 <c4d2518f-4813-c941-6f47-73897f420517@suse.cz>
 <1568297308.19040.5.camel@mtksdccf07>
 <613f9f23-c7f0-871f-fe13-930c35ef3105@suse.cz>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <79fede05-735b-8477-c273-f34db93fd72b@virtuozzo.com>
Date:   Thu, 12 Sep 2019 20:05:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <613f9f23-c7f0-871f-fe13-930c35ef3105@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/19 5:31 PM, Vlastimil Babka wrote:
> On 9/12/19 4:08 PM, Walter Wu wrote:
>>
>>>   extern void __reset_page_owner(struct page *page, unsigned int order);
>>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>>> index 6c9682ce0254..dc560c7562e8 100644
>>> --- a/lib/Kconfig.kasan
>>> +++ b/lib/Kconfig.kasan
>>> @@ -41,6 +41,8 @@ config KASAN_GENERIC
>>>       select SLUB_DEBUG if SLUB
>>>       select CONSTRUCTORS
>>>       select STACKDEPOT
>>> +    select PAGE_OWNER
>>> +    select PAGE_OWNER_FREE_STACK
>>>       help
>>>         Enables generic KASAN mode.
>>>         Supported in both GCC and Clang. With GCC it requires version 4.9.2
>>> @@ -63,6 +65,8 @@ config KASAN_SW_TAGS
>>>       select SLUB_DEBUG if SLUB
>>>       select CONSTRUCTORS
>>>       select STACKDEPOT
>>> +    select PAGE_OWNER
>>> +    select PAGE_OWNER_FREE_STACK
>>>       help
>>
>> What is the difference between PAGE_OWNER+PAGE_OWNER_FREE_STACK and
>> DEBUG_PAGEALLOC?
> 
> Same memory usage, but debug_pagealloc means also extra checks and restricting memory access to freed pages to catch UAF.
> 
>> If you directly enable PAGE_OWNER+PAGE_OWNER_FREE_STACK
>> PAGE_OWNER_FREE_STACK,don't you think low-memory device to want to use
>> KASAN?
> 
> OK, so it should be optional? But I think it's enough to distinguish no PAGE_OWNER at all, and PAGE_OWNER+PAGE_OWNER_FREE_STACK together - I don't see much point in PAGE_OWNER only for this kind of debugging.
> 
> So how about this? KASAN wouldn't select PAGE_OWNER* but it would be recommended in the help+docs. When PAGE_OWNER and KASAN are selected by user, PAGE_OWNER_FREE_STACK gets also selected, and both will be also runtime enabled without explicit page_owner=on.
> I mostly want to avoid another boot-time option for enabling PAGE_OWNER_FREE_STACK.
> Would that be enough flexibility for low-memory devices vs full-fledged debugging?

Originally I thought that with you patch users still can disable page_owner via "page_owner=off" boot param.
But now I realized that this won't work. I think it should work, we should allow users to disable it.



Or another alternative option (and actually easier one to implement), leave PAGE_OWNER as is (no "select"s in Kconfigs)
Make PAGE_OWNER_FREE_STACK like this:

+config PAGE_OWNER_FREE_STACK
+	def_bool KASAN || DEBUG_PAGEALLOC
+	depends on PAGE_OWNER
+

So, users that want alloc/free stack will have to enable CONFIG_PAGE_OWNER=y and add page_owner=on to boot cmdline.


Basically the difference between these alternative is whether we enable page_owner by default or not. But there is always a possibility to disable it.

