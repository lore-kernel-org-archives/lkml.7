Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD11EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8759020673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfFRQ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:28:05 -0400
Received: from relay.sw.ru ([185.231.240.75]:56162 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbfFRQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:28:05 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hdGxk-0002qE-CF; Tue, 18 Jun 2019 19:28:00 +0300
Subject: Re: [PATCH] [v2] page flags: prioritize kasan bits over last-cpuid
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190618095347.3850490-1-arnd@arndb.de>
 <5ac26e68-8b75-1b06-eecd-950987550451@virtuozzo.com>
 <CAK8P3a1CAKecyinhzG9Mc7UzZ9U15o6nacbcfSvb4EBSaWvCTw@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e782e546-dac7-8479-d5a0-fdacfb3359b8@virtuozzo.com>
Date:   Tue, 18 Jun 2019 19:28:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1CAKecyinhzG9Mc7UzZ9U15o6nacbcfSvb4EBSaWvCTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/19 6:30 PM, Arnd Bergmann wrote:
> On Tue, Jun 18, 2019 at 4:30 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>> On 6/18/19 12:53 PM, Arnd Bergmann wrote:
>>> ARM64 randdconfig builds regularly run into a build error, especially
>>> when NUMA_BALANCING and SPARSEMEM are enabled but not SPARSEMEM_VMEMMAP:
>>>
>>>  #error "KASAN: not enough bits in page flags for tag"
>>>
>>> The last-cpuid bits are already contitional on the available space,
>>> so the result of the calculation is a bit random on whether they
>>> were already left out or not.
>>>
>>> Adding the kasan tag bits before last-cpuid makes it much more likely
>>> to end up with a successful build here, and should be reliable for
>>> randconfig at least, as long as that does not randomize NR_CPUS
>>> or NODES_SHIFT but uses the defaults.
>>>
>>> In order for the modified check to not trigger in the x86 vdso32 code
>>> where all constants are wrong (building with -m32), enclose all the
>>> definitions with an #ifdef.
>>>
>>
>> Why not keep "#error "KASAN: not enough bits in page flags for tag"" under "#ifdef CONFIG_KASAN_SW_TAGS" ?
> 
> I think I had meant the #error to leave out the mention of KASAN, as there
> might be other reasons for using up all the bits, but then I did not change
> it in the end.
> 
> Should I remove the "KASAN" word or add the #ifdef when resending?

It seems like changing the error message is a better choice.
Don't forget to remove "for tag" as well.
