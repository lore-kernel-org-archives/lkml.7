Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121A8C468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF38321670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562406418;
	bh=rUObuUBjwA6YaM0q4j967LHpg/fiBubMG6L+Pf7hk0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PV4DkXCtKXPtWoM1MJqS3bQhJPfCCl2/zYOcTrt80LUp/Z1kVsUOVBssbHjdLE4OT
	 owgHzcewlHFphVdpy0cdVdk8botsdXK8b7hNhxDuJHROwkOutoqNr3E6xmPhvKNZ6e
	 5XtY5fZCW/S4xJPPAgGPjhd9rrLNcszlncdlr9Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfGFJq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 05:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfGFJq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 05:46:57 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D822083B;
        Sat,  6 Jul 2019 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562406417;
        bh=rUObuUBjwA6YaM0q4j967LHpg/fiBubMG6L+Pf7hk0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TV5uvT5+onsV2X3m1vuIPIafA7wOf1Ij0hVjpcR9lHzBrtGBWOTjmZ/tTjA0Y/a3+
         04+f2E6DqOXyDrOrVgDfVQWUqEJQpFfzTPWZspv56FsxCYTYIifnM20a1lB1yIm/7b
         xy+blvts4pkOAw26YVLOstg4UouIk78QfEHqfc/g=
Date:   Sat, 6 Jul 2019 11:46:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 4
Message-ID: <20190706094647.GA17929@kroah.com>
References: <20190704220945.27728dd9@canb.auug.org.au>
 <20190704222450.021c9d71@canb.auug.org.au>
 <20190706083433.GB9249@kroah.com>
 <20190706194412.64c15c42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706194412.64c15c42@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 07:44:12PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Sat, 6 Jul 2019 10:34:33 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 04, 2019 at 10:24:50PM +1000, Stephen Rothwell wrote:
> > > 
> > > This release produces a whole lot (over 200) of this message in my qemu
> > > boot tests:
> > > 
> > > [    1.698497] debugfs: File 'sched' already present!
> > > 
> > > Introduced by commit
> > > 
> > >   43e23b6c0b01 ("debugfs: log errors when something goes wrong")
> > > 
> > > from the driver-core tree.  I assume that the error(?) was already
> > > happening, but it is now being reported.  
> > 
> > What are you passing to qemu to get this?  I just tried it myself and
> > see no error reports at all.  Have a .config I can use to try to
> > reproduce this?
> 
> It is a powerpc pseries_le_defconfig kernel and I run qemu like this:
> 
> qemu-system-ppc64 -M pseries -m 2G -vga none -nographic -kernel vmlinux -initrd rootfs.cpio.gz

Hm, I think my rootfs initrd might be quite simple compared to yours (it
drops me into a busybox shell).  Any pointers to where you created yours
from?

thanks,

greg k-h
