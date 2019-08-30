Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE84C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7C32186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBTecyMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfH3SsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:48:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40030 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfH3SsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:48:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id v5so1267791oto.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ce8D4/4we4jYF2K9LdYPteLGThCcdVbG/lxWqzVv0M=;
        b=IBTecyMeOCP/oImzEA1xiIYPxniXSv+zS2Ks3cNLVJl1mpo5VWLXxq6cLUS7npJxZt
         kGprFf7y9vlTj7zksfJWEsgzlSUKSJk2tqUFZ25rU6raZHwH9mxSByDjCs+GsIPW3SsU
         bunrrPI+vxZJjgcY+ydfdwzUEFctVNRWUZIUax/Co5/3GJS/YixfsZ9O1zjY/gz8U1SC
         BfWs4yke7Lx+LMSyv3if0kj/HtfQRX2gnJrUBgHYNBn5DrfUGKmoxuZXG1dZt7EkLR1L
         C44/ivVXxfdQAST6jyLC3eXphCK29bjwqa3XiOg+H8isQK+XnR+9ffEDxtsBuWwwXgks
         k9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ce8D4/4we4jYF2K9LdYPteLGThCcdVbG/lxWqzVv0M=;
        b=bMsaz6ORf3p8xmPNKxGJcLDrc6xSnqu1s/6Dq3DyjRZScIm8xmfaBj3nHiLhfMbHr2
         22sgFwdCVcFz7njstHa5kiJJB0Ifhicw1lvOYlAyiKHXL3CHJJh9ZyvW+8qGjgF/fyM4
         CUYYE7q0KFz796gDAAxMAtZosEVPwVL4JPmrytQjuEwHWeHj4vRt4EMkb5+sYN5gVeoD
         KSe2kmZyq79BUD2EdDzXglJMUtu81QfmYU8YqKU2+jQPqgAhM3HzaFJ1xjF1wy1Wduzc
         PSOMwItX8Ur2mS+PqFtBwWSpPDkxPX4adNwKfq3FSgw/f4QHpMu+VMzWeVbW+57gc88h
         4tNQ==
X-Gm-Message-State: APjAAAWhzw8vCzRcd1scW5gbqCRDFZOmVr3zs5tX/yZ+IJXuJoKxLIVC
        Fa0DiZwA0tYAr8c+MQbj0EaXlBfsH7JYhGMxaUzJ3Q==
X-Google-Smtp-Source: APXvYqwxJqID3UffV4RNzsN1GzlIIgzl4pwCMU5bQIHBilgazhNf8/vwMx81EtNHawUvfXqj2ogFc60QPCKXtinIokk=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr12551907otf.97.1567190884830;
 Fri, 30 Aug 2019 11:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190829211812.32520-1-hridya@google.com> <20190829211812.32520-3-hridya@google.com>
 <20190830113215.eaa6dfvlhxkmhqc3@wittgenstein>
In-Reply-To: <20190830113215.eaa6dfvlhxkmhqc3@wittgenstein>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 30 Aug 2019 11:47:28 -0700
Message-ID: <CA+wgaPPKUOJ_XAhLzt-zibmwj0qng8c7cOoFU4388d7jhvcv7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] binder: Add stats, state and transactions files
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

On Fri, Aug 30, 2019 at 4:32 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Aug 29, 2019 at 02:18:10PM -0700, Hridya Valsaraju wrote:
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
>
> Just two comments below. If you have addressed them you can add my:
>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thank you for taking another look Christian, will address both
comments and send out v3 soon :)

>
> > ---
> >
> >  Changes in v2:
> >  - Consistently name variables across functions as per Christian
> >    Brauner.
> >  - Improve check for binderfs device in binderfs_evict_inode()
> >    as per Christian Brauner.
> >
> >  drivers/android/binder.c          |  15 ++--
> >  drivers/android/binder_internal.h |   8 ++
> >  drivers/android/binderfs.c        | 140 +++++++++++++++++++++++++++++-
> >  3 files changed, 153 insertions(+), 10 deletions(-)
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
> > index 7045bfe5b52b..0e1e7c87cd33 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -280,7 +280,7 @@ static void binderfs_evict_inode(struct inode *inode)
> >
> >       clear_inode(inode);
> >
> > -     if (!device)
> > +     if (!S_ISCHR(inode->i_mode) || !device)
> >               return;
> >
> >       mutex_lock(&binderfs_minors_mutex);
> > @@ -502,6 +502,141 @@ static const struct inode_operations binderfs_dir_inode_operations = {
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
> > +static struct dentry *binderfs_create_dentry(struct dentry *parent,
> > +                                          const char *name)
> > +{
> > +     struct dentry *dentry;
> > +
> > +     dentry = lookup_one_len(name, parent, strlen(name));
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
> > +static struct dentry *binderfs_create_file(struct dentry *parent,
> > +                                        const char *name,
> > +                                        const struct file_operations *fops,
> > +                                        void *data)
> > +{
> > +     struct dentry *dentry;
> > +     struct inode *new_inode, *parent_inode;
> > +     struct super_block *sb;
> > +
> > +     parent_inode = parent->d_inode;
>
> Note that you're using d_inode(parent) below but parent->d_inode here. :)
>
> > +     inode_lock(parent_inode);
> > +
> > +     dentry = binderfs_create_dentry(parent, name);
> > +     if (IS_ERR(dentry))
> > +             goto out;
> > +
> > +     sb = parent_inode->i_sb;
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
> > +     fsnotify_create(parent_inode, dentry);
> > +
> > +out:
> > +     inode_unlock(parent_inode);
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
>
> This should be set_nlink(new_inode, 2) since noboby can modify it and
> it's also clearer what's happening and what the expected count is.
>
> > +     d_instantiate(dentry, new_inode);
> > +     inc_nlink(parent_inode);
> > +     fsnotify_mkdir(parent_inode, dentry);
> > +
> > +out:
> > +     inode_unlock(parent_inode);
> > +     return dentry;
> > +}
> > +
> > +static int init_binder_logs(struct super_block *sb)
> > +{
> > +     struct dentry *binder_logs_root_dir, *dentry;
> > +     int ret = 0;
> > +
> > +     binder_logs_root_dir = binderfs_create_dir(sb->s_root,
> > +                                                "binder_logs");
> > +     if (IS_ERR(binder_logs_root_dir)) {
> > +             ret = PTR_ERR(binder_logs_root_dir);
> > +             goto out;
> > +     }
> > +
> > +     dentry = binderfs_create_file(binder_logs_root_dir, "stats",
> > +                                   &binder_stats_fops, NULL);
> > +     if (IS_ERR(dentry)) {
> > +             ret = PTR_ERR(dentry);
> > +             goto out;
> > +     }
> > +
> > +     dentry = binderfs_create_file(binder_logs_root_dir, "state",
> > +                                   &binder_state_fops, NULL);
> > +     if (IS_ERR(dentry)) {
> > +             ret = PTR_ERR(dentry);
> > +             goto out;
> > +     }
> > +
> > +     dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
> > +                                   &binder_transactions_fops, NULL);
> > +     if (IS_ERR(dentry))
> > +             ret = PTR_ERR(dentry);
> > +
> > +out:
> > +     return ret;
> > +}
> > +
> >  static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  {
> >       int ret;
> > @@ -580,6 +715,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
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
