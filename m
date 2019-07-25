Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C478FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E257218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlXZqAqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391477AbfGYLA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:00:29 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36403 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388173AbfGYLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:00:29 -0400
Received: by mail-yw1-f66.google.com with SMTP id x67so17769218ywd.3;
        Thu, 25 Jul 2019 04:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/9tM/cnY197lNtKIbEGvdjoci5BadrTWQa+L94ekpI=;
        b=TlXZqAqRzPpf3gfD8V0EvgwNAWlvyzJuGQp0qP4ZcQNUngpwSwvdyCMRR/7R9AHZAW
         GuOMdzNyGDZMf0PNKbCk7y9QD3lXOCjkZr7ZBB7uDm0BgUiMCBBBr4MJNZ79HcfB7uRR
         L35CzL1tUcFV3AhEfiKdHSqMddOjEGDIjA6oYlJUoxFhaBszEVXcNnY1+6ul3za+2x57
         Fw4/Z16Ne3tTR/xwVvioVo+dBJGbQUwLLnbbtQnDKJW3nE8e/fdWobY8TyMHl8mHwfZ/
         0iniDeqcvqEVhuMQ9FeziB6ZkiOj1k+jcPLpT3Xj5U/CRQtc0a+tjL6VOfSGfW7Slce9
         17fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/9tM/cnY197lNtKIbEGvdjoci5BadrTWQa+L94ekpI=;
        b=nvXblKHCrMjppxmTQchwtsjy8LKtAywid0MU3HOcQaRcmUW6lhEGod4ArhyD3iXpmV
         Ew8BduBMrxZTb3a2b/p9iiZhjJKTII4mG0Viom0JediX4K+HmHb03bnHYn4lXFKhhGVf
         RAtIS5gMxeVhrwGIKw8lIcc1y83+0sbP5+drJaiuECxQvNPN/i4+qV7SssVrWoaYXD/+
         roEhsx9i/udPdhdKCdEmyaG2EkAeo8huiSYd1QF4ehgob0+LghBJ8MU7/E3jDCg0fbjx
         Vr5pTIANLvYCcJs42dZe6r6ikX52h833sC8K1olwT84pmg4rr/KKXa1jvNcOo4mYq1Rq
         Pygg==
X-Gm-Message-State: APjAAAXsspmd7cd185araiRC0hRaz2ROKpOW36whz6kEvElur/OAdyUx
        hEzlz5N7pBZ6qI6QHQ4kO9Hs8c9QRRUyGQh3PYQ=
X-Google-Smtp-Source: APXvYqyaI0ALNuRqjV/CcW0cJWZEl55/D3HnYB1O7bWKszwmgtyXizOwoXMN/aHq3bEU7U72mLKk3KOKlEXc/ZyRTMM=
X-Received: by 2002:a81:13d4:: with SMTP id 203mr53284263ywt.181.1564052428064;
 Thu, 25 Jul 2019 04:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190724195719.218307-1-salyzyn@android.com> <20190724195719.218307-5-salyzyn@android.com>
In-Reply-To: <20190724195719.218307-5-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Jul 2019 14:00:16 +0300
Message-ID: <CAOQ4uxhtASSymEOdh4XByXbxWO2_ZivzqjBrgK7jB3fWXLqr_w@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] overlayfs: internal getxattr operations without
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
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Check impure, opaque, origin & meta xattr with no sepolicy audit
> (using __vfs_getxattr) since these operations are internal to
> overlayfs operations and do not disclose any data.  This became
> an issue for credential override off since sys_admin would have
> been required by the caller; whereas would have been inherently
> present for the creator since it performed the mount.
>
> This is a change in operations since we do not check in the new
> ovl_vfs_getxattr function if the credential override is off or
> not.  Reasoning is that the sepolicy check is unnecessary overhead,
> especially since the check can be expensive.

I don't know that this reasoning suffice to skip the sepolicy checks
for overlayfs private xattrs.
Can't sepolicy be defined to allow get access to trusted.overlay.*?

>
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
> ---
> v10 - added to patch series
> ---
>  fs/overlayfs/namei.c     | 12 +++++++-----
>  fs/overlayfs/overlayfs.h |  2 ++
>  fs/overlayfs/util.c      | 24 +++++++++++++++---------
>  3 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 9702f0d5309d..fb6c0cd7b65f 100644
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
> +       res = ovl_vfs_getxattr(dentry, name, NULL, 0);
>         if (res < 0) {
>                 if (res == -ENODATA || res == -EOPNOTSUPP)
>                         return NULL;
> @@ -123,7 +124,7 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
>         if (!fh)
>                 return ERR_PTR(-ENOMEM);
>
> -       res = vfs_getxattr(dentry, name, fh, res);
> +       res = ovl_vfs_getxattr(dentry, name, fh, res);
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
> index 73a02a263fbc..82574684a9b6 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -205,6 +205,8 @@ int ovl_want_write(struct dentry *dentry);
>  void ovl_drop_write(struct dentry *dentry);
>  struct dentry *ovl_workdir(struct dentry *dentry);
>  const struct cred *ovl_override_creds(struct super_block *sb);
> +ssize_t ovl_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
> +                        size_t size);
>  struct super_block *ovl_same_sb(struct super_block *sb);
>  int ovl_can_decode_fh(struct super_block *sb);
>  struct dentry *ovl_indexdir(struct super_block *sb);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f5678a3f8350..672459c3cff7 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -40,6 +40,12 @@ const struct cred *ovl_override_creds(struct super_block *sb)
>         return override_creds(ofs->creator_cred);
>  }
>
> +ssize_t ovl_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
> +                        size_t size)
> +{
> +       return __vfs_getxattr(dentry, d_inode(dentry), name, buf, size);
> +}
> +

When introducing a new ovl_ => vfs_ wrapper, please follow the
ovl_do_XXX helpers
convention in overlayfs.h.

Note that those wrappers do not generally bypass security checks and
you have not
convinced me yet that skipping security checks on the overlayfs
private xattr get
is the right thing to do.

Thanks,
Amir.
