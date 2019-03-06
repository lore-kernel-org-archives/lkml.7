Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D847C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD6120663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccTd2CEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfCFXMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:12:47 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35083 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:12:46 -0500
Received: by mail-it1-f194.google.com with SMTP id 188so12925547itb.0;
        Wed, 06 Mar 2019 15:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yYY+hlDrFnFfX0Lw0YllZ9KuunWzLXQegi/MDoLIIQ=;
        b=ccTd2CEUfadVkqIG5F21ppkpCDRJhwZ3sYqJxWp40HMveZiw+EzC5GaPHkRuOCpSsD
         x0YbSGJUWygD2/GMqjpx3Sx/hxJHRaypd8iPifQsJKeYjJOTWuqYsBNCpCFEAMc9utcz
         zJt7OIAwM3u0iZTkxyJ+y9OAKhTfeIwkmDjsMxLAjyQBfv/H0rQ4aIvtGUELFmltZw/R
         bM++BG9zip81E0geoEqpOMjiyhf+rFmCJNYQnV4Tc3VulYIqUA/QYMfGd9+YzRYuc4Qj
         VFrb4RXnvuh25j1c0bnx5rDK/WAtihwwzOj4omul9UmHE5TPOTpC4a2CSVtx+Nodcqo1
         e74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yYY+hlDrFnFfX0Lw0YllZ9KuunWzLXQegi/MDoLIIQ=;
        b=UKsfMIqHAmLT8xTNMFH6P39l3Kpw8yiqtYaG5ltvonL5Un7o4MQQGMiIxT4C0FnDhR
         1qcHUY5fI3zx0uMQfwsszhiJHNjh2//kcc8yQAurQJaNMZJBJ+YwfEFfNst/Q+5+spsJ
         6cwi/n8zs6Hl/8lUnJkTI+wNzP8jRUNW5N0/BEE0slQ/ccMVsVfpk7pMqZYpJ4cBBiCE
         FZM/YR4mCy2k9lSVI64Mzz3zztJ1oIbxlUdZgj3YlWkzoEQl0aL7WvZoJ0RDLA2sGIN6
         WRXSiHWe6llT5+ozwsG3/V8xPAjIs8fD14QnhL988nS9pkuGqhLakf9tMigF68EdMVRG
         qsuQ==
X-Gm-Message-State: APjAAAVz2V7KFdeAg1zn9R/pDnmwDzbqYPeh8JcFZiQJEwQCjY1dNvvc
        xLBj61uWU28SdH7xjZSh9Yl0nfG1741I0vEDyHs=
X-Google-Smtp-Source: APXvYqzQsJp2+41k/pIeJ0VDstp4dM3UZ2CNqmpIYH9+63MK2mMWrd/7nWmxDo3vKjdieKVRBF6vFO68MeK1xnPtYjc=
X-Received: by 2002:a24:4650:: with SMTP id j77mr3611316itb.6.1551913965195;
 Wed, 06 Mar 2019 15:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com> <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com> <20190306133826-mutt-send-email-mst@kernel.org>
 <3f87916d-8d18-013c-8988-9eb516c9cd2e@redhat.com> <20190306140917-mutt-send-email-mst@kernel.org>
 <9ead968e-0cc6-0061-de5c-42a3cef46339@redhat.com> <20190306165223-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190306165223-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Mar 2019 15:12:33 -0800
Message-ID: <CAKgT0UeN=o0NratKSmhBhBBmwQ06qo9tiU9sqvpq_u8uMZPM1w@mail.gmail.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
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

