Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84814C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520C32147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="aXnTnzvR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ov872Nzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDCVT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:19:58 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45189 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbfDCVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:19:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 101FA21A84;
        Wed,  3 Apr 2019 17:19:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2019 17:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Jby8yi6XtGo+Fp5Ers69YhaBfux
        3eIt01Ju9PJJZVTw=; b=aXnTnzvRemKYQDugVcBQFMBidMbrHuWIp28Zo6aK7cS
        6JTYrXR8OOLoJtGXHKOg5SjHLQ1TcGYfZ2Tor2ZfNI6xOQHDbuw3JE/MXxJ+kVoq
        LL8tQtY+pj1DkEh49+a7Na1vtU5zBbVvKt27bpwO/BYYT722J7HqnFf8eFg+GnhD
        LPNipeOXXEfjSGzFYzke/rFm3lO706Xupm35W7xSQJcd9Fbgz2MBQ4JZab4tNRAl
        dovGvwFuS/2UZfUJ67LwJCU0a+51DT0W+qwJss/0DabzS0uy5O/L8RY0IaUs3ugq
        SZC6jsHSR2/8qLb6SLCJB69ySkEN9GzEyXOIhYWa+Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Jby8yi
        6XtGo+Fp5Ers69YhaBfux3eIt01Ju9PJJZVTw=; b=Ov872Nzw1Or51P1ZU2Z50O
        N53CmnY1UAeQeQIa24Z85+5yyQZLsXAMVofaHS5OeXEwbYo2N0LI8JtJEH0UM24Z
        SpUdvDE5FZium9lDrzbWmprnZEfmY9s1FQssikf06j/bSqFQGzK53Roi938kQQlt
        d7Fo9PjPW/Ds4KR2U/Ah/MHauqJEX7dat3R7SUowXbjOxORftx1xNH3GOTJe/qcR
        B8DMcYSsozJHsuVqwo2C5H+s8y7mNyf21a7rMcld65FODI/cQsuwpJRDlHB/VQB0
        F/fFUnO/HswtSHZlAHro5vESLBhVPTTDXTG2q/x2VtnSCyAScJ/7Y5hf7lf/MZYA
        ==
X-ME-Sender: <xms:eSOlXLOV41zOG-nEaB5TQnLsbZOE4KeyVwNth3Tfy2cd9y_pmhkHvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddufeefucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffk
    fhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrh
    guihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduvdegrddugeelrdduudeg
    rdekieenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:eSOlXKOEjuEzZcgzocxVwveTn72r2YKBa-7dJgzueErl-b5x7Tlt5Q>
    <xmx:eSOlXFTYx3b42Tpk-GSpj5rbqhylvjU3e8z7RiOqHaRVYx4lK1U5MA>
    <xmx:eSOlXECd4XOJQs1casaHGkm1lNcQZVyJhGUttt3uTAd3DY22ZLZdMw>
    <xmx:fSOlXIQsKCyM0c3Iecoie5OsBuzy83Zi1iaGHTbDC1u3h9tTzgnA3g>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA78F10390;
        Wed,  3 Apr 2019 17:19:51 -0400 (EDT)
Date:   Thu, 4 Apr 2019 08:19:23 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/14] xarray: Implement migration function for
 objects
Message-ID: <20190403211923.GD23288@eros.localdomain>
References: <20190403042127.18755-1-tobin@kernel.org>
 <20190403042127.18755-10-tobin@kernel.org>
 <20190403172326.GJ22763@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403172326.GJ22763@bombadil.infradead.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:23:26AM -0700, Matthew Wilcox wrote:
> On Wed, Apr 03, 2019 at 03:21:22PM +1100, Tobin C. Harding wrote:
> > +void xa_object_migrate(struct xa_node *node, int numa_node)
> > +{
> > +	struct xarray *xa = READ_ONCE(node->array);
> > +	void __rcu **slot;
> > +	struct xa_node *new_node;
> > +	int i;
> > +
> > +	/* Freed or not yet in tree then skip */
> > +	if (!xa || xa == XA_RCU_FREE)
> > +		return;
> > +
> > +	new_node = kmem_cache_alloc_node(radix_tree_node_cachep,
> > +					 GFP_KERNEL, numa_node);
> > +	if (!new_node)
> > +		return;
> > +
> > +	xa_lock_irq(xa);
> > +
> > +	/* Check again..... */
> > +	if (xa != node->array || !list_empty(&node->private_list)) {
> > +		node = new_node;
> > +		goto unlock;
> > +	}
> > +
> > +	memcpy(new_node, node, sizeof(struct xa_node));
> > +
> > +	/* Move pointers to new node */
> > +	INIT_LIST_HEAD(&new_node->private_list);
> 
> Surely we can do something more clever, like ...
> 
> 	if (xa != node->array) {
> ...
> 	if (list_empty(&node->private_list))
> 		INIT_LIST_HEAD(&new_node->private_list);
> 	else
> 		list_replace(&node->private_list, &new_node->private_list);

Oh nice, thanks!  I'll roll this into the next version.

> BTW, the raidx tree nodes / xa_nodes share the same slab cache; we need
> to finish converting all radix tree & IDR users to the XArray before
> this series can go in.

Ok, I'll add this comment to the commit log for this patch on the next
version so we don't forget.  FTR complete conversion to the XArray is
your goal isn't it (on the way to the Maple tree)?

thanks,
Tobin.

