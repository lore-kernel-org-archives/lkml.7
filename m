Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4036CC282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 00:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF1B218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 00:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnr8Qcmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDFAJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 20:09:57 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:52923 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDFAJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 20:09:57 -0400
Received: by mail-it1-f180.google.com with SMTP id x132so2051095itf.2;
        Fri, 05 Apr 2019 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+uZuXK3Cg5BkLu3R2m2Qt0Oi23SaZRCYQzeotiWu9hc=;
        b=Pnr8Qcmz5UA3Vq8hzId7rtXzoTDHe+wd5mhOyTxaUsKYIUhWd6C+4BBbLROLNVT11A
         88Rp2XHc7s0GEEh3AwJiGHc5Ytt1l+r5JTrcTdiRzGQ7ZJEd+ICBqAqPLOM7SALWyOaO
         xrl1kbNQINdnJ+49uLIfBIOvM/kB8G7IokkksV6x9SjHsdTvIhgXpVW11QQ4csezlTSZ
         ByFVwSr7wy6DiiH0RQEViqIFKCroQvgDra9/qD4bqUaI4wGgJHz6R9Jg5x4TpEbb8WP5
         MVBbAaM5ARHjDJp0KWy0+xahJHq9Eaf83OmNOz/ezj4d0HK2xSiFKFpG39UAvoYGPbaT
         jzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+uZuXK3Cg5BkLu3R2m2Qt0Oi23SaZRCYQzeotiWu9hc=;
        b=N5wTPCm7fCl+H+91lHqehlFdFsDa9iEvm4zxWVtCKoge1P4UoNyWPYRSlzDH558pIj
         Dmx5KQCdnpNLLQWMwawvN8H7h3/egqh3i6wo6kUfhw3Y5mbLidMSnC582ExBmWYeAGdC
         FKPMgqJVBXFyqClQoqT7yItyBI1mEm/MaAyUlalgqLL2bHRau7k7nHL9hQwur5MYq2aX
         0uRjFYNgoDq0W+RSYxuvCbnN3OdaceC+0xIX5M1rXB88IztgogA2032zpagvWrDGcFrh
         9TT+MAA9exO9r8NBhEQW+5jQB+doQoush6iUJ9ZwSQuUIaHG6OawTMw3jf1ti2PZo+BO
         lAgw==
X-Gm-Message-State: APjAAAUWQPWRzl2BbafuA6j7Y3h13SVtwuZx7streVKa8ymj2eC1D/5J
        AzYJoEDUmYdjUHq8NuwhHBdOfEVa4s6XM1hdUbA=
X-Google-Smtp-Source: APXvYqw3Drw5oqr7TTrV7zTrQdEEoKBMGAwzJWRcUZ5Q6L3u0TvUlbUhcUSDaIhf45VwUMOvJ1Pg/hocSByuFV7OQd4=
X-Received: by 2002:a24:7c52:: with SMTP id a79mr12697448itd.51.1554509396242;
 Fri, 05 Apr 2019 17:09:56 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 5 Apr 2019 17:09:45 -0700
Message-ID: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
Subject: Thoughts on simple scanner approach for free page hinting
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
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

So I am starting this thread as a spot to collect my thoughts on the
current guest free page hinting design as well as point out a few
possible things we could do to improve upon it.

1. The current design isn't likely going to scale well to multiple
VCPUs. The issue specifically is that the zone lock must be held to
pull pages off of the free list and to place them back there once they
have been hinted upon. As a result it would likely make sense to try
to limit ourselves to only having one thread performing the actual
hinting so that we can avoid running into issues with lock contention
between threads.

2. There are currently concerns about the hinting triggering false OOM
situations if too much memory is isolated while it is being hinted. My
thought on this is to simply avoid the issue by only hint on a limited
amount of memory at a time. Something like 64MB should be a workable
limit without introducing much in the way of regressions. However as a
result of this we can easily be overrun while waiting on the host to
process the hinting request. As such we will probably need a way to
walk the free list and free pages after they have been freed instead
of trying to do it as they are freed.

3. Even with the current buffering which is still on the larger side
it is possible to overrun the hinting limits if something causes the
host to stall and a large swath of memory is released. As such we are
still going to need some sort of scanning mechanism or will have to
live with not providing accurate hints.

4. In my opinion, the code overall is likely more complex then it
needs to be. We currently have 2 allocations that have to occur every
time we provide a hint all the way to the host, ideally we should not
need to allocate more memory to provide hints. We should be able to
hold the memory use for a memory hint device constant and simply map
the page address and size to the descriptors of the virtio-ring.

With that said I have a few ideas that may help to address the 4
issues called out above. The basic idea is simple. We use a high water
mark based on zone->free_area[order].nr_free to determine when to wake
up a thread to start hinting memory out of a given free area. From
there we allocate non-"Offline" pages from the free area and assign
them to the hinting queue up to 64MB at a time. Once the hinting is
completed we mark them "Offline" and add them to the tail of the
free_area. Doing this we should cycle the non-"Offline" pages slowly
out of the free_area. In addition the search cost should be minimal
since all of the "Offline" pages should be aggregated to the tail of
the free_area so all pages allocated off of the free_area will be the
non-"Offline" pages until we shift over to them all being "Offline".
This should be effective for MAX_ORDER - 1 and MAX_ORDER - 2 pages
since the only real consumer of add_to_free_area_tail is
__free_one_page which uses it to place a page with an order less than
MAX_ORDER - 2 on the tail of a free_area assuming that it should be
freeing the buddy of that page shortly. The only other issue with
adding to tail would be the memory shuffling which was recently added,
but I don't see that as being something that will be enabled in most
cases so we could probably just make the features mutually exclusive,
at least for now.

So if I am not mistaken this would essentially require a couple
changes to the mm infrastructure in order for this to work.

First we would need to split nr_free into two counters, something like
nr_freed and nr_bound. You could use nr_freed - nr_bound to get the
value currently used for nr_free. When we pulled the pages for hinting
we would reduce the nr_freed value and then add back to it when the
pages are returned. When pages are allocated they would increment the
nr_bound value. The idea behind this is that we can record nr_free
when we collect the pages and save it to some local value. This value
could then tell us how many new pages have been added that have not
been hinted upon.

In addition we will need some way to identify which pages have been
hinted on and which have not. The way I believe easiest to do this
would be to overload the PageType value so that we could essentially
have two values for "Buddy" pages. We would have our standard "Buddy"
pages, and "Buddy" pages that also have the "Offline" value set in the
PageType field. Tracking the Online vs Offline pages this way would
actually allow us to do this with almost no overhead as the mapcount
value is already being reset to clear the "Buddy" flag so adding a
"Offline" flag to this clearing should come at no additional cost.

Lastly we would need to create a specialized function for allocating
the non-"Offline" pages, and to tweak __free_one_page to tail enqueue
"Offline" pages. I'm thinking the alloc function it would look
something like __rmqueue_smallest but without the "expand" and needing
to modify the !page check to also include a check to verify the page
is not "Offline". As far as the changes to __free_one_page it would be
a 2 line change to test for the PageType being offline, and if it is
to call add_to_free_area_tail instead of add_to_free_area.

Anyway this email ended up being pretty massive by the time I was
done. Feel free to reply to parts of it and we can break it out into
separate threads of discussion as necessary. I will start working on
coding some parts of this next week.

Thanks.

- Alex
