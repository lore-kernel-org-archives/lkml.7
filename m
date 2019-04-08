Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B89C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6501B21874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIDKDkDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDHV4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:56:22 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36713 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDHV4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:56:21 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so1722803itc.1;
        Mon, 08 Apr 2019 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlaYw51ba8o+5WL0df316lF6GXkQeiMHb5j6EngoIN0=;
        b=FIDKDkDkd8iMIviZovj+I+OtFzEbzHrGP4RwSSA9Qtp6Wh495PTI/rHf07dDBZ/JW1
         7AT+cFzPUAQnWNUavkOhpBUz2piGIQ9AmSRXUrAqMP+JDJLmNCdqiCnSYUIVzevuFccn
         xbn2BkKch4iGvV00BNRYxcRugvhlKS/F++kx6vW3O+IxgbdlQ10E3wIFhRHuTh9dqkbR
         jwHhympS49chzhbhdcDfGcy9XsMQ0ttG/20o2LNtExO7NnnRFn+hz5oUaDLU/Afq2qhQ
         GGK1r5THXLjaoOACJ3q5tjVPuvt7WWa3RFKP4wO+sSvml9ZsMI4/JwoNeJ/ktLsFKC4H
         /Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlaYw51ba8o+5WL0df316lF6GXkQeiMHb5j6EngoIN0=;
        b=OFsC16pXwSsNROAltLGGOo82cEljO/TikCeKIDCzd7xTAKI/etJ61q9jB7d3mFhC+W
         GqIi03Jt9iVwxvmYTD/6JMZXiy53g7V3RuXs+4bjzAS0s/sp1FMeu+mAONXCoPWVbs3l
         0MpOCV9YIjQix7nqC7lu3HVDLis2FTur4QlCf1Fvxgt7Mqj2h+TRwuwfPY1L6wg/iN8i
         8qlyM6GqkQOeByleUhE2YuhzU1lWVoRs4mdE4iIMNBhF65YQG0zAR+eJlHnxLCsNKi7e
         MiBoG5IgXTxP5UOYrlsDSxjEheQJn2smV0QKxet5z+PoJV2xtauz6/AePefwxt8jNTIv
         uCqw==
X-Gm-Message-State: APjAAAVsxGuV0ZfmpIDSy8/eg8NcC6N8TOF2pZEdH9hvUzvuEOtWCeYJ
        Vdl1Gemftk5Kxd0qdDN0VnAY62WP+rcCWj6udNE=
X-Google-Smtp-Source: APXvYqxnkG02zbOKRqiNAduEkkbnrhwIVSqN9LtpdyKaRX7jITYtRGFQDiXq+BDxA8Yzn6uwSBpTzDIt5qJwXv4G8sU=
X-Received: by 2002:a24:4d06:: with SMTP id l6mr19327875itb.140.1554760580453;
 Mon, 08 Apr 2019 14:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0Ue4LufT4q4dLwjqhGRpDbVnucNWhmhwWxbwtytgjxx+Kw@mail.gmail.com>
 <01d5f4e8-742b-33f5-6d91-0c7c396d1cfc@redhat.com> <CAKgT0UfbVS2iupbf4Dfp91PAdgHNHwZ-RNyL=mcPsS_68Ly_9Q@mail.gmail.com>
 <ef4c219f-6686-f5f6-fd22-d1da0b1720f3@redhat.com> <CAKgT0Ucp1nt4roC1xdZEMcD17TvJovsDKBdkRK6vA_4bUM8bdw@mail.gmail.com>
 <efe01b95-33d4-71ce-2a48-ec43f0846d68@redhat.com> <9da317cb-38ee-9b02-2549-65d8b45d5354@redhat.com>
In-Reply-To: <9da317cb-38ee-9b02-2549-65d8b45d5354@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 8 Apr 2019 14:56:09 -0700
Message-ID: <CAKgT0Uc=KbjCr_cX4GUbwqdJDXo45TAD6WcmwxD2D0Q48scRWw@mail.gmail.com>
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

