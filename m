Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D5BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366FA214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah8A6oKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfJWGkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:40:01 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38345 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387946AbfJWGkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:40:00 -0400
Received: by mail-yb1-f194.google.com with SMTP id r68so5981516ybf.5;
        Tue, 22 Oct 2019 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsRmmy8kO0r1yWjAMGmPFWzuU6qtFEhb9ZOIoYR8bqI=;
        b=ah8A6oKbZMJU0gw9xfPeocFp3eXf7lI+zU+AJDWNiCwdRCULkp+9BDeAmtpZYH3lMY
         EKE9L5k6t6fwLilnlvkd+MO5RLsmpKF7PMuBAjDyb5oLnRN2GZ8UgoO3xJctNpkm6U2H
         uYanhg0bHOeACWodS7wXKQ6V/zpZguzlXQ367/Kstm7cNK7dEAPl2WkSnlrCOF9sVSXC
         4CoJBE2dpLqBd0fMfC/jE8p4Q5msr5EeWQYRIDKdh8SpQLBwjWwT7ux/X25PZF2ap2Mw
         9idSJxJEMvYp7Ukc+tRm4FzD092+uxZOm9Yf4IDIizo8S3hMHRzmpLBcqWSJuFyJQwK6
         Mcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsRmmy8kO0r1yWjAMGmPFWzuU6qtFEhb9ZOIoYR8bqI=;
        b=eCPGJhpdCX2jW7K4QUMlH6m1TUlE+hEHAWxPfKd5bD1YWYtWbucCS3ql7EDBI+M3U4
         KJQtU+MCYXf9Chs9EeLNvE7OKLPmhnfvaJrmb9nKh8jSo4sBfpeboQElIstbcHcQmHNd
         lkE5VadpJyA3jX7wQmniim0iZ34QEOR/6ZOIJmp3jdPht3twrwn4GHaZ7hC6aawuBLXk
         2gbQzxB1t1lddk4moSTs3ETHHPuLQsoGJO5Asgz0N+hcfYr9h1YTp1QexPq0+Ksp38jd
         xv3cyX9yp/lUA4piA0Ns0ciCPt/+tac9Hkfind1fZrWzZG5ke74JlHfapzxdK8lNvlnq
         o96g==
X-Gm-Message-State: APjAAAVWdwEX4TihwMaDonsa/y/KenFGP6gdTq8tcc4ORIlj66A75sqm
        CkP3oP0FOJMEZk2xZEmQU5ByZjkamSr3hH1E5PQ=
X-Google-Smtp-Source: APXvYqyEfIXS1YE02Mcv67dN7iXghA3NKnUKoWWnlXbuVJEjLidLeAzeaD6xfSscivEuXqFzslSUfPde/2zcn8Ccszs=
X-Received: by 2002:a25:8308:: with SMTP id s8mr4983149ybk.126.1571812797949;
 Tue, 22 Oct 2019 23:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191022204453.97058-1-salyzyn@android.com> <20191022204453.97058-5-salyzyn@android.com>
In-Reply-To: <20191022204453.97058-5-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Oct 2019 09:39:47 +0300
Message-ID: <CAOQ4uxgWOmV_x5gRZ9tR+u86GE6JoXn-MSxKkvi87e9owMApZw@mail.gmail.com>
Subject: Re: [PATCH v14 4/5] overlayfs: internal getxattr operations without
 sepolicy checking
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:46 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Check impure, opaque, origin & meta xattr with no sepolicy audit
> (using __vfs_getxattr) since these operations are internal to
> overlayfs operations and do not disclose any data.  This became
> an issue for credential override off since sys_admin would have
> been required by the caller; whereas would have been inherently
> present for the creator since it performed the mount.
>
> This is a change in operations since we do not check in the new
> ovl_do_vfs_getxattr function if the credential override is off or
> not.  Reasoning is that the sepolicy check is unnecessary overhead,
> especially since the check can be expensive.
>
> Because for override credentials off, this affects _everyone_ that
> underneath performs private xattr calls without the appropriate
> sepolicy permissions and sys_admin capability.  Providing blanket
> support for sys_admin would be bad for all possible callers.
>
> For the override credentials on, this will affect only the mounter,
> should it lack sepolicy permissions. Not considered a security
> problem since mounting by definition has sys_admin capabilities,
> but sepolicy contexts would still need to be crafted.
>

