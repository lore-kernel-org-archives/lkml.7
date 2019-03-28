Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303A3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D6B20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hQTuoJhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfC1AYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:24:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33741 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1AYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:24:44 -0400
Received: by mail-vs1-f66.google.com with SMTP id a190so8911546vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7GN9cehs4sFiRUtIy6yGYKSApdDZAE2PIgd1f/NGW7E=;
        b=hQTuoJhs+FaOP8ZfA3J77ZI38PPyipwJ31azQn0HF+d+BX9hq8NciGbrZAicY7vQcG
         pPUMXFR3Ug0+CGNRpQtv+Rmw50CYG9J5iYmS9gTBzaxLthrCOGwWhf/W8wD+uozA14xQ
         AQu0RX7d28KHsqf3TFvXoxvVH+bQzKWTZVTJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GN9cehs4sFiRUtIy6yGYKSApdDZAE2PIgd1f/NGW7E=;
        b=YXnUcHQxU7MBqc5dpdoYM64gKAqD3j8LHda/Ht4A1jYdwOBW/xTUreFXS4Xp95yUat
         WuT9HsnRDynXjNDWDy+R6f3T3wmzkqdYXAsKk76abTVvHBCfu8d4+TFY0kW800fPfTe9
         Oj2OMh8/cPCiia+KswUkIxnZnuHhLgDSZ+Q0pq/hxisBWEsU1HVK6vk2ukbpkELYWGGy
         zsL6Mnetk1bE3WKMPEe++v4ceUA7Kq2WinCKKRJkfe+dXZ3wYUWgkxgJK39vy5GIFKWM
         8sJl3mkMJ7JIx3sdYuFmqor5aqbemzvtt3uuWwUHnJ82Cq5IFRpHFnEZwy9Lh7bCOs8g
         rG+Q==
X-Gm-Message-State: APjAAAWZwXmrRS7WSQJLAU2DoAY7DhVWo0/Kwix5IXBERkCzgCRj7ZKX
        Aoc8IIJrvla5ytNRZN2pq+tn6Ll3Pd4=
X-Google-Smtp-Source: APXvYqx5lvEtopMkO7jIZZ/D65xTAu3O4H+TjzhanfGoBDsw0zmjH7X360a0MW20B/4gJk0X7AHloA==
X-Received: by 2002:a67:fac8:: with SMTP id g8mr24888012vsq.216.1553732682037;
        Wed, 27 Mar 2019 17:24:42 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id o197sm26275862vkf.27.2019.03.27.17.24.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 17:24:41 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id w13so11091841vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 17:24:40 -0700 (PDT)
X-Received: by 2002:a67:e881:: with SMTP id x1mr22932329vsn.48.1553732680542;
 Wed, 27 Mar 2019 17:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373046781.7602.3527275113589619793.stgit@warthog.procyon.org.uk>
