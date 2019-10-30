Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A590CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DC0208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572458488;
	bh=rgVuG060ct1HJ2zksRzBOeYbM4L4+UBfe3r9n1/1YRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KlEApz/SmTN+S4Bu1KIk9zSyIqV86wsU4BH7f0zfj9514X9MjuzNmvdH8XqysnHrY
	 ch1AIjC3KbyRnmjtwFMCJF7EMgS7xTQ+xGf2yDNjbWmCT59YifMnDdkbTYxgKieHXg
	 ihkln56F6+VjLNxRqx94tybCGOGVstQALOyqvytg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfJ3SB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:01:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfJ3SB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:01:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D6E2B257;
        Wed, 30 Oct 2019 18:01:24 +0000 (UTC)
Date:   Wed, 30 Oct 2019 19:01:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191030180116.GN31513@dhcp22.suse.cz>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz>
 <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz>
 <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz>
 <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
 <20191030173123.GK31513@dhcp22.suse.cz>
 <CA+CK2bA_Cb95mu6XRLy3nnjNoRwMHR2OQuRAPGU-uzPXbBth1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA_Cb95mu6XRLy3nnjNoRwMHR2OQuRAPGU-uzPXbBth1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-10-19 13:53:52, Pavel Tatashin wrote:
> On Wed, Oct 30, 2019 at 1:31 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 30-10-19 12:53:41, Pavel Tatashin wrote:
[...]
> > > Yes, PMD_SIZE should be the alignment here. It just does not make
> > > sense to align to size.
> >
> > What about this? It still aligns to the size but that should be
> > correctly done to the section size level.
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 72f010d9bff5..ab1e6175ac9a 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
> >         if (map)
> >                 return map;
> >
> > -       map = memblock_alloc_try_nid(size,
> > -                                         PAGE_SIZE, addr,
> > +       map = memblock_alloc_try_nid(size, size, addr,
> >                                           MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >         if (!map)
> >                 panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
> > @@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> >  {
> >         phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
> >         WARN_ON(sparsemap_buf); /* forgot to call sparse_buffer_fini()? */
> > +       /*
> > +        * Pre-allocated buffer is mainly used by __populate_section_memmap
> > +        * and we want it to be properly aligned to the section size - this is
> > +        * especially the case for VMEMMAP which maps memmap to PMDs
> > +        */
> >         sparsemap_buf =
> > -               memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> > +               memblock_alloc_try_nid_raw(size, section_map_size(),
> >                                                 addr,
> >                                                 MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >         sparsemap_buf_end = sparsemap_buf + size;
> 
> This looks good, I think we should also change alignment in fallback
> of vmemmap_alloc_block() to be
> section_map_size().
> 
> +++ b/mm/sparse-vmemmap.c
> @@ -65,9 +65,10 @@ void * __meminit vmemmap_alloc_block(unsigned long
> size, int node)
>                         warned = true;
>                 }
>                 return NULL;
> -       } else
> -               return __earlyonly_bootmem_alloc(node, size, size,
> +       } else {
> +               return __earlyonly_bootmem_alloc(node, size, section_map_size(),
>                                 __pa(MAX_DMA_ADDRESS));
> +       }
>  }

Are you sure? Doesn't this provide the proper alignement already? Most
callers do PAGE_SIZE vmemmap_populate_hugepages PMD_SIZE so the
resulting alignment looks good to me.
-- 
Michal Hocko
SUSE Labs
