Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B84C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF87221850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfC1Wkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfC1Wkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:40:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F271D307D85B;
        Thu, 28 Mar 2019 22:40:35 +0000 (UTC)
Received: from redhat.com (ovpn-121-118.rdu2.redhat.com [10.10.121.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBA655C223;
        Thu, 28 Mar 2019 22:40:34 +0000 (UTC)
Date:   Thu, 28 Mar 2019 18:40:32 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/11] mm/hmm: add helpers for driver to safely take
 the mmap_sem v2
Message-ID: <20190328224032.GH13560@redhat.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-11-jglisse@redhat.com>
 <9df742eb-61ca-3629-a5f4-8ad1244ff840@nvidia.com>
 <20190328213047.GB13560@redhat.com>
 <a16efd42-3e2b-1b72-c205-0c2659de2750@nvidia.com>
 <20190328220824.GE13560@redhat.com>
 <068db0a8-fade-8ed1-3b9d-c29c27797301@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <068db0a8-fade-8ed1-3b9d-c29c27797301@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 28 Mar 2019 22:40:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:25:39PM -0700, John Hubbard wrote:
> On 3/28/19 3:08 PM, Jerome Glisse wrote:
> > On Thu, Mar 28, 2019 at 02:41:02PM -0700, John Hubbard wrote:
> >> On 3/28/19 2:30 PM, Jerome Glisse wrote:
> >>> On Thu, Mar 28, 2019 at 01:54:01PM -0700, John Hubbard wrote:
> >>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> >>>>> From: Jérôme Glisse <jglisse@redhat.com>
> [...]
> >>
> >>>>
> >>>> If you insist on having this wrapper, I think it should have approximately 
> >>>> this form:
> >>>>
> >>>> void hmm_mirror_mm_down_read(...)
> >>>> {
> >>>> 	WARN_ON(...)
> >>>> 	down_read(...)
> >>>> } 
> >>>
> >>> I do insist as it is useful and use by both RDMA and nouveau and the
> >>> above would kill the intent. The intent is do not try to take the lock
> >>> if the process is dying.
> >>
> >> Could you provide me a link to those examples so I can take a peek? I
> >> am still convinced that this whole thing is a race condition at best.
> > 
> > The race is fine and ok see:
> > 
> > https://cgit.freedesktop.org/~glisse/linux/commit/?h=hmm-odp-v2&id=eebd4f3095290a16ebc03182e2d3ab5dfa7b05ec
> > 
> > which has been posted and i think i provided a link in the cover
> > letter to that post. The same patch exist for nouveau i need to
> > cleanup that tree and push it.
> 
> Thanks for that link, and I apologize for not keeping up with that
> other review thread.
> 
> Looking it over, hmm_mirror_mm_down_read() is only used in one place.
> So, what you really want there is not a down_read() wrapper, but rather,
> something like
> 
> 	hmm_sanity_check()
> 
> , that ib_umem_odp_map_dma_pages() calls.

Why ? The device driver pattern is:
    if (hmm_is_it_dying()) {
        // handle when process die and abort the fault ie useless
        // to call within HMM
    }
    down_read(mmap_sem);

This pattern is common within nouveau and RDMA and other device driver in
the work. Hence why i am replacing it with just one helper. Also it has the
added benefit that changes being discussed around the mmap sem will be easier
to do as it avoid having to update each driver but instead it can be done
just once for the HMM helpers.

> 
> 
> > 
> >>>
> >>>
> >>>>
> >>>>> +{
> >>>>> +	struct mm_struct *mm;
> >>>>> +
> >>>>> +	/* Sanity check ... */
> >>>>> +	if (!mirror || !mirror->hmm)
> >>>>> +		return -EINVAL;
> >>>>> +	/*
> >>>>> +	 * Before trying to take the mmap_sem make sure the mm is still
> >>>>> +	 * alive as device driver context might outlive the mm lifetime.
> >>>>
> >>>> Let's find another way, and a better place, to solve this problem.
> >>>> Ref counting?
> >>>
> >>> This has nothing to do with refcount or use after free or anthing
> >>> like that. It is just about checking wether we are about to do
> >>> something pointless. If the process is dying then it is pointless
> >>> to try to take the lock and it is pointless for the device driver
> >>> to trigger handle_mm_fault().
> >>
> >> Well, what happens if you let such pointless code run anyway? 
> >> Does everything still work? If yes, then we don't need this change.
> >> If no, then we need a race-free version of this change.
> > 
> > Yes everything work, nothing bad can happen from a race, it will just
> > do useless work which never hurt anyone.
> > 
> 
> OK, so let's either drop this patch, or if merge windows won't allow that,
> then *eventually* drop this patch. And instead, put in a hmm_sanity_check()
> that does the same checks.

RDMA depends on this, so does the nouveau patchset that convert to new API.
So i do not see reason to drop this. They are user for this they are posted
and i hope i explained properly the benefit.

It is a common pattern. Yes it only save couple lines of code but down the
road i will also help for people working on the mmap_sem patchset.


Cheers,
Jérôme
