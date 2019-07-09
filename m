Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0CC606D4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E293A20665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="iirb/6Ws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xQfFfIj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGIGfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:35:16 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44473 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbfGIGfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:35:15 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CAD8A38B;
        Tue,  9 Jul 2019 02:35:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 09 Jul 2019 02:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=v8ab4iz9mRCsmFOih2FrXq41LQe
        WiVzpeFoeaTn6hNU=; b=iirb/6WsCSI72Cry2wR8Bk05xjMShkMzoq0iAUsHOrf
        cxtju/5PixmO9n7iw230R2FxqWcmX9fjoZNrS3x2onMxrjXaZ5QXFfs3GsN4/hTl
        zZIRkwXvtmDu/N6CcRICo67UH4xsx8iEH4gIDRrEjtuUYTjak0LU0FnXluz1DH3R
        NUNqfVbpRWYwsuH9UQhNcEhGZ9B8qqLffRf5LqSuSoaGJM7QdqepRejEs7M1IVpD
        rR17CiVFCkgefoLrWexJszEjoBgUPwUCZzAP00LZyYYDSeuqfuyk2kKfWvuRoCc4
        uaC5qld7cdGXbEGEHW+A9AlEQ4PdiNMhx9ZqViK5prQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=v8ab4i
        z9mRCsmFOih2FrXq41LQeWiVzpeFoeaTn6hNU=; b=xQfFfIj7CC5zEcAGqOi/rP
        GUxpW2wniHebayaVAgyUwuto91M/CYo+jshTVjELVT/YsG2imZ27dA4FvogoG70m
        2NBBtuHvfZKWwjza20QZw6OkEkH98MqGQAt6z9zKZze7UZQMmwyM8+5BHbIvX/Fi
        eevsFqDW8Ez0Sya6+EWW3s8W4k9uHzSCzL9Nohc5W8i6pDas0RBKMAjK4CEbQmJ5
        WzovAkWMmvDQ1o2vexhAizJVZpiYZg0USO+0khnLf7OjObBvTngZpIr28iJjOe4d
        GVNlwgttQjU8PD5WPpVyonkBxhMziinU/JaIcaC3edkadW68coPBTJU1mYSCpg8w
        ==
X-ME-Sender: <xms:oTUkXZYiA98kgBjXVX2SZBduegJYPV0m2q3Crnb1--UQ59XbMcKOpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgedugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:oTUkXctqW33h0l1NVMpVtS6ws9bfP11KqTyVFOrEvBpMO1aDRNYoYg>
    <xmx:oTUkXevjAQ5NcgbDmBV7OaaIstu_lpm-B1ND3ZFPzxxarS5QFDxtDg>
    <xmx:oTUkXZfMymim6Q-oQXx23pRgchGQgpZWE6T-WiCquoXO82JSdTumbg>
    <xmx:oTUkXcSyvUf1VAqp-EgPRGTAZtnKfqAJOh-_StDc7RWwCLwt8SrgJA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2B4980061;
        Tue,  9 Jul 2019 02:35:12 -0400 (EDT)
Date:   Tue, 9 Jul 2019 08:35:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the pci tree
Message-ID: <20190709063510.GB10587@kroah.com>
References: <20190624171229.6415ca4f@canb.auug.org.au>
 <20190624073443.GA13830@kroah.com>
 <20190624174729.327f2edf@canb.auug.org.au>
 <20190709095833.727ac5e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709095833.727ac5e8@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:58:33AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 24 Jun 2019 17:47:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the usb tree got a conflict in:
> > 
> >   Documentation/index.rst
> > 
> > between commit:
> > 
> >   c42eaffa1656 ("Documentation: add Linux PCI to Sphinx TOC tree")
> > 
> > from the pci tree and commit:
> > 
> >   ecefae6db042 ("docs: usb: rename files to .rst and add them to drivers-api")
> > 
> > from the usb tree.
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
> > diff --cc Documentation/index.rst
> > index 239100accbf6,91055adde327..000000000000
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@@ -101,7 -101,7 +101,8 @@@ needed)
> >      filesystems/index
> >      vm/index
> >      bpf/index
> >  +   PCI/index
> > +    usb/index
> >      misc-devices/index
> >   
> >   Architecture-specific documentation
> 
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

For a merge issue like this, I think he can handle it :)

thanks,

greg k-h