On Wed, Mar 6, 2019 at 2:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Mar 06, 2019 at 10:40:57PM +0100, David Hildenbrand wrote:
> > On 06.03.19 21:32, Michael S. Tsirkin wrote:
> > > On Wed, Mar 06, 2019 at 07:59:57PM +0100, David Hildenbrand wrote:
> > >> On 06.03.19 19:43, Michael S. Tsirkin wrote:
> > >>> On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> > >>>>>> Here are the results:
> > >>>>>>
> > >>>>>> Procedure: 3 Guests of size 5GB is launched on a single NUMA node with
> > >>>>>> total memory of 15GB and no swap. In each of the guest, memhog is run
> > >>>>>> with 5GB. Post-execution of memhog, Host memory usage is monitored by
> > >>>>>> using Free command.
> > >>>>>>
> > >>>>>> Without Hinting:
> > >>>>>>                  Time of execution    Host used memory
> > >>>>>> Guest 1:        45 seconds            5.4 GB
> > >>>>>> Guest 2:        45 seconds            10 GB
> > >>>>>> Guest 3:        1  minute               15 GB
> > >>>>>>
> > >>>>>> With Hinting:
> > >>>>>>                 Time of execution     Host used memory
> > >>>>>> Guest 1:        49 seconds            2.4 GB
> > >>>>>> Guest 2:        40 seconds            4.3 GB
> > >>>>>> Guest 3:        50 seconds            6.3 GB
> > >>>>> OK so no improvement.
> > >>>> If we are looking in terms of memory we are getting back from the guest,
> > >>>> then there is an improvement. However, if we are looking at the
> > >>>> improvement in terms of time of execution of memhog then yes there is none.
> > >>>
> > >>> Yes but the way I see it you can't overcommit this unused memory
> > >>> since guests can start using it at any time.  You timed it carefully
> > >>> such that this does not happen, but what will cause this timing on real
> > >>> guests?
> > >>
> > >> Whenever you overcommit you will need backup swap.
> > >
> > > Right and the point of hinting is that pages can just be
> > > discarded and not end up in swap.
> > >
> > >
> > > Point is you should be able to see the gain.
> > >
> > > Hinting patches cost some CPU so we need to know whether
> > > they cost too much. How much is too much? When the cost
> > > is bigger than benefit. But we can't compare CPU cycles
> > > to bytes. So we need to benchmark everything in terms of
> > > cycles.
> > >
> > >> There is no way
> > >> around it. It just makes the probability of you having to go to disk
> > >> less likely.
> > >
> > >
> > > Right and let's quantify this. Does this result in net gain or loss?
> >
> > Yes, I am totally with you. But if it is a net benefit heavily depends
> > on the setup. E.g. what kind of storage used for the swap, how fast, is
> > the same disk also used for other I/O ...
> >
> > Also, CPU is a totally different resource than I/O. While you might have
> > plenty of CPU cycles to spare, your I/O throughput might already be
> > limited. Same goes into the other direction.
> >
> > So it might not be as easy as comparing two numbers. It really depends
> > on the setup. Well, not completely true, with 0% CPU overhead we would
> > have a clear winner with hinting ;)
>
> I mean users need to know about this too.
>
> Are these hinting patches a gain:
> - on zram
> - on ssd
> - on a rotating disk
> - none of the above
> ?
>
> If users don't know when would they enable hinting?
>
> Close to one is going to try all possible configurations, test
> exhaustively and find an optimal default for their workload.
> So it's our job to figure it out and provide guidance.

Right. I think for now I will stick to testing on what I have which is
a SSD for swap, and no-overcommit for the "non of the above" case.

BTW it looks like this patch set introduced a pretty heavy penalty for
the no-overcommit case. For a 32G VM with no overcommit a 32G memhog
test is now taking over 50 seconds whereas without the patch set I can
complete the test in around 20 seconds.

> >
> > >
> > >
> > >> If you assume that all of your guests will be using all of their memory
> > >> all the time, you don't have to think about overcommiting memory in the
> > >> first place. But this is not what we usually have.
> > >
> > > Right and swap is there to support overcommit. However it
> > > was felt that hinting can be faster since it avoids IO
> > > involved in swap.
> >
> > Feels like it, I/O is prone to be slow.
> >
> >
> > --
> >
> > Thanks,
> >
> > David / dhildenb
>
> OK so should be measureable.
>
> --
> MST
