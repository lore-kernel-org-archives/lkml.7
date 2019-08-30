Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51983C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0CB2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5MczlIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfH3SzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:55:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38386 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3SzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:55:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id q8so6130439oij.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MH0eqbh/fXT34oOIWwMe6uGVJDIJhsZgB+8WWkjU9s=;
        b=d5MczlIeVJeVEuZJiRRTwhnnTyAv6Pr+lyb8wWvnZprB+K3Fi2gxYb8cxN7eGCcC7c
         btKhy69RufSPlQZ6wX1aPNynt5FQWhZPo0HZlwQvh/R95E6k6MwSgZmxhox1vxztp09Z
         ysGQN8eoJxC3uw0reVC02C+LepaBJArgEBG+juvAmt9QZqrDQwiYgP2iZEZZfvOusy1K
         oviLlvMioUbnhzEIdc548QMFUFx5V/WWc1HuPfEjQjN9NXaePL1Sn382RsojqyIRNxKq
         w7x/5RW0j4RSk8l0UjKyGMkifIqpmK2UDwzOnOHKjbo4uy4meZgFS7L3YajzW+L3jpGo
         LeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MH0eqbh/fXT34oOIWwMe6uGVJDIJhsZgB+8WWkjU9s=;
        b=ZeV0Mfki7Hxio3iUjJ8QSqWrGDXUGxKMBEMxKhdIYOizGcssNHWupVBQUPNRALyKRh
         Nf3M/QaXF0pVQh3Y9hJ1jJhCh/9ln8EwLy6WOmkkP4xPRo6Lhh8gHMWHCFTybdCD6bPP
         Qedzie3NsPmjyPNd1BW7KpUDZNx5zbvV0Jgkeqz4Ejk+q4QbFMWGAjEVL4HyHNQ8gohQ
         qVaItN7TqKmL+KbiOQX6XUVkFvrH/tGtxcvt7GOM1cyvPYC1YsbYrp0k2nqe4fURGF6R
         Y7S4aGDLY1ue+x6XWN3/wFLTmCb+PLAw1+UVfAO4009PhzhouvR0a8s5OchSwM2mhhiD
         y+2A==
X-Gm-Message-State: APjAAAX+m0J+xXK3HNi34oGk8nwQ2RcKku8o6FDrTB4CYOvJlulBVo3G
        dUTAI0rOLbOzZvLsQcJ804WyLlm2GMVOEyfhtikdbA==
X-Google-Smtp-Source: APXvYqwD4STr00vzPKj8Ky0Drus5t5waxEaYPAupmQ3fNj2KIGm2VNJ19hIB/uV76M5mWl76Ef3+mafe1EnHE2tvhpw=
X-Received: by 2002:a54:418c:: with SMTP id 12mr5923070oiy.23.1567191300100;
 Fri, 30 Aug 2019 11:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190829211812.32520-1-hridya@google.com> <20190829211812.32520-4-hridya@google.com>
 <20190830113420.ikbjj37cn5qvlhmk@wittgenstein>
In-Reply-To: <20190830113420.ikbjj37cn5qvlhmk@wittgenstein>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 30 Aug 2019 11:54:23 -0700
Message-ID: <CA+wgaPMbR7UaJHUq-nn95t00Vh3cPWqVcx64-JF87edwPUntVQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] binder: Make transaction_log available in binderfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:34 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Aug 29, 2019 at 02:18:11PM -0700, Hridya Valsaraju wrote:
> > Currently, the binder transaction log files 'transaction_log'
> > and 'failed_transaction_log' live in debugfs at the following locations:
> >
> > /sys/kernel/debug/binder/failed_transaction_log
> > /sys/kernel/debug/binder/transaction_log
> >
> > This patch makes these files also available in a binderfs instance
> > mounted with the mount option "stats=global".
> > It does not affect the presence of these files in debugfs.
> > If a binderfs instance is mounted at path /dev/binderfs, the location of
> > these files will be as follows:
> >
> > /dev/binderfs/binder_logs/failed_transaction_log
> > /dev/binderfs/binder_logs/transaction_log
> >
> > This change provides an alternate option to access these files when
> > debugfs is not mounted.
> >
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
>
> (If you don't change this patch in the next version, please just keep my:
>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>
> when sending it out. :)

Will do! Thank you Christian!

