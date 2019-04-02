Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A97CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E709720883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyDT4ed9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfDBPEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:04:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53516 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:04:13 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so5631954itf.3;
        Tue, 02 Apr 2019 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35SCcjt6KSCmwtvu70RpULRlQXf867RVWG3TdPtPOiw=;
        b=tyDT4ed9Hw0Qs9tZ5SwjJiHQ8jIH9ArPZjpCcPhx5E/V/aTbQj4jEYJMJ3BNbOlgMf
         4zRglnfhV+v1JAnzYmBTRUflPuJbP6EpMAC6md11pWhNC5BlI4+DeW14fICt2Q4EY7ZQ
         sS10WQXV7ZP2b6jeRWf2lhXJJtmy81l13dcl4FAYe0T20WFnQG7/md8lRSZnrWoVROwl
         zrfvkZZa/MBsTDwdLG2AHwFQMXZ/4kopW1GKPFcyXWtz8/1vjtJDKGx2KbZWV8kofsM2
         vrmcEp0m9vUKOO5hfuCs9j17SBBwD3ooOr1TmTRADW4yza8fFLr+lDUPObC0cX9k8VIx
         eMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35SCcjt6KSCmwtvu70RpULRlQXf867RVWG3TdPtPOiw=;
        b=tShK7iYOYJm5m6G4Z8sFgAJFQK+0A88X0aQkQXDUIA6O50LDRBQYYD4qntM1MjxukI
         zyhqoQELR577Tigv6E//qplvgTVHERFuquidaJ4wbpBmKWTxJL6xaVa21qNfHPPKtf9B
         xLbGPoM6NrUI5s0ceF06mvCAHrR1vwzxMAZugALam776WnxMspDLPmREFlWQdt4rODGi
         3YXreqTOqslHHxacTJvWByqunm1qLxtlri4k9/jxHFcOghd7tME46XrZLJdXX79TbulI
         zvXpBVn9ceK/OoSAVvIJZaz1nA0hel5ucp1tb+YDt1xtDmMOWe7Vws2ysiBrZDShrpJu
         FbCA==
X-Gm-Message-State: APjAAAXbbmqKYojgHbiVydIcUtlBOrfZO8h/PkiBRFM9kUfI8tm2n2Z3
        x3cO0qg4/Bx3KNk34rfyQxdjB+Xn/nJWmzr6pc/2DA==
X-Google-Smtp-Source: APXvYqxd1HmY0sozYx282aqBcrKzL4DLn0usECCgjgENDvP0bYBLb3yBGumBjEVQwv0z5Y0XaNhyL0X48VazKrZq+us=
X-Received: by 2002:a24:4d06:: with SMTP id l6mr3980278itb.140.1554217452351;
 Tue, 02 Apr 2019 08:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com> <20190329104311-mutt-send-email-mst@kernel.org>
 <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com> <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org> <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org> <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
 <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com> <20190401104608-mutt-send-email-mst@kernel.org>
 <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com> <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com>
In-Reply-To: <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 2 Apr 2019 08:04:00 -0700
Message-ID: <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
Subject: Re: On guest free page hinting and OOM
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

On Tue, Apr 2, 2019 at 12:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.04.19 22:56, Alexander Duyck wrote:
> > On Mon, Apr 1, 2019 at 7:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Mon, Apr 01, 2019 at 04:11:42PM +0200, David Hildenbrand wrote:
> >>>> The interesting thing is most probably: Will the hinting size usually be
> >>>> reasonable small? At least I guess a guest with 4TB of RAM will not
> >>>> suddenly get a hinting size of hundreds of GB. Most probably also only
> >>>> something in the range of 1GB. But this is an interesting question to
> >>>> look into.
> >>>>
> >>>> Also, if the admin does not care about performance implications when
> >>>> already close to hinting, no need to add the additional 1Gb to the ram size.
> >>>
> >>> "close to OOM" is what I meant.
> >>
> >> Problem is, host admin is the one adding memory. Guest admin is
> >> the one that knows about performance.
> >
> > The thing we have to keep in mind with this is that we are not dealing
> > with the same behavior as the balloon driver. We don't need to inflate
> > a massive hint and hand that off. Instead we can focus on performing
> > the hints on much smaller amounts and do it incrementally over time
> > with the idea being as the system sits idle it frees up more and more
> > of the inactive memory on the system.
> >
> > With that said, I still don't like the idea of us even trying to
> > target 1GB of RAM for hinting. I think it would be much better if we
> > stuck to smaller sizes and kept things down to a single digit multiple
> > of THP or higher order pages. Maybe something like 64MB of total
> > memory out for hinting.
>
> 1GB was just a number I came up with. But please note, as VCPUs hint in
> parallel, even though each request is only 64MB in size, things can sum up.

