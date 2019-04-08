Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD4A20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfDHSTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:19:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39058 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDHSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:19:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id c189so8586864qke.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Avkd9FV8mkuF8EI7MptVtPgWNRuvw+m2QRmIU3VL0bE=;
        b=ujuB1hA3VjNcjDQNOdHhyH3QTzJH0uO5EFIIxsILT/YTUM4VIXcsxvO7va/Sc2J5Uk
         Nc6xawTOnhnMw5NnaJFPCXjDElv6oRiCu1Q71wrZ/txVSAV+t7TqJoelEfD8bC2hHm4N
         RQWRavzcdf/M0lRsSjXFNtrjokjPKnd10pky07Yo7mMPar/NYerGcjdvs/hTRywAVat5
         pmCdnwkYis5iCQinp6U8P4EN6ziFQ8CYoCUXrGXJwTE5dFDq6wJykcB38QRKI3Q8dA/Y
         V4CTm31WjCO4e2TEmykV2ylDSd0NyPOv70KxKCmuhC3vW6DFkj8D3b2U32esIy2Ozsm3
         vmIA==
X-Gm-Message-State: APjAAAXeLq7oKstmBov98tYtbM/4YYmsKDC304xEqQf/B3kbbNA/srN5
        RVT7fcknkJX26fn2V0IDgRA67A==
X-Google-Smtp-Source: APXvYqw0252jad25s5qg3toJukqr/5mvEtBrqI0+p6SRkPdwB8OZQzBOT8Hp0UtSIJeLY9tT2dU7Nw==
X-Received: by 2002:a37:9407:: with SMTP id w7mr22407697qkd.197.1554747563930;
        Mon, 08 Apr 2019 11:19:23 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id n6sm11337343qte.11.2019.04.08.11.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 11:19:23 -0700 (PDT)
Date:   Mon, 8 Apr 2019 14:19:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: Thoughts on simple scanner approach for free page hinting
Message-ID: <20190408141145-mutt-send-email-mst@kernel.org>
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
 <01d5f4e8-742b-33f5-6d91-0c7c396d1cfc@redhat.com>
 <6f097f31-abc7-f56c-199c-dc167331f6b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f097f31-abc7-f56c-199c-dc167331f6b9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 02:09:59PM -0400, Nitesh Narayan Lal wrote:
