Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A9EC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A52208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="favjAw+a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HB4+xudE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfGLHpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:45:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49979 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbfGLHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:45:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B4C3222E4;
        Fri, 12 Jul 2019 03:45:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Jul 2019 03:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=TdDT4PcMZlJA5ggzk95aEHAbpX5
        ROIOgBrIvKCVPfEE=; b=favjAw+aeMM1F/VBZpryP4pyINTgk7/NL3c7Hc5seIg
        nGE5c9akzsoC+Fjen3V02MnhnYBrTWjgrgv2HZ9Q3C8kk4bTu7EEi1iJS/3sb/LM
        cgUlbsgiXMR/++UL77XI6l5OOHx8aY3oZ8HRdUp+p2MTyQsFuVG6+2eZJ3W1TUm0
        fZB8iRKQ4TjO68CO/RvEpTvAKwTQosr7RN4n3DDSpr4Ai3cxmzF8IOzRzfs5U12z
        /laN3E56eZCqsDYzq4dOoRjeM6g/UPg3ZNJbhaXoHk7H8NQdbOp3i/qYx4g1gWBX
        gtTHmyjbZAc2MR4uQPWb4w9RCTJMSbBNGWoQ6+Nw54A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TdDT4P
        cMZlJA5ggzk95aEHAbpX5ROIOgBrIvKCVPfEE=; b=HB4+xudEEX/3witkn1uJd6
        72e/lyHKUYs9SREGyiUchn9RGgGCQoDpv2KR5wthkDJJmE5gf8G3jTB4zxi6kPSN
        pIR7+461X3ieSFot65FX0YwuuZlBh298QM8zTVr+yo9FklrscwFkITKLedMxaq/Y
        j1IgtTUkjb1Xr4ZT2Mw3Q2jAzlp4VgNWvaMUYkJA2KJiXVBiHJZDpAsogztatWx2
        jY0qairQfv72lmZOk/XYIDro8EwUpt9/C2Lz1drBZBUKI+v0ycF3slu25T/JIEXZ
        ZBup/qU87iiAAwmiuC8nQ1QNa35kDg3Tv0lYMSB7Ne4xv9vW3eu0zXNtt60zR7Pg
        ==
X-ME-Sender: <xms:lzooXdviQO1s--D4L4g6FQlW4VNGPWZMlOjvIBhmwIV_8ncY545HsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeelgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:lzooXYsFmlmvwD3Fv7Q6_fHfta5A-1nE2dYsEDHgfRhhyhbRikhlUg>
    <xmx:lzooXQ1d8kvFjDVJfA9Ee4RNl6gNFFXl92eerKksUxkoJuHNl4glWg>
    <xmx:lzooXdJSeFAQIipnXsVtvZNJlURLfM5He2b8ZUHA36ZpC9K3UA9_7w>
    <xmx:mDooXVaVLzr4F47YC6UjToBjulNeSWcu6G6sSUSdpkcDYe6dzF8k2A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC836380085;
        Fri, 12 Jul 2019 03:45:26 -0400 (EDT)
Date:   Fri, 12 Jul 2019 09:45:25 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190712074525.GB16826@kroah.com>
References: <20190613155344.64fce8b9@canb.auug.org.au>
 <20190709092003.6087a9c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709092003.6087a9c4@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:20:03AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 13 Jun 2019 15:53:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the char-misc tree got a conflict in:
> > 
> >   drivers/misc/vmw_balloon.c
> > 
> > between commit:
> > 
> >   225afca60b8a ("vmw_balloon: no need to check return value of debugfs_create functions")
> > 
> > from the driver-core tree and commits:
> > 
> >   83a8afa72e9c ("vmw_balloon: Compaction support")
> >   5d1a86ecf328 ("vmw_balloon: Add memory shrinker")
> > 
> > from the char-misc tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc drivers/misc/vmw_balloon.c
> > index fdf5ad757226,043eed845246..000000000000
> > --- a/drivers/misc/vmw_balloon.c
> > +++ b/drivers/misc/vmw_balloon.c
> > @@@ -1553,15 -1942,26 +1932,24 @@@ static int __init vmballoon_init(void
> >   	if (x86_hyper_type != X86_HYPER_VMWARE)
> >   		return -ENODEV;
> >   
> > - 	for (page_size = VMW_BALLOON_4K_PAGE;
> > - 	     page_size <= VMW_BALLOON_LAST_SIZE; page_size++)
> > - 		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
> > - 
> > - 
> >   	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
> >   
> > + 	error = vmballoon_register_shrinker(&balloon);
> > + 	if (error)
> > + 		goto fail;
> > + 
> >  -	error = vmballoon_debugfs_init(&balloon);
> >  -	if (error)
> >  -		goto fail;
> >  +	vmballoon_debugfs_init(&balloon);
> >   
> > + 	/*
> > + 	 * Initialization of compaction must be done after the call to
> > + 	 * balloon_devinfo_init() .
> > + 	 */
> > + 	balloon_devinfo_init(&balloon.b_dev_info);
> > + 	error = vmballoon_compaction_init(&balloon);
> > + 	if (error)
> > + 		goto fail;
> > + 
> > + 	INIT_LIST_HEAD(&balloon.huge_pages);
> >   	spin_lock_init(&balloon.comm_lock);
> >   	init_rwsem(&balloon.conf_sem);
> >   	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
> 
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

Ok, I sent off the pull request for the driver core tree now.  I had all
of my other trees merged "first" so that all of the conflicts would
happen just once here.  Hopefully I've pointed out all of the potential
and real problems with this merge.

Ugh, this was a messy one, sorry about all of this, full-tree api
changes and cleanups are a pain at times.

thanks,

greg k-h
