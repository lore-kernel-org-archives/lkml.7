Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF57C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280462084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFM2qFV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfDHSS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:18:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52034 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDHSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:18:56 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so681240itk.1;
        Mon, 08 Apr 2019 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LVmDudigUQwervo/T2AQUQqqfCDjZvjOSZzNBMYRkc=;
        b=CFM2qFV2JTJ/z5hk8cHEk0uexH42QZudO6KbdmAwYN1GAQeQ9sc+ru3btKbt/Us2Lv
         MEGgo7pfWohvP8ylJzq5u/QGnri2EIx8A6S/04zb2OtNA+TqMOsxWfs7il54weTrPZB3
         WuShVAiJFzK1iagOoRgBxNvWvYbwmATJwETbrIicypU0ZEYuHURPiCl8Avbt2YMr09ga
         pj5qhv08Lbr6jSsDYF+u7IODWTYI2kgWetqvIwRZImbzD3eRq901QU0cVFdrnHr0OwxK
         ottGwhnVIv9/62jO8yWgwXcPrBD4hDXnBtve3uH497YQZHM60Gj9fKZK+xyDaDAFzlBR
         r3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LVmDudigUQwervo/T2AQUQqqfCDjZvjOSZzNBMYRkc=;
        b=qbYd11lG0qsMNd9I86sKVk9uFyzBr70xGxFPLPPnPigON7e1QlV8O7gzayGalT32HS
         ijGkbZVHVFirVRmpjOnppD/wpKXJeTyCphv20etb3oc8+wLVBGi/Wh9Z1iqBbjTTMynE
         9+woy2t98KurmlpxQZ2xJwxg6c4H3nML5kHFt77yU2H4TDba9XbnfB811zPlpaHOSyL8
         0gkwKdI1l3x28YC3WAosQ/5ahiRkYE2Jo/CPJXvO/XEmF9L3bdyAu+hnjDmgYGMeYwS8
         7/zV0iQwMflBgTjGOQJMh+vQ2qZZM+hZDEZ3dAOszF3svnQk3iAMA1c94QcukUExTkoX
         gV4A==
X-Gm-Message-State: APjAAAWi+7ghKUeOiNil1ROR7XeKsI0HZhMqASRzY9+swGO1qF/MR2UG
        po5mQ1dpGEaw1CSoLLIDvSCI/FpMTp7lWOlvylzwaH92
X-Google-Smtp-Source: APXvYqxbkN3J4RSph1R+ApwGyG3+UZOMg3+Lr4vPosL20NUvOGWe1Ym+nvuY8MeArnGoLOLzheaaYAS1zcnUkGxd57I=
X-Received: by 2002:a24:7c52:: with SMTP id a79mr23388203itd.51.1554747535455;
 Mon, 08 Apr 2019 11:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
 <01d5f4e8-742b-33f5-6d91-0c7c396d1cfc@redhat.com>
In-Reply-To: <01d5f4e8-742b-33f5-6d91-0c7c396d1cfc@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 8 Apr 2019 11:18:44 -0700
Message-ID: <CAKgT0UfbVS2iupbf4Dfp91PAdgHNHwZ-RNyL=mcPsS_68Ly_9Q@mail.gmail.com>
Subject: Re: Thoughts on simple scanner approach for free page hinting
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
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

On Mon, Apr 8, 2019 at 9:36 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.04.19 02:09, Alexander Duyck wrote:
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
>
> Makes sense.
>
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
>
> We will need such a way in case we care about dropped hinting requests, yes.
>
> >
> > 3. Even with the current buffering which is still on the larger side
> > it is possible to overrun the hinting limits if something causes the
> > host to stall and a large swath of memory is released. As such we are
> > still going to need some sort of scanning mechanism or will have to
> > live with not providing accurate hints.
>
> Yes, usually if there is a lot of guest activity, you could however
> assume that free pages might get reused either way soon. Of course,
> special cases are "freeing XGB and being idle afterwards".

If we are assuming pages would get reused soon there wouldn't be as
much value to the free page hinting. Our optimal case is memory that
is going to be sitting free for an extended period of time. I say that
because we are adding overhead by hinting the pages away. The biggest
gain for this patch set is to be hinting before the page would be
swapped out to disk. If we are hinting before then and then reusing
the page we will actually introduce a performance regression as a page
fault is necessary to make the page usable again and that comes at a
cost. On the other hand if we linger too long in hinting we end up
with the page being swapped to disk.

> >
> > 4. In my opinion, the code overall is likely more complex then it
> > needs to be. We currently have 2 allocations that have to occur every
> > time we provide a hint all the way to the host, ideally we should not
> > need to allocate more memory to provide hints. We should be able to
> > hold the memory use for a memory hint device constant and simply map
> > the page address and size to the descriptors of the virtio-ring.
>
> I don't think the two allocations are that complex. The only thing I
> consider complex is isolation a lot of pages from different zones etc.
> Two allocations, nobody really cares about that. Of course, the fact
> that we have to allocate memory from the VCPUs where we currently freed
> a page is not optimal. I consider that rather a problem/complex.
>
> Especially you have a point regarding scalability and multiple VCPUs.

