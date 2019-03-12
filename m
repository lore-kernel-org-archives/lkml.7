Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACEFC10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26638214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Uf/KtrOT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2HSi7Br/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCLBy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:54:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49787 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfCLBy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:54:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3818023176;
        Mon, 11 Mar 2019 21:54:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Mar 2019 21:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DWxYFqFht/GTnBUrw50jGcXbdTj
        gIErrdzyLX70BJKc=; b=Uf/KtrOTzgHM/DVKJ0i0SYM1puQbNeo5DjesYmUCojg
        6eZDxn4eU6RurNSVtPL3EKm1kxCtoUmnnGkLStn2C62TmuywYz1t0+rqa9DbZVJY
        FZhC0HMn1KXZ3W9R0hvDfQpF3upZTuXeKhc6tNAFIqf/AXrHWphWpSo72TKkjXr0
        slBfXZzxZVqRe8lWzdX7bmfsN6CYQqM+uNnQlQmiLwRcGb/wWaEysYczOUmwag2Z
        fvT6vKzqUW8GO3b7hgGanMz6uebyNM6LShiHH7Y6eHQfHjIoRQ48FiTre2ZqH7tn
        6GYeQuIchvVTwEo00++K9cTyt6BwY45wGaH8NweGYlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DWxYFq
        Fht/GTnBUrw50jGcXbdTjgIErrdzyLX70BJKc=; b=2HSi7Br/pN+UMckjZh3KC5
        GZ1dG+6z2quFoSUwO4lPc64LxWCi1rfoF/shfxDC9swDyi7PJ74DdxYHDgIzs+xp
        pbMS1p7nA9DoO6i5EeJm2ae0sgIJPvLQ4BQ8rBe9zVpxAl+vhvjv1N8ytz3hb87q
        oKuZZYM9l6vMaNeezcsu5j8Dyqo3w8+VikvJjz76pHGsFhJwARlTJ+2clkzuBW9m
        PHgD9wpIZdRAuG8WsYdvAIL19J1kvbxaGGeeVgXu8KiweL0nbCnIW1n4+/wcIGag
        Ai7N7rGBCp0PCbaHZgUAHzOLDA7qMDzzhCI9jDkiLbmkji4KfihThzydv2CoLiSQ
        ==
X-ME-Sender: <xms:bhGHXIY1Sa3BMaDcyURcL8rGVRZLnuMQqFvGaOKcopmG7Z2C4KEG8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeejgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddutddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:bhGHXC-2KyZD3iH_YoXwop1pPkWXsZt6p2mdDJj_UAFUq3F-nqQirw>
    <xmx:bhGHXGtG51OEbRvgVdl2ZbrP3bMYpEjyQDqJ2VKlJOpB6eb6u__PhA>
    <xmx:bhGHXHFUgjSGEo9hBxyDTF5UYzjRLMmuTIL2evF0fJgPZz3Sob-10g>
    <xmx:cBGHXBnWiRcQl4KU5xa1yQEVHMLBa74qRrtCe8EkfFs0o5tX2Ni0ng>
Received: from localhost (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F935E4173;
        Mon, 11 Mar 2019 21:54:53 -0400 (EDT)
Date:   Tue, 12 Mar 2019 12:54:32 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Roman Gushchin <guro@fb.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 12/15] xarray: Implement migration function for objects
Message-ID: <20190312015432.GI9362@eros.localdomain>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-13-tobin@kernel.org>
 <20190312001602.GB25059@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312001602.GB25059@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:16:07AM +0000, Roman Gushchin wrote:
> On Fri, Mar 08, 2019 at 03:14:23PM +1100, Tobin C. Harding wrote:
> > Implement functions to migrate objects. This is based on
> > initial code by Matthew Wilcox and was modified to work with
> > slab object migration.
> > 
> > Co-developed-by: Christoph Lameter <cl@linux.com>
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  lib/radix-tree.c | 13 +++++++++++++
> >  lib/xarray.c     | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> > 
> > diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> > index 14d51548bea6..9412c2853726 100644
> > --- a/lib/radix-tree.c
> > +++ b/lib/radix-tree.c
> > @@ -1613,6 +1613,17 @@ static int radix_tree_cpu_dead(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +extern void xa_object_migrate(void *tree_node, int numa_node);
> > +
> > +static void radix_tree_migrate(struct kmem_cache *s, void **objects, int nr,
> > +			       int node, void *private)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < nr; i++)
> > +		xa_object_migrate(objects[i], node);
> > +}
> > +
> >  void __init radix_tree_init(void)
> >  {
> >  	int ret;
> > @@ -1627,4 +1638,6 @@ void __init radix_tree_init(void)
> >  	ret = cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
> >  					NULL, radix_tree_cpu_dead);
> >  	WARN_ON(ret < 0);
> > +	kmem_cache_setup_mobility(radix_tree_node_cachep, NULL,
> > +				  radix_tree_migrate);
> >  }
> > diff --git a/lib/xarray.c b/lib/xarray.c
> > index 81c3171ddde9..4f6f17c87769 100644
> > --- a/lib/xarray.c
> > +++ b/lib/xarray.c
> > @@ -1950,6 +1950,50 @@ void xa_destroy(struct xarray *xa)
> >  }
> >  EXPORT_SYMBOL(xa_destroy);
> >  
> > +void xa_object_migrate(struct xa_node *node, int numa_node)
> > +{
> > +	struct xarray *xa = READ_ONCE(node->array);
> > +	void __rcu **slot;
> > +	struct xa_node *new_node;
> > +	int i;
> > +
> > +	/* Freed or not yet in tree then skip */
> > +	if (!xa || xa == XA_FREE_MARK)
> > +		return;
> 
> XA_FREE_MARK is equal to 0, so the second check is redundant.
> 
> #define XA_MARK_0		((__force xa_mark_t)0U)
> #define XA_MARK_1		((__force xa_mark_t)1U)
> #define XA_MARK_2		((__force xa_mark_t)2U)
> #define XA_PRESENT		((__force xa_mark_t)8U)
> #define XA_MARK_MAX		XA_MARK_2
> #define XA_FREE_MARK		XA_MARK_0
> 
> xa_node_free() sets node->array to XA_RCU_FREE, so maybe it's
> what you need. I'm not sure however, Matthew should know better

Cheers, will wait for his input.

> > +
> > +	new_node = kmem_cache_alloc_node(radix_tree_node_cachep,
> > +					 GFP_KERNEL, numa_node);
> 
> We need to check here if the allocation was successful.

Woops, bad Tobin.  Thanks.


	Tobin.