>
> > ---
> >
> >  Changes in v2:
> >  -Consistent variable naming accross functions as per Christian Brauner.
> >
> >  drivers/android/binder.c          | 34 +++++--------------------------
> >  drivers/android/binder_internal.h | 30 +++++++++++++++++++++++++++
> >  drivers/android/binderfs.c        | 18 ++++++++++++++++
> >  3 files changed, 53 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index de795bd229c4..bed217310197 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -197,30 +197,8 @@ static inline void binder_stats_created(enum binder_stat_types type)
> >       atomic_inc(&binder_stats.obj_created[type]);
> >  }
> >
> > -struct binder_transaction_log_entry {
> > -     int debug_id;
> > -     int debug_id_done;
> > -     int call_type;
> > -     int from_proc;
> > -     int from_thread;
> > -     int target_handle;
> > -     int to_proc;
> > -     int to_thread;
> > -     int to_node;
> > -     int data_size;
> > -     int offsets_size;
> > -     int return_error_line;
> > -     uint32_t return_error;
> > -     uint32_t return_error_param;
> > -     const char *context_name;
> > -};
> > -struct binder_transaction_log {
> > -     atomic_t cur;
> > -     bool full;
> > -     struct binder_transaction_log_entry entry[32];
> > -};
> > -static struct binder_transaction_log binder_transaction_log;
> > -static struct binder_transaction_log binder_transaction_log_failed;
> > +struct binder_transaction_log binder_transaction_log;
> > +struct binder_transaction_log binder_transaction_log_failed;
> >
> >  static struct binder_transaction_log_entry *binder_transaction_log_add(
> >       struct binder_transaction_log *log)
> > @@ -6166,7 +6144,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
> >                       "\n" : " (incomplete)\n");
> >  }
> >
> > -static int transaction_log_show(struct seq_file *m, void *unused)
> > +int binder_transaction_log_show(struct seq_file *m, void *unused)
> >  {
> >       struct binder_transaction_log *log = m->private;
> >       unsigned int log_cur = atomic_read(&log->cur);
> > @@ -6198,8 +6176,6 @@ const struct file_operations binder_fops = {
> >       .release = binder_release,
> >  };
> >
> > -DEFINE_SHOW_ATTRIBUTE(transaction_log);
> > -
> >  static int __init init_binder_device(const char *name)
> >  {
> >       int ret;
> > @@ -6268,12 +6244,12 @@ static int __init binder_init(void)
> >                                   0444,
> >                                   binder_debugfs_dir_entry_root,
> >                                   &binder_transaction_log,
> > -                                 &transaction_log_fops);
> > +                                 &binder_transaction_log_fops);
> >               debugfs_create_file("failed_transaction_log",
> >                                   0444,
> >                                   binder_debugfs_dir_entry_root,
> >                                   &binder_transaction_log_failed,
> > -                                 &transaction_log_fops);
> > +                                 &binder_transaction_log_fops);
> >       }
> >
> >       if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
> > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > index 12ef96f256c6..b9be42d9464c 100644
> > --- a/drivers/android/binder_internal.h
> > +++ b/drivers/android/binder_internal.h
> > @@ -65,4 +65,34 @@ DEFINE_SHOW_ATTRIBUTE(binder_state);
> >
> >  int binder_transactions_show(struct seq_file *m, void *unused);
> >  DEFINE_SHOW_ATTRIBUTE(binder_transactions);
> > +
> > +int binder_transaction_log_show(struct seq_file *m, void *unused);
> > +DEFINE_SHOW_ATTRIBUTE(binder_transaction_log);
> > +
> > +struct binder_transaction_log_entry {
> > +     int debug_id;
> > +     int debug_id_done;
> > +     int call_type;
> > +     int from_proc;
> > +     int from_thread;
> > +     int target_handle;
> > +     int to_proc;
> > +     int to_thread;
> > +     int to_node;
> > +     int data_size;
> > +     int offsets_size;
> > +     int return_error_line;
> > +     uint32_t return_error;
> > +     uint32_t return_error_param;
> > +     const char *context_name;
> > +};
> > +
> > +struct binder_transaction_log {
> > +     atomic_t cur;
> > +     bool full;
> > +     struct binder_transaction_log_entry entry[32];
> > +};
> > +
> > +extern struct binder_transaction_log binder_transaction_log;
> > +extern struct binder_transaction_log binder_transaction_log_failed;
> >  #endif /* _LINUX_BINDER_INTERNAL_H */
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 0e1e7c87cd33..1715e72ce9c7 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -630,6 +630,24 @@ static int init_binder_logs(struct super_block *sb)
> >
> >       dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
> >                                     &binder_transactions_fops, NULL);
> > +     if (IS_ERR(dentry)) {
> > +             ret = PTR_ERR(dentry);
> > +             goto out;
> > +     }
> > +
> > +     dentry = binderfs_create_file(binder_logs_root_dir,
> > +                                   "transaction_log",
> > +                                   &binder_transaction_log_fops,
> > +                                   &binder_transaction_log);
> > +     if (IS_ERR(dentry)) {
> > +             ret = PTR_ERR(dentry);
> > +             goto out;
> > +     }
> > +
> > +     dentry = binderfs_create_file(binder_logs_root_dir,
> > +                                   "failed_transaction_log",
> > +                                   &binder_transaction_log_fops,
> > +                                   &binder_transaction_log_failed);
> >       if (IS_ERR(dentry))
> >               ret = PTR_ERR(dentry);
> >
> > --
> > 2.23.0.187.g17f5b7556c-goog
> >
