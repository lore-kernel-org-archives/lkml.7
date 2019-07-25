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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44EC20828
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMmatGNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405351AbfGYFso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:48:44 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42659 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfGYFsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:48:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id z63so18881623ywz.9;
        Wed, 24 Jul 2019 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydVv4zA+/+sIts4hNM+2vqi1osfpHO63Y+XbeZJumzQ=;
        b=eMmatGNUa8boqLelfvO399Vaw7UDGMefdLOheQGuVFAtZRiS+0hM3D/WhDoEBh7LZF
         5zqXwfBghsOS06xidCuUA6APv+qHY+sSnZZNDlzZJWYrqf2BiYXctFNS/yxmY711PtFG
         IWgFWDmnuUgGwasEeMpv9eA7sjmLOJHA2+crDowIEgTLQsHo6Ekx92AUXEm1u5Yr8+mg
         ihfj4O2KXWlwFHMo0sRA2CW8SrZoUoBYwhGbparm9CvKSMF2iW0vlVQXgK71q3PjawsP
         WzXjORimQKp2Yw9LTumnIs2xfI9AKyZDG0NKck4F89IqTHwsYryJ4g1kLPlWo3UVAHEL
         5bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydVv4zA+/+sIts4hNM+2vqi1osfpHO63Y+XbeZJumzQ=;
        b=kWZ0w7Czdt0yKWQsq+n1drCBXjgia9VgR9YEUK0PH4VxLQD83RrqtsbHQyeZv+z9fd
         cYFxth9WMj9q+WbqQ+jD91gk8b1xc1lIU87/+6v0HfOEO2qLVRX97VmUSrgJifppHiJD
         EmSps3PYNTd9kph5MPApJifpyON+p3PJo6CbwSG3czcS8irJMNKN54z0b0ScIYellM+B
         IojP6Kp/s1SQzD9WKreyB1DITXSYJaFZRyfziGknVIJMQxUnH0hZJogA9q55XuNWdaIy
         Tb3LPQ5OrzJgA0SRk9beUb+S+9M/S/ubIBboySmetqW69lJ2PuZe6LNbPdyfj1TDpc7B
         +KAA==
X-Gm-Message-State: APjAAAWVWPLXs2jrZjOOnhqZ158CN5eza3/nXbqz1IBki//JXzeIo82n
        5oVBDCxd8+oYaXDNxRYZWWunrHyaR4XhaGV3PDU=
X-Google-Smtp-Source: APXvYqwCWRfdEVOKSFGgonpy6tDpp/BmVqyzmoFoc2iB9nt8WEi3TpUUme9/UMcfFea8WSzFjJ6AXqz2ZkRNyM9GVXc=
X-Received: by 2002:a81:13d4:: with SMTP id 203mr52608843ywt.181.1564033717094;
 Wed, 24 Jul 2019 22:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190724195719.218307-1-salyzyn@android.com> <20190724195719.218307-4-salyzyn@android.com>
In-Reply-To: <20190724195719.218307-4-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Jul 2019 08:48:26 +0300
Message-ID: <CAOQ4uxjizC1RhmLe3qmfASk2M-Y+QEiyLL1yJXa4zXAEby7Tig@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] overlayfs: add __get xattr method
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
> Because of the overlayfs getxattr recursion, the incoming inode fails
> to update the selinux sid resulting in avc denials being reported
> against a target context of u:object_r:unlabeled:s0.

This description is too brief for me to understand the root problem.
What's wring with the overlayfs getxattr recursion w.r.t the selinux
security model?

Please give an example of your unprivileged mounter use case
to explain.

CC Vivek because I could really never understand all this.

>
> Solution is to add a _get xattr method that calls the __vfs_getxattr
> handler so that the context can be read in, rather than being denied
> with an -EACCES when vfs_getxattr handler is called.
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
>  fs/overlayfs/inode.c     | 15 +++++++++++++++
>  fs/overlayfs/overlayfs.h |  2 ++
>  fs/overlayfs/super.c     | 18 ++++++++++++++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 7663aeb85fa3..d3b53849615c 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -362,6 +362,21 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
>         return err;
>  }
>
> +int __ovl_xattr_get(struct dentry *dentry, struct inode *inode,
> +                   const char *name, void *value, size_t size)
> +{
> +       ssize_t res;
> +       const struct cred *old_cred;
> +       struct dentry *realdentry =
> +               ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
> +
> +       old_cred = ovl_override_creds(dentry->d_sb);
> +       res = __vfs_getxattr(realdentry, d_inode(realdentry), name, value,
> +                            size);
> +       ovl_revert_creds(old_cred);
> +       return res;
> +}
> +
>  int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
>                   void *value, size_t size)
>  {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 6934bcf030f0..73a02a263fbc 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -357,6 +357,8 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
>                   const void *value, size_t size, int flags);
>  int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
>                   void *value, size_t size);
> +int __ovl_xattr_get(struct dentry *dentry, struct inode *inode,
> +                   const char *name, void *value, size_t size);
>  ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
>  struct posix_acl *ovl_get_acl(struct inode *inode, int type);
>  int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index b368e2e102fa..82e1130de206 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -859,6 +859,14 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
>         return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
>  }
>
> +static int __maybe_unused
> +__ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
> +                         struct dentry *dentry, struct inode *inode,
> +                         const char *name, void *buffer, size_t size)
> +{
> +       return __ovl_xattr_get(dentry, inode, handler->name, buffer, size);
> +}
> +
>  static int __maybe_unused
>  ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
>                         struct dentry *dentry, struct inode *inode,
> @@ -939,6 +947,13 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
>         return ovl_xattr_get(dentry, inode, name, buffer, size);
>  }
>
> +static int __ovl_other_xattr_get(const struct xattr_handler *handler,
> +                                struct dentry *dentry, struct inode *inode,
> +                                const char *name, void *buffer, size_t size)
> +{
> +       return __ovl_xattr_get(dentry, inode, name, buffer, size);
> +}
> +
>  static int ovl_other_xattr_set(const struct xattr_handler *handler,
>                                struct dentry *dentry, struct inode *inode,
>                                const char *name, const void *value,
> @@ -952,6 +967,7 @@ ovl_posix_acl_access_xattr_handler = {
>         .name = XATTR_NAME_POSIX_ACL_ACCESS,
>         .flags = ACL_TYPE_ACCESS,
>         .get = ovl_posix_acl_xattr_get,
> +       .__get = __ovl_posix_acl_xattr_get,
>         .set = ovl_posix_acl_xattr_set,
>  };
>
> @@ -960,6 +976,7 @@ ovl_posix_acl_default_xattr_handler = {
>         .name = XATTR_NAME_POSIX_ACL_DEFAULT,
>         .flags = ACL_TYPE_DEFAULT,
>         .get = ovl_posix_acl_xattr_get,
> +       .__get = __ovl_posix_acl_xattr_get,
>         .set = ovl_posix_acl_xattr_set,
>  };
>
> @@ -972,6 +989,7 @@ static const struct xattr_handler ovl_own_xattr_handler = {
>  static const struct xattr_handler ovl_other_xattr_handler = {
>         .prefix = "", /* catch all */
>         .get = ovl_other_xattr_get,
> +       .__get = __ovl_other_xattr_get,
>         .set = ovl_other_xattr_set,
>  };
>


Not very professional of me to comment on the proposed solution
without understanding the problem, but my nose says this cannot
be the right solution and if it is, then you better find a much better
name for the API then __get() and document it properly.

Thanks,
Amir.
