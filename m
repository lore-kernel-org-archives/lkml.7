Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E530C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014102189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562145063;
	bh=nTQJQz0aUFEnhElWalm9pUd5CXb56Zsx7NpZ+tqQ/5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zjlw7BU6XVTm3cuX2UZ3ZNiE8gsyRPRZOGdO8r7xUhQ9RxmPVfRMe2+JDgu1F4wn0
	 xRBkp97wE1wZ51mNQhYTikNB6CniHmBhhm2/o02gjKCHBoju0ynP6R1W3IWUSWyVQ7
	 tn60mjAEAHbltMR4ZBkrQwEppR4+RMV9FEySWV0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfGCJLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:11:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34666 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfGCJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:10:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so1616835otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DciJ90nh1NzfXcJeF9DL81fOMF6IEI7qQaUbMDoK/ok=;
        b=D0df0vV3AQOyeU9kHyW9lCS2FPRxLXLZmDF4Tsc8VesjfikKW4b5iQMJ3ENZXTKgsh
         +1TpgO52ArMlFL48IG84lgekF3KuC2hs4ZUtJjE73eGQ9ioFSpwQte8womsAcq2R7xU4
         4ioHcFbri4EJ98FpXldGQ+6oba6dqw9ZjiKkQ9IKqvnRdFKR5fBmtLKn2yVjLDPATCnE
         gy5xMj6exF+mmKAQU1M9XXuY8uu5tZr8JrKxRSbe2kNmv/5sGHHET97ogminCfDRAjHc
         HyIx76gnT/KQlaTb8GyeMVBvT9Eq9nja38IwhRMoir+sHUoq30QK61ZF+T2gD45Npk8f
         jYew==
X-Gm-Message-State: APjAAAWuECMq8/s+AaCsXby6hVOFo1jvE1fue8uX0MSbKelehisW7YhD
        c+aPQ+cIwFxun/nFQ5ltwVzacDwWEBhd42VGU9I=
X-Google-Smtp-Source: APXvYqza5e2FicbMKr5dqkoDR8/5pVuhNf2c6MThpTIwKh+O0DLItd1BhWLNz0X1CeBA1OglAGsa7GKg7RMI0hHwSCE=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr13449335otn.266.1562145055618;
 Wed, 03 Jul 2019 02:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190703071653.2799-1-gregkh@linuxfoundation.org> <20190703071653.2799-2-gregkh@linuxfoundation.org>
In-Reply-To: <20190703071653.2799-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 11:10:44 +0200
Message-ID: <CAJZ5v0goKqHXfG=nNprMtKTDj02s3U56BOGQTuqajcqVdqqFcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] debugfs: log errors when something goes wrong
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 9:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> As it is not recommended that debugfs calls be checked, it was pointed
> out that major errors should still be logged somewhere so that
> developers and users have a chance to figure out what went wrong.  To
> help with this, error logging has been added to the debugfs core so that
> it is not needed to be present in every individual file that calls
> debugfs.
>
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Generally speaking

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index f04c8475d9a1..7f43c8acfcbf 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -2,8 +2,9 @@
>  /*
>   *  inode.c - part of debugfs, a tiny little debug file system
>   *
> - *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
> + *  Copyright (C) 2004,2019 Greg Kroah-Hartman <greg@kroah.com>
>   *  Copyright (C) 2004 IBM Inc.
> + *  Copyright (C) 2019 Linux Foundation <gregkh@linuxfoundation.org>
>   *
>   *  debugfs is for people to use instead of /proc or /sys.
>   *  See ./Documentation/core-api/kernel-api.rst for more details.
> @@ -294,8 +295,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>
>         error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
>                               &debugfs_mount_count);
> -       if (error)
> +       if (error) {
> +               pr_err("Unable to pin filesystem for file '%s'\n", name);

But I'm not sure about the log level here.  Particularly, why would
pr_info() not work?

>                 return ERR_PTR(error);
> +       }
>
>         /* If the parent is not specified, we create it in the root.
>          * We need the root dentry to do this, which is in the super
> @@ -309,6 +312,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>         dentry = lookup_one_len(name, parent, strlen(name));
>         if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
>                 dput(dentry);
> +               pr_err("File '%s' already present!\n", name);
>                 dentry = ERR_PTR(-EEXIST);
>         }
>
> @@ -351,8 +355,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
>                 return dentry;
>
>         inode = debugfs_get_inode(dentry->d_sb);
> -       if (unlikely(!inode))
> +       if (unlikely(!inode)) {
> +               pr_err("out of free dentries, can not create file '%s'\n",
> +                      name);
>                 return failed_creating(dentry);
> +       }
>
>         inode->i_mode = mode;
>         inode->i_private = data;
> @@ -513,8 +520,11 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>                 return dentry;
>
>         inode = debugfs_get_inode(dentry->d_sb);
> -       if (unlikely(!inode))
> +       if (unlikely(!inode)) {
> +               pr_err("out of free dentries, can not create directory '%s'\n",
> +                      name);
>                 return failed_creating(dentry);
> +       }
>
>         inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>         inode->i_op = &simple_dir_inode_operations;
> @@ -552,8 +562,11 @@ struct dentry *debugfs_create_automount(const char *name,
>                 return dentry;
>
>         inode = debugfs_get_inode(dentry->d_sb);
> -       if (unlikely(!inode))
> +       if (unlikely(!inode)) {
> +               pr_err("out of free dentries, can not create automount '%s'\n",
> +                      name);
>                 return failed_creating(dentry);
> +       }
>
>         make_empty_dir_inode(inode);
>         inode->i_flags |= S_AUTOMOUNT;
> @@ -608,6 +621,8 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
>
>         inode = debugfs_get_inode(dentry->d_sb);
>         if (unlikely(!inode)) {
> +               pr_err("out of free dentries, can not create symlink '%s'\n",
> +                      name);
>                 kfree(link);
>                 return failed_creating(dentry);
>         }
> --
> 2.22.0
>
