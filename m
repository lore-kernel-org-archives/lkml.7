Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E5CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9B214B2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfKDPv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:51:29 -0500
Received: from smtp2.axis.com ([195.60.68.18]:8140 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfKDPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:51:28 -0500
IronPort-SDR: 566HpXW0y6wrJ25x7MYzR1+E92meAWNnbTsoCpgsUOxKg+TuSW+mSzM2Xjn77KHKF7xiVOo++Z
 +S+zi++/iRIMMTCV1vQ2zfMaIDQD8iK6bZ0pjDBaLLweiX12yJlz9nXiDTh7+/FiL473pr/RLp
 Qif/TVsXFV6TS4wCxtk5onZQh4umD4YwhFgKS1jb7O/BCkTc5aALOM7ihas0v8mAfh0ACcpL5E
 bOpBhkA389mvFyV0qemwA/0xkgTBBXvTn2N4lEpy4CWbveiMFXV79FAx/FPMQCNy4UZ0dKVCPa
 X4E=
X-IronPort-AV: E=Sophos;i="5.68,267,1569276000"; 
   d="scan'208";a="2060488"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Date:   Mon, 4 Nov 2019 16:51:26 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191104155126.y2fcjwrx5mhdoqi7@axis.com>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz>
 <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz>
 <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz>
 <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
 <20191030173123.GK31513@dhcp22.suse.cz>
 <20191031072555.GA13102@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031072555.GA13102@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 08:25:55AM +0100, Michal Hocko wrote:
> On Wed 30-10-19 18:31:23, Michal Hocko wrote:
> [...]
> > What about this? It still aligns to the size but that should be
> > correctly done to the section size level.
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 72f010d9bff5..ab1e6175ac9a 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
> >  	if (map)
> >  		return map;
> >  
> > -	map = memblock_alloc_try_nid(size,
> > -					  PAGE_SIZE, addr,
> > +	map = memblock_alloc_try_nid(size, size, addr,
> >  					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >  	if (!map)
> >  		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
> > @@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> >  {
> >  	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
> >  	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
> > +	/*
> > +	 * Pre-allocated buffer is mainly used by __populate_section_memmap
> > +	 * and we want it to be properly aligned to the section size - this is
> > +	 * especially the case for VMEMMAP which maps memmap to PMDs
> > +	 */
> >  	sparsemap_buf =
> > -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> > +		memblock_alloc_try_nid_raw(size, section_map_size(),
> >  						addr,
> >  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >  	sparsemap_buf_end = sparsemap_buf + size;
>
> Vincent, could you give this a try please? It would be even better if
> you could add some debugging to measure the overhead. Let me know if you
> need any help with a debugging patch.

I've tested this patch and it works on my platform:  The allocations
from sparse_buffer_alloc() now succeed and the fallback path is not
taken.

I'm not sure what kind of overhead you're interested in.  The memory
overhead of the initial allocations (as measured via the "Memory: XX/YY
available" prints and MemTotal), is identical with and without this
patch.  I don't see any difference in the time taken for the
initializations either.
