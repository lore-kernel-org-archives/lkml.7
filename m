Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03839C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96E8214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="TBuk2CMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tJg/AMhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCVOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:14:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46517 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbfDCVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:14:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D791231BB;
        Wed,  3 Apr 2019 17:14:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Apr 2019 17:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=eT5LyJ3XilDZvzAmzpa/qNoLto9
        N4YRi9epZijWVMuQ=; b=TBuk2CMuz13ViMY1TIo+aLivtPnZMmkaUm/TlTfUOJH
        mtc3jHcYxSL+ysk8xbdwK0jjKbg9YoBEfN30delzG2ej6og5j6ASKj/F7SApJ5JW
        zhyfSQngreFiz2/GIzhpvzZoFoCqu//9gdmyfv8cJYPMLlduMXLkijgsGMT3nQma
        SN1Q2xpwWpQO0Ht0I2epxyC/J5bcHqXadPi25+2h29v4QFEcvo4HwZS7tVXXUVcQ
        5+0O27bPtgjxb/g/Dubfa6yl0vr3btkFvXbEhaANG8OELcaguXQAKVd1VWHLsDsa
        a/roMsI494Y+pntIaipEyX9/JwU4/aq/9eD2E8LUoNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eT5LyJ
        3XilDZvzAmzpa/qNoLto9N4YRi9epZijWVMuQ=; b=tJg/AMhcb7XSPVPL/l1FIz
        Yu+/pcs+KbPNdswfGujQJbuHR+pVYJH5HHD8x7IujIjTQ5JocJz2+5JaMQ+vTZdD
        wYjiC1by2Az8Dw7zETBKPPNNZlgwXbOLELePmcDsSR2WBcH/vKlykxp5SIh7AMoY
        mpW1O3CDGM6/EeBIzx6t5gGDfq8hQVUZHrdLyl1Jr05jtcnpcswr+KazPLTA6TEx
        QF+DxuVB8Z59PXxcmtJJ98MGrnHf9QWdP/GwlN7loeovcbar3K6rvKIA5Hy8/Wgr
        wZs5iGUAOYaXWO4Kmw7PHLLwThs5heaHasJCOKLZcTKLxo8zSEZJ2/VLr+cQe2dg
        ==
X-ME-Sender: <xms:MiKlXO1fzOtfzSJmd5mjjstLQQ21Zg3RBW6tlzJMH7T4NDWWmdZ9fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddufedvucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffk
    fhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrh
    guihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduvdegrddugeelrdduudeg
    rdekieenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:MiKlXLy6kc0NzsVaZXM5VYYItV2y-Ra6xaYLxQUpPNz128ue2tx2zA>
    <xmx:MiKlXK7s60MrqPWbfeHOQ_SzUEHiGAgnofsaRvII59fiNSpq3DdZsw>
    <xmx:MiKlXAhmHDMpTjrEsHjyDiIaxSAifmI14679d1lmRNc8gn8V--X8Tw>
    <xmx:NSKlXDizc7rqOfz4tRMZ4GWZ7QjsdZJC29I0N_gUQSbDiGnAoOBS6Q>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id 33026E408B;
        Wed,  3 Apr 2019 17:14:24 -0400 (EDT)
Date:   Thu, 4 Apr 2019 08:13:54 +1100
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
Message-ID: <20190403211354.GC23288@eros.localdomain>
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
> 
> Thanks!
> 
> >  {
> >  	slob_t *prev, *cur, *aligned = NULL;
> >  	int delta = 0, units = SLOB_UNITS(size);
> >  
> > +	*page_removed_from_list = false;
> >  	for (prev = NULL, cur = sp->freelist; ; prev = cur, cur = slob_next(cur)) {
> >  		slobidx_t avail = slob_units(cur);
> >  
> > @@ -254,8 +267,10 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
> >  			}
> >  
> >  			sp->units -= units;
> > -			if (!sp->units)
> > +			if (!sp->units) {
> >  				clear_slob_page_free(sp);
> > +				*page_removed_from_list = true;
> > +			}
> >  			return cur;
> >  		}
> >  		if (slob_last(cur))
> > @@ -269,10 +284,10 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align)
> >  static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
> >  {
> >  	struct page *sp;
> > -	struct list_head *prev;
> >  	struct list_head *slob_list;
> >  	slob_t *b = NULL;
> >  	unsigned long flags;
> > +	bool _unused;
> >  
> >  	if (size < SLOB_BREAK1)
> >  		slob_list = &free_slob_small;
> > @@ -284,6 +299,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
> >  	spin_lock_irqsave(&slob_lock, flags);
> >  	/* Iterate through each partially free page, try to find room */
> >  	list_for_each_entry(sp, slob_list, lru) {
> > +		bool page_removed_from_list = false;
> >  #ifdef CONFIG_NUMA
> >  		/*
> >  		 * If there's a node specification, search for a partial
> > @@ -296,18 +312,25 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
> >  		if (sp->units < SLOB_UNITS(size))
> >  			continue;
> >  
> > -		/* Attempt to alloc */
> > -		prev = sp->lru.prev;
> > -		b = slob_page_alloc(sp, size, align);
> > +		b = slob_page_alloc(sp, size, align, &page_removed_from_list);
> >  		if (!b)
> >  			continue;
> >  
> > -		/* Improve fragment distribution and reduce our average
> > -		 * search time by starting our next search here. (see
> > -		 * Knuth vol 1, sec 2.5, pg 449) */
> > -		if (prev != slob_list->prev &&
> > -				slob_list->next != prev->next)
> > -			list_move_tail(slob_list, prev->next);
> > +		/*
> > +		 * If slob_page_alloc() removed sp from the list then we
> > +		 * cannot call list functions on sp.  If so allocation
> > +		 * did not fragment the page anyway so optimisation is
> > +		 * unnecessary.
> > +		 */
> > +		if (!page_removed_from_list) {
> > +			/*
> > +			 * Improve fragment distribution and reduce our average
> > +			 * search time by starting our next search here. (see
> > +			 * Knuth vol 1, sec 2.5, pg 449)
> > +			 */
> > +			if (!list_is_first(&sp->lru, slob_list))
> > +				list_rotate_to_front(&sp->lru, slob_list);

According to 0day test robot this is triggering an error from
CHECK_DATA_CORRUPTION when the kernel is built with CONFIG_DEBUG_LIST.
I think this is because list_rotate_to_front() puts the list into an
invalid state before it calls __list_add().  The thing that has me
stumped is why this was not happening before this patch series was
applied?  ATM I'm not able to get my test module to trigger this but I'm
going to try a bit harder today.  If I'm right one solution is to modify
list_rotate_to_front() to _not_ call __list_add() but do it manually,
this solution doesn't sit well with me though.

So, summing up, I think the patch is correct in that it does the correct
thing but I think the debugging code doesn't like it because we are
violating typical usage - so the patch is wrong :)

thanks,
Tobin.
