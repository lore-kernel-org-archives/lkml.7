Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0836C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F1B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="xN/6sspu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/R4rO1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfDDU3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:29:50 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34711 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbfDDU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:29:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 579542560B;
        Thu,  4 Apr 2019 16:29:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 Apr 2019 16:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/iXR9Etw+vhQyqWT29ovFK7pHcL
        2BRgAxfihaLYxNSU=; b=xN/6sspuUWSZGBi1Y6IP5bVBNnkKiHLfPK1+bKTm9Iw
        1O5SJgWLRSrlQdM1AXjda/qvl79TwazNyHRdJX0ojkh+eJdhTJuEKEDushjL/+3t
        KTy82aJF+JGQ7orgX4IY8sMbT9Hdbn8IySArnOsjNkNmVLI2rI/mEVF93hcf17Y/
        PqYzhBIEoOGV74MQFREp/dcAEZkkWnwRBoxqZ524KzkylBI4yvNHLzUulthkCo3t
        hH1FBJHkgJDAEKE9DWz5v/mXDcb4js+kCj1lR0mpRhbHcR4VC4nUdPn9mf8n8ZIC
        3XV0+GW6RaQb0OEGGNL5qDeJzLMN61hkpLsEDyTghPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/iXR9E
        tw+vhQyqWT29ovFK7pHcL2BRgAxfihaLYxNSU=; b=B/R4rO1GDI3kRmLYZKv8WB
        SeLe+A21iuCN3AH0ZebZTI5QlSHszd82qxn+XLOZPPO/B9lXXZxDvbGqyQieWojm
        AdctTyhduWde6j2UdB0rED2s0kaYdGkV1VehppMy2likLREes6HG+i3rLuot3KHY
        OW7YDXrKQEQSOsrCqe4Mh0bj7OoIHb4ko+v48B+ECyBCzDQir4zu+Zw2pJdinzo4
        JH0eKbMqbnoeyiuOk9i9IvNXlYHQSPf2KjBiTQ1/9KJD/VWeGQJrT7kgeZk35A2t
        jYgZL+Bz3qmnbP4c2P39QIC+PUJmuuT2hKcOPz1zZQyotoAQMiBn7pl779BZUTOQ
        ==
X-ME-Sender: <xms:OmmmXHNr6umUKOcAIwbc6Wg9kBWMxrc_lwkgqeY5oYDasRTpCW26sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdehgddugeekucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffk
    fhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrh
    guihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduvdegrddugeelrdduudeg
    rdekieenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OmmmXIEWjJgt9a4gB3SR_KeJV-Pd52QAVK3sHw3mVFOFkwONm8nezw>
    <xmx:OmmmXL0ihRfvXIYC9bNXWaQ-ZYDKBaw-dFKOwfwv6GGeLrcimzwgcw>
    <xmx:OmmmXPE1R9PuTxd4BwO0_Oa4Z_w9exI7UCcncptmc6fN_ZYvzblexQ>
    <xmx:PGmmXKbm_HihBPB5nhLDVkeamBj1I_r5a8ABzHLN--z-dXB7G1oysA>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id B63B3E452B;
        Thu,  4 Apr 2019 16:29:44 -0400 (EDT)
Date:   Fri, 5 Apr 2019 07:29:14 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 14/14] dcache: Implement object migration
Message-ID: <20190404202914.GA16709@eros.localdomain>
References: <20190403042127.18755-1-tobin@kernel.org>
 <20190403042127.18755-15-tobin@kernel.org>
 <20190403170811.GR2217@ZenIV.linux.org.uk>
 <20190403171920.GS2217@ZenIV.linux.org.uk>
 <20190403174855.GT2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403174855.GT2217@ZenIV.linux.org.uk>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:48:55PM +0100, Al Viro wrote:
> On Wed, Apr 03, 2019 at 06:19:21PM +0100, Al Viro wrote:
> > On Wed, Apr 03, 2019 at 06:08:11PM +0100, Al Viro wrote:
> > 
> > > Oh, *brilliant*
> > > 
> > > Let's do d_invalidate() on random dentries and hope they go away.
> > > With convoluted and brittle logics for deciding which ones to
> > > spare, which is actually wrong.  This will pick mountpoints
> > > and tear them out, to start with.
> > > 
> > > NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > And this is a NAK for the entire approach; if it has a positive refcount,
> > > LEAVE IT ALONE.  Period.  Don't play this kind of games, they are wrong.
> > > d_invalidate() is not something that can be done to an arbitrary dentry.
> > 
> > PS: "try to evict what can be evicted out of this set" can be done, but
> > you want something like
> > 	start with empty list
> > 	go through your array of references
> > 		grab dentry->d_lock
> > 		if dentry->d_lockref.count is not zero
> > 			unlock and continue
> > 		if dentry->d_flags & DCACHE_SHRINK_LIST
> > 			ditto, it's not for us to play with
> >                 if (dentry->d_flags & DCACHE_LRU_LIST)
> >                         d_lru_del(dentry);
> > 		d_shrink_add(dentry, &list);
> > 		unlock
> > 
> > on the collection phase and
> > 	if the list is not empty by the end of that loop
> > 		shrink_dentry_list(&list);
> > on the disposal.
> 
> Note, BTW, that your constructor is wrong - all it really needs to do
> is spin_lock_init() and setting ->d_lockref.count same as lockref_mark_dead()
> does, to match the state of dentries being torn down.

Thanks for looking at this Al.

> __d_alloc() is not holding ->d_lock, since the object is not visible to
> anybody else yet; with your changes it *is* visible.

I don't quite understand this comment.  How is the object visible?  The
constructor is only called when allocating a new page to the slab and
this is done with interrupts disabled.

>  However, if the
> assignment to ->d_lockref.count in __d_alloc() is guaranteed to be
> non-zero to non-zero, the above should be safe.

I've done as you suggest and set it to -128

Thanks for schooling me on the VFS stuff.


	Tobin
