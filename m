Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655AF20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjOhpI08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCGVcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:32:41 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54413 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:32:41 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so17718375itj.4;
        Thu, 07 Mar 2019 13:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+TIUlP+9LqYKoo9au+R+NKrwoKPpt3T3L/Q7f7u8Hk=;
        b=LjOhpI08+gPsODT2ilekjiyJ6JFIJSNIb8VSdJHq8eh3ORh1yx+PNlqqOASNu2aeSZ
         Juutrs850efakswXWqHpFOH5+ml1bHsWJzzrABgdniSjXHjO9N2jANPqDq/ey1y8P6b7
         /ZDM7rN+zolSMi9meoJQQlcyiDuRYLjHtl36UaIOaP9H9YlkV52gw3FxS/lSVf3itfic
         fX+Oh7w0nCkCYHsap2MV9ffKyZZiyazUS+Hmm1aI/dGOOn43cb5qi8G2Oo3NHFvrbMLH
         6YPshR8zcx2Sdt1L8RnBYUZ6ouLjyZhKLKUtfIh5y8YUPRACKLqRYTFJEAQ1SkGuK0Cz
         6wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+TIUlP+9LqYKoo9au+R+NKrwoKPpt3T3L/Q7f7u8Hk=;
        b=Me1QlZ+qOzvXh/uVX/ypd9/do6cudxs39WRj6XNxmK9pjj+q/XHIhqekVGrTSK332J
         86Ci4F5MMHl82A+LijU0ZO5vdzTlFZAGJsaMYyLK5x+A1N58QTpWqb5h9kM6iPD/MmPy
         Z6sgY3YyS0V/5NH8NgdcULEVEwsoabZpnPkuGHxBdbcofbChSdnSO9/Md9EtsV2u/Xff
         TBsKzH1eH1+9/PdVe08q1hm/5kXu7DKOBXz/yZ/4Bf2QCFdhFqqoT1pnxaNLsH9ZBXOB
         agooG2z+bbDV5nYgMR7X/GpLah03vYdMydtiD59KnYj9j0EnmV3ejx0lNy5KhnxIpVb5
         93eg==
X-Gm-Message-State: APjAAAUPsETeuFvNqr1NJa88X1RUwynRVpkxDJFlrDWlPolLYz12kaGo
        ZOQFgdifh6dUswnxg20HIyT84xAM2tP4kv/Kdyo=
X-Google-Smtp-Source: APXvYqxhnYUmSvQyKkX0f12oQ5gwsgM923fNYDhQgS8eq4ni/0X30MImXSOhzDndCnd23kceYrPKH1fdxMoW65j9jtQ=
X-Received: by 2002:a24:4650:: with SMTP id j77mr6570876itb.6.1551994359429;
 Thu, 07 Mar 2019 13:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com> <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
