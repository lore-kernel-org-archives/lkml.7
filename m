Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17790C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60FE2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfHOTnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbfHOTno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3690B300C72E;
        Thu, 15 Aug 2019 19:43:44 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F4BA177C5;
        Thu, 15 Aug 2019 19:43:41 +0000 (UTC)
Date:   Thu, 15 Aug 2019 15:43:39 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Message-ID: <20190815194339.GC9253@redhat.com>
References: <20190806160554.14046-5-hch@lst.de>
 <20190807174548.GJ1571@mellanox.com>
 <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
 <20190808065933.GA29382@lst.de>
 <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
 <20190814073854.GA27249@lst.de>
 <20190814132746.GE13756@mellanox.com>
 <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
 <20190815180325.GA4920@redhat.com>
 <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 15 Aug 2019 19:43:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 12:36:58PM -0700, Dan Williams wrote:
> On Thu, Aug 15, 2019 at 11:07 AM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Wed, Aug 14, 2019 at 07:48:28AM -0700, Dan Williams wrote:
> > > On Wed, Aug 14, 2019 at 6:28 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Wed, Aug 14, 2019 at 09:38:54AM +0200, Christoph Hellwig wrote:
> > > > > On Tue, Aug 13, 2019 at 06:36:33PM -0700, Dan Williams wrote:
> > > > > > Section alignment constraints somewhat save us here. The only example
> > > > > > I can think of a PMD not containing a uniform pgmap association for
> > > > > > each pte is the case when the pgmap overlaps normal dram, i.e. shares
> > > > > > the same 'struct memory_section' for a given span. Otherwise, distinct
> > > > > > pgmaps arrange to manage their own exclusive sections (and now
> > > > > > subsections as of v5.3). Otherwise the implementation could not
> > > > > > guarantee different mapping lifetimes.
> > > > > >
> > > > > > That said, this seems to want a better mechanism to determine "pfn is
> > > > > > ZONE_DEVICE".
> > > > >
> > > > > So I guess this patch is fine for now, and once you provide a better
> > > > > mechanism we can switch over to it?
> > > >
> > > > What about the version I sent to just get rid of all the strange
> > > > put_dev_pagemaps while scanning? Odds are good we will work with only
> > > > a single pagemap, so it makes some sense to cache it once we find it?
> > >
> > > Yes, if the scan is over a single pmd then caching it makes sense.
> >
> > Quite frankly an easier an better solution is to remove the pagemap
> > lookup as HMM user abide by mmu notifier it means we will not make
> > use or dereference the struct page so that we are safe from any
> > racing hotunplug of dax memory (as long as device driver using hmm
> > do not have a bug).
> 
> Yes, as long as the driver remove is synchronized against HMM
> operations via another mechanism then there is no need to take pagemap
> references. Can you briefly describe what that other mechanism is?

So if you hotunplug some dax memory i assume that this can only
happens once all the pages are unmapped (as it must have the
zero refcount, well 1 because of the bias) and any unmap will
trigger a mmu notifier callback. User of hmm mirror abiding by
the API will never make use of information they get through the
fault or snapshot function until checking for racing notifier
under lock.

Cheers,
Jérôme
