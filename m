Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C10A20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFGijHMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCHVjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:39:49 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39256 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfCHVjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:39:49 -0500
Received: by mail-io1-f67.google.com with SMTP id x3so17968804ior.6;
        Fri, 08 Mar 2019 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ER81jMz6aYwks5XjM3dWpCRuuybUmD81uRR18RYI/cw=;
        b=jFGijHMME0wbRzZZpwiy4attIJJPudFqZM5x4Wyf3EOzMgh4yiNwwJSjLltr9csfl0
         mBDYYh6NF8Pqmm3mrLrVgD0255C7zC/O93EP4N9oJjPhV9DacnvYvByO+sf23+K2g5fw
         c+5u6mRjmQZ56epEkOT5yBaY9UWsVt2EOAs/Gky6t0A09Ycv+iZxy2df9mfFCRNZpp4q
         Lj68V7LWLMlSmocBcpFtOKtz4atLLd/0wH7XCQvFnNLglC6xKSCGPMN6d3Zb1EM2qYVZ
         wmNDVNoYDfcVsK5ra8djPn9uL6slxDnDFvtqIuWqShfcROZyFz2bbZ2g/NHwHFq1Xlyi
         dipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ER81jMz6aYwks5XjM3dWpCRuuybUmD81uRR18RYI/cw=;
        b=s/0B/jYgZ8luCna2kv6nAIw9XBpJFC8JkbGIReJdB7iXx5DCjJJxtLhNh+NA4I05Fl
         fqlq/WL0if7aToiLEPLBOnDm22wVPoBvrcuCrPYfQ66hmj3VdS8b/Okg36NGYY3ren5H
         l1RRUx2WxVJPATUoDSRL0RRWRG5hMcRbKg3rQYwxQJejHc/PvA3OFo7jfHG2LBEhyaOI
         jVw77Ty759Fma2KYDi6gzcCe57/3HFUtgpRiDSotZuNDYzvV9MI505T5sLJIwv65X6Yi
         17Pojky9cJJ2UHycXz+7Ky/fCv657xNfZ4N3tbxJVgMbTnLiwPloV4dlO2GmwCqEiHSX
         xExw==
X-Gm-Message-State: APjAAAXnJAr9aXKtS41WXJ0mjKTYO9TPPrQfvqJbS0lj8QTmJV1hbHlv
        BKNwZgexHGNdW530NkQ58KdMXFDjDn40Fwpwz3U=
X-Google-Smtp-Source: APXvYqw39cp+/C3Zic+uI32cg/tlcNORWlBCMTiteau667jhCugVZWVLu1SuMidywbKgws1aBxMY+/I0bTPtTDXyirY=
X-Received: by 2002:a5e:8403:: with SMTP id h3mr1229443ioj.116.1552081187769;
 Fri, 08 Mar 2019 13:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com> <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
 <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
 <78b604be-2129-a716-a7a6-f5b382c9fb9c@redhat.com> <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
 <20190307212845-mutt-send-email-mst@kernel.org> <CAKgT0Ucu3EMsYBfdKtEiprrn-VBZy3Y+0HdEp5b4PO2SQgGsRw@mail.gmail.com>
 <17d2afa6-556e-ec73-40dc-beac536b3f20@redhat.com> <CAKgT0UcdQZwHjmMBkSWmy_ZdShJCagjwomn13g+r7ZNJBRn1LQ@mail.gmail.com>
 <8f692047-4750-6827-1ee0-d3d354788f09@redhat.com>
In-Reply-To: <8f692047-4750-6827-1ee0-d3d354788f09@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 8 Mar 2019 13:39:36 -0800
Message-ID: <CAKgT0UddT9CKg1uZo6ZODs9ARti-6XGm9Zvo+8QRZKUPSwzWMQ@mail.gmail.com>
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest free pages
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

