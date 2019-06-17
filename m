Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8CDC31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E68B217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFQEA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:00:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26162 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbfFQEAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:00:25 -0400
X-UUID: 4f8413c5163f45fab280b7f808ef34f4-20190617
X-UUID: 4f8413c5163f45fab280b7f808ef34f4-20190617
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1298173636; Mon, 17 Jun 2019 12:00:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Jun 2019 12:00:18 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Jun 2019 12:00:17 +0800
Message-ID: <1560744017.15814.49.camel@mtksdccf07>
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
CC:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 17 Jun 2019 12:00:17 +0800
In-Reply-To: <1560479520.15814.34.camel@mtksdccf07>
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com>
         <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
         <1560447999.15814.15.camel@mtksdccf07>
         <1560479520.15814.34.camel@mtksdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 10:32 +0800, Walter Wu wrote:
> On Fri, 2019-06-14 at 01:46 +0800, Walter Wu wrote:
> > On Thu, 2019-06-13 at 15:27 +0300, Andrey Ryabinin wrote:
> > > 
> > > On 6/13/19 11:13 AM, Walter Wu wrote:
> > > > This patch adds memory corruption identification at bug report for
> > > > software tag-based mode, the report show whether it is "use-after-free"
> > > > or "out-of-bound" error instead of "invalid-access" error.This will make
> > > > it easier for programmers to see the memory corruption problem.
> > > > 
> > > > Now we extend the quarantine to support both generic and tag-based kasan.
> > > > For tag-based kasan, the quarantine stores only freed object information
> > > > to check if an object is freed recently. When tag-based kasan reports an
> > > > error, we can check if the tagged addr is in the quarantine and make a
> > > > good guess if the object is more like "use-after-free" or "out-of-bound".
> > > > 
> > > 
> > > 
> > > We already have all the information and don't need the quarantine to make such guess.
> > > Basically if shadow of the first byte of object has the same tag as tag in pointer than it's out-of-bounds,
> > > otherwise it's use-after-free.
> > > 
> > > In pseudo-code it's something like this:
> > > 
> > > u8 object_tag = *(u8 *)kasan_mem_to_shadow(nearest_object(cacche, page, access_addr));
> > > 
> > > if (access_addr_tag == object_tag && object_tag != KASAN_TAG_INVALID)
> > > 	// out-of-bounds
> > > else
> > > 	// use-after-free
> > 
> > Thanks your explanation.
> > I see, we can use it to decide corruption type.
> > But some use-after-free issues, it may not have accurate free-backtrace.
> > Unfortunately in that situation, free-backtrace is the most important.
> > please see below example
> > 
> > In generic KASAN, it gets accurate free-backrace(ptr1).
> > In tag-based KASAN, it gets wrong free-backtrace(ptr2). It will make
> > programmer misjudge, so they may not believe tag-based KASAN.
> > So We provide this patch, we hope tag-based KASAN bug report is the same
> > accurate with generic KASAN.
> > 
> > ---
> >     ptr1 = kmalloc(size, GFP_KERNEL);
> >     ptr1_free(ptr1);
> > 
> >     ptr2 = kmalloc(size, GFP_KERNEL);
> >     ptr2_free(ptr2);
> > 
> >     ptr1[size] = 'x';  //corruption here
> > 
> > 
> > static noinline void ptr1_free(char* ptr)
> > {
> >     kfree(ptr);
> > }
> > static noinline void ptr2_free(char* ptr)
> > {
> >     kfree(ptr);
> > }
> > ---
> > 
> We think of another question about deciding by that shadow of the first
> byte.
> In tag-based KASAN, it is immediately released after calling kfree(), so
> the slub is easy to be used by another pointer, then it will change
> shadow memory to the tag of new pointer, it will not be the
> KASAN_TAG_INVALID, so there are many false negative cases, especially in
> small size allocation.
> 
> Our patch is to solve those problems. so please consider it, thanks.
> 
Hi, Andrey and Dmitry,

I am sorry to bother you.
Would you tell me what you think about this patch?
We want to use tag-based KASAN, so we hope its bug report is clear and
correct as generic KASAN.

Thanks your review.
Walter

