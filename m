Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87CD217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdWzyAPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfH1UUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:20:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35606 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1UUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:20:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id 100so1155497otn.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZdApXr7HqxlwdsIqx7JRjNU5L47bfzu9+cVzi/wilM=;
        b=EdWzyAPkTBY+vrZQocH789fQ4t/os1Ygvj5020ZxvjsaGWulSsQKv4dLOVKJCxzZP2
         Z8lWs32NbYkVz+PGG4WfdPBjqonhDt68G+kJxW/HkHFOW47ehkZIfD5vABTKm9ldu6db
         LxIng0pHRkH7V5H80+7305Q6OQYWunXLgdq1dFsOfM0uHA3YELY90GNWLVAD1fCDpje6
         ad7Q4N/pw94HH5Xj83Q3jOELs45m9eDpN6MQeG2wCF2fFqnoi+jpKopfFDWgD3p0XbDj
         zYNCDbMtGArHytv8s/99XSmutHVNdhioB0Vb2ZRfhj82mSw8RGL7R2NOHNo+bykJpIYJ
         kUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZdApXr7HqxlwdsIqx7JRjNU5L47bfzu9+cVzi/wilM=;
        b=Qab2TH0898sMynsw/H/LVNhR8cVjSqk92r8XxveZ9jGTIHWI/42/P5sW9ZC8Fzo8ki
         ctyU/PV35CjmiX6Ce4Z1B9UirP/tG/zzGdrMKmuQB2ATN7rZhkbenfZxjnU+zBp8HPWo
         dEiNUY7876zBNBCO8v4JtocbXOOBxfdc9uUxokt2vWg/TXPv2l8IJSQL/CefZYpRvdzy
         Y8d47sfbhCqSGF+Q7sH/+NXB/rZ8W5UjeissrYbJp6epciatSg2ybBIN8hklWP4cDrTb
         jYEj1l/oP0RCSEz6OVlpC2bijksSnBLuB06hgNwJhHN2oTFeGrYDV17TKkd2lwiNrvJr
         aExw==
X-Gm-Message-State: APjAAAWdl6qYgwIlOkoip6zxRIw+3WbH/T7xoWWWf94StVW12sAIrD69
        3aqJYEdNmVh7rmR2Ti6gjxnj9pcIUQ0taZPukOM+5w==
X-Google-Smtp-Source: APXvYqzpRwBDr5k3lHA1Fn4+aNQ2cSnP2tDWjnyZhpbILqeveLlypdbb6aa2cI5016dpfZeIdMTWDY+la2UgntTulo4=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr4529909otf.97.1567023610275;
 Wed, 28 Aug 2019 13:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190827204152.114609-1-hridya@google.com> <20190827204152.114609-3-hridya@google.com>
 <20190828125816.cexbvn2dqy6to3ww@wittgenstein>
In-Reply-To: <20190828125816.cexbvn2dqy6to3ww@wittgenstein>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 28 Aug 2019 13:19:33 -0700
Message-ID: <CA+wgaPNkPgo64H6ZyFPCP_1BFSt1ZPQqBFk701a=W9O4H9BB-Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] binder: Add stats, state and transactions files
To:     Christian Brauner <christian.brauner@ubuntu.com>
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

