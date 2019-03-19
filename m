Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BFB206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSNaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:30:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfCSNaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:30:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 970AF308426A;
        Tue, 19 Mar 2019 13:30:07 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D92DF1001DF7;
        Tue, 19 Mar 2019 13:30:06 +0000 (UTC)
Date:   Tue, 19 Mar 2019 09:30:05 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 07/10] mm/hmm: add an helper function that fault pages
 and map them to a device
Message-ID: <20190319133004.GA3437@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-8-jglisse@redhat.com>
 <CAA9_cmcN+8B_tyrxRy5MMr-AybcaDEEWB4J8dstY6h0cmFxi3g@mail.gmail.com>
 <20190318204134.GD6786@redhat.com>
 <CAPcyv4he6v5JQMucezZV4J3i+Ea-i7AsaGpCOnc4f-stCrhGag@mail.gmail.com>
 <20190318221515.GA6664@redhat.com>
 <CAPcyv4gYUfEDSsGa_e1v8hqHyyvX8pEc75=G33aaQ6EWG3pSZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gYUfEDSsGa_e1v8hqHyyvX8pEc75=G33aaQ6EWG3pSZA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 19 Mar 2019 13:30:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:29:45PM -0700, Dan Williams wrote:
> On Mon, Mar 18, 2019 at 3:15 PM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Mon, Mar 18, 2019 at 02:30:15PM -0700, Dan Williams wrote:
> > > On Mon, Mar 18, 2019 at 1:41 PM Jerome Glisse <jglisse@redhat.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2019 at 01:21:00PM -0700, Dan Williams wrote:
> > > > > On Tue, Jan 29, 2019 at 8:55 AM <jglisse@redhat.com> wrote:
> > > > > >
> > > > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > > > >
> > > > > > This is a all in one helper that fault pages in a range and map them to
> > > > > > a device so that every single device driver do not have to re-implement
> > > > > > this common pattern.
> > > > >
> > > > > Ok, correct me if I am wrong but these seem effectively be the typical
> > > > > "get_user_pages() + dma_map_page()" pattern that non-HMM drivers would
> > > > > follow. Could we just teach get_user_pages() to take an HMM shortcut
> > > > > based on the range?
> > > > >
> > > > > I'm interested in being able to share code across drivers and not have
> > > > > to worry about the HMM special case at the api level.
> > > > >
> > > > > And to be clear this isn't an anti-HMM critique this is a "yes, let's
> > > > > do this, but how about a more fundamental change".
> > > >
> > > > It is a yes and no, HMM have the synchronization with mmu notifier
> > > > which is not common to all device driver ie you have device driver
> > > > that do not synchronize with mmu notifier and use GUP. For instance
> > > > see the range->valid test in below code this is HMM specific and it
> > > > would not apply to GUP user.
> > > >
> > > > Nonetheless i want to remove more HMM code and grow GUP to do some
> > > > of this too so that HMM and non HMM driver can share the common part
> > > > (under GUP). But right now updating GUP is a too big endeavor.
> > >
> > > I'm open to that argument, but that statement then seems to indicate
> > > that these apis are indeed temporary. If the end game is common api
> > > between HMM and non-HMM drivers then I think these should at least
> > > come with /* TODO: */ comments about what might change in the future,
> > > and then should be EXPORT_SYMBOL_GPL since they're already planning to
> > > be deprecated. They are a point in time export for a work-in-progress
> > > interface.
> >
> > The API is not temporary it will stay the same ie the device driver
> > using HMM would not need further modification. Only the inner working
> > of HMM would be ported over to use improved common GUP. But GUP has
> > few shortcoming today that would be a regression for HMM:
> >     - huge page handling (ie dma mapping huge page not 4k chunk of
> >       huge page)
> >     - not incrementing page refcount for HMM (other user like user-
> >       faultd also want a GUP without FOLL_GET because they abide by
> >       mmu notifier)
> >     - support for device memory without leaking it ie restrict such
> >       memory to caller that can handle it properly and are fully
> >       aware of the gotcha that comes with it
> >     ...
> 
> ...but this is backwards because the end state is 2 driver interfaces
> for dealing with page mappings instead of one. My primary critique of
> HMM is that it creates a parallel universe of HMM apis rather than
> evolving the existing core apis.

Just to make it clear here is pseudo code:
    gup_range_dma_map() {...}

    hmm_range_dma_map() {
        hmm_specific_prep_step();
        gup_range_dma_map();
        hmm_specific_post_step();
    }

Like i said HMM do have the synchronization with mmu notifier to take
care of and other user of GUP and dma map pattern do not care about
that. Hence why not everything can be share between device driver that
can not do mmu notifier and other.

Is that not acceptable to you ? Should every driver duplicate the code
HMM factorize ?


> > So before converting HMM to use common GUP code under-neath those GUP
> > shortcoming (from HMM POV) need to be addressed and at the same time
> > the common dma map pattern can be added as an extra GUP helper.
> 
> If the HMM special cases are not being absorbed into the core-mm over
> time then I think this is going in the wrong direction. Specifically a
> direction that increases the long term maintenance burden over time as
> HMM drivers stay needlessly separated.

HMM is core mm and other thing like GUP do not need to absord all of HMM
as it would be forcing down on them mmu notifier and those other user can
not leverage mmu notifier. So forcing down something that is useless on
other is pointless, don't you agree ?

> 
> > The issue is that some of the above changes need to be done carefully
> > to not impact existing GUP users. So i rather clear some of my plate
> > before starting chewing on this carefully.
> 
> I urge you to put this kind of consideration first and not "merge
> first, ask hard questions later".

There is no hard question here. GUP does not handle THP optimization and
other thing HMM and ODP has. Adding this to GUP need to be done carefully
to not break existing GUP user. So i taking a small step approach since
when that is a bad thing. First merge HMM and ODP together then push down
common thing into GUP. It is a lot safer than a huge jump.

> 
> > Also doing this patch first and then the GUP thing solve the first user
> > problem you have been asking for. With that code in first the first user
> > of the GUP convertion will be all the devices that use those two HMM
> > functions. In turn the first user of that code is the ODP RDMA patch
> > i already posted. Second will be nouveau once i tackle out some nouveau
> > changes. I expect amdgpu to come close third as a user and other device
> > driver who are working on HMM integration to come shortly after.
> 
> I appreciate that it has users, but the point of having users is so
> that the code review can actually be fruitful to see if the
> infrastructure makes sense, and in this case it seems to be
> duplicating an existing common pattern in the kernel.

It is not duplicating anything i am removing code at the end if you
include the odp convertion patch and i will remove more code once
i am done with nouveau changes, and again more code once other driver
catchup.

Cheers,
Jérôme