I found the extra allocations made thing much more difficult to
review. Basically we are having to design the virio interface to parse
the scatterlist that is being allocated and sent via the virtio
buffer. I really prefer the way the virtio-ballon was offlining pages
by just mapping them as though they were going to be used as Rx
buffers.

> >
> > With that said I have a few ideas that may help to address the 4
> > issues called out above. The basic idea is simple. We use a high water
> > mark based on zone->free_area[order].nr_free to determine when to wake
> > up a thread to start hinting memory out of a given free area. From
> > there we allocate non-"Offline" pages from the free area and assign
> > them to the hinting queue up to 64MB at a time. Once the hinting is
> > completed we mark them "Offline" and add them to the tail of the
> > free_area. Doing this we should cycle the non-"Offline" pages slowly
> > out of the free_area. In addition the search cost should be minimal
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
>
> I can imagine that quite some people will have problems with such
> "virtualization specific changes" splattered around core memory
> management. Would there be a way to manage this data at a different
> place, out of core-mm and somehow work on it via callbacks?

I'm working on the patches for this now. As I mentioned I only really
see 2, maybe 3 total changes.
1. area->nr_free -> area->nr_freed - area->nr_bound
2. Buddy -> Buddy & Offline, free "Offline" to tail.
3. alloc_non-offline

I'll elaborate more on the last two below.

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
>
> Just nothing here that this will require modifications to kdump
> (makedumpfile to be precise and the vmcore information exposed from the
> kernel), as kdump only checks for the the actual mapcount value to
> detect buddy and offline pages (to exclude them from dumps), they are
> not treated as flags.
>
> For now, any mapcount values are really only separate values, meaning
> not the separate bits are of interest, like flags would be. Reusing
> other flags would make our life a lot easier. E.g. PG_young or so. But
> clearing of these is then the problematic part.
>
> Of course we could use in the kernel two values, Buddy and BuddyOffline.
> But then we have to check for two different values whenever we want to
> identify a buddy page in the kernel.

Actually this may not be working the way you think it is working.
Below is the PageType code:
#define PAGE_TYPE_BASE 0xf0000000
/* Reserve 0x0000007f to catch underflows of page_mapcount */
#define PAGE_MAPCOUNT_RESERVE -128
#define PG_buddy 0x00000080
#define PG_offline 0x00000100
#define PG_kmemcg 0x00000200
#define PG_table 0x00000400

#define PageType(page, flag) \
((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)

If I am reading this correctly when you are testing for the "Buddy"
page type all you are doing is something like:
        page_type & 0xf0000080 = 0xf0000000;

This should work if mapcount is 0xfffffe7f or 0xffffff7f. So if I have
added "Online" to it the value the result will not have changed since
all adding a type really does is clear an additional bit in the
mapcount.

The only real issue I see is in __ClearPage##uname as it requires that
the bit be set when we are clearing it. For now I am just creating
another macro called "__ResetPage##uname" that uses the same test as
the set and then does an "|=" with the bit, and then using that to
reset the "Offline" value.

> >
> > Lastly we would need to create a specialized function for allocating
> > the non-"Offline" pages, and to tweak __free_one_page to tail enqueue
> > "Offline" pages. I'm thinking the alloc function it would look
> > something like __rmqueue_smallest but without the "expand" and needing
> > to modify the !page check to also include a check to verify the page
> > is not "Offline". As far as the changes to __free_one_page it would be
> > a 2 line change to test for the PageType being offline, and if it is
> > to call add_to_free_area_tail instead of add_to_free_area.
>
> As already mentioned, there might be scenarios where the additional
> hinting thread might consume too much CPU cycles, especially if there is
> little guest activity any you mostly spend time scanning a handful of
> free pages and reporting them. I wonder if we can somehow limit the
> amount of wakeups/scans for a given period to mitigate this issue.

That is why I was talking about breaking nr_free into nr_freed and
nr_bound. By doing that I can record the nr_free value to a
virtio-balloon specific location at the start of any walk and should
know exactly now many pages were freed between that call and the next
one. By ordering things such that we place the "Offline" pages on the
tail of the list it should make the search quite fast since we would
just be always allocating off of the head of the queue until we have
hinted everything int he queue. So when we hit the last call to alloc
the non-"Offline" pages and shut down our thread we can use the
nr_freed value that we recorded to know exactly how many pages have
been added that haven't been hinted.

> One main issue I see with your approach is that we need quite a lot of
> core memory management changes. This is a problem. I wonder if we can
> factor out most parts into callbacks.

I think that is something we can't get away from. However if we make
this generic enough there would likely be others beyond just the
virtualization drivers that could make use of the infrastructure. For
example being able to track the rate at which the free areas are
cycling in and out pages seems like something that would be useful
outside of just the virtualization areas.

> E.g. in order to detect where to queue a certain page (front/tail), call
> a callback if one is registered, mark/check pages in a core-mm unknown
> way as offline etc.
>
> I still wonder if there could be an easier way to combine recording of
> hints and one hinting thread, essentially avoiding scanning and some of
> the required core-mm changes.

The concern I have with trying to avoid the scanning by tracking is
that if you fall behind it becomes something where just tracking the
metadata for the page hints would start to become expensive.
