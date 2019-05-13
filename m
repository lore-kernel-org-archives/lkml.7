Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36577C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0584F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="BvZ23USq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnx7+g5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEMVlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:41:16 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40285 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbfEMVlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:41:15 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E36E05C2;
        Mon, 13 May 2019 17:41:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 May 2019 17:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Vn/T/POBtkQCivubXNnOyOKOoXD
        swoy+p7rd61BSZqE=; b=BvZ23USq+n0H6bFfinEnI042Scm2YF1IK4T/Ipy1oA7
        EnMtmM24XOtJG3N6yUG9XfvPeAZ/DSmgYOungx4VobZ6ghiLq//Xwp0sr5EEG7tM
        Chzj5aZKD6m7W1TvsCqEtWYJStcGCVl5G+L6L8KT4XKk/Q49y9FrPvwUw/u5w5D7
        O5qDuZBkWjWLkA8eVdRxL4ZDD4N84oiQQg70BWtobahYl6yrquda8wBvHZGUs04V
        KYsqffXOd3dFefZHvErodbuAPP7ralWwr5/PUjmwOHIPcRoJ33o8+xbuQoRLhy1b
        S+15WBT9/o6/uFE9+rF5lgoLuJ8F+DzCb3RRLdnM1ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Vn/T/P
        OBtkQCivubXNnOyOKOoXDswoy+p7rd61BSZqE=; b=hnx7+g5RF4XXPsmU/JIrvk
        trc7cyfb04VRdoTVoe6lKHx3US8i5l74WHwRKYREd8NxzoJ5f0nOTy1M+wkndKvQ
        s36lQuteqU+wHNSrt27kx4eBalmY3U7wD/jg1Z5IgxEKOZZkUG1dAnxwkJKDRIZM
        WGjxtno8qEf25ApyCQubPFDreAjW3PRnIJWgKKRg/RgBScFbfFagIq9ZZPRXGGMW
        45UJP80rwyEROZa4jRQ3Xpd3vJ2I1jtMqXEB559MMNKKwZLuzZBzxPr7qofa7ejV
        YkFZA7q3aCJ7IZ65bQZZS2tVhrsdzechSy+eWC2ALV6kf0kmor9G9G0gMsENPrkA
        ==
X-ME-Sender: <xms:d-TZXFRRkH-8e7vBJEPVZcl5TD4sDNFnspcIQp7fTLcc5I94HJLIGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdduiedrudekheenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:d-TZXK5j0tX3LgYou62RdrIWuzXD-nvhFHkz-iUYE9ZiNbWDK7_OQw>
    <xmx:d-TZXEHh35WyA_1MN-hDT2kJcyx-PXCTO7hDV8IbYGIDwM0JtHDAsw>
    <xmx:d-TZXMGzgk4fcT7RSe5zg_VG4SvazSyA1wEV-tv5d0XbsyNngqy8xw>
    <xmx:d-TZXOSeMpWkHt6eP0ekLynCg-eMfbDDpJmpcXY3eYLiYcfYacYm_Q>
Received: from localhost (124-169-16-185.dyn.iinet.net.au [124.169.16.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9515E80063;
        Mon, 13 May 2019 17:41:10 -0400 (EDT)
Date:   Tue, 14 May 2019 07:40:39 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
Message-ID: <20190513214039.GA27187@eros.localdomain>
References: <20190513033213.2468-1-tobin@kernel.org>
 <20190513071405.GF2868@kroah.com>
 <20190513103936.GA15053@eros.localdomain>
 <CAHc6FU7FCBn1CnzEjyj8W7LBu-Ths7bME2R3_GQ2ZmsFQxWEhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7FCBn1CnzEjyj8W7LBu-Ths7bME2R3_GQ2ZmsFQxWEhA@mail.gmail.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 06:41:23PM +0200, Andreas Gruenbacher wrote:
> On Mon, 13 May 2019 at 12:40, Tobin C. Harding <me@tobin.cc> wrote:
> >
> > On Mon, May 13, 2019 at 09:14:05AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, May 13, 2019 at 01:32:13PM +1000, Tobin C. Harding wrote:
> > > > If a call to kobject_init_and_add() fails we must call kobject_put()
> > > > otherwise we leak memory.
> > > >
> > > > Function always calls kobject_init_and_add() which always calls
> > > > kobject_init().
> > > >
> > > > It is safe to leave object destruction up to the kobject release
> > > > function and never free it manually.
> > > >
> > > > Remove call to kfree() and always call kobject_put() in the error path.
> > > >
> > > > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > > > ---
> > > >
> > > > Is it ok to send patches during the merge window?
> > > >
> > > > Applies on top of Linus' mainline tag: v5.1
> > > >
> > > > Happy to rebase if there are conflicts.
> > > >
> > > > thanks,
> > > > Tobin.
> > > >
> > > >  fs/gfs2/sys.c | 7 +------
> > > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > >
> > > > diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> > > > index 1787d295834e..98586b139386 100644
> > > > --- a/fs/gfs2/sys.c
> > > > +++ b/fs/gfs2/sys.c
> > > > @@ -661,8 +661,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
> > > >     if (error)
> > > >             goto fail_reg;
> > > >
> > > > -   sysfs_frees_sdp = 1; /* Freeing sdp is now done by sysfs calling
> > > > -                           function gfs2_sbd_release. */
> > >
> > > You should also delete this variable at the top of the function, as it
> > > is now only set once there and never used.
> >
> > Thanks, I should have gotten a compiler warning for that.  I was feeling
> > so confident with my builds this morning ... pays not to get too cocky
> > I suppose.
> >
> > > With that:
> > >
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Thanks, will re-spin.
> 
> Don't bother, I'll fix that up.

Thanks man!
