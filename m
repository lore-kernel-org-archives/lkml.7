Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7417C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C2B2238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfGZMwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:52:16 -0400
Received: from relay.sw.ru ([185.231.240.75]:56286 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfGZMwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:52:15 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hqzhc-0007Xf-H3; Fri, 26 Jul 2019 15:52:04 +0300
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com>
 <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
 <1560447999.15814.15.camel@mtksdccf07> <1560479520.15814.34.camel@mtksdccf07>
 <1560744017.15814.49.camel@mtksdccf07>
 <CACT4Y+Y3uS59rXf92ByQuFK_G4v0H8NNnCY1tCbr4V+PaZF3ag@mail.gmail.com>
 <1560774735.15814.54.camel@mtksdccf07> <1561974995.18866.1.camel@mtksdccf07>
 <CACT4Y+aMXTBE0uVkeZz+MuPx3X1nESSBncgkScWvAkciAxP1RA@mail.gmail.com>
 <ebc99ee1-716b-0b18-66ab-4e93de02ce50@virtuozzo.com>
 <1562640832.9077.32.camel@mtksdccf07>
 <d9fd1d5b-9516-b9b9-0670-a1885e79f278@virtuozzo.com>
 <1562839579.5846.12.camel@mtksdccf07>
 <37897fb7-88c1-859a-dfcc-0a5e89a642e0@virtuozzo.com>
 <1563160001.4793.4.camel@mtksdccf07>
 <9ab1871a-2605-ab34-3fd3-4b44a0e17ab7@virtuozzo.com>
 <1563789162.31223.3.camel@mtksdccf07>
 <e62da62a-2a63-3a1c-faeb-9c5561a5170c@virtuozzo.com>
 <1564144097.515.3.camel@mtksdccf07>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <71df2bd5-7bc8-2c82-ee31-3f68c3b6296d@virtuozzo.com>
Date:   Fri, 26 Jul 2019 15:52:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564144097.515.3.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 3:28 PM, Walter Wu wrote:
> On Fri, 2019-07-26 at 15:00 +0300, Andrey Ryabinin wrote:
>>
>
>>>
>>>
>>> I remember that there are already the lists which you concern. Maybe we
>>> can try to solve those problems one by one.
>>>
>>> 1. deadlock issue? cause by kmalloc() after kfree()?
>>
>> smp_call_on_cpu()
> 
>>> 2. decrease allocation fail, to modify GFP_NOWAIT flag to GFP_KERNEL?
>>
>> No, this is not gonna work. Ideally we shouldn't have any allocations there.
>> It's not reliable and it hurts performance.
>>
> I dont know this meaning, we need create a qobject and put into
> quarantine, so may need to call kmem_cache_alloc(), would you agree this
> action?
> 

How is this any different from what you have now?