On Wed, Aug 28, 2019 at 5:58 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Aug 27, 2019 at 01:41:50PM -0700, Hridya Valsaraju wrote:
> > The following binder stat files currently live in debugfs.
> >
> > /sys/kernel/debug/binder/state
> > /sys/kernel/debug/binder/stats
> > /sys/kernel/debug/binder/transactions
> >
> > This patch makes these files available in a binderfs instance
> > mounted with the mount option 'stats=global'. For example, if a binderfs
> > instance is mounted at path /dev/binderfs, the above files will be
> > available at the following locations:
> >
> > /dev/binderfs/binder_logs/state
> > /dev/binderfs/binder_logs/stats
> > /dev/binderfs/binder_logs/transactions
> >
> > This provides a way to access them even when debugfs is not mounted.
> >
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > ---
> >  drivers/android/binder.c          |  15 ++--
> >  drivers/android/binder_internal.h |   8 ++
> >  drivers/android/binderfs.c        | 137 +++++++++++++++++++++++++++++-
> >  3 files changed, 150 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index ca6b21a53321..de795bd229c4 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -6055,7 +6055,7 @@ static void print_binder_proc_stats(struct seq_file *m,
> >  }
> >
> >
> > -static int state_show(struct seq_file *m, void *unused)
> > +int binder_state_show(struct seq_file *m, void *unused)
> >  {
> >       struct binder_proc *proc;
> >       struct binder_node *node;
> > @@ -6094,7 +6094,7 @@ static int state_show(struct seq_file *m, void *unused)
> >       return 0;
> >  }
> >
> > -static int stats_show(struct seq_file *m, void *unused)
> > +int binder_stats_show(struct seq_file *m, void *unused)
> >  {
> >       struct binder_proc *proc;
> >
> > @@ -6110,7 +6110,7 @@ static int stats_show(struct seq_file *m, void *unused)
> >       return 0;
> >  }
> >
> > -static int transactions_show(struct seq_file *m, void *unused)
> > +int binder_transactions_show(struct seq_file *m, void *unused)
> >  {
> >       struct binder_proc *proc;
> >
> > @@ -6198,9 +6198,6 @@ const struct file_operations binder_fops = {
> >       .release = binder_release,
> >  };
> >
> > -DEFINE_SHOW_ATTRIBUTE(state);
> > -DEFINE_SHOW_ATTRIBUTE(stats);
> > -DEFINE_SHOW_ATTRIBUTE(transactions);
> >  DEFINE_SHOW_ATTRIBUTE(transaction_log);
> >
> >  static int __init init_binder_device(const char *name)
> > @@ -6256,17 +6253,17 @@ static int __init binder_init(void)
> >                                   0444,
> >                                   binder_debugfs_dir_entry_root,
> >                                   NULL,
> > -                                 &state_fops);
> > +                                 &binder_state_fops);
> >               debugfs_create_file("stats",
> >                                   0444,
> >                                   binder_debugfs_dir_entry_root,
> >                                   NULL,
> > -                                 &stats_fops);
> > +                                 &binder_stats_fops);
> >               debugfs_create_file("transactions",
> >                                   0444,
> >                                   binder_debugfs_dir_entry_root,
> >                                   NULL,
> > -                                 &transactions_fops);
> > +                                 &binder_transactions_fops);
> >               debugfs_create_file("transaction_log",
> >                                   0444,
> >                                   binder_debugfs_dir_entry_root,
> > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > index fe8c745dc8e0..12ef96f256c6 100644
> > --- a/drivers/android/binder_internal.h
> > +++ b/drivers/android/binder_internal.h
> > @@ -57,4 +57,12 @@ static inline int __init init_binderfs(void)
> >  }
> >  #endif
> >
> > +int binder_stats_show(struct seq_file *m, void *unused);
> > +DEFINE_SHOW_ATTRIBUTE(binder_stats);
> > +
> > +int binder_state_show(struct seq_file *m, void *unused);
> > +DEFINE_SHOW_ATTRIBUTE(binder_state);
> > +
> > +int binder_transactions_show(struct seq_file *m, void *unused);
> > +DEFINE_SHOW_ATTRIBUTE(binder_transactions);
> >  #endif /* _LINUX_BINDER_INTERNAL_H */
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index d95d179aec58..d542f9b8d8ab 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -280,7 +280,7 @@ static void binderfs_evict_inode(struct inode *inode)
> >
> >       clear_inode(inode);
> >
> > -     if (!device)
> > +     if (!device || S_ISREG(inode->i_mode))
>
> Hm, remind me why we need the S_ISREG again?

Thanks for taking a look Christian! We need the additional check
because for some of the stat files(for example, the transaction log
file in patch 3/5), the binder driver uses the i_private field of its
inode to stash some data that will be used for content generation when
the file is opened.

> Also we probably should do:
>
> if (S_ISREG(inode->i_mode) || !device)
>
> should this maybe be:
>
> if (!S_ISCHR(inode->i_mode) || !device)
>
> ?

Sounds good to me, will make the change in v2!

