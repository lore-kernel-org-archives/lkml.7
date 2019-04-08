Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488BCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A6F214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klr4Aced"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfDHPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:18:47 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:40115 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfDHPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:18:47 -0400
Received: by mail-it1-f176.google.com with SMTP id k64so21574568itb.5;
        Mon, 08 Apr 2019 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ad7AdjXU9ameo2mNrt8hvSxpBLgf7Vhvuo315awnqU=;
        b=Klr4AcedXx6EGvpASoRhkbaiXG0ydzxtI+rPrewCYsTiVGFA+5bpdnsxDX8VtCpt0u
         nCHcRrzAZio4Ju8BOQwIjHt2VeerBKScixd1CB1shkTCVl0O/35qgWqP9o6IAoZph3/q
         SJXF0yUrGyFa1c5BjefUghgcfgBMTnlZRZC3x6dQNWAOV2hG1VCmLrtTpTJSe/mMEK+n
         OAxH6E398pyzLUrsc0nQB97Dy5Kg13ML9mHqdgapdVEXIAO94wOpIZod+slygLUkWr5D
         ki08oJ74V0DmQVIA6qpJzS9ESSDOn6KkeLooUjuLjqbrNNar72DDtkoTvZ9De6aWgdQB
         QNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ad7AdjXU9ameo2mNrt8hvSxpBLgf7Vhvuo315awnqU=;
        b=qmK4z/DGKplAXBgSSzF9X3xqDS9CMp3v4bGDvcE6xcpYneVqB6t4Rs+RyN8rU4RUEL
         ShIREscX26S8A+5I5oOTgjVU20H6f/aiDNjI5ZI/FHkMWaqExZ2NUbNOokYQk3bzgyBR
         lxhpOf+lhJdW8RsjfOwnbQ4N9DTXkA5a9Sa6Vxvc4G9XwNgKOoWbpvdqStgpp38l8l3o
         XoHHot1hQhchOU9h6qlF9QMSOIN+T7VfaOYQqu8uTMZpCUiBTQQIkqE2jx63XQwgB82i
         b9hWH8g44/sAK6nhRornb7UzDY5uA5twuUrpdEIv38dFlgH4TGrlgYvRG1asVi4EH79W
         vDUA==
X-Gm-Message-State: APjAAAUsuTIjQZj4z46yEuL13ud6LYKazFNSAgb0CVR2nyi0Ytn564LB
        tQqOt1qvpy6wpfdUbqGiLtX5lqVeovK3XwQtVeKyXA==
X-Google-Smtp-Source: APXvYqyeadTJY73h1ipvgeAyLEjTLmudhCISSDw0Y4WHYDT300Xsu0YsvCa92oN0H7NY5xyTePQX/dR5eYb+F9LrjqE=
X-Received: by 2002:a02:c6d8:: with SMTP id r24mr3072108jan.93.1554736725871;
 Mon, 08 Apr 2019 08:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
 <ef0c542a-ded5-f063-e6e2-8e84d1c12c85@redhat.com>
In-Reply-To: <ef0c542a-ded5-f063-e6e2-8e84d1c12c85@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 8 Apr 2019 08:18:35 -0700
Message-ID: <CAKgT0UfyG=0wg5jzZPcnh7Q1rf0+gd9H5Q4626GTft85EiJNeA@mail.gmail.com>
Subject: Re: Thoughts on simple scanner approach for free page hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 5:24 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>
> On 4/5/19 8:09 PM, Alexander Duyck wrote:
> > So I am starting this thread as a spot to collect my thoughts on the
> > current guest free page hinting design as well as point out a few
> > possible things we could do to improve upon it.
> >
> > 1. The current design isn't likely going to scale well to multiple
> > VCPUs. The issue specifically is that the zone lock must be held to
> > pull pages off of the free list and to place them back there once they
> > have been hinted upon. As a result it would likely make sense to try
> > to limit ourselves to only having one thread performing the actual
> > hinting so that we can avoid running into issues with lock contention
> > between threads.
> >
> > 2. There are currently concerns about the hinting triggering false OOM
> > situations if too much memory is isolated while it is being hinted. My
> > thought on this is to simply avoid the issue by only hint on a limited
> > amount of memory at a time. Something like 64MB should be a workable
> > limit without introducing much in the way of regressions. However as a
> > result of this we can easily be overrun while waiting on the host to
> > process the hinting request. As such we will probably need a way to
> > walk the free list and free pages after they have been freed instead
> > of trying to do it as they are freed.
> >
> > 3. Even with the current buffering which is still on the larger side
> > it is possible to overrun the hinting limits if something causes the
> > host to stall and a large swath of memory is released. As such we are
> > still going to need some sort of scanning mechanism or will have to
> > live with not providing accurate hints.
> >
> > 4. In my opinion, the code overall is likely more complex then it
> > needs to be. We currently have 2 allocations that have to occur every
> > time we provide a hint all the way to the host, ideally we should not
> > need to allocate more memory to provide hints. We should be able to
> > hold the memory use for a memory hint device constant and simply map
> > the page address and size to the descriptors of the virtio-ring.
> >
> > With that said I have a few ideas that may help to address the 4
> > issues called out above. The basic idea is simple. We use a high water
> > mark based on zone->free_area[order].nr_free to determine when to wake
> > up a thread to start hinting memory out of a given free area. From
> > there we allocate non-"Offline" pages from the free area and assign
> > them to the hinting queue up to 64MB at a time. Once the hinting is
> > completed we mark them "Offline" and add them to the tail of the
> > free_area. Doing this we should cycle the non-"Offline" pages slowly
> > out of the free_area.
> any ideas about how are you planning to control this?