On Fri, Mar 8, 2019 at 11:39 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> On 3/8/19 2:25 PM, Alexander Duyck wrote:
> > On Fri, Mar 8, 2019 at 11:10 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >>
> >> On 3/8/19 1:06 PM, Alexander Duyck wrote:
> >>> On Thu, Mar 7, 2019 at 6:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>> On Thu, Mar 07, 2019 at 02:35:53PM -0800, Alexander Duyck wrote:
> >>>>> The only other thing I still want to try and see if I can do is to add
> >>>>> a jiffies value to the page private data in the case of the buddy
> >>>>> pages.
> >>>> Actually there's one extra thing I think we should do, and that is make
> >>>> sure we do not leave less than X% off the free memory at a time.
> >>>> This way chances of triggering an OOM are lower.
> >>> If nothing else we could probably look at doing a watermark of some
> >>> sort so we have to have X amount of memory free but not hinted before
> >>> we will start providing the hints. It would just be a matter of
> >>> tracking how much memory we have hinted on versus the amount of memory
> >>> that has been pulled from that pool.
> >> This is to avoid false OOM in the guest?
> > Partially, though it would still be possible. Basically it would just
> > be a way of determining when we have hinted "enough". Basically it
> > doesn't do us much good to be hinting on free memory if the guest is
> > already constrained and just going to reallocate the memory shortly
> > after we hinted on it. The idea is with a watermark we can avoid
> > hinting until we start having pages that are actually going to stay
> > free for a while.
> >
> >>>  It is another reason why we
> >>> probably want a bit in the buddy pages somewhere to indicate if a page
> >>> has been hinted or not as we can then use that to determine if we have
> >>> to account for it in the statistics.
> >> The one benefit which I can see of having an explicit bit is that it
> >> will help us to have a single hook away from the hot path within buddy
> >> merging code (just like your arch_merge_page) and still avoid duplicate
> >> hints while releasing pages.
> >>
> >> I still have to check PG_idle and PG_young which you mentioned but I
> >> don't think we can reuse any existing bits.
> > Those are bits that are already there for 64b. I think those exist in
> > the page extension for 32b systems. If I am not mistaken they are only
> > used in VMA mapped memory. What I was getting at is that those are the
> > bits we could think about reusing.
> >
> >> If we really want to have something like a watermark, then can't we use
> >> zone->free_pages before isolating to see how many free pages are there
> >> and put a threshold on it? (__isolate_free_page() does a similar thing
> >> but it does that on per request basis).
> > Right. That is only part of it though since that tells you how many
> > free pages are there. But how many of those free pages are hinted?
> > That is the part we would need to track separately and then then
> > compare to free_pages to determine if we need to start hinting on more
> > memory or not.
> Only pages which are isolated will be hinted, and once a page is
> isolated it will not be counted in the zone free pages.
> Feel free to correct me if I am wrong.

You are correct up to here. When we isolate the page it isn't counted
against the free pages. However after we complete the hint we end up
taking it out of isolation and returning it to the "free" state, so it
will be counted against the free pages.

> If I am understanding it correctly you only want to hint the idle pages,
> is that right?

Getting back to the ideas from our earlier discussion, we had 3 stages
for things. Free but not hinted, isolated due to hinting, and free and
hinted. So what we would need to do is identify the size of the first
pool that is free and not hinted by knowing the total number of free
pages, and then subtract the size of the pages that are hinted and
still free.

> >
> >>>>> With that we could track the age of the page so it becomes
> >>>>> easier to only target pages that are truly going cold rather than
> >>>>> trying to grab pages that were added to the freelist recently.
> >>>> I like that but I have a vague memory of discussing this with Rik van
> >>>> Riel and him saying it's actually better to take away recently used
> >>>> ones. Can't see why would that be but maybe I remember wrong. Rik - am I
> >>>> just confused?
> >>> It is probably to cut down on the need for disk writes in the case of
> >>> swap. If that is the case it ends up being a trade off.
> >>>
> >>> The sooner we hint the less likely it is that we will need to write a
> >>> given page to disk. However the sooner we hint, the more likely it is
> >>> we will need to trigger a page fault and pull back in a zero page to
> >>> populate the last page we were working on. The sweet spot will be that
> >>> period of time that is somewhere in between so we don't trigger
> >>> unnecessary page faults and we don't need to perform additional swap
> >>> reads/writes.
> >> --
> >> Regards
> >> Nitesh
> >>
> --
> Regards
> Nitesh
>
