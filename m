Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F8C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04372087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfECNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:00:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfECNAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 317A5AE63;
        Fri,  3 May 2019 13:00:32 +0000 (UTC)
Date:   Fri, 3 May 2019 15:00:29 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
Message-ID: <20190503130023.GA22564@linux>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
 <CAPcyv4g+KNu=upejy7Xm=jWR0cdhygPAdSRbkfFGpJeHFGc4+w@mail.gmail.com>
 <bd76cb2f-7cdc-f11b-11ec-285862db66f3@arm.com>
 <CA+CK2bBS5Csz0O9sDVwt_NjtrBtLaMfkycjhaOmR7mXoKJ5XEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBS5Csz0O9sDVwt_NjtrBtLaMfkycjhaOmR7mXoKJ5XEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 08:57:09AM -0400, Pavel Tatashin wrote:
> On Fri, May 3, 2019 at 6:35 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 03/05/2019 01:41, Dan Williams wrote:
> > > On Thu, May 2, 2019 at 7:53 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> > >>
> > >> On Wed, Apr 17, 2019 at 2:52 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >>>
> > >>> Up-level the local section size and mask from kernel/memremap.c to
> > >>> global definitions.  These will be used by the new sub-section hotplug
> > >>> support.
> > >>>
> > >>> Cc: Michal Hocko <mhocko@suse.com>
> > >>> Cc: Vlastimil Babka <vbabka@suse.cz>
> > >>> Cc: Jérôme Glisse <jglisse@redhat.com>
> > >>> Cc: Logan Gunthorpe <logang@deltatee.com>
> > >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >>
> > >> Should be dropped from this series as it has been replaced by a very
> > >> similar patch in the mainline:
> > >>
> > >> 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
> > >>   mm/memremap: Rename and consolidate SECTION_SIZE
> > >
> > > I saw that patch fly by and acked it, but I have not seen it picked up
> > > anywhere. I grabbed latest -linus and -next, but don't see that
> > > commit.
> > >
> > > $ git show 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
> > > fatal: bad object 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
> >
> > Yeah, I don't recognise that ID either, nor have I had any notifications
> > that Andrew's picked up anything of mine yet :/
> 
> Sorry for the confusion. I thought I checked in a master branch, but
> turns out I checked in a branch where I applied arm hotremove patches
> and Robin's patch as well. These two patches are essentially the same,
> so which one goes first the other should be dropped.
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Hey Pavel,

just a friendly note :-) :

you are reviewing v6, I think you might want to review v7 [1] instead ;-)?

[1] https://patchwork.kernel.org/cover/10926035/
 

-- 
Oscar Salvador
SUSE L3