> On 4/8/19 12:36 PM, David Hildenbrand wrote:
> > On 06.04.19 02:09, Alexander Duyck wrote:
> >> So I am starting this thread as a spot to collect my thoughts on the
> >> current guest free page hinting design as well as point out a few
> >> possible things we could do to improve upon it.
> >>
> >> 1. The current design isn't likely going to scale well to multiple
> >> VCPUs. The issue specifically is that the zone lock must be held to
> >> pull pages off of the free list and to place them back there once they
> >> have been hinted upon. As a result it would likely make sense to try
> >> to limit ourselves to only having one thread performing the actual
> >> hinting so that we can avoid running into issues with lock contention
> >> between threads.
> > Makes sense.
> >
> >> 2. There are currently concerns about the hinting triggering false OOM
> >> situations if too much memory is isolated while it is being hinted. My
> >> thought on this is to simply avoid the issue by only hint on a limited
> >> amount of memory at a time. Something like 64MB should be a workable
> >> limit without introducing much in the way of regressions. However as a
> >> result of this we can easily be overrun while waiting on the host to
> >> process the hinting request. As such we will probably need a way to
> >> walk the free list and free pages after they have been freed instead
> >> of trying to do it as they are freed.
> > We will need such a way in case we care about dropped hinting requests, yes.
> >
> >> 3. Even with the current buffering which is still on the larger side
> >> it is possible to overrun the hinting limits if something causes the
> >> host to stall and a large swath of memory is released. As such we are
> >> still going to need some sort of scanning mechanism or will have to
> >> live with not providing accurate hints.
> > Yes, usually if there is a lot of guest activity, you could however
> > assume that free pages might get reused either way soon. Of course,
> > special cases are "freeing XGB and being idle afterwards".
> >
> >> 4. In my opinion, the code overall is likely more complex then it
> >> needs to be. We currently have 2 allocations that have to occur every
> >> time we provide a hint all the way to the host, ideally we should not
> >> need to allocate more memory to provide hints. We should be able to
> >> hold the memory use for a memory hint device constant and simply map
> >> the page address and size to the descriptors of the virtio-ring.
> > I don't think the two allocations are that complex. The only thing I
> > consider complex is isolation a lot of pages from different zones etc.
> > Two allocations, nobody really cares about that. Of course, the fact
> > that we have to allocate memory from the VCPUs where we currently freed
> > a page is not optimal. I consider that rather a problem/complex.
> >
> > Especially you have a point regarding scalability and multiple VCPUs.
> >
> >> With that said I have a few ideas that may help to address the 4
> >> issues called out above. The basic idea is simple. We use a high water
> >> mark based on zone->free_area[order].nr_free to determine when to wake
> >> up a thread to start hinting memory out of a given free area. From
> >> there we allocate non-"Offline" pages from the free area and assign
> >> them to the hinting queue up to 64MB at a time. Once the hinting is
> >> completed we mark them "Offline" and add them to the tail of the
> >> free_area. Doing this we should cycle the non-"Offline" pages slowly
> >> out of the free_area. In addition the search cost should be minimal
> >> since all of the "Offline" pages should be aggregated to the tail of
> >> the free_area so all pages allocated off of the free_area will be the
> >> non-"Offline" pages until we shift over to them all being "Offline".
> >> This should be effective for MAX_ORDER - 1 and MAX_ORDER - 2 pages
> >> since the only real consumer of add_to_free_area_tail is
> >> __free_one_page which uses it to place a page with an order less than
> >> MAX_ORDER - 2 on the tail of a free_area assuming that it should be
> >> freeing the buddy of that page shortly. The only other issue with
> >> adding to tail would be the memory shuffling which was recently added,
> >> but I don't see that as being something that will be enabled in most
> >> cases so we could probably just make the features mutually exclusive,
> >> at least for now.
> >>
> >> So if I am not mistaken this would essentially require a couple
> >> changes to the mm infrastructure in order for this to work.
> >>
> >> First we would need to split nr_free into two counters, something like
> >> nr_freed and nr_bound. You could use nr_freed - nr_bound to get the
> >> value currently used for nr_free. When we pulled the pages for hinting
> >> we would reduce the nr_freed value and then add back to it when the
> >> pages are returned. When pages are allocated they would increment the
> >> nr_bound value. The idea behind this is that we can record nr_free
> >> when we collect the pages and save it to some local value. This value
> >> could then tell us how many new pages have been added that have not
> >> been hinted upon.
> > I can imagine that quite some people will have problems with such
> > "virtualization specific changes" splattered around core memory
> > management. Would there be a way to manage this data at a different
> > place, out of core-mm and somehow work on it via callbacks?
> >
> >> In addition we will need some way to identify which pages have been
> >> hinted on and which have not. The way I believe easiest to do this
> >> would be to overload the PageType value so that we could essentially
> >> have two values for "Buddy" pages. We would have our standard "Buddy"
> >> pages, and "Buddy" pages that also have the "Offline" value set in the
> >> PageType field. Tracking the Online vs Offline pages this way would
> >> actually allow us to do this with almost no overhead as the mapcount
> >> value is already being reset to clear the "Buddy" flag so adding a
> >> "Offline" flag to this clearing should come at no additional cost.
> > Just nothing here that this will require modifications to kdump
> > (makedumpfile to be precise and the vmcore information exposed from the
> > kernel), as kdump only checks for the the actual mapcount value to
> > detect buddy and offline pages (to exclude them from dumps), they are
> > not treated as flags.
> >
> > For now, any mapcount values are really only separate values, meaning
> > not the separate bits are of interest, like flags would be. Reusing
> > other flags would make our life a lot easier. E.g. PG_young or so. But
> > clearing of these is then the problematic part.
> >
> > Of course we could use in the kernel two values, Buddy and BuddyOffline.
> > But then we have to check for two different values whenever we want to
> > identify a buddy page in the kernel.
> >
> >> Lastly we would need to create a specialized function for allocating
> >> the non-"Offline" pages, and to tweak __free_one_page to tail enqueue
> >> "Offline" pages. I'm thinking the alloc function it would look
> >> something like __rmqueue_smallest but without the "expand" and needing
> >> to modify the !page check to also include a check to verify the page
> >> is not "Offline". As far as the changes to __free_one_page it would be
> >> a 2 line change to test for the PageType being offline, and if it is
> >> to call add_to_free_area_tail instead of add_to_free_area.
> > As already mentioned, there might be scenarios where the additional
> > hinting thread might consume too much CPU cycles, especially if there is
> > little guest activity any you mostly spend time scanning a handful of
> > free pages and reporting them. I wonder if we can somehow limit the
> > amount of wakeups/scans for a given period to mitigate this issue.
> >
> > One main issue I see with your approach is that we need quite a lot of
> > core memory management changes. This is a problem. I wonder if we can
> > factor out most parts into callbacks.
> >
> > E.g. in order to detect where to queue a certain page (front/tail), call
> > a callback if one is registered, mark/check pages in a core-mm unknown
> > way as offline etc.
> >
> > I still wonder if there could be an easier way to combine recording of
> > hints and one hinting thread, essentially avoiding scanning and some of
> > the required core-mm changes.
> In order to resolve the scalability issues associated with my
> patch-series without compromising with free memory hints, I may explore
> the idea described below:
> - Use xbitmap (if possible - earlier suggested by Rik and Wei)
> corresponding to each zone on a granularity of MAX_ORDER - 2, to track
> the freed PFN's.

MAX_ORDER - 2 is what? 2Mbyte?

> - Define and use counters corresponding to each zone to monitor the
> amount of memory freed.
> - As soon as the 64MB free memory threshold is hit wake up the kernel
> thread which will scan this xbitmap and try to isolate the pages and
> clear the corresponding bits. (We still have to acquire zone lock to
> protect the respective xbitmap)

So that's 32 pages then? I'd say just keep them in an array,
list, tree or hash, bitmap is for when you have nots of pages.


> - Report the isolated pages back to the host in a synchronous manner.
> I still have to work on several details of this idea including xbitmap,
> but first would like to hear any suggestions/thoughts.
> >
> -- 
> Regards
> Nitesh
> 







-- 
MST
