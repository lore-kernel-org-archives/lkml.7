Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4DC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497124408
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfE3B6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:58:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15272 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726527AbfE3B6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:58:12 -0400
X-UUID: 06101ce5e0844a43a15a98856ac9e508-20190530
X-UUID: 06101ce5e0844a43a15a98856ac9e508-20190530
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 117967436; Thu, 30 May 2019 09:58:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 30 May 2019 09:58:02 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 30 May 2019 09:58:02 +0800
Message-ID: <1559181482.24427.18.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: add memory corruption identification for
 software tag-based mode
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Miles Chen" <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Date:   Thu, 30 May 2019 09:58:02 +0800
In-Reply-To: <CACT4Y+ZwXsBk8VqvDOJGMqrbVjuZ-HfC9RG4LpgRC-9WqmQJVw@mail.gmail.com>
References: <1559027797-30303-1-git-send-email-walter-zh.wu@mediatek.com>
         <CACT4Y+aCnODuffR7PafyYispp_U+ZdY1Dr0XQYvmghkogLJzSw@mail.gmail.com>
         <1559122529.17186.24.camel@mtksdccf07>
         <CACT4Y+ZwXsBk8VqvDOJGMqrbVjuZ-HfC9RG4LpgRC-9WqmQJVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-29 at 12:00 +0200, Dmitry Vyukov wrote:
> > > There can be multiple qobjects in the quarantine associated with the
> > > address, right? If so, we need to find the last one rather then a
> > > random one.
> > >
> > The qobject includes the address which has tag and range, corruption
> > address must be satisfied with the same tag and within object address
> > range, then it is found in the quarantine.
> > It should not easy to get multiple qobjects have the same tag and within
> > object address range.
> 
> Yes, using the tag for matching (which I missed) makes the match less likely.
> 
> But I think we should at least try to find the newest object in
> best-effort manner.
We hope it, too.

> Consider, both slab and slub reallocate objects in LIFO manner and we
> don't have a quarantine for objects themselves. So if we have a loop
> that allocates and frees an object of same size a dozen of times.
> That's enough to get a duplicate pointer+tag qobject.
> This includes:
> 1. walking the global quarantine from quarantine_tail backwards.
It is ok.

> 2. walking per-cpu lists in the opposite direction: from tail rather
> then from head. I guess we don't have links, so we could change the
> order and prepend new objects from head.
> This way we significantly increase chances of finding the right
> object. This also deserves a comment mentioning that we can find a
> wrong objects.
> 
The current walking per-cpu list direction is from head to trail. we
will modify the direction and find the newest object.


> > > Why don't we allocate qlist_object and qlist_node in a single
> > > allocation? Doing 2 allocations is both unnecessary slow and leads to
> > > more complex code. We need to allocate them with a single allocations.
> > > Also I think they should be allocated from a dedicated cache that opts
> > > out of quarantine?
> > >
> > Single allocation is good suggestion, if we only has one allocation.
> > then we need to move all member of qlist_object to qlist_node?
> >
> > struct qlist_object {
> >     unsigned long addr;
> >     unsigned int size;
> >     struct kasan_alloc_meta free_track;
> > };
> > struct qlist_node {
> >     struct qlist_object *qobject;
> >     struct qlist_node *next;
> > };
> 
> I see 2 options:
> 1. add addr/size/free_track to qlist_node under ifdef CONFIG_KASAN_SW_TAGS
> 2. or probably better would be to include qlist_node into qlist_object
> as first field, then allocate qlist_object and cast it to qlist_node
> when adding to quarantine, and then as we iterate quarantine, we cast
> qlist_node back to qlist_object and can access size/addr.
> 
Choice 2 looks better, We first try it.

> 
> > We call call ___cache_free() to free the qobject and qnode, it should be
> > out of quarantine?
> 
> This should work.

Thanks your good suggestion.
We will implement those solution which you suggested to the second
edition.


Thanks,
Walter