You mean in terms of switching the hinting on/off? The setup should be
pretty simple. Basically we would still need a hook like the one you
added after the allocation to determine where the free page ultimately
landed and to do a check against the high water mark I mentioned.
Basically if there is something like 2X the number of pages needed to
fulfill the 64MB requirement we could then kick off a thread running
on the zone to begin populating the hints and notifying the
virtio-balloon interface. When we can no longer fill the ring we would
simply stop the thread until we get back to the 2X state for nr_freed
versus the last nr_freed value we had hinted upon. It wouldn't be
dissimilar to how we currently handle the Tx path in many NICs where
we shut off hinting.

For examples of doing something like this you could look at the Rx
softIRQ handling in the NIC drivers. Basically the idea there is you
trigger the event once, and then the thread is running until all work
has been completed. The thread itself is limiting itself to only
processing some number of fixed buffers for each request, and when it
can no longer get a full set it stops and waits to be rescheduled by
an interrupt.

> > In addition the search cost should be minimal
> > since all of the "Offline" pages should be aggregated to the tail of
> > the free_area so all pages allocated off of the free_area will be the
> > non-"Offline" pages until we shift over to them all being "Offline".
> > This should be effective for MAX_ORDER - 1 and MAX_ORDER - 2 pages
> > since the only real consumer of add_to_free_area_tail is
> > __free_one_page which uses it to place a page with an order less than
> > MAX_ORDER - 2 on the tail of a free_area assuming that it should be
> > freeing the buddy of that page shortly. The only other issue with
> > adding to tail would be the memory shuffling which was recently added,
> > but I don't see that as being something that will be enabled in most
> > cases so we could probably just make the features mutually exclusive,
> > at least for now.
> >
> > So if I am not mistaken this would essentially require a couple
> > changes to the mm infrastructure in order for this to work.
> >
> > First we would need to split nr_free into two counters, something like
> > nr_freed and nr_bound. You could use nr_freed - nr_bound to get the
> > value currently used for nr_free. When we pulled the pages for hinting
> > we would reduce the nr_freed value and then add back to it when the
> > pages are returned. When pages are allocated they would increment the
> > nr_bound value. The idea behind this is that we can record nr_free
> > when we collect the pages and save it to some local value. This value
> > could then tell us how many new pages have been added that have not
> > been hinted upon.
> >
> > In addition we will need some way to identify which pages have been
> > hinted on and which have not. The way I believe easiest to do this
> > would be to overload the PageType value so that we could essentially
> > have two values for "Buddy" pages. We would have our standard "Buddy"
> > pages, and "Buddy" pages that also have the "Offline" value set in the
> > PageType field. Tracking the Online vs Offline pages this way would
> > actually allow us to do this with almost no overhead as the mapcount
> > value is already being reset to clear the "Buddy" flag so adding a
> > "Offline" flag to this clearing should come at no additional cost.
> >
> > Lastly we would need to create a specialized function for allocating
> > the non-"Offline" pages, and to tweak __free_one_page to tail enqueue
> > "Offline" pages. I'm thinking the alloc function it would look
> > something like __rmqueue_smallest but without the "expand" and needing
> > to modify the !page check to also include a check to verify the page
> > is not "Offline". As far as the changes to __free_one_page it would be
> > a 2 line change to test for the PageType being offline, and if it is
> > to call add_to_free_area_tail instead of add_to_free_area.
> Is it possible that once the pages are offline, there is a large
> allocation request in the guest needing those offline pages as well?

It is possible. However the behavior here would be no different from a
NIC driver. NIC drivers will sit on a swath of memory for Rx purposes
waiting for the DMA to occur. Here we are sitting on 64MB which for a
large allocation should not be that significant.

As far as avoiding it, I don't think there is any way we can avoid
such an event completely. There are scenerios where the hitning will
get hung up while sitting on memory for an extended period of time.
That is why I am thinking our best mitigation for now would be to keep
the amount of hinting we are doing confined to something on the
smaller side such as 64M or less which I have already mentioned. By
doing that if we do hit one of the problematic scenarios we should
have minimal impact.

> >
> > Anyway this email ended up being pretty massive by the time I was
> > done. Feel free to reply to parts of it and we can break it out into
> > separate threads of discussion as necessary. I will start working on
> > coding some parts of this next week.
> >
> > Thanks.
> >
> > - Alex
> --
> Regards
> Nitesh
>
