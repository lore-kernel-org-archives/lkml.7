Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3384C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ADC20866
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="BUbr09iH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0AySjuOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCHTxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:53:46 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60979 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbfCHTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:53:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C49A21D09;
        Fri,  8 Mar 2019 14:53:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 08 Mar 2019 14:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=EBeIov4ac8U20cNceUuu8eIcm0A
        kI9pPam0NCd5Le2I=; b=BUbr09iHTMItQ+AEddCgSvILkEYUNSVYYlK/MWgiMxk
        AEWgI8NbJln/frY8FDRE2kAo4w3NVlS+GbV6zx1sMNPkPCel1mTFJg0VVCdSvfH1
        rMedU/68F+VUu2pBKauLDOH1/MgchW8AbGsUCTqGOW4w/Jd7YuyY426RWC5dq20S
        m83KHrYPDvrai/SSF6fiRbA4d21JAHAETFTVH40p9tVIFh+H1TkBhZXGjjRZ6faq
        oakalofcQM3HZBcDq5croPga0u4gbJ4R3oasSGQFinCmarA5M8deKVVYlmaAM4QB
        RXYypTJ8rO2cstnVe3wEsi8ZhHkBaRvozc/nkzQ0ZOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EBeIov
        4ac8U20cNceUuu8eIcm0AkI9pPam0NCd5Le2I=; b=0AySjuOWbHUlQvcfVmKTb/
        b7L8MXhYcPXIBdQjnKCiDkMlmeIgqdGPJOOArx7Qsxco0X3kzHmPTINZ301eKAWA
        ld3e6np52dkiwIJrwc4QOWGBfDguQ0BI+/lg4qhwnDJy3/defAUYPmYfnslBwGck
        2VFgMmP0dk5FVtmSNzg7uGF8LjrZa8kQY3Jcq9zW0U6RNIRWWQRKbdAaJ+tAgZTd
        lbD9QKf5XE3sPovIy44rzssEd5zbCt37abc27W3uH62frhFkRzp58YFFYHjd1zqO
        Gvko/KFqvdB7iPT7WTaMAoLn9ub8zrq9Ozd+Oq5CXp26K75MuXYVjIoVl4OR2qeg
        ==
X-ME-Sender: <xms:R8iCXBsb21leKgdIC_wpHG-ZdZUgLApRAvzuZa8Rg0is5mZxBfgMpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgedtgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdduledrudektdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:R8iCXNeIMLvbpuGgV5tcA8BbkOVE_iDoTFr3tvTSTFkfN3Q9Foe7xQ>
    <xmx:R8iCXHXSpwCXlaRwJwZMrUAY0t1siwlxRV1g0bkyxCwX7I09op0ZjA>
    <xmx:R8iCXCotG_YL4ud0CGRwcOsMTKPTQlbnWyWyR66Kg9Sq8jOhs5Gj1Q>
    <xmx:SciCXCbtC86L5OOBtR6TLEpjglOTRqg_ix6c8WFlTD0ar0kgD_qJKw>
Received: from localhost (124-169-19-180.dyn.iinet.net.au [124.169.19.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3CCB8E4580;
        Fri,  8 Mar 2019 14:53:42 -0500 (EST)
Date:   Sat, 9 Mar 2019 06:53:22 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christopher Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/15] slub: Add isolate() and migrate() methods
Message-ID: <20190308195322.GA25102@eros.localdomain>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-3-tobin@kernel.org>
 <20190308152820.GB373@cisco>
 <010001695e16cdef-9831bf56-3075-4f0e-8c25-5d60103cb95f-000000@email.amazonses.com>
 <20190308162237.GD373@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308162237.GD373@cisco>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:22:37AM -0700, Tycho Andersen wrote:
> On Fri, Mar 08, 2019 at 04:15:46PM +0000, Christopher Lameter wrote:
> > On Fri, 8 Mar 2019, Tycho Andersen wrote:
> > 
> > > On Fri, Mar 08, 2019 at 03:14:13PM +1100, Tobin C. Harding wrote:
> > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > index f9d89c1b5977..754acdb292e4 100644
> > > > --- a/mm/slab_common.c
> > > > +++ b/mm/slab_common.c
> > > > @@ -298,6 +298,10 @@ int slab_unmergeable(struct kmem_cache *s)
> > > >  	if (!is_root_cache(s))
> > > >  		return 1;
> > > >
> > > > +	/*
> > > > +	 * s->isolate and s->migrate imply s->ctor so no need to
> > > > +	 * check them explicitly.
> > > > +	 */
> > >
> > > Shouldn't this implication go the other way, i.e.
> > >     s->ctor => s->isolate & s->migrate
> > 
> > A cache can have a constructor but the object may not be movable (I.e.
> > currently dentries and inodes).
> 
> Yep, thanks. Somehow I got confused by the comment.

I removed code here from the original RFC-v2, if this comment is
confusing perhaps we are better off without it.

thanks,
Tobin.
