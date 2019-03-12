Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB158214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="qNSobwJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OBy44wk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfCLCCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:02:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33735 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfCLCCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:02:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 32CAC22101;
        Mon, 11 Mar 2019 22:02:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Mar 2019 22:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=t+vi9vkWEvQdhqL9XEq4Jv0l/8V
        RKRuscgdakwpYeMI=; b=qNSobwJBVluA9sSGqRjqg+kqOcrP67t1AkbwiMVfzzM
        o0uxLX/KyTEryiaHt/vQk5JY0AN8onQHLrwEDA5YI0IZ7teDzOOfJ2rR5BfGtLcf
        d1BDX7RHuMbFLcg3vdmFE90JubG+4y84cKyUNqgxuVSTyVfSsCvcmDLbr4bgDtmp
        eNSSL2uy5hQSIc0j3l3ULHYef9kf9eWNVbQ1xHi9hgmA4Brrudc54U1LCFddlMhb
        zYuabPa1l14nYBaemf2MWumqrui5UcAizYKu1M5RC12G9vN8FXfFgtGnNyKgsdRj
        LViUz233at3c22Dp8PmvJEoCX/1YMUnPqwYHed0RMFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=t+vi9v
        kWEvQdhqL9XEq4Jv0l/8VRKRuscgdakwpYeMI=; b=OBy44wk1OXwkB4anjukE4N
        uQuxYdiGaXE8BrymM+qmULY9p22YP20pOa6J9qLPnySUVKXxw6MueXROxKziFsE0
        G9WutsuHH6w4bSj6qxFlCjnVaqMv0yxlvHXgOQcXxVSTaWbqkj+kE4RvJhSB7mHu
        5njYpNTNa00gP3KHfvgQLdp8L5wRDgXdrevU2KHzea5UlR3oSwpFggaT005fSSLg
        Q7qOM9yI64A0aDbt1RckmbRuWgchfSpksbCQ13RB1j0haanIFcvgVxPGL1Y5SSpx
        wuPEaPQ0TS79We8HOt4ZV8T5xOHoi2b55Xs/ApNVxJS5j4IttaAp1WlGMqP2fz8A
        ==
X-ME-Sender: <xms:OBOHXCdz5yjplf3hng7QceLw_74KLL4fYxtYRZRSzBpTeTpveQaaBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:OBOHXCmoFxQCehxzRvZHOC7ap5bN8wv_9NxbJfd34I-P0ImNg-xiJw>
    <xmx:OBOHXINvmauqekS8ns7PY5srYUDIy5_W2q7VPhBIu1jo0vmg9-l_3A>
    <xmx:OBOHXDFT6iOnESa8f9dB6RAeLidUBguI-hTmml45gkB7YIUSo77y_A>
    <xmx:OROHXCJ2QvHv4IhExcGHzk9QK4DbrBWIeobQXFteCxap0qATy9XoNw>
Received: from localhost (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 48D7BE4665;
        Mon, 11 Mar 2019 22:02:31 -0400 (EDT)
Date:   Tue, 12 Mar 2019 13:01:53 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Message-ID: <20190312020153.GJ9362@eros.localdomain>
References: <20190311010744.5862-1-tobin@kernel.org>
 <20190311204919.GA20002@tower.DHCP.thefacebook.com>
 <20190311231633.GF19508@bombadil.infradead.org>
 <20190312002217.GA31718@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312002217.GA31718@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:22:23AM +0000, Roman Gushchin wrote:
> On Mon, Mar 11, 2019 at 04:16:33PM -0700, Matthew Wilcox wrote:
> > On Mon, Mar 11, 2019 at 08:49:23PM +0000, Roman Gushchin wrote:
> > > The patchset looks good to me, however I'd add some clarifications
> > > why switching from lru to slab_list is safe.
> > > 
> > > My understanding is that the slab_list fields isn't currently in use,
> > > but it's not that obvious that putting slab_list and next/pages/pobjects
> > > fields into a union is safe (for the slub case).
> > 
> > It's already in a union.
> > 
> > struct page {
> >         union {
> >                 struct {        /* Page cache and anonymous pages */
> >                         struct list_head lru;
> > ...
> >                 struct {        /* slab, slob and slub */
> >                         union {
> >                                 struct list_head slab_list;     /* uses lru */
> >                                 struct {        /* Partial pages */
> >                                         struct page *next;
> > 
> > slab_list and lru are in the same bits.  Once this patch set is in,
> > we can remove the enigmatic 'uses lru' comment that I added.
> 
> Ah, perfect, thanks! Makes total sense then.
> 
> Tobin, can you, please, add a note to the commit message?
> With the note:
> Reviewed-by: Roman Gushchin <guro@fb.com>

Awesome, thanks.  That's for all 4 patches or excluding 2?

thanks,
Tobin.
