Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D66C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728542064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562586185;
	bh=5x2L1rmSEDec2vDe0Sb8wCP76ECPKQa4Kz5H6zt8fxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZHNxy4ztcX5dGsvbwXOCP/U11uuC41BfqGYh2IzjajTBZhHQ8q3oC6QaJ2kYp3xb7
	 x/O3SuldE393GouoVetUvDcAGlmf/8yiAM3rfgjnW+K8XAJ4aSDAAVJPGXOlEScOw9
	 57ryCpVRi2YmluX0ZsTMYzh+d+3rQ5rD4UnCAVu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfGHLnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGHLnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:43:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D946820861;
        Mon,  8 Jul 2019 11:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562586182;
        bh=5x2L1rmSEDec2vDe0Sb8wCP76ECPKQa4Kz5H6zt8fxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKacZaFgUSWO6MoKe2w0oCHqDyUDVJHQ5zhE+/lhsx26jjhI3v5A+zZb66CBQtWu5
         FXEuSWajHDpJDhRTk3ygAl8F09B/kth+qW8aCiRy9RjFrpf1abUVE9IYHjA/wqUgEt
         sy+qac3MjSoOQdUueT6PK3pxI7dkIC7SFFa0Qufw=
Date:   Mon, 8 Jul 2019 13:42:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH] habanalabs: use correct variable to show fd open counter
Message-ID: <20190708114259.GA16677@kroah.com>
References: <20190708104355.32569-1-oded.gabbay@gmail.com>
 <20190708112136.GA13795@kroah.com>
 <CAFCwf11XN_stq3HHVGqD4_LKG8W3uFiYarfbwP50hw58Hi10Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11XN_stq3HHVGqD4_LKG8W3uFiYarfbwP50hw58Hi10Sw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 02:30:13PM +0300, Oded Gabbay wrote:
> On Mon, Jul 8, 2019 at 2:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 08, 2019 at 01:43:55PM +0300, Oded Gabbay wrote:
> > > The current code checks if the user context pointer is NULL or not to
> > > display the number of open file descriptors of a device. However, that
> > > variable (user_ctx) will eventually go away as the driver will support
> > > multiple processes. Instead, the driver can use the atomic counter of
> > > the open file descriptors which the driver already maintains.
> > >
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > ---
> > >  drivers/misc/habanalabs/sysfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
> > > index 25eb46d29d88..881be19b5fad 100644
> > > --- a/drivers/misc/habanalabs/sysfs.c
> > > +++ b/drivers/misc/habanalabs/sysfs.c
> > > @@ -356,7 +356,7 @@ static ssize_t write_open_cnt_show(struct device *dev,
> > >  {
> > >       struct hl_device *hdev = dev_get_drvdata(dev);
> > >
> > > -     return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
> > > +     return sprintf(buf, "%d\n", atomic_read(&hdev->fd_open_cnt));
> > >  }
> >
> > Odds are, this means nothing, as it doesn't get touched if the file
> > descriptor is duped or sent to another process.
> >
> > Why do you care about the number of open files?  Whenever someone tries
> > to do this type of logic, it is almost always wrong, just let userspace
> > do what it wants to do, and if wants to open something twice, then it
> > gets to keep the pieces when things break.
> >
> > thanks,
> >
> > greg k-h
> 
> I care about the number of open file descriptors because I can't let
> multiple processes run simultaneously on my device, as we still don't
> have the code to do proper isolation between the processes, in regard
> of memory accesses on our device memory and by using our DMA engine.
> Basically, it's a security hole. If you want, I can explain more in
> length on this issue.

But the issue is that you can't "force" this from the kernel side at
all.  Trying to catch this at open() time only catches the obvious
processes.

As I said, how do you check for:
	fd = open(...);
	fd_new = dup(fd);

	write(fd, ...);
	write(fd_new, ...);

or, pass the fd across a socket?  Or other fun ways of sending file
descriptors around a system.

You have to trust userspace here, sorry.  If someone wants to do
multiple accesses, they can, but again, they deserve the pieces when
things fall apart.

> We have the H/W infrastructure for that, using MMU and multiple
> address space IDs (ASID), but we didn't write the code yet in the
> driver, as that is a BIG feature but it wasn't requested by anyone
> yet.
> 
> So the current solution is to block the ability to open multiple file
> descriptors.
> 
> Regarding this specific sysfs property, I don't really care about it.
> I simply saw that it is shown in other drivers and I thought it may be
> nice for a system admin utility to show it.

What drivers show the number of open file descriptors?  Time to go
delete them as well :)

thanks,

greg k-h
