Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A1C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9001420675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCFQD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:03:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCFQD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:03:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2734D307E044;
        Wed,  6 Mar 2019 16:03:26 +0000 (UTC)
Received: from redhat.com (ovpn-125-142.rdu2.redhat.com [10.10.125.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F8621001DF0;
        Wed,  6 Mar 2019 16:03:25 +0000 (UTC)
Date:   Wed, 6 Mar 2019 11:03:23 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-ID: <20190306160323.GD3230@redhat.com>
References: <20190130030317.GC10462@redhat.com>
 <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
 <20190130183616.GB5061@redhat.com>
 <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
 <20190131041641.GK5061@redhat.com>
 <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
 <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
 <20190306155126.GB3230@redhat.com>
 <CAPcyv4iB+7LF-ZOF1VXE+g2hS7Gb=+RbGAmTiGWDsaikEuXGYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iB+7LF-ZOF1VXE+g2hS7Gb=+RbGAmTiGWDsaikEuXGYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 06 Mar 2019 16:03:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 07:57:30AM -0800, Dan Williams wrote:
> On Wed, Mar 6, 2019 at 7:51 AM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Tue, Mar 05, 2019 at 08:20:10PM -0800, Dan Williams wrote:
> > > On Tue, Mar 5, 2019 at 2:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 30 Jan 2019 21:44:46 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > > >
> > > > > > > Another way to help allay these worries is commit to no new exports
> > > > > > > without in-tree users. In general, that should go without saying for
> > > > > > > any core changes for new or future hardware.
> > > > > >
> > > > > > I always intend to have an upstream user the issue is that the device
> > > > > > driver tree and the mm tree move a different pace and there is always
> > > > > > a chicken and egg problem. I do not think Andrew wants to have to
> > > > > > merge driver patches through its tree, nor Linus want to have to merge
> > > > > > drivers and mm trees in specific order. So it is easier to introduce
> > > > > > mm change in one release and driver change in the next. This is what
> > > > > > i am doing with ODP. Adding things necessary in 5.1 and working with
> > > > > > Mellanox to have the ODP HMM patch fully tested and ready to go in
> > > > > > 5.2 (the patch is available today and Mellanox have begin testing it
> > > > > > AFAIK). So this is the guideline i will be following. Post mm bits
> > > > > > with driver patches, push to merge mm bits one release and have the
> > > > > > driver bits in the next. I do hope this sound fine to everyone.
> > > > >
> > > > > The track record to date has not been "merge HMM patch in one release
> > > > > and merge the driver updates the next". If that is the plan going
> > > > > forward that's great, and I do appreciate that this set came with
> > > > > driver changes, and maintain hope the existing exports don't go
> > > > > user-less for too much longer.
> > > >
> > > > Decision time.  Jerome, how are things looking for getting these driver
> > > > changes merged in the next cycle?
> > > >
> > > > Dan, what's your overall take on this series for a 5.1-rc1 merge?
> > >
> > > My hesitation would be drastically reduced if there was a plan to
> > > avoid dangling unconsumed symbols and functionality. Specifically one
> > > or more of the following suggestions:
> > >
> > > * EXPORT_SYMBOL_GPL on all exports to avoid a growing liability
> > > surface for out-of-tree consumers to come grumble at us when we
> > > continue to refactor the kernel as we are wont to do.
> > >
> > > * A commitment to consume newly exported symbols in the same merge
> > > window, or the following merge window. When that goal is missed revert
> > > the functionality until such time that it can be consumed, or
> > > otherwise abandoned.
> > >
> > > * No new symbol exports and functionality while existing symbols go unconsumed.
> > >
> > > These are the minimum requirements I would expect my work, or any
> > > core-mm work for that matter, to be held to, I see no reason why HMM
> > > could not meet the same.
> >
> > nouveau use all of this and other driver patchset have been posted to
> > also use this API.
> >
> > > On this specific patch I would ask that the changelog incorporate the
> > > motivation that was teased out of our follow-on discussion, not "There
> > > is no reason not to support that case." which isn't a justification.
> >
> > mlx5 wants to use HMM without DAX support it would regress mlx5. Other
> > driver like nouveau also want to access DAX filesystem. So yes there is
> > no reason not to support DAX filesystem. Why do you not want DAX with
> > mirroring ? You want to cripple HMM ? Why ?
> 
> There is a misunderstanding... my request for this patch was to update
> the changelog to describe the merits of DAX mirroring to replace the
> "There is no reason not to support that case." Otherwise someone
> reading this changelog in a year will wonder what the motivation was.

So what about:

HMM mirroring allow device to mirror process address onto device
there is no reason for that mirroring to not work if the virtual
address are the result of an mmap of a file on DAX enabled file-
system.
