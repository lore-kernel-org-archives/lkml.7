Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6721C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A842D21783
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfI0FO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:14:29 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:60298 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfI0FO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:14:29 -0400
Received: from mail2.nmnhosting.com (unknown [202.78.40.170])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 0C2522DC009C;
        Fri, 27 Sep 2019 01:14:24 -0400 (EDT)
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x8R5E5Gx002542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Sep 2019 15:14:21 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <d98c05cde18e6f64afa98d6d771399c8e4883eb8.camel@d-silva.org>
Subject: Re: [PATCH v4] memory_hotplug: Add a bounds check to __add_pages
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Sep 2019 15:14:05 +1000
In-Reply-To: <20190926075307.GB17200@linux>
References: <20190926013406.16133-1-alastair@au1.ibm.com>
         <20190926013406.16133-2-alastair@au1.ibm.com>
         <20190926075307.GB17200@linux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Sep 2019 15:14:22 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-26 at 09:53 +0200, Oscar Salvador wrote:
> On Thu, Sep 26, 2019 at 11:34:05AM +1000, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > On PowerPC, the address ranges allocated to OpenCAPI LPC memory
> > are allocated from firmware. These address ranges may be higher
> > than what older kernels permit, as we increased the maximum
> > permissable address in commit 4ffe713b7587
> > ("powerpc/mm: Increase the max addressable memory to 2PB"). It is
> > possible that the addressable range may change again in the
> > future.
> > 
> > In this scenario, we end up with a bogus section returned from
> > __section_nr (see the discussion on the thread "mm: Trigger bug on
> > if a section is not found in __section_nr").
> > 
> > Adding a check here means that we fail early and have an
> > opportunity to handle the error gracefully, rather than rumbling
> > on and potentially accessing an incorrect section.
> > 
> > Further discussion is also on the thread ("powerpc: Perform a
> > bounds
> > check in arch_add_memory")
> > http://lkml.kernel.org/r/20190827052047.31547-1-alastair@au1.ibm.com
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> Just a nit-picking below:
> 
> > ---
> >  mm/memory_hotplug.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index c73f09913165..212804c0f7f5 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long pfn,
> > unsigned long nr_pages,
> >  	return 0;
> >  }
> >  
> > +static int check_hotplug_memory_addressable(unsigned long pfn,
> > +					    unsigned long nr_pages)
> > +{
> > +	unsigned long max_addr = ((pfn + nr_pages) << PAGE_SHIFT) - 1;
> 
> I would use PFN_PHYS instead:
> 
> 	unsigned long max_addr = PFN_PHYS(pfn + nr_pages) - 1;
> 
> > +
> > +	if (max_addr >> MAX_PHYSMEM_BITS) {
> > +		WARN(1,
> > +		     "Hotplugged memory exceeds maximum addressable
> > address, range=%#lx-%#lx, maximum=%#lx\n",
> > +		     pfn << PAGE_SHIFT, max_addr,
> 
> Same here.
> 
> > +		     (1ul << (MAX_PHYSMEM_BITS + 1)) - 1);
> 
> I would use a local variable to hold this computation.
> 
> > +		return -E2BIG;
> > +	}
> > +
> > +	return 0;


Looks like I'll have to do another spin to change that to a ull anyway,
so I'll implement those suggestions.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


