Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061ACC10F09
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB07920643
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551824200;
	bh=ncsXmKXmMkk5Earq8UB9ne6xK71c4d4s06KyjYjwkPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ajSDetHLDoub4iKKsoLy1kz7LtasUIewhAYpJOEZQsl5K4MYQabBAp6xiLPsQuZln
	 WvGR21zEro2kCwdxkkrRe+v9PTEyyhUmOKGEBlbgn24pOwpK8UAPBO5bJRNLsq6nHW
	 YY4PGko/xIARVHQe66l/kF5sdqEVFYeBH6bzRieo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfCEWQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:16:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfCEWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:16:38 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF4F3102C5;
        Tue,  5 Mar 2019 22:16:36 +0000 (UTC)
Date:   Tue, 5 Mar 2019 14:16:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-Id: <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
In-Reply-To: <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
References: <20190129165428.3931-10-jglisse@redhat.com>
        <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
        <20190129193123.GF3176@redhat.com>
        <CAPcyv4gkYTZ-_Et1ZriAcoHwhtPEftOt2LnR_kW+hQM5-0G4HA@mail.gmail.com>
        <20190129212150.GP3176@redhat.com>
        <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
        <20190130030317.GC10462@redhat.com>
        <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
        <20190130183616.GB5061@redhat.com>
        <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
        <20190131041641.GK5061@redhat.com>
        <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 21:44:46 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> >
> > > Another way to help allay these worries is commit to no new exports
> > > without in-tree users. In general, that should go without saying for
> > > any core changes for new or future hardware.
> >
> > I always intend to have an upstream user the issue is that the device
> > driver tree and the mm tree move a different pace and there is always
> > a chicken and egg problem. I do not think Andrew wants to have to
> > merge driver patches through its tree, nor Linus want to have to merge
> > drivers and mm trees in specific order. So it is easier to introduce
> > mm change in one release and driver change in the next. This is what
> > i am doing with ODP. Adding things necessary in 5.1 and working with
> > Mellanox to have the ODP HMM patch fully tested and ready to go in
> > 5.2 (the patch is available today and Mellanox have begin testing it
> > AFAIK). So this is the guideline i will be following. Post mm bits
> > with driver patches, push to merge mm bits one release and have the
> > driver bits in the next. I do hope this sound fine to everyone.
> 
> The track record to date has not been "merge HMM patch in one release
> and merge the driver updates the next". If that is the plan going
> forward that's great, and I do appreciate that this set came with
> driver changes, and maintain hope the existing exports don't go
> user-less for too much longer.

Decision time.  Jerome, how are things looking for getting these driver
changes merged in the next cycle?

Dan, what's your overall take on this series for a 5.1-rc1 merge?

Jerome, what would be the risks in skipping just this [09/10] patch?
