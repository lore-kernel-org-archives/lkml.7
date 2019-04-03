Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E0C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5428206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="CKIrNj18";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3LGBcvf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDCVED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:04:03 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56817 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfDCVED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:04:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 15541207E1;
        Wed,  3 Apr 2019 17:04:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2019 17:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ii4vLzr0/hkZhS9GYDt0aqtb1MV
        cJQwo2KZPugK4eL0=; b=CKIrNj188yEHiLVuSyJLmSVXaTjbJKoHEZLT6ElMwVY
        pAlEbBkXjACgWjv8DwRACN+5pqh23c4Bw+hefHTXYN3QAeMnA9OzmGmPjLn+91t1
        W7ob+apC/O8FRhNF/wR4TD3GevQFmPrF8v/+MrRmUizyW19lUs0fLS2Xl8GMnZYI
        KG5QTpzn/+k9On18L40kxHvxcIqZG3NPUK5ScHayI0IDDxr6o5/5sltTXKZ4ePMv
        L5l/NRgEphzT5azf3bnwONJY+qXli9TxJrMiYGgQhVmbCJH8WLny857h71ORydIG
        UJ48RYBkUDwA88fnwUqZuzqoC0kUo1bafnbmGafl2qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ii4vLz
        r0/hkZhS9GYDt0aqtb1MVcJQwo2KZPugK4eL0=; b=3LGBcvf1ki3l0G9LnsH7tk
        YOQX40sT+bKAjnvn0jnfdnkGvpguASUoJ9KC0OqfHHJCcwIRGoao5IOj+5imekoK
        NtLp43AJeGOJHoBagY9XKyxeG+vrt9CvzNmmlyJzBrKStce/fZ6AAjmyQjEAgSdd
        EHa1desRrq8DRhEdw+rcYS1XD+6ak7CVosHfLRoXGAATRbNC1sEpyNwT/GCVrebY
        DMUHIV0UxpgM28MIrttntVj7l8y1vzuOt+IUPq3cCMuQNLwLy0I4iuUPnVDR0xFn
        LgqbM76klIJWpoEhknpmYaMhTvEwxIsojQqCNu+qd9wyOxR/b6FQDIrKVNp/GP/A
        ==
X-ME-Sender: <xms:wB-lXH7kVcLxDKCusO0wzsxqqeEim2LnVEJIRpFonys8U_Sn487cjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddufedtucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffk
    fhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrh
    guihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduvdegrddugeelrdduudeg
    rdekieenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wB-lXJV8NhF3UpxA9o052iLYasu69hL_HivBKqbscxDcQnqxyFsxKg>
    <xmx:wB-lXGNxIxDrW6dWR1ZvDc5Pa-Vroc1YhohEVD7yJ5MAirV2wXVhGQ>
    <xmx:wB-lXJCTf2TIdSvn_VtEqFzACu9IedZU2Xs86ENqCMAYUVZqIYcYdQ>
    <xmx:wh-lXPBw1-KR8W_rv-sPsDXnDJEXHy2zcv9h4341OTKmVfZTbSprgA>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDDBF10316;
        Wed,  3 Apr 2019 17:03:58 -0400 (EDT)
Date:   Thu, 4 Apr 2019 08:03:27 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Roman Gushchin <guro@fb.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] slob: Respect list_head abstraction layer
Message-ID: <20190403210327.GB23288@eros.localdomain>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-3-tobin@kernel.org>
 <20190403180026.GC6778@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403180026.GC6778@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:00:30PM +0000, Roman Gushchin wrote:
> On Wed, Apr 03, 2019 at 10:05:40AM +1100, Tobin C. Harding wrote:
> > Currently we reach inside the list_head.  This is a violation of the
> > layer of abstraction provided by the list_head.  It makes the code
> > fragile.  More importantly it makes the code wicked hard to understand.
> > 
> > The code reaches into the list_head structure to counteract the fact
> > that the list _may_ have been changed during slob_page_alloc().  Instead
> > of this we can add a return parameter to slob_page_alloc() to signal
> > that the list was modified (list_del() called with page->lru to remove
> > page from the freelist).
> > 
> > This code is concerned with an optimisation that counters the tendency
> > for first fit allocation algorithm to fragment memory into many small
> > chunks at the front of the memory pool.  Since the page is only removed
> > from the list when an allocation uses _all_ the remaining memory in the
> > page then in this special case fragmentation does not occur and we
> > therefore do not need the optimisation.
> > 
> > Add a return parameter to slob_page_alloc() to signal that the
> > allocation used up the whole page and that the page was removed from the
> > free list.  After calling slob_page_alloc() check the return value just
> > added and only attempt optimisation if the page is still on the list.
> > 
> > Use list_head API instead of reaching into the list_head structure to
> > check if sp is at the front of the list.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  mm/slob.c | 51 +++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 37 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/slob.c b/mm/slob.c
> > index 307c2c9feb44..07356e9feaaa 100644
> > --- a/mm/slob.c
> > +++ b/mm/slob.c
> > @@ -213,13 +213,26 @@ static void slob_free_pages(void *b, int order)
> >  }
> >  
> >  /*
> > - * Allocate a slob block within a given slob_page sp.
> > + * slob_page_alloc() - Allocate a slob block within a given slob_page sp.
> > + * @sp: Page to look in.
> > + * @size: Size of the allocation.
> > + * @align: Allocation alignment.
> > + * @page_removed_from_list: Return parameter.
> > + *
> > + * Tries to find a chunk of memory at least @size bytes big within @page.
> > + *
> > + * Return: Pointer to memory if allocated, %NULL otherwise.  If the
> > + *         allocation fills up @page then the page is removed from the
> > + *         freelist, in this case @page_removed_from_list will be set to
> > + *         true (set to false otherwise).
> >   */
> > -static void *slob_page_alloc(struct page *sp, size_t size, int align)
> > +static void *slob_page_alloc(struct page *sp, size_t size, int align,
> > +			     bool *page_removed_from_list)
> 
> Hi Tobin!
> 
> Isn't it better to make slob_page_alloc() return a bool value?
> Then it's easier to ignore the returned value, no need to introduce "_unused".

We need a pointer to the memory allocated also so AFAICS its either a
return parameter for the memory pointer or a return parameter to
indicate the boolean value?  Open to any other ideas I'm missing.

In a previous crack at this I used a double pointer to the page struct
then set that to null to indicate the boolean value.  I think the
explicit boolean parameter is cleaner.

thanks,
Tobin.
