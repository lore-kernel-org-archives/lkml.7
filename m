Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E2C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F127920862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574076508;
	bh=wcDqI7jsVXIhoZjAtwWjbP/yuCzDnK/RHwRl+ISL5pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0NHE55h6g+41vDj2WNRecGTnJb6jGAN+h6yMCerzkVHAJk/1lxyPmZ5G92XajYWUW
	 xXm9x7vI437zqQtgMhnhU/ANWF1/Y4GnezzQaTwMhfIZiRcbJ6q+5JlyncfXXsSukj
	 u4ZQ7rtn3SNUAIAXV4EGQ9uGk9E4eFZzLosYb4jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKRL20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:28:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:50058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfKRL20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:28:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70E5BAC59;
        Mon, 18 Nov 2019 11:28:24 +0000 (UTC)
Date:   Mon, 18 Nov 2019 12:28:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191118112823.GC14255@dhcp22.suse.cz>
References: <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz>
 <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz>
 <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
 <20191030173123.GK31513@dhcp22.suse.cz>
 <20191031072555.GA13102@dhcp22.suse.cz>
 <20191104155126.y2fcjwrx5mhdoqi7@axis.com>
 <20191105084352.GJ22672@dhcp22.suse.cz>
 <20191115155535.2a9da68ad58bb787a0ac7833@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115155535.2a9da68ad58bb787a0ac7833@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-11-19 15:55:35, Andrew Morton wrote:
> On Tue, 5 Nov 2019 09:43:52 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Mon 04-11-19 16:51:26, Vincent Whitchurch wrote:
> > > On Thu, Oct 31, 2019 at 08:25:55AM +0100, Michal Hocko wrote:
> > > > On Wed 30-10-19 18:31:23, Michal Hocko wrote:
> > > > [...]
> > > > > What about this? It still aligns to the size but that should be
> > > > > correctly done to the section size level.
> > > > > 
> > > > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > > > index 72f010d9bff5..ab1e6175ac9a 100644
> > > > > --- a/mm/sparse.c
> > > > > +++ b/mm/sparse.c
> > > > > @@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
> > > > >  	if (map)
> > > > >  		return map;
> > > > >  
> > > > > -	map = memblock_alloc_try_nid(size,
> > > > > -					  PAGE_SIZE, addr,
> > > > > +	map = memblock_alloc_try_nid(size, size, addr,
> > > > >  					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > > > >  	if (!map)
> > > > >  		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
> > > > > @@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> > > > >  {
> > > > >  	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
> > > > >  	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
> > > > > +	/*
> > > > > +	 * Pre-allocated buffer is mainly used by __populate_section_memmap
> > > > > +	 * and we want it to be properly aligned to the section size - this is
> > > > > +	 * especially the case for VMEMMAP which maps memmap to PMDs
> > > > > +	 */
> > > > >  	sparsemap_buf =
> > > > > -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> > > > > +		memblock_alloc_try_nid_raw(size, section_map_size(),
> > > > >  						addr,
> > > > >  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > > > >  	sparsemap_buf_end = sparsemap_buf + size;
> > > >
> > > > Vincent, could you give this a try please? It would be even better if
> > > > you could add some debugging to measure the overhead. Let me know if you
> > > > need any help with a debugging patch.
> > > 
> > > I've tested this patch and it works on my platform:  The allocations
> > > from sparse_buffer_alloc() now succeed and the fallback path is not
> > > taken.
> > 
> > Thanks a lot. I will try to prepare the full patch with a proper
> > changelog sometimes this week.
> > 
> 
> We're late in -rc7.  Should we run with Vincent's original for now?

Yes, that patch is correct on its own. I have still the follow up clean
up on my todo list. I will get to this hopefully soon.

> And I'm wondering why this is -stable -material?  You said
> 
> : Anyway the patch is OK.  Even though this is not a bug strictly
> : speaking it is certainly a suboptimal behavior because zeroying takes
> : time so I would flag this for a stable tree 4.19+.  There is no clear
> : Fixes tag to apply (35fd1eb1e8212 would get closest I guess).
> 
> I'm not seeing any description of any runtime effect of the bug at
> present.  When would unzeroed sparsemem pageframes cause a problem? 
> Could they be visible during deferred initialization or mem hotadd?

The main user visible problem is a memory wastage. The overal amount of
memory should be small. I wouldn't call it a stable material.

-- 
Michal Hocko
SUSE Labs
