Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C606C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE1F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="v9qEBssM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7NOuyzjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfCLBGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:06:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40027 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfCLBGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:06:23 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E4E6226F4;
        Mon, 11 Mar 2019 21:06:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Mar 2019 21:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=BfTF9/5XfuXj8gIHT3yfX9FHWyt
        Oy+CqJr0NmgfbW+4=; b=v9qEBssMxx8UjrHaKeQhZGrw3xhr3nm6bsLRV6sPDqB
        THj4osgaOer9a8BFnE4tgtFjxJDGIvVV/iCjTAGtlRodeBYxsJ+yUNZ0bn/SwS/7
        DkuzjFVJOIhBpoH+fkfJb2/P1UW/TuSjdJcxh1HLq4b6EqGP1cqAeJ9uqlu3sge/
        u9poj+DVXxgfDqqIAnT0OD8o660l0V5Jr3vZ8gWqf1nNNlEOZwcMOdgUng+gZTzg
        6QalMJRVrhDiZBaysVbOhsx+GUc9/bjgOMccnxInavUpmrbN3xPVXe851HQ1Oyix
        cYNS8/4MJO1+WqQcTAcoipOEfkb++7NZIEYqLne5yAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BfTF9/
        5XfuXj8gIHT3yfX9FHWytOy+CqJr0NmgfbW+4=; b=7NOuyzjwFNct8c7dj37fdO
        AwnGdyS7YZ9+u7IhlASmz7qbcJb/xZK+a9X1cQNV1uzYjhaptK2bfGtHisp0kBis
        hboaR+hfPtW9/KEurLqVF+edbbceyzsuwUtbYW+hJbjttmclQ8dIBnbt7B8qDtak
        nruwK+ZjJuAveHL3xpyLkxncqg5+MTckcfwHpBkmPT/X1UQbRvc8FNvjTR3qXUAd
        4CEXN3RZH6bqunDQfJxkX+6nVxsQBZeJPD4SDfsO/gvP4xVEbWvGAF+WThkZI7Ya
        J7cJ1cIvCht2IOBmccJbH1z2izSuq9wHiuef5+SUQEAMFDcEmhFnJibVx8SdfKjw
        ==
X-ME-Sender: <xms:CgaHXPy18bevCJZaVvD4E2hMf2whqgQ950KYFAYYXJ7VZtXWWV8ABQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:CgaHXI7rg91R3vuz4n-POghIUOAhPxJD-h7wuW7Tyl-igrD_M1Ehlw>
    <xmx:CgaHXNbEdogCkmNboxXNCVCuZa2Z4z5E6VpMzWsM_gD8OaZd_nr6mA>
    <xmx:CgaHXP-5w56EjfhStOdjnadP9xKSayTk919MNx4gg1vzGOz7uVqIug>
    <xmx:DAaHXINCaELhtCEs2hH3NLMsxINiXJA4GpShyndbtsD_O20v3oPHUw>
Received: from localhost (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id AFE8C1030F;
        Mon, 11 Mar 2019 21:06:16 -0400 (EDT)
Date:   Tue, 12 Mar 2019 12:05:54 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <guro@fb.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Message-ID: <20190312010554.GA9362@eros.localdomain>
References: <20190311010744.5862-1-tobin@kernel.org>
 <20190311204919.GA20002@tower.DHCP.thefacebook.com>
 <20190311231633.GF19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311231633.GF19508@bombadil.infradead.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:16:33PM -0700, Matthew Wilcox wrote:
> On Mon, Mar 11, 2019 at 08:49:23PM +0000, Roman Gushchin wrote:
> > The patchset looks good to me, however I'd add some clarifications
> > why switching from lru to slab_list is safe.
> > 
> > My understanding is that the slab_list fields isn't currently in use,
> > but it's not that obvious that putting slab_list and next/pages/pobjects
> > fields into a union is safe (for the slub case).
> 
> It's already in a union.
> 
> struct page {
>         union {
>                 struct {        /* Page cache and anonymous pages */
>                         struct list_head lru;
> ...
>                 struct {        /* slab, slob and slub */
>                         union {
>                                 struct list_head slab_list;     /* uses lru */
>                                 struct {        /* Partial pages */
>                                         struct page *next;
> 
> slab_list and lru are in the same bits.  Once this patch set is in,
> we can remove the enigmatic 'uses lru' comment that I added.

Funny you should say this, I came to me today while daydreaming that I
should have removed that comment :)

I'll remove it in v2.

thanks,
Tobin.
