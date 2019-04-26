Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA78B208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556305401;
	bh=Py2Wqi+xE6pgsXNg1HxGqxEnqkYnYEVvNDXhwnYtHso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=dW+bsPW3KygqXkOfVWohhUhSV+ooUkyaVG9217EwOY2CC3o7aV2hRtiUYp8eayXpK
	 YpW01Fg3XfoInmQarDCTGlF5tN7R++VAj6a5mcj9aWpYeltUDurEpYBqF//PKuJ9k8
	 PDcE3PtXgbOGPmchbkwla8iisNHVzwTJlniZjbrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDZTDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfDZTDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:03:20 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C26520869;
        Fri, 26 Apr 2019 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556305398;
        bh=Py2Wqi+xE6pgsXNg1HxGqxEnqkYnYEVvNDXhwnYtHso=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c5F1FNOcUCniv2IpwJFaELXJugWly/+8V2JZhzs/fDyjDnD/ulZC0euGsDkiAFJdk
         8UQ33DS4ufjMrcw1WKCedM34R9e8PQ3nct17/HVsAui/3RedXyTVlrg5jVcfyKnszT
         81RO6TA99+QIZ/o/Rl05UFZv8DyEmEMORl5pVctM=
Message-ID: <eac6b8a50c98abe2c5a3858a9d11555de2cedca3.camel@kernel.org>
Subject: Re: [PATCH 0/5] vfs: track the dentry name length in name_snapshot
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Date:   Fri, 26 Apr 2019 15:03:16 -0400
In-Reply-To: <20190426185158.GB2217@ZenIV.linux.org.uk>
References: <20190426182847.25088-1-jlayton@kernel.org>
         <20190426185158.GB2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 19:51 +0100, Al Viro wrote:
> On Fri, Apr 26, 2019 at 02:28:42PM -0400, Jeff Layton wrote:
> > name_snapshot will snapshot the current contents of a dentry's name for
> > later consumption. Several of those users end up needing to do a strlen
> > on the resulting string later. We already have that info in the original
> > dentry though, so we can do this a bit more efficiently by stuffing the
> > name length into the name_snapshot as well.
> > 
> > This is not well tested, but it built and booted. Do we have a testsuite
> > that exercises the fsnotify code, in particular?
> 
> FWIW, my variant sits in vfs.git@work.dcache.
> 
> > Jeff Layton (5):
> >   dcache: track the length of the string in struct name_snapshot
> >   fsnotify: have fsnotify_move take a struct qstr instead of a string
> >   fsnotify: have fsnotify() take a qstr instead of a string
> >   fsnotify: change ->handle_event and send_to_group to take a qstr
> >   audit: fix audit_compare_dname_path to take a qstr
> > 
> >  fs/dcache.c                          | 11 +++++++----
> >  fs/debugfs/inode.c                   |  2 +-
> >  fs/kernfs/file.c                     |  6 ++++--
> >  fs/namei.c                           |  4 ++--
> >  fs/notify/dnotify/dnotify.c          |  2 +-
> >  fs/notify/fanotify/fanotify.c        |  2 +-
> >  fs/notify/fsnotify.c                 |  8 ++++----
> >  fs/notify/inotify/inotify.h          |  2 +-
> >  fs/notify/inotify/inotify_fsnotify.c |  6 +++---
> >  fs/overlayfs/export.c                |  2 +-
> >  include/linux/dcache.h               |  2 +-
> >  include/linux/fsnotify.h             | 17 ++++++++---------
> >  include/linux/fsnotify_backend.h     |  6 +++---
> >  kernel/audit.h                       |  3 ++-
> >  kernel/audit_fsnotify.c              |  5 +++--
> >  kernel/audit_tree.c                  |  2 +-
> >  kernel/audit_watch.c                 |  4 ++--
> >  kernel/auditfilter.c                 |  7 ++++---
> >  kernel/auditsc.c                     |  7 +++----
> >  19 files changed, 52 insertions(+), 46 deletions(-)
> 
>  fs/dcache.c                          | 14 ++++++--------
>  fs/debugfs/inode.c                   |  2 +-
>  fs/kernfs/file.c                     |  6 ++++--
>  fs/namei.c                           |  4 ++--
>  fs/notify/dnotify/dnotify.c          |  2 +-
>  fs/notify/fanotify/fanotify.c        |  2 +-
>  fs/notify/fsnotify.c                 |  8 ++++----
>  fs/notify/inotify/inotify.h          |  2 +-
>  fs/notify/inotify/inotify_fsnotify.c |  6 +++---
>  fs/overlayfs/export.c                |  2 +-
>  include/linux/dcache.h               |  2 +-
>  include/linux/fsnotify.h             | 10 +++++-----
>  include/linux/fsnotify_backend.h     |  6 +++---
>  kernel/audit.h                       |  2 +-
>  kernel/audit_fsnotify.c              |  2 +-
>  kernel/audit_tree.c                  |  2 +-
>  kernel/audit_watch.c                 |  4 ++--
>  kernel/auditfilter.c                 |  6 +++---
>  kernel/auditsc.c                     |  4 ++--
>  19 files changed, 43 insertions(+), 43 deletions(-)
> 
> here...

Pretty similar :)

Let's just go with yours then, since it breaks out some of the strlen
changes into separate patches.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

