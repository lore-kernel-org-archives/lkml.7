Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9BC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B565B2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="pWn6Lfbo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mt9Aq5PM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDCWPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:15:04 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57747 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfDCWPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:15:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8EDC822826;
        Wed,  3 Apr 2019 18:15:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2019 18:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=PXNaA02TbTVP8tEtw5M4gplr/AS
        7L4pD4MCo/RGPH2o=; b=pWn6LfbomuOxdudwA2tKOa+TaalINDsz6jEoUyon3n1
        zsQolXPJxvyKxJ/E6rI/6Zme0837YDDHhVRis2MzC5GXWS4oWBQ70BPgUnz+otFk
        RmkS58JBtEMoeGX4Uc5aU8G2/jDLkllIeeMbw9blPuV3JgPcN+5DMcrFPTRfxIJ7
        aZGv/I3fQrit1RpbIc5zhMAqcUgcsr9qBo0qDbSsklZJn5gjVhVNIoKjPYQ5RmmJ
        j0k1Pv/2bhOBDb+CyOt0+X2fOc9LiuhFze7xIOw0M1R+UJ+b2ZQ7IipyNIcwxBzl
        zcQw9YHM/l2ed4kCH2WS6jadZtB/zEr7qoq2WVAo59A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PXNaA0
        2TbTVP8tEtw5M4gplr/AS7L4pD4MCo/RGPH2o=; b=mt9Aq5PMcQzv4HWrGoBbYn
        1E1q1pGZHkdJ313aOjz8wC6qzalzVsL6NNXDvrZmK4WSG1Z+xyXyHW0aRiYzQDN1
        ulOb1nR5lB0VwyiwBHqA6Jt7mSu1V6fJLlO6CwS3M567NabOwhvpj2slJJ0OP07c
        HLc5W9F0QEYHVgnQlNOGxQKwtUgeBbfhvdGsr375Kk5mvN0y7C6eD6+pasXO+nWt
        CsScr7HvAgIgFsdIo/YlMxcLuXGB4HLIHGCgxWf52noOZNMhQctBnMTnpK+gI6Al
        d4TDxDxd+YkJL+D8Hfo4f1txOA9EKwR8BLA6NAQ6iy7SrI6b9rm2DLTwKYO2Lxmw
        ==
X-ME-Sender: <xms:ZDClXOLnDWqyTfeeQJ9Yho3jnOwtqH9kIxKOALGldJ9lQEGrVUl2UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggddtieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhf
    gggtuggjofgfsehttdertdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrug
    hinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkphepuddvgedrudegledruddugedr
    keeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ZDClXN32XZRJqDB6BdqnhW-w9i90WnugOigf1bMgDPE5aPBvbSIdEg>
    <xmx:ZDClXEhAJxe57aqWMfZyGO6IFTUu6mfQTYl_OpAseWv0_xpPwllO0g>
    <xmx:ZDClXExRqay2ZBo9Fz7pT_uhNxpjN6byS1Klcbc28HduDiw33uzK4Q>
    <xmx:ZjClXBa887UBKWcEyoMKPE6R818T-GUAnp0pPnpj4fRLoctx9hBBQQ>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id 949B610319;
        Wed,  3 Apr 2019 18:14:59 -0400 (EDT)
Date:   Thu, 4 Apr 2019 09:14:31 +1100
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
Message-ID: <20190403221431.GA5025@eros.localdomain>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-3-tobin@kernel.org>
 <20190403180026.GC6778@tower.DHCP.thefacebook.com>
 <20190403210327.GB23288@eros.localdomain>
 <20190403212322.GA5116@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403212322.GA5116@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:23:28PM +0000, Roman Gushchin wrote:
> On Thu, Apr 04, 2019 at 08:03:27AM +1100, Tobin C. Harding wrote:
> > On Wed, Apr 03, 2019 at 06:00:30PM +0000, Roman Gushchin wrote:
> > > On Wed, Apr 03, 2019 at 10:05:40AM +1100, Tobin C. Harding wrote:
> > > > Currently we reach inside the list_head.  This is a violation of the
> > > > layer of abstraction provided by the list_head.  It makes the code
> > > > fragile.  More importantly it makes the code wicked hard to understand.
> > > > 
> > > > The code reaches into the list_head structure to counteract the fact
> > > > that the list _may_ have been changed during slob_page_alloc().  Instead
> > > > of this we can add a return parameter to slob_page_alloc() to signal
> > > > that the list was modified (list_del() called with page->lru to remove
> > > > page from the freelist).
> > > > 
> > > > This code is concerned with an optimisation that counters the tendency
> > > > for first fit allocation algorithm to fragment memory into many small
> > > > chunks at the front of the memory pool.  Since the page is only removed
> > > > from the list when an allocation uses _all_ the remaining memory in the
> > > > page then in this special case fragmentation does not occur and we
> > > > therefore do not need the optimisation.
> > > > 
> > > > Add a return parameter to slob_page_alloc() to signal that the
> > > > allocation used up the whole page and that the page was removed from the
> > > > free list.  After calling slob_page_alloc() check the return value just
> > > > added and only attempt optimisation if the page is still on the list.
> > > > 
> > > > Use list_head API instead of reaching into the list_head structure to
> > > > check if sp is at the front of the list.
> > > > 
> > > > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > > > ---
> > > >  mm/slob.c | 51 +++++++++++++++++++++++++++++++++++++--------------
> > > >  1 file changed, 37 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/mm/slob.c b/mm/slob.c
> > > > index 307c2c9feb44..07356e9feaaa 100644
> > > > --- a/mm/slob.c
> > > > +++ b/mm/slob.c
> > > > @@ -213,13 +213,26 @@ static void slob_free_pages(void *b, int order)
> > > >  }
> > > >  
> > > >  /*
> > > > - * Allocate a slob block within a given slob_page sp.
> > > > + * slob_page_alloc() - Allocate a slob block within a given slob_page sp.
> > > > + * @sp: Page to look in.
> > > > + * @size: Size of the allocation.
> > > > + * @align: Allocation alignment.
> > > > + * @page_removed_from_list: Return parameter.
> > > > + *
> > > > + * Tries to find a chunk of memory at least @size bytes big within @page.
> > > > + *
> > > > + * Return: Pointer to memory if allocated, %NULL otherwise.  If the
> > > > + *         allocation fills up @page then the page is removed from the
> > > > + *         freelist, in this case @page_removed_from_list will be set to
> > > > + *         true (set to false otherwise).
> > > >   */
> > > > -static void *slob_page_alloc(struct page *sp, size_t size, int align)
> > > > +static void *slob_page_alloc(struct page *sp, size_t size, int align,
> > > > +			     bool *page_removed_from_list)
> > > 
> > > Hi Tobin!
> > > 
> > > Isn't it better to make slob_page_alloc() return a bool value?
> > > Then it's easier to ignore the returned value, no need to introduce "_unused".
> > 
> > We need a pointer to the memory allocated also so AFAICS its either a
> > return parameter for the memory pointer or a return parameter to
> > indicate the boolean value?  Open to any other ideas I'm missing.
> > 
> > In a previous crack at this I used a double pointer to the page struct
> > then set that to null to indicate the boolean value.  I think the
> > explicit boolean parameter is cleaner.
> 
> Yeah, sorry, it's my fault. Please, ignore this comment.
> Bool* argument is perfectly fine here.

Cheers man, no sweat.  I appreciate you looking at this stuff.

	Tobin