>
> >               return;
> >
> >       mutex_lock(&binderfs_minors_mutex);
> > @@ -504,6 +504,138 @@ static const struct inode_operations binderfs_dir_inode_operations = {
> >       .unlink = binderfs_unlink,
> >  };
> >
> > +static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
> > +{
> > +     struct inode *ret;
> > +
> > +     ret = new_inode(sb);
> > +     if (ret) {
> > +             ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
> > +             ret->i_mode = mode;
> > +             ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> > +     }
> > +     return ret;
> > +}
> > +
> > +static struct dentry *binderfs_create_dentry(struct dentry *dir,
> > +                                          const char *name)
> > +{
> > +     struct dentry *dentry;
> > +
> > +     dentry = lookup_one_len(name, dir, strlen(name));
> > +     if (IS_ERR(dentry))
> > +             return dentry;
> > +
> > +     /* Return error if the file/dir already exists. */
> > +     if (d_really_is_positive(dentry)) {
> > +             dput(dentry);
> > +             return ERR_PTR(-EEXIST);
> > +     }
> > +
> > +     return dentry;
> > +}
> > +
> > +static struct dentry *binderfs_create_file(struct dentry *dir, const char *name,
> > +                                 const struct file_operations *fops,
> > +                                 void *data)
> > +{
> > +     struct dentry *dentry;
> > +     struct inode *new_inode, *dir_inode;
> > +     struct super_block *sb;
> > +
> > +     dir_inode = dir->d_inode;
> > +     inode_lock(dir_inode);
> > +
> > +     dentry = binderfs_create_dentry(dir, name);
> > +     if (IS_ERR(dentry))
> > +             goto out;
> > +
> > +     sb = dir_inode->i_sb;
> > +     new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
> > +     if (!new_inode) {
> > +             dput(dentry);
> > +             dentry = ERR_PTR(-ENOMEM);
> > +             goto out;
> > +     }
> > +
> > +     new_inode->i_fop = fops;
> > +     new_inode->i_private = data;
> > +     d_instantiate(dentry, new_inode);
> > +     fsnotify_create(dir_inode, dentry);
> > +
> > +out:
> > +     inode_unlock(dir_inode);
> > +     return dentry;
> > +}
> > +
> > +static struct dentry *binderfs_create_dir(struct dentry *parent,
> > +                                       const char *name)
> > +{
> > +     struct dentry *dentry;
> > +     struct inode *new_inode, *parent_inode;
> > +     struct super_block *sb;
> > +
> > +     parent_inode = d_inode(parent);
>
> For consistency, could you use the same variable name for the directory
> in which you create a new dentry? I don't care if its "dir_inode" like
> above or "parent_inode".

Makes sense, will make the change in v2.

>
> > +     inode_lock(parent_inode);
> > +
> > +     dentry = binderfs_create_dentry(parent, name);
> > +     if (IS_ERR(dentry))
> > +             goto out;
> > +
> > +     sb = parent_inode->i_sb;
> > +     new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
> > +     if (!new_inode) {
> > +             dput(dentry);
> > +             dentry = ERR_PTR(-ENOMEM);
> > +             goto out;
> > +     }
> > +
> > +     new_inode->i_fop = &simple_dir_operations;
> > +     new_inode->i_op = &simple_dir_inode_operations;
> > +
> > +     inc_nlink(new_inode);
> > +     d_instantiate(dentry, new_inode);
> > +     inc_nlink(parent_inode);
> > +     fsnotify_mkdir(parent_inode, dentry);
> > +out:
>
> For consistency please leave a \n after fsnotify_mkdir and the goto
> label like you did in the function above.

Agreed, will fix in v2.

>
> > +     inode_unlock(parent_inode);
> > +     return dentry;
> > +}
> > +
> > +static int init_binder_logs(struct super_block *sb)
> > +{
> > +     struct dentry *binder_logs_root_dir, *file_dentry;
>
> Why "file_dentry" and not just simply "dentry" like everywhere else?

I was trying to distinguish it from the directory dentries in the
function but I don't mind changing it to just 'dentry' for
consistency.

>
> > +     int ret = 0;
> > +
> > +     binder_logs_root_dir = binderfs_create_dir(sb->s_root,
> > +                                                "binder_logs");
> > +     if (IS_ERR(binder_logs_root_dir)) {
> > +             ret = PTR_ERR(binder_logs_root_dir);
> > +             goto out;
> > +     }
> > +
> > +     file_dentry = binderfs_create_file(binder_logs_root_dir, "stats",
> > +                                        &binder_stats_fops, NULL);
> > +     if (IS_ERR(file_dentry)) {
> > +             ret = PTR_ERR(file_dentry);
> > +             goto out;
> > +     }
> > +
> > +     file_dentry = binderfs_create_file(binder_logs_root_dir, "state",
> > +                                        &binder_state_fops, NULL);
> > +     if (IS_ERR(file_dentry)) {
> > +             ret = PTR_ERR(file_dentry);
> > +             goto out;
> > +     }
> > +
> > +     file_dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
> > +                                        &binder_transactions_fops, NULL);
> > +     if (IS_ERR(file_dentry))
> > +             ret = PTR_ERR(file_dentry);
> > +out:
> > +     return ret;
> > +}
> > +
> >  static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  {
> >       int ret;
> > @@ -582,6 +714,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >
> >       }
> >
> > +     if (info->mount_opts.stats_mode == STATS_GLOBAL)
> > +             return init_binder_logs(sb);
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.23.0.187.g17f5b7556c-goog
> >
