Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5F8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11A9206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCGAgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:36:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCGAgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:36:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F4543082E53;
        Thu,  7 Mar 2019 00:36:09 +0000 (UTC)
Received: from redhat.com (ovpn-125-142.rdu2.redhat.com [10.10.125.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65C6B5D9CA;
        Thu,  7 Mar 2019 00:36:08 +0000 (UTC)
Date:   Wed, 6 Mar 2019 19:36:06 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-ID: <20190307003605.GB5528@redhat.com>
References: <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
 <20190130030317.GC10462@redhat.com>
 <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
 <20190130183616.GB5061@redhat.com>
 <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
 <20190131041641.GK5061@redhat.com>
 <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
 <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <20190306154903.GA3230@redhat.com>
 <20190306141820.d60e47d6e173d6ec171f52cf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190306141820.d60e47d6e173d6ec171f52cf@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 07 Mar 2019 00:36:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 02:18:20PM -0800, Andrew Morton wrote:
> On Wed, 6 Mar 2019 10:49:04 -0500 Jerome Glisse <jglisse@redhat.com> wrote:
> 
> > On Tue, Mar 05, 2019 at 02:16:35PM -0800, Andrew Morton wrote:
> > > On Wed, 30 Jan 2019 21:44:46 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> > > 
> > > > >
> > > > > > Another way to help allay these worries is commit to no new exports
> > > > > > without in-tree users. In general, that should go without saying for
> > > > > > any core changes for new or future hardware.
> > > > >
> > > > > I always intend to have an upstream user the issue is that the device
> > > > > driver tree and the mm tree move a different pace and there is always
> > > > > a chicken and egg problem. I do not think Andrew wants to have to
> > > > > merge driver patches through its tree, nor Linus want to have to merge
> > > > > drivers and mm trees in specific order. So it is easier to introduce
> > > > > mm change in one release and driver change in the next. This is what
> > > > > i am doing with ODP. Adding things necessary in 5.1 and working with
> > > > > Mellanox to have the ODP HMM patch fully tested and ready to go in
> > > > > 5.2 (the patch is available today and Mellanox have begin testing it
> > > > > AFAIK). So this is the guideline i will be following. Post mm bits
> > > > > with driver patches, push to merge mm bits one release and have the
> > > > > driver bits in the next. I do hope this sound fine to everyone.
> > > > 
> > > > The track record to date has not been "merge HMM patch in one release
> > > > and merge the driver updates the next". If that is the plan going
> > > > forward that's great, and I do appreciate that this set came with
> > > > driver changes, and maintain hope the existing exports don't go
> > > > user-less for too much longer.
> > > 
> > > Decision time.  Jerome, how are things looking for getting these driver
> > > changes merged in the next cycle?
> > 
> > nouveau is merge already.
> 
> Confused.  Nouveau in mainline is dependent upon "mm/hmm: allow to
> mirror vma of a file on a DAX backed filesystem"?  That can't be the
> case?

Not really, HMM mirror is about mirroring address space onto the device
so if mirroring does not work for file that are on a filesystem that use
DAX it fails in un-expected way from user point of view. But as nouveau
is just getting upstrean you can argue that no one previously depended
on that working for file backed page on DAX filesystem.

Now the ODP RDMA case is different, what is upstream today works on DAX
so if that patch is not upstream in 5.1 then i can not merge HMM ODP in
5.2 as it would regress and the ODP people would not take the risk of
regression ie ODP folks want the DAX support to be upstream first.

> 
> > > 
> > > Dan, what's your overall take on this series for a 5.1-rc1 merge?
> > > 
> > > Jerome, what would be the risks in skipping just this [09/10] patch?
> > 
> > As nouveau is a new user it does not regress anything but for RDMA
> > mlx5 (which i expect to merge new window) it would regress that
> > driver.
> 
> Also confused.  How can omitting "mm/hmm: allow to mirror vma of a file
> on a DAX backed filesystem" from 5.1-rc1 cause an mlx5 regression?

Not in 5.1 but i can not merge HMM ODP in 5.2 if that is not in 5.1.
I know this circular dependency between sub-system is painful but i
do not see any simpler way.

Cheers,
Jérôme
