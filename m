Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDDC48BD3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7CB20856
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562427751;
	bh=E2Wp+2tu1z65R6wgftwY1VKNw2jNrsx/ERN7YQtjaJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NrJQPqQwW6FNMvkLHgMy6eR3n2urgSq4fJp0qYy4J/1gkrE9ATj7jnmb5YUY9BSX6
	 FPAzfYTZA1tipoLSFQXd5JxOhVKAw8beOFUwoGdHi2dCTHEL7U1pf8VDkAjp50oa+z
	 5fWVGOQzLOZ0t+lmTbVIwDn1LzKqecJWYiGXgYJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGFPma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfGFPma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:42:30 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCEA20838;
        Sat,  6 Jul 2019 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562427749;
        bh=E2Wp+2tu1z65R6wgftwY1VKNw2jNrsx/ERN7YQtjaJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DegJDqZS91xLGsRqsJDwfXRtpXHxqOHr3lZAnpBWsVKGteEFmAo8qTo8Q/7LcvndA
         7GqbYgnAZD6gslZVyemwQkzcYVUUXwViBpA/wJrdR61dh+JaRKJyhToMvop+kRl9vV
         qwhVYuzBxZWTvLRMoAd8RnO0gU3gRGcOiWbo9EBU=
Date:   Sat, 6 Jul 2019 17:42:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: Tree for Jul 4
Message-ID: <20190706154224.GA2698@kroah.com>
References: <20190704220945.27728dd9@canb.auug.org.au>
 <20190704222450.021c9d71@canb.auug.org.au>
 <20190706083433.GB9249@kroah.com>
 <20190706194412.64c15c42@canb.auug.org.au>
 <20190706094647.GA17929@kroah.com>
 <20190706201729.48548ede@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706201729.48548ede@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 08:17:29PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Sat, 6 Jul 2019 11:46:47 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jul 06, 2019 at 07:44:12PM +1000, Stephen Rothwell wrote:
> > > 
> > > On Sat, 6 Jul 2019 10:34:33 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:  
> > > >
> > > > On Thu, Jul 04, 2019 at 10:24:50PM +1000, Stephen Rothwell wrote:  
> > > > > 
> > > > > This release produces a whole lot (over 200) of this message in my qemu
> > > > > boot tests:
> > > > > 
> > > > > [    1.698497] debugfs: File 'sched' already present!
> > > > > 
> > > > > Introduced by commit
> > > > > 
> > > > >   43e23b6c0b01 ("debugfs: log errors when something goes wrong")
> > > > > 
> > > > > from the driver-core tree.  I assume that the error(?) was already
> > > > > happening, but it is now being reported.    
> > > > 
> > > > What are you passing to qemu to get this?  I just tried it myself and
> > > > see no error reports at all.  Have a .config I can use to try to
> > > > reproduce this?  
> > > 
> > > It is a powerpc pseries_le_defconfig kernel and I run qemu like this:
> > > 
> > > qemu-system-ppc64 -M pseries -m 2G -vga none -nographic -kernel vmlinux -initrd rootfs.cpio.gz  
> > 
> > Hm, I think my rootfs initrd might be quite simple compared to yours (it
> > drops me into a busybox shell).  Any pointers to where you created yours
> > from?
> 
> Michael Ellerman gave it to me.  It is very simple.  Its /init is just
> 
> $ cat init
> #!/bin/sh
> # devtmpfs does not get automounted for initramfs
> /bin/mount -t devtmpfs devtmpfs /dev
> exec 0</dev/console
> exec 1>/dev/console
> exec 2>/dev/console
> exec /sbin/init $*
> 
> and /sbin/init is a link to /bin/busybox
> 
> It is all run by an expect script that just waits for the login:
> prompt, logs in a root and runs "halt".
> 
> All the debugfs messages appear before the kernel finished booting.

Ah, found the bug.  Turns out I caused it in the blk queue debugfs code
a short while ago.  I'll post a patch for this in a few minutes...

thanks,

greg k-h
