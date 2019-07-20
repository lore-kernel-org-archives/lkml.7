Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF4C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B09C20873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRc1zVKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfGTPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:25:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34396 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfGTPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 11:25:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so2091230edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lELsSa3M0PDTP6k1R69wbifFn4aOMEZT0hhaREFVj54=;
        b=gRc1zVKbD3OGHAHB1Xj9O1kWL6IYDACafMvOXUSMLCYXcsTrn/BY6xpofywdtZSLa2
         9eLGn3uT4txsUbsZsWXtmEvGSjIdsfNj2y8V0uoePLkxU398uk+mh26IXzJrh3C9Cn6l
         JAs4rr/rS3diqjuDQ6StXztIt0IU7ZV2VcMJZRuWQWLyv6PGp5O22L4SorVDaM7p8QEQ
         iSO8FS8ZXsLE9UHaAgjVg0HuTtKJ8Aty85RHzOw9QZH7cnrmHH+ObhzV92jpk5A3qziK
         zDnBDhEtZ4k5nBz+raICWQCYmefSBdLGmg6RBEmVfcZ9HQXfMhvI7hy8W8Moyd1A/vpq
         1gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lELsSa3M0PDTP6k1R69wbifFn4aOMEZT0hhaREFVj54=;
        b=Durd3pp/Wj7ejdXvPPZBXpzA8Z/EsqA37cUVjETQ9A0JLqw2peZM5aFKCqH2/ENEg+
         BFwEVzIQQISBqPrfrkdyWL3b7rsqrgVxaWY4/rd26+CkcQtpo7vGvYkxLkry7zQeyMJt
         2gHTMKJpCMx7CRV5f5Z0Rz+GjRNU66jk1yzS8FJfvieuJ1HE5mWpQzQ0SMSgmDj9m2l0
         SVBID/2Uk5v4ha2x/etwvqbD8I7tqbRClX2xhpzUiTyrHEGdBMvu7P//1JM4+15Q7BQQ
         iZsjf9/RzQEawiyUVHBQp4NCi2e7Uy5BqZOFeF1mB+mDe5kC/rApKdQafVlxWP3soRuC
         xTeg==
X-Gm-Message-State: APjAAAXKavFn1AULMYr52x4tkMYTn4PICkSXYGz3Mh71Tsj8ETqOLhCN
        n9ToCPDyp6Xbg/b55zRThpGg2tx1hLAPvWCkGzU=
X-Google-Smtp-Source: APXvYqx7NephmVP0xjXD4JcfbTEmIIiWZ6Vmj4HnPmEfXxpEnp8aNiTCQb4/ksmgX0D0jlqfvuPtR5gW3vx4aF3VzoE=
X-Received: by 2002:a50:d7d0:: with SMTP id m16mr50795060edj.162.1563636319525;
 Sat, 20 Jul 2019 08:25:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a6d8:0:0:0:0:0 with HTTP; Sat, 20 Jul 2019 08:25:18
 -0700 (PDT)
In-Reply-To: <20190521152526.3071-1-haydenw.kernel@gmail.com>
References: <haodwang@cisco.com> <20190521152526.3071-1-haydenw.kernel@gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 21 Jul 2019 03:25:18 +1200
Message-ID: <CAGsJ_4wOdLhR3gSE8Fpy5D7Tic1DDQw=AwOkXEz0MgrjxKNG2g@mail.gmail.com>
Subject: Re: [PATCH] knfsd: add nfs-export support to ramfs
To:     Haodong Wong <haydenw.kernel@gmail.com>
Cc:     haodwang@cisco.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the subject is unsuitable? i mean the prefix should be fs/ramfs rather
than knfsd?

2019-05-22 3:25 GMT+12:00, Haodong Wong <haydenw.kernel@gmail.com>:
> Refer to tmpfs, use inode number and generation number
> to construct the filehandle for nfs-export

would you like to describe what is happening without this patch?

BTW, i guess you can keep Andrew Morton in the loop to review the
patch when you resend it.

>
> Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
> ---
>  fs/ramfs/inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 11201b2d06b9..418b2551f6fd 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -36,6 +36,7 @@
>  #include <linux/magic.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/exportfs.h>
>  #include "internal.h"
>
>  struct ramfs_mount_opts {
> @@ -66,6 +67,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
>  	if (inode) {
>  		inode->i_ino = get_next_ino();
>  		inode_init_owner(inode, dir, mode);
> +		inode->i_generation = get_seconds();
>  		inode->i_mapping->a_ops = &ramfs_aops;
>  		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  		mapping_set_unevictable(inode->i_mapping);
> @@ -217,6 +219,75 @@ static int ramfs_parse_options(char *data, struct
> ramfs_mount_opts *opts)
>  	return 0;
>  }
>
> +static struct dentry *ramfs_get_parent(struct dentry *child)
> +{
> +	return ERR_PTR(-ESTALE);
> +}
> +
> +static int ramfs_match(struct inode *ino, void *vfh)
> +{
> +	__u32 *fh = vfh;
> +	__u64 inum = fh[2];
> +
> +	inum = (inum << 32) | fh[1];
> +	return ino->i_ino == inum && fh[0] == ino->i_generation;
> +}
> +
> +static struct dentry *ramfs_fh_to_dentry(struct super_block *sb,
> +			   struct fid *fid, int fh_len, int fh_type)
> +
> +{
> +	struct inode *inode;
> +	struct dentry *dentry = NULL;
> +	u64 inum;
> +
> +	if (fh_len < 3)
> +		return NULL;
> +
> +	inum = fid->raw[2];
> +	inum = (inum << 32) | fid->raw[1];
> +	inode = ilookup5(sb, (unsigned long)(inum + fid->raw[0]),
> +				ramfs_match, fid->raw);
> +
> +	if (inode) {
> +		dentry = d_find_alias(inode);
> +		iput(inode);
> +	}
> +
> +	return dentry;
> +}
> +
> +static int ramfs_encode_fh(struct inode *inode, __u32 *fh, int *len,
> +			   struct inode *parent)
> +{
> +	if (*len < 3) {
> +		*len = 3;
> +		return FILEID_INVALID;
> +	}
> +
> +	if (inode_unhashed(inode)) {
> +		static DEFINE_SPINLOCK(lock);
> +
> +		spin_lock(&lock);
> +		if (inode_unhashed(inode))
> +			__insert_inode_hash(inode,
> +				inode->i_ino + inode->i_generation);
> +		spin_unlock(&lock);
> +	}
> +	fh[0] = inode->i_generation;
> +	fh[1] = inode->i_ino;
> +	fh[2] = ((__u64)inode->i_ino) >> 32;
> +
> +	*len = 3;
> +	return 1;
> +}
> +
> +static const struct export_operations ramfs_export_ops = {
> +	.get_parent     = ramfs_get_parent,
> +	.encode_fh      = ramfs_encode_fh,
> +	.fh_to_dentry   = ramfs_fh_to_dentry,
> +};
> +
>  int ramfs_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	struct ramfs_fs_info *fsi;
> @@ -238,6 +309,7 @@ int ramfs_fill_super(struct super_block *sb, void *data,
> int silent)
>  	sb->s_magic		= RAMFS_MAGIC;
>  	sb->s_op		= &ramfs_ops;
>  	sb->s_time_gran		= 1;
> +	sb->s_export_op         = &ramfs_export_ops;
>
>  	inode = ramfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
>  	sb->s_root = d_make_root(inode);
> --
> 2.17.1
>
>

-barry
