Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA15C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4943E20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfILObp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:31:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732579AbfILObo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:31:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F35A4AFFE;
        Thu, 12 Sep 2019 14:31:42 +0000 (UTC)
Subject: Re: [PATCH v3] mm/kasan: dump alloc and free stack for page allocator
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <613f9f23-c7f0-871f-fe13-930c35ef3105@suse.cz>
Date:   Thu, 12 Sep 2019 16:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568297308.19040.5.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/19 4:08 PM, Walter Wu wrote:
> 
>>   extern void __reset_page_owner(struct page *page, unsigned int order);
>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>> index 6c9682ce0254..dc560c7562e8 100644
>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>> @@ -41,6 +41,8 @@ config KASAN_GENERIC
>>   	select SLUB_DEBUG if SLUB
>>   	select CONSTRUCTORS
>>   	select STACKDEPOT
>> +	select PAGE_OWNER
>> +	select PAGE_OWNER_FREE_STACK
>>   	help
>>   	  Enables generic KASAN mode.
>>   	  Supported in both GCC and Clang. With GCC it requires version 4.9.2
>> @@ -63,6 +65,8 @@ config KASAN_SW_TAGS
>>   	select SLUB_DEBUG if SLUB
>>   	select CONSTRUCTORS
>>   	select STACKDEPOT
>> +	select PAGE_OWNER
>> +	select PAGE_OWNER_FREE_STACK
>>   	help
> 
> What is the difference between PAGE_OWNER+PAGE_OWNER_FREE_STACK and
> DEBUG_PAGEALLOC?

Same memory usage, but debug_pagealloc means also extra checks and 
restricting memory access to freed pages to catch UAF.

> If you directly enable PAGE_OWNER+PAGE_OWNER_FREE_STACK
> PAGE_OWNER_FREE_STACK,don't you think low-memory device to want to use
> KASAN?

OK, so it should be optional? But I think it's enough to distinguish no 
PAGE_OWNER at all, and PAGE_OWNER+PAGE_OWNER_FREE_STACK together - I 
don't see much point in PAGE_OWNER only for this kind of debugging.

So how about this? KASAN wouldn't select PAGE_OWNER* but it would be 
recommended in the help+docs. When PAGE_OWNER and KASAN are selected by 
user, PAGE_OWNER_FREE_STACK gets also selected, and both will be also 
runtime enabled without explicit page_owner=on.
I mostly want to avoid another boot-time option for enabling 
PAGE_OWNER_FREE_STACK.
Would that be enough flexibility for low-memory devices vs full-fledged 
debugging?