In-Reply-To: <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 7 Mar 2019 13:32:28 -0800
Message-ID: <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest free pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 11:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.03.19 20:23, Nitesh Narayan Lal wrote:
> >
> > On 3/7/19 1:30 PM, Alexander Duyck wrote:
> >> On Wed, Mar 6, 2019 at 7:51 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >>> This patch enables the kernel to scan the per cpu array
> >>> which carries head pages from the buddy free list of order
> >>> FREE_PAGE_HINTING_MIN_ORDER (MAX_ORDER - 1) by
> >>> guest_free_page_hinting().
> >>> guest_free_page_hinting() scans the entire per cpu array by
> >>> acquiring a zone lock corresponding to the pages which are
> >>> being scanned. If the page is still free and present in the
> >>> buddy it tries to isolate the page and adds it to a
> >>> dynamically allocated array.
> >>>
> >>> Once this scanning process is complete and if there are any
> >>> isolated pages added to the dynamically allocated array
> >>> guest_free_page_report() is invoked. However, before this the
> >>> per-cpu array index is reset so that it can continue capturing
> >>> the pages from buddy free list.
> >>>
> >>> In this patch guest_free_page_report() simply releases the pages back
> >>> to the buddy by using __free_one_page()
> >>>
> >>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> >> I'm pretty sure this code is not thread safe and has a few various issues.
> >>
> >>> ---
> >>>  include/linux/page_hinting.h |   5 ++
> >>>  mm/page_alloc.c              |   2 +-
> >>>  virt/kvm/page_hinting.c      | 154 +++++++++++++++++++++++++++++++++++
> >>>  3 files changed, 160 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
> >>> index 90254c582789..d554a2581826 100644
> >>> --- a/include/linux/page_hinting.h
> >>> +++ b/include/linux/page_hinting.h
> >>> @@ -13,3 +13,8 @@
> >>>
> >>>  void guest_free_page_enqueue(struct page *page, int order);
> >>>  void guest_free_page_try_hinting(void);
> >>> +extern int __isolate_free_page(struct page *page, unsigned int order);
> >>> +extern void __free_one_page(struct page *page, unsigned long pfn,
> >>> +                           struct zone *zone, unsigned int order,
> >>> +                           int migratetype);
> >>> +void release_buddy_pages(void *obj_to_free, int entries);
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 684d047f33ee..d38b7eea207b 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -814,7 +814,7 @@ static inline int page_is_buddy(struct page *page, struct page *buddy,
> >>>   * -- nyc
> >>>   */
> >>>
> >>> -static inline void __free_one_page(struct page *page,
> >>> +inline void __free_one_page(struct page *page,
> >>>                 unsigned long pfn,
> >>>                 struct zone *zone, unsigned int order,
> >>>                 int migratetype)
> >>> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
> >>> index 48b4b5e796b0..9885b372b5a9 100644
> >>> --- a/virt/kvm/page_hinting.c
> >>> +++ b/virt/kvm/page_hinting.c
> >>> @@ -1,5 +1,9 @@
> >>>  #include <linux/mm.h>
> >>>  #include <linux/page_hinting.h>
> >>> +#include <linux/page_ref.h>
> >>> +#include <linux/kvm_host.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/sort.h>
> >>>
> >>>  /*
> >>>   * struct guest_free_pages- holds array of guest freed PFN's along with an
> >>> @@ -16,6 +20,54 @@ struct guest_free_pages {
> >>>
> >>>  DEFINE_PER_CPU(struct guest_free_pages, free_pages_obj);
> >>>
> >>> +/*
> >>> + * struct guest_isolated_pages- holds the buddy isolated pages which are
> >>> + * supposed to be freed by the host.
> >>> + * @pfn: page frame number for the isolated page.
> >>> + * @order: order of the isolated page.
> >>> + */
> >>> +struct guest_isolated_pages {
> >>> +       unsigned long pfn;
> >>> +       unsigned int order;
> >>> +};
> >>> +
> >>> +void release_buddy_pages(void *obj_to_free, int entries)
> >>> +{
> >>> +       int i = 0;
> >>> +       int mt = 0;
> >>> +       struct guest_isolated_pages *isolated_pages_obj = obj_to_free;
> >>> +
> >>> +       while (i < entries) {
> >>> +               struct page *page = pfn_to_page(isolated_pages_obj[i].pfn);
> >>> +
> >>> +               mt = get_pageblock_migratetype(page);
> >>> +               __free_one_page(page, page_to_pfn(page), page_zone(page),
> >>> +                               isolated_pages_obj[i].order, mt);
> >>> +               i++;
> >>> +       }
> >>> +       kfree(isolated_pages_obj);
> >>> +}
> >> You shouldn't be accessing __free_one_page without holding the zone
> >> lock for the page. You might consider confining yourself to one zone
> >> worth of hints at a time. Then you can acquire the lock once, and then
> >> return the memory you have freed.
> > That is correct.
> >>
> >> This is one of the reasons why I am thinking maybe a bit in the page
> >> and then spinning on that bit in arch_alloc_page might be a nice way
> >> to get around this. Then you only have to take the zone lock when you
> >> are finding the pages you want to hint on and setting the bit
> >> indicating they are mid hint. Otherwise you have to take the zone lock
> >> to pull pages out, and to put them back in and the likelihood of a
> >> lock collision is much higher.
> > Do you think adding a new flag to the page structure will be acceptable?
>
> My lesson learned: forget it. If (at all) reuse some other one that
> might be safe in that context. Hard to tell if that is even possible and
> will be accepted upstream.

I was thinking we could probably just resort to reuse. Essentially
what we are looking at doing is idle page tracking so my thought is to
see if we can just reuse those bits in the buddy allocator. Then we
would essentially have 3 stages, young, "hinting", and idle.

> Spinning is not the solution. What you would want is the buddy to
> actually skip over these pages and only try to use them (-> spin) when
> OOM. Core mm changes (see my other reply).

It is more of a workaround. Ideally we should almost never encounter
this anyway as what we really want to be doing is performing hints on
cold pages, so hopefully we will be on the other end of the LRU list
from any active allocations.

> This all sounds like future work which can be built on top of this work.

Actually I was kind of thinking about this the other way. The simple
spin approach is a good first step. If we have a bit or two in the
page that tells us if the page is available or not we could then
follow-up with optimizations to only allocate either a young or idle
page and doesn't bother with pages being "hinted", at least in the
first pass.

As it currently stands we are only really performing hints on higher
order pages anyway so if we happen to encounter a slight delay under
memory pressure it probably wouldn't be that noticeable versus the
memory system having to go through and try to compact things from some
lower order pages. In my mind us introducing a delay in memory
allocation in the case of a collision would be preferable versus us
triggering allocation failures.