Why do we need them running in parallel for a single guest? I don't
think we need the hints so quickly that we would need to have multiple
VCPUs running in parallel to provide hints. In addition as it
currently stands in order to get pages into and out of the buddy
allocator we are going to have to take the zone lock anyway so we
could probably just assume a single thread for pulling the memory,
placing it on the ring, and putting it back into the buddy allocator
after the hint has been completed.

> >
> > All we really would need to make it work would be to possibly look at
> > seeing if we can combine PageType values. Specifically what I would be
> > looking at is a transition that looks something like Buddy -> Offline
> > -> (Buddy | Offline). We would have to hold the zone lock at each
> > transition, but that shouldn't be too big of an issue. If we are okay
> > with possibly combining the Offline and Buddy types we would have a
> > way of tracking which pages have been hinted and which have not. Then
> > we would just have to have a thread running in the background on the
> > guest that is looking at the higher order pages and pulling 64MB at a
> > time offline, and when the hinting is done put them back in the "Buddy
> > | Offline" state.
>
> That approach may have other issues to solve (1 thread vs. many VCPUs,
> scanning all buddy pages over and over again) and other implications
> that might be undesirable (hints performed even more delayed, additional
> thread activity). I wouldn't call it the ultimate solution.

So the problem with trying to provide the hint sooner is that you end
up creating a bottle-neck or you end up missing hints on pages
entirely and then have to fall back to such an approach. By just
letting the thread run in the background reporting the idle memory we
can avoid much of that.

Also there isn't a huge priority to report idle memory in real time.
That would be kind of pointless as it might be pulled back out and
reused as soon as it is added. What we need is to give the memory a
bit of time to "cool" so that we aren't constantly hinting away memory
that is still in use.

> Your approach sounds very interesting to play with, however
> at this point I would like to avoid throwing away Nitesh work once again
> to follow some other approach that looks promising. If we keep going
> like that, we'll spend another ~10 years working on free page hinting
> without getting anything upstream. Especially if it involves more
> core-MM changes. We've been there, we've done that. As long as the
> guest-host interface is generic enough, we can play with such approaches
> later in the guest. Important part is that the guest-host interface
> allows for that.

I'm not throwing anything away. One of the issues in Nitesh's design
is that he is going to either miss memory and have to run an
asynchronous thread to clean it up after the fact, or he is going to
cause massive OOM errors and/or have to start halting VCPUs while
waiting on the processing. All I am suggesting is that we can get away
from having to deal with both by just walking through the free pages
for the higher order and hinting only a few at a time without having
to try to provide the host with the hints on what is idle the second
it is freed.

> >
> > I view this all as working not too dissimilar to how a standard Rx
> > ring in a network device works. Only we would want to allocate from
> > the pool of "Buddy" pages, flag the pages as "Offline", and then when
> > the hint has been processed we would place them back in the "Buddy"
> > list with the "Offline" value still set. The only real changes needed
> > to the buddy allocator would be to add some logic for clearing/merging
> > the "Offline" setting as necessary, and to provide an allocator that
> > only works with non-"Offline" pages.
>
> Sorry, I had to smile at the phrase "only" in combination with "provide
> an allocator that only works with non-Offline pages" :) . I guess you
> realize yourself that these are core-mm changes that might easily be
> rejected upstream because "the virt guys try to teach core-MM yet
> another special case". I agree that this is nice to play with,
> eventually that approach could succeed and be accepted upstream. But I
> consider this long term work.

The actual patch for this would probably be pretty small and compared
to some of the other stuff that has gone in recently isn't too far out
of the realm of possibility. It isn't too different then the code that
has already done in to determine the unused pages for virtio-balloon
free page hinting.

Basically what we would be doing is providing a means for
incrementally transitioning the buddy memory into the idle/offline
state to reduce guest memory overhead. It would require one function
that would walk the free page lists and pluck out pages that don't
have the "Offline" page type set, a one-line change to the logic for
allocating a page as we would need to clear that extra bit of state,
and optionally some bits for how to handle the merge of two "Offline"
pages in the buddy allocator (required for lower order support). It
solves most of the guest side issues with the free page hinting in
that trying to do it via the arch_free_page path is problematic at
best since it was designed for a synchronous setup, not an
asynchronous one.
