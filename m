Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A975C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4049121882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562165642;
	bh=UgFXVQjqdWzNhDEEXIrom4xBM//5mub8f6kiCfq2ZjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UV4qKDasxvKT0x1VHbOk1zOeBbrwbd1N1ELFb3G3zPXusCY+qmwwqLA9OQFFg7Spn
	 sxKh/3kYDPUsgSMmy9KBL9NKMjwD1AbPFUgCydqxA3J5mUT9jU0YDIsLqhEAQ4iVdM
	 K7pVPArMHz7cRr6AFHXnaSGJKBf7I8I/S3VO/+2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGCOyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCOyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:54:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E269821882;
        Wed,  3 Jul 2019 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562165639;
        bh=UgFXVQjqdWzNhDEEXIrom4xBM//5mub8f6kiCfq2ZjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKzzdwaR+OFxl12oG32IQfgd7prRrRsrLj2SoN2TMDR2calwqwZGk1dcuFTh7yK+2
         OrAf/jrVAGdl0j/ZZwygwaZ0X20ObdgzlGfAkBB9ETj8VJzTPWd3cxmjqpHL0Duuca
         RZ7DfdUj+HHkZsWaIDAuIVOgY8QUEUt0kXZ4Z3n0=
Date:   Wed, 3 Jul 2019 16:53:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] debugfs: log errors when something goes wrong
Message-ID: <20190703145357.GA15756@kroah.com>
References: <20190703071653.2799-1-gregkh@linuxfoundation.org>
 <20190703071653.2799-2-gregkh@linuxfoundation.org>
 <CAJZ5v0goKqHXfG=nNprMtKTDj02s3U56BOGQTuqajcqVdqqFcw@mail.gmail.com>
 <20190703093233.GA4436@kroah.com>
 <s5hpnmrmpe1.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpnmrmpe1.wl-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 11:35:50AM +0200, Takashi Iwai wrote:
> On Wed, 03 Jul 2019 11:32:33 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Wed, Jul 03, 2019 at 11:10:44AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 3, 2019 at 9:17 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > As it is not recommended that debugfs calls be checked, it was pointed
> > > > out that major errors should still be logged somewhere so that
> > > > developers and users have a chance to figure out what went wrong.  To
> > > > help with this, error logging has been added to the debugfs core so that
> > > > it is not needed to be present in every individual file that calls
> > > > debugfs.
> > > >
> > > > Reported-by: Mark Brown <broonie@kernel.org>
> > > > Reported-by: Takashi Iwai <tiwai@suse.de>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Generally speaking
> > > 
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > > ---
> > > >  fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
> > > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > index f04c8475d9a1..7f43c8acfcbf 100644
> > > > --- a/fs/debugfs/inode.c
> > > > +++ b/fs/debugfs/inode.c
> > > > @@ -2,8 +2,9 @@
> > > >  /*
> > > >   *  inode.c - part of debugfs, a tiny little debug file system
> > > >   *
> > > > - *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
> > > > + *  Copyright (C) 2004,2019 Greg Kroah-Hartman <greg@kroah.com>
> > > >   *  Copyright (C) 2004 IBM Inc.
> > > > + *  Copyright (C) 2019 Linux Foundation <gregkh@linuxfoundation.org>
> > > >   *
> > > >   *  debugfs is for people to use instead of /proc or /sys.
> > > >   *  See ./Documentation/core-api/kernel-api.rst for more details.
> > > > @@ -294,8 +295,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
> > > >
> > > >         error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
> > > >                               &debugfs_mount_count);
> > > > -       if (error)
> > > > +       if (error) {
> > > > +               pr_err("Unable to pin filesystem for file '%s'\n", name);
> > > 
> > > But I'm not sure about the log level here.  Particularly, why would
> > > pr_info() not work?
> > 
> > It could, but it is an error in that debugfs didn't do what was asked of
> > it.  I really don't care either way, the odds of anyone ever seeing this
> > message is almost none :)
> 
> Yes, that's an obvious error and I see no big reason to hide it.
> 
> For both:
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks all for the review, I'll go apply these to my tree now.

greg k-h