On Mon, Apr 8, 2019 at 2:21 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.04.19 22:51, David Hildenbrand wrote:
> > On 08.04.19 22:10, Alexander Duyck wrote:
> >> On Mon, Apr 8, 2019 at 11:40 AM David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>>>>>
> >>>>>> In addition we will need some way to identify which pages have been
> >>>>>> hinted on and which have not. The way I believe easiest to do this
> >>>>>> would be to overload the PageType value so that we could essentially
> >>>>>> have two values for "Buddy" pages. We would have our standard "Buddy"
> >>>>>> pages, and "Buddy" pages that also have the "Offline" value set in the
> >>>>>> PageType field. Tracking the Online vs Offline pages this way would
> >>>>>> actually allow us to do this with almost no overhead as the mapcount
> >>>>>> value is already being reset to clear the "Buddy" flag so adding a
> >>>>>> "Offline" flag to this clearing should come at no additional cost.
> >>>>>
> >>>>> Just nothing here that this will require modifications to kdump
> >>>>> (makedumpfile to be precise and the vmcore information exposed from the
> >>>>> kernel), as kdump only checks for the the actual mapcount value to
> >>>>> detect buddy and offline pages (to exclude them from dumps), they are
> >>>>> not treated as flags.
> >>>>>
> >>>>> For now, any mapcount values are really only separate values, meaning
> >>>>> not the separate bits are of interest, like flags would be. Reusing
> >>>>> other flags would make our life a lot easier. E.g. PG_young or so. But
> >>>>> clearing of these is then the problematic part.
> >>>>>
> >>>>> Of course we could use in the kernel two values, Buddy and BuddyOffline.
> >>>>> But then we have to check for two different values whenever we want to
> >>>>> identify a buddy page in the kernel.
> >>>>
> >>>> Actually this may not be working the way you think it is working.
> >>>
> >>> Trust me, I know how it works. That's why I was giving you the notice.
> >>>
> >>> Read the first paragraph again and ignore the others. I am only
> >>> concerned about makedumpfile that has to be changed.
> >>>
> >>> PAGE_OFFLINE_MAPCOUNT_VALUE
> >>> PAGE_BUDDY_MAPCOUNT_VALUE
> >>>
> >>> Once you find out how these values are used, you should understand what
> >>> has to be changed and where.
> >>
> >> Ugh. Is there an official repo I am supposed to refer to for makedumpfile?
> >>
> >> As far as the changes needed I don't think this would necessitate
> >> additional exports. We could probably just get away with having
> >> makedumpfile generate a new value by simply doing an "&" of the two
> >> values to determine what an offline buddy would be. If need be I can
> >> submit a patch for that. I find it kind of annoying that the kernel is
> >> handling identifying these bits one way, and makedumpfile is doing it
> >> another way. It should have been setup to handle this all the same
> >> way.
> >>
> >>>
> >>>>>>
> >>>>>> Lastly we would need to create a specialized function for allocating
> >>>>>> the non-"Offline" pages, and to tweak __free_one_page to tail enqueue
> >>>>>> "Offline" pages. I'm thinking the alloc function it would look
> >>>>>> something like __rmqueue_smallest but without the "expand" and needing
> >>>>>> to modify the !page check to also include a check to verify the page
> >>>>>> is not "Offline". As far as the changes to __free_one_page it would be
> >>>>>> a 2 line change to test for the PageType being offline, and if it is
> >>>>>> to call add_to_free_area_tail instead of add_to_free_area.
> >>>>>
> >>>>> As already mentioned, there might be scenarios where the additional
> >>>>> hinting thread might consume too much CPU cycles, especially if there is
> >>>>> little guest activity any you mostly spend time scanning a handful of
> >>>>> free pages and reporting them. I wonder if we can somehow limit the
> >>>>> amount of wakeups/scans for a given period to mitigate this issue.
> >>>>
> >>>> That is why I was talking about breaking nr_free into nr_freed and
> >>>> nr_bound. By doing that I can record the nr_free value to a
> >>>> virtio-balloon specific location at the start of any walk and should
> >>>> know exactly now many pages were freed between that call and the next
> >>>> one. By ordering things such that we place the "Offline" pages on the
> >>>> tail of the list it should make the search quite fast since we would
> >>>> just be always allocating off of the head of the queue until we have
> >>>> hinted everything int he queue. So when we hit the last call to alloc
> >>>> the non-"Offline" pages and shut down our thread we can use the
> >>>> nr_freed value that we recorded to know exactly how many pages have
> >>>> been added that haven't been hinted.
> >>>>
> >>>>> One main issue I see with your approach is that we need quite a lot of
> >>>>> core memory management changes. This is a problem. I wonder if we can
> >>>>> factor out most parts into callbacks.
> >>>>
> >>>> I think that is something we can't get away from. However if we make
> >>>> this generic enough there would likely be others beyond just the
> >>>> virtualization drivers that could make use of the infrastructure. For
> >>>> example being able to track the rate at which the free areas are
> >>>> cycling in and out pages seems like something that would be useful
> >>>> outside of just the virtualization areas.
> >>>
> >>> Might be, but might be the other extreme, people not wanting such
> >>> special cases in core mm. I assume the latter until I see a very clear
> >>> design where such stuff has been properly factored out.
> >>
> >> The only real pain point I am seeing right now is the assumptions
> >> makedumpfile is currently making about how mapcount is being used to
> >> indicate pagetype. If we patch it to fix it most of the other bits are
> >> minor.
> >
> > I'll be curious how splitting etc. will be handled. Especially if you
> > want to set Offline for all affected sub pages.
> >
>
> Answering that myself, I guess you are planning to change the buddy to
> basically copy the offline value to sub-pages when splitting, also
> attaching them to the tail of the list instead of the head.

Yes that was the ultimate plan. I'm still debating the best place to
pull it from though. For now I am looking at just sampling the Offline
value before calling del_page_from_free_area as I had that currently
clearing the Offline flag when I was clearing the buddy. Then I was
just passing that to the expand function and having it set the Offline
flag.

Since expand is only called if the lower orders are empty there isn't
any point in adding to tail since the list is empty so head == tail
anyway.
