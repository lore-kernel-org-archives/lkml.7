Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EDC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544BB21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfGICyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:54:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44662 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727391AbfGICyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:54:06 -0400
X-UUID: e54a938dbb3841b2821206c79fe148af-20190709
X-UUID: e54a938dbb3841b2821206c79fe148af-20190709
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1677781939; Tue, 09 Jul 2019 10:53:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Jul 2019 10:53:52 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Jul 2019 10:53:52 +0800
Message-ID: <1562640832.9077.32.camel@mtksdccf07>
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
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
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Tue, 9 Jul 2019 10:53:52 +0800
In-Reply-To: <ebc99ee1-716b-0b18-66ab-4e93de02ce50@virtuozzo.com>
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com>
         <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
         <1560447999.15814.15.camel@mtksdccf07>
         <1560479520.15814.34.camel@mtksdccf07>
         <1560744017.15814.49.camel@mtksdccf07>
         <CACT4Y+Y3uS59rXf92ByQuFK_G4v0H8NNnCY1tCbr4V+PaZF3ag@mail.gmail.com>
         <1560774735.15814.54.camel@mtksdccf07>
         <1561974995.18866.1.camel@mtksdccf07>
         <CACT4Y+aMXTBE0uVkeZz+MuPx3X1nESSBncgkScWvAkciAxP1RA@mail.gmail.com>
         <ebc99ee1-716b-0b18-66ab-4e93de02ce50@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-08 at 19:33 +0300, Andrey Ryabinin wrote:
> 
> On 7/5/19 4:34 PM, Dmitry Vyukov wrote:
> > On Mon, Jul 1, 2019 at 11:56 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >>>>>>>>> This patch adds memory corruption identification at bug report for
> >>>>>>>>> software tag-based mode, the report show whether it is "use-after-free"
> >>>>>>>>> or "out-of-bound" error instead of "invalid-access" error.This will make
> >>>>>>>>> it easier for programmers to see the memory corruption problem.
> >>>>>>>>>
> >>>>>>>>> Now we extend the quarantine to support both generic and tag-based kasan.
> >>>>>>>>> For tag-based kasan, the quarantine stores only freed object information
> >>>>>>>>> to check if an object is freed recently. When tag-based kasan reports an
> >>>>>>>>> error, we can check if the tagged addr is in the quarantine and make a
> >>>>>>>>> good guess if the object is more like "use-after-free" or "out-of-bound".
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> We already have all the information and don't need the quarantine to make such guess.
> >>>>>>>> Basically if shadow of the first byte of object has the same tag as tag in pointer than it's out-of-bounds,
> >>>>>>>> otherwise it's use-after-free.
> >>>>>>>>
> >>>>>>>> In pseudo-code it's something like this:
> >>>>>>>>
> >>>>>>>> u8 object_tag = *(u8 *)kasan_mem_to_shadow(nearest_object(cacche, page, access_addr));
> >>>>>>>>
> >>>>>>>> if (access_addr_tag == object_tag && object_tag != KASAN_TAG_INVALID)
> >>>>>>>>   // out-of-bounds
> >>>>>>>> else
> >>>>>>>>   // use-after-free
> >>>>>>>
> >>>>>>> Thanks your explanation.
> >>>>>>> I see, we can use it to decide corruption type.
> >>>>>>> But some use-after-free issues, it may not have accurate free-backtrace.
> >>>>>>> Unfortunately in that situation, free-backtrace is the most important.
> >>>>>>> please see below example
> >>>>>>>
> >>>>>>> In generic KASAN, it gets accurate free-backrace(ptr1).
> >>>>>>> In tag-based KASAN, it gets wrong free-backtrace(ptr2). It will make
> >>>>>>> programmer misjudge, so they may not believe tag-based KASAN.
> >>>>>>> So We provide this patch, we hope tag-based KASAN bug report is the same
> >>>>>>> accurate with generic KASAN.
> >>>>>>>
> >>>>>>> ---
> >>>>>>>     ptr1 = kmalloc(size, GFP_KERNEL);
> >>>>>>>     ptr1_free(ptr1);
> >>>>>>>
> >>>>>>>     ptr2 = kmalloc(size, GFP_KERNEL);
> >>>>>>>     ptr2_free(ptr2);
> >>>>>>>
> >>>>>>>     ptr1[size] = 'x';  //corruption here
> >>>>>>>
> >>>>>>>
> >>>>>>> static noinline void ptr1_free(char* ptr)
> >>>>>>> {
> >>>>>>>     kfree(ptr);
> >>>>>>> }
> >>>>>>> static noinline void ptr2_free(char* ptr)
> >>>>>>> {
> >>>>>>>     kfree(ptr);
> >>>>>>> }
> >>>>>>> ---
> >>>>>>>
> >>>>>> We think of another question about deciding by that shadow of the first
> >>>>>> byte.
> >>>>>> In tag-based KASAN, it is immediately released after calling kfree(), so
> >>>>>> the slub is easy to be used by another pointer, then it will change
> >>>>>> shadow memory to the tag of new pointer, it will not be the
> >>>>>> KASAN_TAG_INVALID, so there are many false negative cases, especially in
> >>>>>> small size allocation.
> >>>>>>
> >>>>>> Our patch is to solve those problems. so please consider it, thanks.
> >>>>>>
> >>>>> Hi, Andrey and Dmitry,
> >>>>>
> >>>>> I am sorry to bother you.
> >>>>> Would you tell me what you think about this patch?
> >>>>> We want to use tag-based KASAN, so we hope its bug report is clear and
> >>>>> correct as generic KASAN.
> >>>>>
> >>>>> Thanks your review.
> >>>>> Walter
> >>>>
> >>>> Hi Walter,
> >>>>
> >>>> I will probably be busy till the next week. Sorry for delays.
> >>>
> >>> It's ok. Thanks your kindly help.
> >>> I hope I can contribute to tag-based KASAN. It is a very important tool
> >>> for us.
> >>
> >> Hi, Dmitry,
> >>
> >> Would you have free time to discuss this patch together?
> >> Thanks.
> > 
> > Sorry for delays. I am overwhelm by some urgent work. I afraid to
> > promise any dates because the next week I am on a conference, then
> > again a backlog and an intern starting...
> > 
> > Andrey, do you still have concerns re this patch? This change allows
> > to print the free stack.
> 
> I 'm not sure that quarantine is a best way to do that. Quarantine is made to delay freeing, but we don't that here.
> If we want to remember more free stacks wouldn't be easier simply to remember more stacks in object itself?
> Same for previously used tags for better use-after-free identification.
> 

Hi Andrey,

We ever tried to use object itself to determine use-after-free
identification, but tag-based KASAN immediately released the pointer
after call kfree(), the original object will be used by another
pointer, if we use object itself to determine use-after-free issue, then
it has many false negative cases. so we create a lite quarantine(ring
buffers) to record recent free stacks in order to avoid those false
negative situations.

We hope to have one solution to cover all cases and be accurate. Our
patch is configurable feature option, it can provide some programmers to
easy see the tag-based KASAN report.


> > We also have a quarantine for hwasan in user-space. Though it works a
> > bit differently then the normal asan quarantine. We keep a per-thread
> > fixed-size ring-buffer of recent allocations:
> > https://github.com/llvm-mirror/compiler-rt/blob/master/lib/hwasan/hwasan_report.cpp#L274-L284
> > and scan these ring buffers during reports.
> > 

Thanks your information, it looks like the same idea with our patch.

