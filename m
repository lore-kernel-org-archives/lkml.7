Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14551C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B9B206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JS5WCbbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395224AbfHBV5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:57:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40955 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbfHBV5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:57:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so36571942oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGuW4tG7YREvM0Tkwd56d78mTsuSaz2wZqP3WJdbo78=;
        b=JS5WCbbgJ3urA3aE1jNreeG23PyNNrBu5EuDNauGNuCJrtFegQgUqeLFkSkbsKGOYH
         pvh9Sen+L9CA7iU0/uPc80Y2VrIGgThDoLA9CWPkMmK9zdDHBUyTKJUE2udzdFxpGdzH
         q3yX2kbeXOppHH36whi5FbxLvQsF1RvceEhIOZIbxjrOQ1IdStcU8n5Kj+1kPfNncxGO
         C5k7qxldqyCJ3InOq1iLhKCfwEXH7CTG4aw77tgJCBPFmd7GzaEVD17Myl5tX60I/1II
         pIfFxOYWJWxXH7fg2UtPQ6Ix2nYObRj08Gu1jFUel6COnkLdKzCuj+KtRHmWA/P3QRXp
         ZChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGuW4tG7YREvM0Tkwd56d78mTsuSaz2wZqP3WJdbo78=;
        b=kgRN0op7fFOEjb4QA2AbDhFXJMKpsz+tWM58Dt5Jo/2lFL8jRtYGgMxd8tn4O6BQmF
         jeNwRXate7v0tyO/vSJkKfmauVIo7qsJiWUvOBDNXheKNqFOYkwy8zYQOVwtPozEy4FF
         HT//lvUe5hPVF6J4Gd+tn/N0wLIL5uV0r8L4xlPAIKwYwYqQFVOXrn4TS8PsI/8untbK
         TpFVHJtD23Ojv+ZftMheWqwE+mTuZx0UdkdRhGB/4kGTZSFlM5V+JvjA32JEmsrQmIG0
         X/R9bBPLkaJmvaveO5he3DOlYotzzIjtnpkV+YUMQZrY1Qz7P5NAsemJBnb+CGhFbKOm
         gH+g==
X-Gm-Message-State: APjAAAWHwOXhr5IbNFTmKiMaaszS7o2Y7HgaG+ryfKBApVvdzdjPShPr
        CVVw/vr2zSvl1ETCamfibOkbSkhIxZiM/+NKLE420w==
X-Google-Smtp-Source: APXvYqxPvIExhTr5+5hX20/Em3/RlwrgRTSjNvdYPqA76CZtPvAqwwYH4WeX6OYha37L5xo4AcV22x1g5iGUwq+ifGA=
X-Received: by 2002:a54:4f95:: with SMTP id g21mr4070854oiy.23.1564783062470;
 Fri, 02 Aug 2019 14:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190801223556.209184-1-hridya@google.com> <20190802061838.GA10844@kroah.com>
 <20190802150612.eff7t42256pvxuja@brauner.io>