In-Reply-To: <155373046781.7602.3527275113589619793.stgit@warthog.procyon.org.uk>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 17:24:29 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+sV95+fJ+rmV=fKuNptgc6BoJGz09ys2iMimmwnVatkg@mail.gmail.com>
Message-ID: <CAGXu5j+sV95+fJ+rmV=fKuNptgc6BoJGz09ys2iMimmwnVatkg@mail.gmail.com>
Subject: Re: [RFC PATCH 57/68] vfs: Convert pstore to use the new mount API
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 4:47 PM David Howells <dhowells@redhat.com> wrote:
>
> Convert the pstore filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
>
> See Documentation/filesystems/mount_api.txt for more information.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Kees Cook <keescook@chromium.org>
> cc: Anton Vorontsov <anton@enomsg.org>
> cc: Colin Cross <ccross@android.com>
> cc: Tony Luck <tony.luck@intel.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  fs/pstore/inode.c |  109 +++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 71 insertions(+), 38 deletions(-)
>
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index c60ee46f3e39..bb4e4cabd11f 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -19,6 +19,8 @@
>
>  #include <linux/module.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/fsnotify.h>
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
> @@ -26,10 +28,8 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/string.h>
> -#include <linux/mount.h>
>  #include <linux/seq_file.h>
>  #include <linux/ramfs.h>
> -#include <linux/parser.h>
>  #include <linux/sched.h>
>  #include <linux/magic.h>
>  #include <linux/pstore.h>
> @@ -227,38 +227,48 @@ static struct inode *pstore_get_inode(struct super_block *sb)
>         return inode;
>  }
>
> +struct pstore_fs_context {
> +       unsigned int    kmsg_bytes;
> +};
> +
>  enum {
> -       Opt_kmsg_bytes, Opt_err
> +       Opt_kmsg_bytes,
>  };
>
> -static const match_table_t tokens = {
> -       {Opt_kmsg_bytes, "kmsg_bytes=%u"},
> -       {Opt_err, NULL}
> +static const struct fs_parameter_spec pstore_param_specs[] = {
> +       fsparam_u32     ("kmsg_bytes",          Opt_kmsg_bytes),
> +       {}
>  };
>
> -static void parse_options(char *options)
> -{
> -       char            *p;
> -       substring_t     args[MAX_OPT_ARGS];
> -       int             option;
> +static const struct fs_parameter_description pstore_fs_parameters = {
> +       .name           = "pstore",
> +       .specs          = pstore_param_specs,
> +};
>
> -       if (!options)
> -               return;
> +static int pstore_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +       struct pstore_fs_context *ctx = fc->fs_private;
> +       struct fs_parse_result result;
> +       int opt;
> +
> +       opt = fs_parse(fc, &pstore_fs_parameters, param, &result);
> +       if (opt < 0)
> +               return opt;
> +
> +       switch (opt) {
> +       case Opt_kmsg_bytes:
> +               ctx->kmsg_bytes = result.uint_32;
> +               break;
> +       }
>
> -       while ((p = strsep(&options, ",")) != NULL) {
> -               int token;
> +       return 0;
> +}
>
> -               if (!*p)
> -                       continue;
> +static void pstore_apply_param(struct fs_context *fc)
> +{
> +       struct pstore_fs_context *ctx = fc->fs_private;
>
> -               token = match_token(p, tokens, args);
> -               switch (token) {
> -               case Opt_kmsg_bytes:
> -                       if (!match_int(&args[0], &option))
> -                               pstore_set_kmsg_bytes(option);
> -                       break;
> -               }
> -       }
> +       pstore_set_kmsg_bytes(ctx->kmsg_bytes);
>  }
>
>  /*
> @@ -271,11 +281,10 @@ static int pstore_show_options(struct seq_file *m, struct dentry *root)
>         return 0;
>  }
>
> -static int pstore_remount(struct super_block *sb, int *flags, char *data)
> +static int pstore_reconfigure(struct fs_context *fc)
>  {
> -       sync_filesystem(sb);
> -       parse_options(data);
> -
> +       sync_filesystem(fc->root->d_sb);
> +       pstore_apply_param(fc);
>         return 0;
>  }
>
> @@ -283,7 +292,6 @@ static const struct super_operations pstore_ops = {
>         .statfs         = simple_statfs,
>         .drop_inode     = generic_delete_inode,
>         .evict_inode    = pstore_evict_inode,
> -       .remount_fs     = pstore_remount,
>         .show_options   = pstore_show_options,
>  };
>
> @@ -389,12 +397,10 @@ void pstore_get_records(int quiet)
>         inode_unlock(d_inode(root));
>  }
>
> -static int pstore_fill_super(struct super_block *sb, void *data, int silent)
> +static int pstore_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>         struct inode *inode;
>
> -       pstore_sb = sb;
> -
>         sb->s_maxbytes          = MAX_LFS_FILESIZE;
>         sb->s_blocksize         = PAGE_SIZE;
>         sb->s_blocksize_bits    = PAGE_SHIFT;
> @@ -402,7 +408,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>         sb->s_op                = &pstore_ops;
>         sb->s_time_gran         = 1;
>
> -       parse_options(data);
> +       pstore_sb = sb;
> +       pstore_apply_param(fc);
>
>         inode = pstore_get_inode(sb);
>         if (inode) {
> @@ -420,10 +427,35 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>         return 0;
>  }
>
> -static struct dentry *pstore_mount(struct file_system_type *fs_type,
> -       int flags, const char *dev_name, void *data)
> +static int pstore_get_tree(struct fs_context *fc)
> +{
> +       return vfs_get_super(fc, vfs_get_single_reconf_super,
> +                            pstore_fill_super);
> +}
> +
> +static void pstore_free_fc(struct fs_context *fc)
>  {
> -       return mount_single(fs_type, flags, data, pstore_fill_super);
> +       kfree(fc->fs_private);
> +}
> +
> +static const struct fs_context_operations pstore_context_ops = {
> +       .free           = pstore_free_fc,
> +       .parse_param    = pstore_parse_param,
> +       .get_tree       = pstore_get_tree,
> +       .reconfigure    = pstore_reconfigure,
> +};
> +
> +static int pstore_init_fs_context(struct fs_context *fc)
> +{
> +       struct pstore_fs_context *ctx;
> +
> +       ctx = kzalloc(sizeof(struct pstore_fs_context), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       fc->fs_private = ctx;
> +       fc->ops = &pstore_context_ops;
> +       return 0;
>  }
>
>  static void pstore_kill_sb(struct super_block *sb)
> @@ -435,7 +467,8 @@ static void pstore_kill_sb(struct super_block *sb)
>  static struct file_system_type pstore_fs_type = {
>         .owner          = THIS_MODULE,
>         .name           = "pstore",
> -       .mount          = pstore_mount,
> +       .init_fs_context = pstore_init_fs_context,
> +       .parameters     = &pstore_fs_parameters,
>         .kill_sb        = pstore_kill_sb,
>  };
>
>


-- 
Kees Cook