It sounds reasonable to me, but I am not a "security person".

> It should be noted that there is precedence, __vfs_getxattr is used
> in other filesystems for their own internal trusted xattr management.
>

Urgh! "other" filesystems meaning ecryptfs_getxattr()?
That looks like a loop hole to read any trusted xattr without any
security checks. Not sure its a good example...

> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: linux-security-module@vger.kernel.org
>
> ---
> v14 - rebase to use xattr_gs_args.
>
> v13 - rebase to use __vfs_getxattr flags option
>
> v12 - rebase
>
> v11 - switch name to ovl_do_vfs_getxattr, fortify comment
>
> v10 - added to patch series
>
> ---
>  fs/overlayfs/namei.c     | 12 +++++++-----
>  fs/overlayfs/overlayfs.h |  2 ++
>  fs/overlayfs/util.c      | 32 +++++++++++++++++++++++---------
>  3 files changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 9702f0d5309d..a4a452c489fa 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -106,10 +106,11 @@ int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
>
>  static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
>  {
> -       int res, err;
> +       ssize_t res;
> +       int err;
>         struct ovl_fh *fh = NULL;
>
> -       res = vfs_getxattr(dentry, name, NULL, 0);
> +       res = ovl_do_vfs_getxattr(dentry, name, NULL, 0);
>         if (res < 0) {
>                 if (res == -ENODATA || res == -EOPNOTSUPP)
>                         return NULL;
> @@ -123,7 +124,7 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
>         if (!fh)
>                 return ERR_PTR(-ENOMEM);
>
> -       res = vfs_getxattr(dentry, name, fh, res);
> +       res = ovl_do_vfs_getxattr(dentry, name, fh, res);
>         if (res < 0)
>                 goto fail;
>
> @@ -141,10 +142,11 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
>         return NULL;
>
>  fail:
> -       pr_warn_ratelimited("overlayfs: failed to get origin (%i)\n", res);
> +       pr_warn_ratelimited("overlayfs: failed to get origin (%zi)\n", res);
>         goto out;
>  invalid:
> -       pr_warn_ratelimited("overlayfs: invalid origin (%*phN)\n", res, fh);
> +       pr_warn_ratelimited("overlayfs: invalid origin (%*phN)\n",
> +                           (int)res, fh);
>         goto out;
>  }
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index c6a8ec049099..72762642b247 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -205,6 +205,8 @@ int ovl_want_write(struct dentry *dentry);
>  void ovl_drop_write(struct dentry *dentry);
>  struct dentry *ovl_workdir(struct dentry *dentry);
>  const struct cred *ovl_override_creds(struct super_block *sb);
> +ssize_t ovl_do_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
> +                           size_t size);
>  struct super_block *ovl_same_sb(struct super_block *sb);
>  int ovl_can_decode_fh(struct super_block *sb);
>  struct dentry *ovl_indexdir(struct super_block *sb);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f5678a3f8350..bed12aed902c 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -40,6 +40,20 @@ const struct cred *ovl_override_creds(struct super_block *sb)
>         return override_creds(ofs->creator_cred);
>  }
>
> +ssize_t ovl_do_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
> +                           size_t size)
> +{
> +       struct xattr_gs_args args = {};
> +
> +       args.dentry = dentry;
> +       args.inode = d_inode(dentry);
> +       args.name = name;
> +       args.buffer = buf;
> +       args.size = size;
> +       args.flags = XATTR_NOSECURITY;
> +       return __vfs_getxattr(&args);
> +}
> +

We do not understand each other.
I commented on this several times.
please put the wrapper helper ovl_do_getxattr() in overlayfs.h
next to the other ovl_do_ wrapper helpers and add pr_debug()
as all other wrappers have.

Thanks,
Amir.