In-Reply-To: <20190802150612.eff7t42256pvxuja@brauner.io>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 2 Aug 2019 14:57:06 -0700
Message-ID: <CA+wgaPPfRiz1RYRyMxX2udhicQGrwNZipPWzbJ--MPWtEXka-w@mail.gmail.com>
Subject: Re: [PATCH] Add default binder devices through binderfs when configured
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 8:06 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Fri, Aug 02, 2019 at 08:18:38AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 01, 2019 at 03:35:56PM -0700, Hridya Valsaraju wrote:
> > > If CONFIG_ANDROID_BINDERFS is set, the default binder devices
> > > specified by CONFIG_ANDROID_BINDER_DEVICES are created in each
> > > binderfs instance instead of global devices being created by
> > > the binder driver.
> > >
> > > Co-developed-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > > ---
> > >  drivers/android/binder.c   |  3 ++-
> > >  drivers/android/binderfs.c | 46 ++++++++++++++++++++++++++++++++++----
> > >  2 files changed, 44 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index 466b6a7f8ab7..65a99ac26711 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -6279,7 +6279,8 @@ static int __init binder_init(void)
> > >                                 &transaction_log_fops);
> > >     }
> > >
> > > -   if (strcmp(binder_devices_param, "") != 0) {
> > > +   if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
> > > +       strcmp(binder_devices_param, "") != 0) {
> > >             /*
> > >             * Copy the module_parameter string, because we don't want to
> > >             * tokenize it in-place.
> > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > index e773f45d19d9..9f5ed50ffd70 100644
> > > --- a/drivers/android/binderfs.c
> > > +++ b/drivers/android/binderfs.c
> > > @@ -48,6 +48,10 @@ static dev_t binderfs_dev;
> > >  static DEFINE_MUTEX(binderfs_minors_mutex);
> > >  static DEFINE_IDA(binderfs_minors);
> > >
> > > +static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
> > > +module_param_named(devices, binder_devices_param, charp, 0444);
> > > +MODULE_PARM_DESC(devices, "Binder devices to be created by default");
> > > +
> >
> > Why are you creating a module parameter?  That was not in your changelog
> > :(
>
> Yeah, you don't need an additional module parameter. You can just move
>
> static char *binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES;
> module_param_named(devices, binder_devices_param, charp, 0444);
>
> from binder.c to binder_internal.h and expose it to binder.c and
> binderfs.c this way. This will work just fine since binderfs.c doesn't
> modify the parameter and binder.c makes a copy of it before doing so.
>
> >
> >
> >
> > >  /**
> > >   * binderfs_mount_opts - mount options for binderfs
> > >   * @max: maximum number of allocatable binderfs binder devices
> > > @@ -135,7 +139,6 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
> > >  #else
> > >     bool use_reserve = true;
> > >  #endif
> > > -
> > >     /* Reserve new minor number for the new device. */
> > >     mutex_lock(&binderfs_minors_mutex);
> > >     if (++info->device_count <= info->mount_opts.max)
> > > @@ -186,8 +189,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
> > >     req->major = MAJOR(binderfs_dev);
> > >     req->minor = minor;
> > >
> > > -   ret = copy_to_user(userp, req, sizeof(*req));
> > > -   if (ret) {
> > > +   if (userp && copy_to_user(userp, req, sizeof(*req))) {
> > >             ret = -EFAULT;
> > >             goto err;
> > >     }
> > > @@ -467,6 +469,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> > >     int ret;
> > >     struct binderfs_info *info;
> > >     struct inode *inode = NULL;
> > > +   struct binderfs_device device_info = { 0 };
> > > +   const char *name;
> > > +   size_t len;
> > >
> > >     sb->s_blocksize = PAGE_SIZE;
> > >     sb->s_blocksize_bits = PAGE_SHIFT;
> > > @@ -521,7 +526,28 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> > >     if (!sb->s_root)
> > >             return -ENOMEM;
> > >
> > > -   return binderfs_binder_ctl_create(sb);
> > > +   ret = binderfs_binder_ctl_create(sb);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   name = binder_devices_param;
> > > +   for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > > +           /*
> > > +            * init_binderfs() has already checked that the length of
> > > +            * device_name_entry->name is not greater than device_info.name.
> > > +            */
> > > +           strscpy(device_info.name, name, len + 1);
> > > +           ret = binderfs_binder_device_create(inode, NULL, &device_info);
> > > +           if (ret)
> > > +                   return ret;
> > > +           name += len;
> > > +           if (*name == ',')
> > > +                   name++;
> > > +
> > > +   }
> > > +
> > > +   return 0;
> > > +
> > >  }
> > >
> > >  static struct dentry *binderfs_mount(struct file_system_type *fs_type,
> > > @@ -553,6 +579,18 @@ static struct file_system_type binder_fs_type = {
> > >  int __init init_binderfs(void)
> > >  {
> > >     int ret;
> > > +   const char *name;
> > > +   size_t len;
> > > +
> > > +   /* Verify that the default binderfs device names are valid. */
> > > +   name = binder_devices_param;
> > > +   for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
> > > +           if (len > BINDERFS_MAX_NAME)
> > > +                   return -E2BIG;
> > > +           name += len;
> > > +           if (*name == ',')
> > > +                   name++;
> > > +   }
> >
> > This verification should be a separate patch, right?
> >
> > But the real issue here is I have no idea _why_ you are wanting this
> > patch.  The changelog text says _what_ you are doing only, which isn't
> > ok.
> >
> > Please provide more information as to why this is needed, what problem
> > it is solving, and break this up into a patch series and resend.

Thank you Greg and Christian, I will address all issues in v2 and resend.

> >
> > thanks,
> >
> > greg k-h
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
