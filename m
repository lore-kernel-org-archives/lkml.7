Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803F5CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FD0208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572456689;
	bh=GYKWXIFW0wEKvav8CdD/BEyfTaA+oBzfiH+fyLXWmCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zkWsEM/vOmbjwd9Lrn9P2sDbAfrirBWKf129PCtSoZCwCrT0HjPkH5q5lUGxbD5pa
	 NxkiRRWOg0j93mDf1UL2XuxJ8ldVBu2PvoeEUlXSWqbBB0its+aDYhYjOrDGwCMVYv
	 gdIdTEZT2JQwouvj0+FebSX/tuyp2gE+eWb1SvFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfJ3Rb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:31:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbfJ3Rb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:31:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C197B3A9;
        Wed, 30 Oct 2019 17:31:25 +0000 (UTC)
Date:   Wed, 30 Oct 2019 18:31:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
Message-ID: <20191030173123.GK31513@dhcp22.suse.cz>
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz>
 <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz>
 <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz>
 <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-10-19 12:53:41, Pavel Tatashin wrote:
> On Wed, Oct 30, 2019 at 11:31 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 30-10-19 11:20:44, Pavel Tatashin wrote:
> > > On Wed, Oct 30, 2019 at 10:13 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > [Add Pavel - the email thread starts http://lkml.kernel.org/r/20191030131122.8256-1-vincent.whitchurch@axis.com
> > > >  but it used your old email address]
> > > >
> > > > On Wed 30-10-19 15:02:16, Vincent Whitchurch wrote:
> > > > > On Wed, Oct 30, 2019 at 02:29:58PM +0100, Michal Hocko wrote:
> > > > > > On Wed 30-10-19 14:11:22, Vincent Whitchurch wrote:
> > > > > > > (I noticed this because on my ARM64 platform, with 1 GiB of memory the
> > > > > > >  first [and only] section is allocated from the zeroing path while with
> > > > > > >  2 GiB of memory the first 1 GiB section is allocated from the
> > > > > > >  non-zeroing path.)
> > > > > >
> > > > > > Do I get it right that sparse_buffer_init couldn't allocate memmap for
> > > > > > the full node for some reason and so sparse_init_nid would have to
> > > > > > allocate one for each memory section?
> > > > >
> > > > > Not quite.  The sparsemap_buf is successfully allocated with the correct
> > > > > size in sparse_buffer_init(), but sparse_buffer_alloc() fails to
> > > > > allocate the same size from it.
> > > > >
> > > > > The reason it fails is that sparse_buffer_alloc() for some reason wants
> > > > > to return a pointer which is aligned to the allocation size.  But the
> > > > > sparsemap_buf was only allocated with PAGE_SIZE alignment so there's not
> > > > > enough space to align it.
> > > > >
> > > > > I don't understand the reason for this alignment requirement since the
> > > > > fallback path also allocates with PAGE_SIZE alignment.  I'm guessing the
> > > > > alignment is for the VMEMAP code which also uses sparse_buffer_alloc()?
> > > >
> > > > I am not 100% sure TBH. Aligning makes some sense when mapping the
> > > > memmaps to page tables but that would suggest that sparse_buffer_init
> > > > is using a wrong alignment then. It is quite wasteful to allocate
> > > > alarge misaligned block like that.
> > > >
> > > > Your patch still makes sense but this is something to look into.
> > > >
> > > > Pavel?
> > >
> > > I remember thinking about this large alignment, as it looked out of
> > > place to me also.
> > > It was there to keep memmap in single chunks on larger x86 machines.
> > > Perhaps it can be revisited now.
> >
> > Don't we need 2MB aligned memmaps for their PMD mappings?
> 
> Yes, PMD_SIZE should be the alignment here. It just does not make
> sense to align to size.

What about this? It still aligns to the size but that should be
correctly done to the section size level.

diff --git a/mm/sparse.c b/mm/sparse.c
index 72f010d9bff5..ab1e6175ac9a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
 	if (map)
 		return map;
 
-	map = memblock_alloc_try_nid(size,
-					  PAGE_SIZE, addr,
+	map = memblock_alloc_try_nid(size, size, addr,
 					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	if (!map)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
@@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 {
 	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
 	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
+	/*
+	 * Pre-allocated buffer is mainly used by __populate_section_memmap
+	 * and we want it to be properly aligned to the section size - this is
+	 * especially the case for VMEMMAP which maps memmap to PMDs
+	 */
 	sparsemap_buf =
-		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
+		memblock_alloc_try_nid_raw(size, section_map_size(),
 						addr,
 						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	sparsemap_buf_end = sparsemap_buf + size;

-- 
Michal Hocko
SUSE Labs
