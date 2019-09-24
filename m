Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CEBC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028D1214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569316180;
	bh=ZqGIqkHrAqpWl/J1W/neTC3vAj1oCwflSsNbpd47qb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PsDmHRILSEMCEs8vh8xaHGEVm1AgOBY0cB0wNPhbbJkkKFc+K+xlKBLpI3mQcYNLM
	 PAh965wfyUEfnOqj4nMqoqY4qHedRALGV+g/RkMYZnVCXBVbKXb3gZe2/54aMcbWKS
	 uSxhNr8cBj95CrHLv4hReeNxQhlmU35m7DicAylY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504085AbfIXJJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:09:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394970AbfIXJJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D58DAC32;
        Tue, 24 Sep 2019 09:09:36 +0000 (UTC)
Date:   Tue, 24 Sep 2019 11:09:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] memory_hotplug: Add a bounds check to
 check_hotplug_memory_range()
Message-ID: <20190924090934.GF23050@dhcp22.suse.cz>
References: <20190917010752.28395-1-alastair@au1.ibm.com>
 <20190917010752.28395-2-alastair@au1.ibm.com>
 <20190923122513.GO6016@dhcp22.suse.cz>
 <25e0af4cb24a41466032d704b89d25559e7ad968.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e0af4cb24a41466032d704b89d25559e7ad968.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 11:31:05, Alastair D'Silva wrote:
> On Mon, 2019-09-23 at 14:25 +0200, Michal Hocko wrote:
> > On Tue 17-09-19 11:07:47, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > On PowerPC, the address ranges allocated to OpenCAPI LPC memory
> > > are allocated from firmware. These address ranges may be higher
> > > than what older kernels permit, as we increased the maximum
> > > permissable address in commit 4ffe713b7587
> > > ("powerpc/mm: Increase the max addressable memory to 2PB"). It is
> > > possible that the addressable range may change again in the
> > > future.
> > > 
> > > In this scenario, we end up with a bogus section returned from
> > > __section_nr (see the discussion on the thread "mm: Trigger bug on
> > > if a section is not found in __section_nr").
> > > 
> > > Adding a check here means that we fail early and have an
> > > opportunity to handle the error gracefully, rather than rumbling
> > > on and potentially accessing an incorrect section.
> > > 
> > > Further discussion is also on the thread ("powerpc: Perform a
> > > bounds
> > > check in arch_add_memory").
> > 
> > It would be nicer to refer to this by a message-id based url.
> > E.g. 
> > http://lkml.kernel.org/r/20190827052047.31547-1-alastair@au1.ibm.com
> > 
> 
> Ok.
> 
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > ---
> > >  include/linux/memory_hotplug.h |  1 +
> > >  mm/memory_hotplug.c            | 13 ++++++++++++-
> > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/memory_hotplug.h
> > > b/include/linux/memory_hotplug.h
> > > index f46ea71b4ffd..bc477e98a310 100644
> > > --- a/include/linux/memory_hotplug.h
> > > +++ b/include/linux/memory_hotplug.h
> > > @@ -110,6 +110,7 @@ extern void
> > > __online_page_increment_counters(struct page *page);
> > >  extern void __online_page_free(struct page *page);
> > >  
> > >  extern int try_online_node(int nid);
> > > +int check_hotplug_memory_addressable(u64 start, u64 size);
> > >  
> > >  extern int arch_add_memory(int nid, u64 start, u64 size,
> > >  			struct mhp_restrictions *restrictions);
> > > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > > index c73f09913165..02cb9a74f561 100644
> > > --- a/mm/memory_hotplug.c
> > > +++ b/mm/memory_hotplug.c
> > > @@ -1030,6 +1030,17 @@ int try_online_node(int nid)
> > >  	return ret;
> > >  }
> > >  
> > > +int check_hotplug_memory_addressable(u64 start, u64 size)
> > > +{
> > > +#ifdef MAX_PHYSMEM_BITS
> > > +	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
> > > +		return -E2BIG;
> > > +#endif
> > 
> > Is there any arch which doesn't define this? We seemed to be using
> > this
> > in sparsemem code without any ifdefs.
> 
> A few, but none of them would be enabling hotplug (which depends on
> sparsemem), so you're right, the ifdef could be removed.
> 
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);
> > 
> > If you squashed the patch 2 then it would become clear why this needs
> > to
> > be exported because you would have a driver user. I find it a bit
> > unfortunate to expect that any driver which uses the hotplug code is
> > expected to know that this check should be called. This sounds too
> > error
> > prone. Why hasn't been this done at __add_pages layer?
> > 
> 
> It seemed that is should be a peer of check_hotplug_memory_range(), as
> it gives similar feedback (whether the provided range is suitable).

Well, that one seems to do a similar yet a different kind of check. It
imposes a constrain to the alignment of the memory that is hotplugable
via add_memory_resource - aka memory with user visible sysfs interface
and that really has some restrictions on the memory block sizes now.
 
> If we did the check in __add_pages, wouldn't we potentially lose bits
> from the LSBs of start & size, or is there some other requirement that
> already ensures start & size are always page aligned?

I do not really think we have to care about page unaligned addresses.
Callers down the road usually work with pfns. 

> It appears this patch has been accepted - if we were to make this
> change, does it go as another spin on this series or a new series?

yes, the patch has been rushed to Linus unfortunatelly. Although I do
not really see any reason why. Sigh...
Anyway, now that it is in Linus' tree then we can only do a follow up on
top.

> > > +
> > >  static int check_hotplug_memory_range(u64 start, u64 size)
> > >  {
> > >  	/* memory range must be block size aligned */
> > > @@ -1040,7 +1051,7 @@ static int check_hotplug_memory_range(u64
> > > start, u64 size)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	return 0;
> > > +	return check_hotplug_memory_addressable(start, size);
> > 
> > This will result in a silent failure (unlike misaligned case). Is
> > this
> > what we want?
> 
> Good point - I guess it comes down to, is there anything we expect an
> end user to do about it? I'm not sure there is, in which case the bad
> RC, which is reported up every call chain that I can see, should be
> sufficient.

It seems like a clear HW/platform bug to me. And that should better be
reported loudly to the log to make sure people do complain to their FW
friends and have it fixed.

-- 
Michal Hocko
SUSE Labs
