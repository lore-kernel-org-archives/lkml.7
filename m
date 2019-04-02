Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF97C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AD52082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUSx16IW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfDBRp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:45:56 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:54376 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbfDBRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:45:56 -0400
Received: by mail-it1-f171.google.com with SMTP id a190so5088926ite.4;
        Tue, 02 Apr 2019 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5t/Y4J0o1SK+hPA+fwYsPBbjhkFvdldj8PMZh7RPww=;
        b=YUSx16IWi0/OQfL04ZDUpWfehULQqBrVTYISDNcZJ7e5LsS4DL8qHHYsRvhp9FziCe
         SA3nLjhz2BrlaVkpKwn7MW/XfnMBHvP+jwmxBvydQF14ePa0gKtS637eds6jdUeVU3X7
         SzHkAfnzicMmvFDS1owUbcpkYduYOFkld/8y0RE+QRqtM/F7WaSvFJQO3W1xBCbVbNpO
         8WNuUqmlkOmWqLH2cceT5Kgc/WYkoGlVAxAHRgCYLRaEh2I+yAXTmbUsum2Rygzx21C1
         tkfunpB0jHPRE6DPQLLqjgdY6fmSA7zgbDnN3v6ZMlIFwjzqUxTgSlUPRNGHDAtzs3GM
         nO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5t/Y4J0o1SK+hPA+fwYsPBbjhkFvdldj8PMZh7RPww=;
        b=HdzD1R/hgOfUiWRHLCdIidZB7C4dDRNRw4JjkIibYiLTapJ7k/6LxQut+EBjLEFaNI
         193X85dUbMbIeLslpylzxpClV53xA4gbxiXAfHtchfGNOSju+hG92FojJcY4O61q7Z5L
         gC+ChB73b7WRPg7LtX9xLYG4VGSDpcfSI6uxKZ5Om/0/fMn0D7/Kop8FoGSSvITresye
         KJrBlENfdHb6q14XWJDSTm7kmRuJRG1aAtfmaDE07OMLQl9D9K1LgdWYKyIUIVR3qYCp
         wINm7nPgA/mzPNi67GdxpC0Pyaw4BKuJnhjojORhbuBfrb3maFp5Bvk9F5UdYPcEzUd4
         8XNg==
X-Gm-Message-State: APjAAAUhteJ9qXzWf6bcQ3kS4EY4ZYJAsgbtq0Ejioc9umISlHJrEN8a
        5qAEEBDn/CgZwubZrNIg3Ysu5WgqGhtHtC7HdCk=
X-Google-Smtp-Source: APXvYqxlZVPpn8RzULpJBTdsc+/NqRS35BYQf4K2iWoFL2TO4wJzqNHWJnFX2NMFPWr9UIN1fMiHi9lKco9sNZgeN7o=
X-Received: by 2002:a24:7c52:: with SMTP id a79mr5627493itd.51.1554227154886;
 Tue, 02 Apr 2019 10:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org> <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org> <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
 <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com> <20190401104608-mutt-send-email-mst@kernel.org>
 <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
 <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com> <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
 <20190402112115-mutt-send-email-mst@kernel.org> <3dd76ce6-c138-b019-3a43-0bb0b793690a@redhat.com>
 <CAKgT0Uc78NYnva4T+G5uas_iSnE_YHGz+S5rkBckCvhNPV96gw@mail.gmail.com> <6b0a3610-0e7b-08dc-8b5f-707062f87bea@redhat.com>
In-Reply-To: <6b0a3610-0e7b-08dc-8b5f-707062f87bea@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 2 Apr 2019 10:45:43 -0700
Message-ID: <CAKgT0UdHA66z1j=3H06AfgtiF4ThFdXwQ6i8p1MszdL2bRHeZQ@mail.gmail.com>
Subject: Re: On guest free page hinting and OOM
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 10:09 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 02.04.19 18:18, Alexander Duyck wrote:
> > n Tue, Apr 2, 2019 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 02.04.19 17:25, Michael S. Tsirkin wrote:
> >>> On Tue, Apr 02, 2019 at 08:04:00AM -0700, Alexander Duyck wrote:
> >>>> Basically what we would be doing is providing a means for
> >>>> incrementally transitioning the buddy memory into the idle/offline
> >>>> state to reduce guest memory overhead. It would require one function
> >>>> that would walk the free page lists and pluck out pages that don't
> >>>> have the "Offline" page type set,
> >>>
> >>> I think we will need an interface that gets
> >>> an offline page and returns the next online free page.
> >>>
> >>> If we restart the list walk each time we can't guarantee progress.
> >>
> >> Yes, and essentially we are scanning all the time for chunks vs. we get
> >> notified which chunks are possible hinting candidates. Totally different
> >> design.
> >
> > The problem as I see it is that we can miss notifications if we become
> > too backlogged, and that will lead to us having to fall back to
> > scanning anyway. So instead of trying to implement both why don't we
> > just focus on the scanning approach. Otherwise the only other option
> > is to hold up the guest and make it wait until the hint processing has
> > completed and at that point we are back to what is essentially just a
> > synchronous solution with batching anyway.
> >
>
> In general I am not a fan of "there might be a problem, let's try
> something completely different". Expect the unexpected. At this point, I
> prefer to think about easy solutions to eventual problems. not
> completely new designs. As I said, we've been there already.

The solution as we have is not "easy". There are a number of race
conditions contained within the code and it doesn't practically scale
when you consider we are introducing multiple threads in both the
isolation and returning of pages to/from the buddy allocator that will
have to function within the zone lock.

> Related to "falling behind" with hinting. If this is indeed possible
> (and I'd like to know under which conditions), I wonder at which point
> we no longer care about missed hints. If our guest as a lot of MM
> activity, could be that is good that we are dropping hints, because our
> guest is so busy, it will reuse pages soon again.

This is making a LOT of assumptions. There are a few scenarios that
can hold up hinting on the host side. One of the limitations of
madvise is that we have to take the mm read semaphore. So if something
is sitting on the write semaphore all of the hints will be blocked
until it is released.

> One important point is - I think - that free page hinting does not have
> to fit all possible setups. In certain environments it just makes sense
> to disable it. Or live with it not giving you "all the hints". E.g.
> databases that eat up all free memory either way. The other extreme
> would be a simple webserver that is mostly idle.

My concern is we are introducing massive buffer bloat in the mm
subsystem and it still has the potential for stalling VCPUs if we
don't have room in the VQs. We went through this back in the day with
networking. Adding more buffers is not the solution. The solution is
to have a way to gracefully recover and keep our hinting latency and
buffer bloat to a minimum.

> We are losing hitning of quite free memory already due to the MAX_ORDER
> - X discussion. Dropping a couple of other hints shouldn't really hurt.
> The question is, are there scenarios where we can completely screw up.

My concern is that it can hurt a ton. In my mind the target for a
feature like this is a guest that has something like an application
that will fire up a few times a day eat up a massive amount of memory,
and then free it all when it is done. Now if that application is
freeing a massive block of memory and for whatever reason the QEMU
thread that is translating our hint requests to madvise calls cannot
keep up then we are going to spend the next several hours with that
memory still assigned to an idle guest.
