Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A73C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD7A20820
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408418AbfIXBb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:31:27 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:55522 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391730AbfIXBb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:31:26 -0400
Received: from mail2.nmnhosting.com (unknown [202.78.40.170])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 9D5A92DC0082;
        Mon, 23 Sep 2019 21:31:25 -0400 (EDT)
Received: from adsilva.ozlabs.ibm.com (static-82-10.transact.net.au [122.99.82.10] (may be forged))
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x8O1V6Jl029002
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Sep 2019 11:31:21 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
Message-ID: <25e0af4cb24a41466032d704b89d25559e7ad968.camel@d-silva.org>
Subject: Re: [PATCH v3 1/2] memory_hotplug: Add a bounds check to
 check_hotplug_memory_range()
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     Michal Hocko <mhocko@kernel.org>
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
Date:   Tue, 24 Sep 2019 11:31:05 +1000
In-Reply-To: <20190923122513.GO6016@dhcp22.suse.cz>
References: <20190917010752.28395-1-alastair@au1.ibm.com>
         <20190917010752.28395-2-alastair@au1.ibm.com>
         <20190923122513.GO6016@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Tue, 24 Sep 2019 11:31:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-23 at 14:25 +0200, Michal Hocko wrote:
> On Tue 17-09-19 11:07:47, Alastair D'Silva wrote:
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
> > check in arch_add_memory").
> 
> It would be nicer to refer to this by a message-id based url.
> E.g. 
> http://lkml.kernel.org/r/20190827052047.31547-1-alastair@au1.ibm.com
> 

Ok.

> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  include/linux/memory_hotplug.h |  1 +
> >  mm/memory_hotplug.c            | 13 ++++++++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/memory_hotplug.h
> > b/include/linux/memory_hotplug.h
> > index f46ea71b4ffd..bc477e98a310 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -110,6 +110,7 @@ extern void
> > __online_page_increment_counters(struct page *page);
> >  extern void __online_page_free(struct page *page);
> >  
> >  extern int try_online_node(int nid);
> > +int check_hotplug_memory_addressable(u64 start, u64 size);
> >  
> >  extern int arch_add_memory(int nid, u64 start, u64 size,
> >  			struct mhp_restrictions *restrictions);
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index c73f09913165..02cb9a74f561 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1030,6 +1030,17 @@ int try_online_node(int nid)
> >  	return ret;
> >  }
> >  
> > +int check_hotplug_memory_addressable(u64 start, u64 size)
> > +{
> > +#ifdef MAX_PHYSMEM_BITS
> > +	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
> > +		return -E2BIG;
> > +#endif
> 
> Is there any arch which doesn't define this? We seemed to be using
> this
> in sparsemem code without any ifdefs.

A few, but none of them would be enabling hotplug (which depends on
sparsemem), so you're right, the ifdef could be removed.

> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);
> 
> If you squashed the patch 2 then it would become clear why this needs
> to
> be exported because you would have a driver user. I find it a bit
> unfortunate to expect that any driver which uses the hotplug code is
> expected to know that this check should be called. This sounds too
> error
> prone. Why hasn't been this done at __add_pages layer?
> 

It seemed that is should be a peer of check_hotplug_memory_range(), as
it gives similar feedback (whether the provided range is suitable).

If we did the check in __add_pages, wouldn't we potentially lose bits
from the LSBs of start & size, or is there some other requirement that
already ensures start & size are always page aligned?

It appears this patch has been accepted - if we were to make this
change, does it go as another spin on this series or a new series?

> > +
> >  static int check_hotplug_memory_range(u64 start, u64 size)
> >  {
> >  	/* memory range must be block size aligned */
> > @@ -1040,7 +1051,7 @@ static int check_hotplug_memory_range(u64
> > start, u64 size)
> >  		return -EINVAL;
> >  	}
> >  
> > -	return 0;
> > +	return check_hotplug_memory_addressable(start, size);
> 
> This will result in a silent failure (unlike misaligned case). Is
> this
> what we want?

Good point - I guess it comes down to, is there anything we expect an
end user to do about it? I'm not sure there is, in which case the bad
RC, which is reported up every call chain that I can see, should be
sufficient.

> >  }
> >  
> >  static int online_memory_block(struct memory_block *mem, void
> > *arg)
> > -- 
> > 2.21.0
> > 

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva    
Twitter: @EvilDeece
blog: http://alastair.d-silva.org


