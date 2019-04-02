Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D26C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEB42075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="DwVu0TB0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAkeXXEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfDBTGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:06:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44773 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728479AbfDBTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:06:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B3BB21C57;
        Tue,  2 Apr 2019 15:06:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Apr 2019 15:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tRHgReLT3oOtyuahd5OJIneMe7p
        sB9fqOhUXYvm8M/I=; b=DwVu0TB0bBuDj1lZNjOpeldVkKgQyV/+QobDE6sSyDn
        doGE2BfKpnqPWMYAOmEa84n8QTYNrBxHM7yveETmT7YVBthnjm2KQ3ot52I9u0Lv
        MOraVi9ABRFs/zn8NUpFEQzKV+9FJzPkk8jz1JVe7pXiHhhllKH7cmp4O5s90SMT
        KyTK8yjS1vOReS0duyE+rQarqujIfnqQBWnni5ZnaSvS7+kaG4kR47z8TU286hOi
        nHPzCi94lvVNGV1tLZxFy2b3MaveVf8CFrw+et6YP21nBAGefWOy0nVjJW8s4Qw8
        h8ycf/QLKmSUf+EbiZg+YwEirQJmnj50MNU4N8VWvpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tRHgRe
        LT3oOtyuahd5OJIneMe7psB9fqOhUXYvm8M/I=; b=ZAkeXXELE4vDYclUgl6Y4c
        RLZxxGWZdIqjWIY7JIOu7a+KRfUhQrLB/Yi6zhUCXwEqQS/X1o0Of2Gfx3aYTD/e
        WdUozuvvlsZTUA8O7VwhZqWIvOT+wJx46//U43TspLr0PaJ5S3lX5w2uq927D80s
        p6IMZp+Mtqm9Ba8zjmeNgMgvBe8BrtyjAMCu6KzgiXlrv2bA3GCBYSNlxgFkVmt2
        QpBB+d+KysQQzVCUmehPUGlnJo4hhyyi1NOQ5Fs7yndd/VtoApvSRSp4xde/GECL
        HVXBVutHZrZHuxb0WRbtgn1bLx58Gk1sEAd7y7JovAH4Ko5LKIRlhOyfDI+xnjAg
        ==
X-ME-Sender: <xms:oLKjXBTOrMqpTcEaqfRycN3wOaL5CY5NfGefnQHamWkcX2Z7UxDqWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddtgdduuddvucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffk
    fhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrh
    guihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduvdegrdduieelrddvjedr
    vddtkeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:oLKjXEJIagNhapY_ZtTwDZR_S3rw24kOBhQuF9TWF_v952vMfKmbvQ>
    <xmx:oLKjXP-OJtkn7d0QYj_A9lZo1t7bfWTkt6y2GT9XDd2ECB8JK51S7w>
    <xmx:oLKjXMAq1UlhEqNmTO97x8DjE5iLtghGk687ktSWPZUmRhGkGqt-BQ>
    <xmx:orKjXHe8fFFfz9NFMPd5kqKu-yic0V2rq7jtDyv5wzxXtvz_vHjtng>
Received: from localhost (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5803AE4210;
        Tue,  2 Apr 2019 15:06:07 -0400 (EDT)
Date:   Wed, 3 Apr 2019 06:05:38 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, LKP <lkp@01.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] slob: Only use list functions when safe to do so
Message-ID: <20190402190538.GA5084@eros.localdomain>
References: <20190402032957.26249-1-tobin@kernel.org>
 <20190402032957.26249-2-tobin@kernel.org>
 <20190401214128.c671d1126b14745a43937969@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401214128.c671d1126b14745a43937969@linux-foundation.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:41:28PM -0700, Andrew Morton wrote:
> On Tue,  2 Apr 2019 14:29:57 +1100 "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > Currently we call (indirectly) list_del() then we manually try to combat
> > the fact that the list may be in an undefined state by getting 'prev'
> > and 'next' pointers in a somewhat contrived manner.  It is hard to
> > verify that this works for all initial states of the list.  Clearly the
> > author (me) got it wrong the first time because the 0day kernel testing
> > robot managed to crash the kernel thanks to this code.
> > 
> > All this is done in order to do an optimisation aimed at preventing
> > fragmentation at the start of a slab.  We can just skip this
> > optimisation any time the list is put into an undefined state since this
> > only occurs when an allocation completely fills the slab and in this
> > case the optimisation is unnecessary since we have not fragmented the slab
> > by this allocation.
> > 
> > Change the page pointer passed to slob_alloc_page() to be a double
> > pointer so that we can set it to NULL to indicate that the page was
> > removed from the list.  Skip the optimisation if the page was removed.
> > 
> > Found thanks to the kernel test robot, email subject:
> > 
> > 	340d3d6178 ("mm/slob.c: respect list_head abstraction layer"):  kernel BUG at lib/list_debug.c:31!
> > 
> 
> It's regrettable that this fixes
> slob-respect-list_head-abstraction-layer.patch but doesn't apply to
> that patch - slob-use-slab_list-instead-of-lru.patch gets in the way. 
> So we end up with a patch series which introduces a bug and later
> fixes it.

Yes I thought that also.  Do you rebase the mm tree?  Did you apply this
right after slob-use-slab_list-instead-of-lru or to the current tip?  If
it is applied to the tip does this effect the ability to later bisect in
between these two commits (if the need arises for some unrelated reason)?

> I guess we can live with that but if the need comes to respin this
> series, please do simply fix
> slob-respect-list_head-abstraction-layer.patch so we get a clean
> series.

If its not too much work for you to apply the new series I'll do another
version just to get this right.

	Tobin.
