Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4158C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA0F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573862138;
	bh=AYrhLwNe+hXbVspP++qlUMNb9xKXjMVWzMPNNDOYrIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ERX9gcBEt/eKrbLCELvnc/fPi06KlB/u+IoOntYsi5CrpsFxoKILutw/2UcIIA0gg
	 veyD7qUQ/O8POruzF/nGC9EW1OKStC84nQozVsU8WgaG1w6BhXBVCaDhm/XL/Si4tv
	 WL+yVneK8Tlgcy9GjvZJR+JGJFyT6z3p2urlmP/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKOXzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfKOXzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:55:37 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2749B2073B;
        Fri, 15 Nov 2019 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573862136;
        bh=AYrhLwNe+hXbVspP++qlUMNb9xKXjMVWzMPNNDOYrIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KGWeGLilG3+3DKI5HLLGVAe12sNQYLZGW85uj4Wy3mPN1wLkBJL5YBcvmro0PhG42
         +eLH4jm8MxT4zeQ/s14zlAmZltszkv15zw9kOMTEbP0etbzNKR0/eaZUuWYA/qi43G
         zbsGmD4WwNqV6H/yPV4gWvTyJBA2AflAG6ncj/Rc=
Date:   Fri, 15 Nov 2019 15:55:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-Id: <20191115155535.2a9da68ad58bb787a0ac7833@linux-foundation.org>
In-Reply-To: <20191105084352.GJ22672@dhcp22.suse.cz>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
        <20191030132958.GD31513@dhcp22.suse.cz>
        <20191030140216.i26n22asgafckfxy@axis.com>
        <20191030141259.GE31513@dhcp22.suse.cz>
        <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
        <20191030153150.GI31513@dhcp22.suse.cz>
        <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
        <20191030173123.GK31513@dhcp22.suse.cz>
        <20191031072555.GA13102@dhcp22.suse.cz>
        <20191104155126.y2fcjwrx5mhdoqi7@axis.com>
        <20191105084352.GJ22672@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 09:43:52 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Mon 04-11-19 16:51:26, Vincent Whitchurch wrote:
> > On Thu, Oct 31, 2019 at 08:25:55AM +0100, Michal Hocko wrote:
> > > On Wed 30-10-19 18:31:23, Michal Hocko wrote:
> > > [...]
> > > > What about this? It still aligns to the size but that should be
> > > > correctly done to the section size level.
> > > > 
> > > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > > index 72f010d9bff5..ab1e6175ac9a 100644
> > > > --- a/mm/sparse.c
> > > > +++ b/mm/sparse.c
> > > > @@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
> > > >  	if (map)
> > > >  		return map;
> > > >  
> > > > -	map = memblock_alloc_try_nid(size,
> > > > -					  PAGE_SIZE, addr,
> > > > +	map = memblock_alloc_try_nid(size, size, addr,
> > > >  					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > > >  	if (!map)
> > > >  		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
> > > > @@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> > > >  {
> > > >  	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
> > > >  	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
> > > > +	/*
> > > > +	 * Pre-allocated buffer is mainly used by __populate_section_memmap
> > > > +	 * and we want it to be properly aligned to the section size - this is
> > > > +	 * especially the case for VMEMMAP which maps memmap to PMDs
> > > > +	 */
> > > >  	sparsemap_buf =
> > > > -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> > > > +		memblock_alloc_try_nid_raw(size, section_map_size(),
> > > >  						addr,
> > > >  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > > >  	sparsemap_buf_end = sparsemap_buf + size;
> > >
> > > Vincent, could you give this a try please? It would be even better if
> > > you could add some debugging to measure the overhead. Let me know if you
> > > need any help with a debugging patch.
> > 
> > I've tested this patch and it works on my platform:  The allocations
> > from sparse_buffer_alloc() now succeed and the fallback path is not
> > taken.
> 
> Thanks a lot. I will try to prepare the full patch with a proper
> changelog sometimes this week.
> 

We're late in -rc7.  Should we run with Vincent's original for now?

And I'm wondering why this is -stable -material?  You said

: Anyway the patch is OK.  Even though this is not a bug strictly
: speaking it is certainly a suboptimal behavior because zeroying takes
: time so I would flag this for a stable tree 4.19+.  There is no clear
: Fixes tag to apply (35fd1eb1e8212 would get closest I guess).

I'm not seeing any description of any runtime effect of the bug at
present.  When would unzeroed sparsemem pageframes cause a problem? 
Could they be visible during deferred initialization or mem hotadd?


