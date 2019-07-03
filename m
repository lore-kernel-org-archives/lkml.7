Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E6C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1510D21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562146688;
	bh=KYbRVVoMDIKPu7vyTGW/1ifRqMqEIBTWpCdpiRW9q/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Dq3V1bpcW/QuQgQdEV54VLc2P40hU3Cn2dcIhEzK8BdVJO7AoYjXIit/HUxuvxlY
	 Qrrt0rzXqPlRhKtUGXEARPvB8Wk162xgK6NrO2ec2tv9fHDqXeYIQ2HD+6pZfiEuqZ
	 4ClWJsT/HNuMXiBOuh8OM75mp6c6jLhFylIENbbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGCJiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:38:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44878 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGCJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:38:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so1631035otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3kMFQ8TXN6LpaUUZdQWD8WXwEeJdvT7O5F6HFvQxlc=;
        b=kCidiH9fEzQQLeOoG+BrvvhoRSHVscvC9xCPjzoCiV9WA9hhQxGMVdAWWFwhqGueFI
         Xy0v0eg07s/f+yIa7RrHmhoUXXJ3fuhhkKt4mQdfra2GOH7oFgRT7v1ekHHeMS3msLvE
         OyQzE5vF+oGc+VHA08vWnMWG/8+udMbq1qSb3IEtNAYEIw9PpwWBVEZf2hFddBXbO31H
         NZ1u75J+ysufW0Vvv1M+LfQyqEY+XUxlcIhB9Ow+qPzOAq6KIqjw4n9NhnZG7nNTpTCr
         AfmtF4f1qJYXLusAC5yxBB3/qaIIgOH/FccaCARNUBArjhFWPVAhsg4EVFPvWFcHu8QU
         ML7Q==
X-Gm-Message-State: APjAAAUFE9Dvx2iWbf8x0b77rdLps4e07LV5TR6DdYIAPPk45hljHJ1K
        rOuZNWl8DyeSw4TokPkT9ZYcUdXqfe3sKaae4Fs=
X-Google-Smtp-Source: APXvYqz6JiFFqUgd0LhQug7NEP8TUwMEo3QYMYh9TtL/pZLpMia9BgUoxuxvkhDb5esarP9gWK2rE24QLI0NlElkAW8=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr10542395oto.167.1562146685904;
 Wed, 03 Jul 2019 02:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190703071653.2799-1-gregkh@linuxfoundation.org>
 <20190703071653.2799-2-gregkh@linuxfoundation.org> <CAJZ5v0goKqHXfG=nNprMtKTDj02s3U56BOGQTuqajcqVdqqFcw@mail.gmail.com>
 <20190703093233.GA4436@kroah.com>
In-Reply-To: <20190703093233.GA4436@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 11:37:55 +0200
Message-ID: <CAJZ5v0homn90GK=j1b4Lk7Lqgji8C+jvi4q79o2_P9790tXdtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] debugfs: log errors when something goes wrong
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 11:32 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 03, 2019 at 11:10:44AM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 3, 2019 at 9:17 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > As it is not recommended that debugfs calls be checked, it was pointed
> > > out that major errors should still be logged somewhere so that
> > > developers and users have a chance to figure out what went wrong.  To
> > > help with this, error logging has been added to the debugfs core so that
> > > it is not needed to be present in every individual file that calls
> > > debugfs.
> > >
> > > Reported-by: Mark Brown <broonie@kernel.org>
> > > Reported-by: Takashi Iwai <tiwai@suse.de>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Generally speaking
> >
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > > ---
> > >  fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
> > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > index f04c8475d9a1..7f43c8acfcbf 100644
> > > --- a/fs/debugfs/inode.c
> > > +++ b/fs/debugfs/inode.c
> > > @@ -2,8 +2,9 @@
> > >  /*
> > >   *  inode.c - part of debugfs, a tiny little debug file system
> > >   *
> > > - *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
> > > + *  Copyright (C) 2004,2019 Greg Kroah-Hartman <greg@kroah.com>
> > >   *  Copyright (C) 2004 IBM Inc.
> > > + *  Copyright (C) 2019 Linux Foundation <gregkh@linuxfoundation.org>
> > >   *
> > >   *  debugfs is for people to use instead of /proc or /sys.
> > >   *  See ./Documentation/core-api/kernel-api.rst for more details.
> > > @@ -294,8 +295,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
> > >
> > >         error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
> > >                               &debugfs_mount_count);
> > > -       if (error)
> > > +       if (error) {
> > > +               pr_err("Unable to pin filesystem for file '%s'\n", name);
> >
> > But I'm not sure about the log level here.  Particularly, why would
> > pr_info() not work?
>
> It could, but it is an error in that debugfs didn't do what was asked of
> it.  I really don't care either way, the odds of anyone ever seeing this
> message is almost none :)

Fair enough.
