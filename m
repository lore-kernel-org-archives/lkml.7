Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C1C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13F0206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556468102;
	bh=Z2d74mf++K8b222mNrf6+2RpM7/IWNqzhtE4h+cyd64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pf8JQDOgFKli4PeYTSzkeX8EameS4TFKo2dB29+3mkmbkuQKyCzmvaBcaGtm1SG5G
	 4pJ8JgjkeDTCe1BRnL1/+8e5bygIjE2gOzK2tft+MuGChXg5dvkgh5u0mpSTNRiugj
	 /NKjExxYN0gY+O3wlS8ZaQMBKtzvGdaXOiHOqVzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfD1QPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 12:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfD1QPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 12:15:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D158F206BB;
        Sun, 28 Apr 2019 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556468100;
        bh=Z2d74mf++K8b222mNrf6+2RpM7/IWNqzhtE4h+cyd64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIcmVvMoRy6z6VL/KInWG81bXFrspiyFROo9q+J3+vWSVhD4rXLL8Fam0CshNFpFO
         sKGsiIBBeJy0UfHjST9urxQuQ3Kr+EsrbB8Co6vmcFf8zgvRbT1x8SNzIbx/5uctOu
         W0UdwmlSZDcgOOCM43R9G5yRw8IydKQNkipgt2/w=
Date:   Sun, 28 Apr 2019 18:14:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Message-ID: <20190428161458.GB13309@kroah.com>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
 <20190428011957.GA18843@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428011957.GA18843@eros.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 11:19:57AM +1000, Tobin C. Harding wrote:
> On Sat, Apr 27, 2019 at 09:28:09PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 27, 2019 at 06:13:30PM +1000, Tobin C. Harding wrote:
> > > (Note at bottom on reasons for 'To' list 'Cc' list)
> > > 
> > > Hi,
> > > 
> > > kobject_init_and_add() seems to be routinely misused.  A failed call to this
> > > function requires a call to kobject_put() otherwise we leak memory.
> > > 
> > > Examples memleaks can be seen in:
> > > 
> > > 	mm/slub.c
> > > 	fs/btrfs/sysfs.c
> > > 	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()
> > > 
> > >  Question: Do we fix the misuse or fix the API?
> > 
> > Fix the misuse.
> 
> Following on from this.  It seems we often also forget to call
> kobject_uevent() after calls to kobject_init_and_add().

Are you sure?  Usually if you don't call it right away, it happens much
later when you have everything "ready to go" to tell userspace that it
then can access that kobject successfully.

Any specific places you feel is not correct?

> Before I make a goose of myself patching the whole tree is there ever
> any reason why we would _not_ want to call kobject_uevent() after
> successfully calling kobject_add() (or kobject_init_and_add())?

You should always do so, but again, sometimes it can be much "later"
after everything is properly set up.

Ok, at quick glance I see some places that do not properly call this.
But, those places should not even be using a "raw" kobject in the first
place, they should be using 'struct device'.  If code using a kobject,
that should be very "rare", and not normal behavior in the first place.

thanks,

greg k-h
