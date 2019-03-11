Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B3BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5194220652
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ9KOjU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfCKDMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:12:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37202 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfCKDMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:12:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id m9so1903806qkl.4;
        Sun, 10 Mar 2019 20:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sk9q/XQEtotVicBryerq4eIMnQNZYUgLvxOTe2OLFf4=;
        b=PQ9KOjU/sp4QDWZAZ6g8R/l7/WbJ+6kgeyMAHOHD6WmT+JKTIRLuSfStTvLUdSwiBL
         JVJ6WKE5kg//YDv8L/oNVfBXnlEEDsk1jO5/W4Js5vL4O5SYmQfiSA2d0Pwj7XPBw6Df
         b9sqfq1tDgtUwx/4w3nNRyKPeXU9bMJ6CqRq8kXpgY+3o56HBw8T7c+oEPGSeT6KrQd9
         INHZjz8S1NXdcQj8ONNvHolo8vYUGu3raDGa+KSQtDOuP7jA9RgDB7gEut/joqVUfQ7l
         nUO42tNOywiTUa0gp5FjaegcFlzTSIS3Wvfrc6R2RH7sBy5JfkOD3u04euEsLhxSQPV0
         ErBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sk9q/XQEtotVicBryerq4eIMnQNZYUgLvxOTe2OLFf4=;
        b=kEahUKaQXZ9v0JahhbbU0YLJ8tYnrS7j4Qx6tiRPdSl9qfF/nBfPwTy8Aap/O+wAv/
         HX3ZOcBIvLMvYll7cLaSPq69bQfoiLMZbjXBNIPhBGa7PGr853NEQJLmeQ3vn6BRuH+z
         9vxaF7JC4Kh9VIqyoLLnOsEomSmFoV84evmfPsoJ9vk+zQyorXWlzIE+QhQDcvaWbFMn
         5Y8dk7Nh6VK16ZWAYTYXX40ub+wXR4GceP/tN5XJmDYJvpUFamL5f90kPMb6xdLNZ47v
         fMv1J5pKlzslNvOdpHRZhDKrSCNILLKswZ4SW7JmsXQ/05ssCdEJSQ3LYBUQTB8KxOZ0
         b7TQ==
X-Gm-Message-State: APjAAAVsjhqgIvSEfdyB5EQnAywXsgvczwPUZYJnkWvy+wR9iAqkrAt8
        VJkwqC8DpZjhQGAZIC1NZo2fMnSkoNAuLGmV5Z8=
X-Google-Smtp-Source: APXvYqwWOzJKzJzsES4/Is1pD+ZSerLieSfmet0/9L8qYszqTXZT1Vz75edKEvM3rWeIbmk6Fcm5bgv9sD8m1BIaBgo=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr23024509qki.291.1552273951080;
 Sun, 10 Mar 2019 20:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190308162757.9260-1-lhenriques@suse.com> <20190308162757.9260-3-lhenriques@suse.com>
In-Reply-To: <20190308162757.9260-3-lhenriques@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Mon, 11 Mar 2019 11:12:19 +0800
Message-ID: <CAAM7YAnDvg0y8qkdGjO-EEdC6s5dMeHHF-PgeAxPqN_LPSSrEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ceph: quota: fix quota subdir mounts
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 9, 2019 at 12:30 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> The CephFS kernel client does not enforce quotas set in a directory that =
isn't
> visible from the mount point.  For example, given the path '/dir1/dir2', =
if quotas
> are set in 'dir1' and the filesystem is mounted with
>
>   mount -t ceph <server>:<port>:/dir1/ /mnt
>
> then the client won't be able to access 'dir1' inode, even if 'dir2' belo=
ngs to
> a quota realm that points to it.
>
> This patch fixes this issue by simply doing an MDS LOOKUPINO operation fo=
r
> unknown inodes.  Any inode reference obtained this way will be added to a=
 list
> in ceph_mds_client, and will only be released when the filesystem is umou=
nted.
>
> Link: https://tracker.ceph.com/issues/38482
> Reported-by: Hendrik Peyerl <hpeyerl@plusline.net>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/mds_client.c | 14 +++++++
>  fs/ceph/mds_client.h |  2 +
>  fs/ceph/quota.c      | 91 +++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/super.h      |  2 +
>  4 files changed, 99 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 163fc74bf221..72c5ce5e4209 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3656,6 +3656,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>         mdsc->max_sessions =3D 0;
>         mdsc->stopping =3D 0;
>         atomic64_set(&mdsc->quotarealms_count, 0);
> +       INIT_LIST_HEAD(&mdsc->quotarealms_inodes_list);
> +       spin_lock_init(&mdsc->quotarealms_inodes_lock);
>         mdsc->last_snap_seq =3D 0;
>         init_rwsem(&mdsc->snap_rwsem);
>         mdsc->snap_realms =3D RB_ROOT;
> @@ -3726,9 +3728,21 @@ static void wait_requests(struct ceph_mds_client *=
mdsc)
>   */
>  void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
>  {
> +       struct ceph_inode_info *ci;
> +
>         dout("pre_umount\n");
>         mdsc->stopping =3D 1;
>
> +       spin_lock(&mdsc->quotarealms_inodes_lock);
> +       while(!list_empty(&mdsc->quotarealms_inodes_list)) {
> +               ci =3D list_first_entry(&mdsc->quotarealms_inodes_list,
> +                                     struct ceph_inode_info,
> +                                     i_quotarealms_inode_item);
> +               list_del(&ci->i_quotarealms_inode_item);
> +               iput(&ci->vfs_inode);

iput while holding spinlock is not good

> +       }
> +       spin_unlock(&mdsc->quotarealms_inodes_lock);
> +
>         lock_unlock_sessions(mdsc);
>         ceph_flush_dirty_caps(mdsc);
>         wait_requests(mdsc);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 729da155ebf0..58968fb338ec 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -329,6 +329,8 @@ struct ceph_mds_client {
>         int                     stopping;      /* true if shutting down *=
/
>
>         atomic64_t              quotarealms_count; /* # realms with quota=
 */
> +       struct list_head        quotarealms_inodes_list;
> +       spinlock_t              quotarealms_inodes_lock;
>
>         /*
>          * snap_rwsem will cover cap linkage into snaprealms, and
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 9455d3aef0c3..c57c0b709efe 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -22,7 +22,16 @@ void ceph_adjust_quota_realms_count(struct inode *inod=
e, bool inc)
>  static inline bool ceph_has_realms_with_quotas(struct inode *inode)
>  {
>         struct ceph_mds_client *mdsc =3D ceph_inode_to_client(inode)->mds=
c;
> -       return atomic64_read(&mdsc->quotarealms_count) > 0;
> +       struct super_block *sb =3D mdsc->fsc->sb;
> +
> +       if (atomic64_read(&mdsc->quotarealms_count) > 0)
> +               return true;
> +       /* if root is the real CephFS root, we don't have quota realms */
> +       if (sb->s_root->d_inode &&
> +           (sb->s_root->d_inode->i_ino =3D=3D CEPH_INO_ROOT))
> +               return false;
> +       /* otherwise, we can't know for sure */
> +       return true;
>  }
>
>  void ceph_handle_quota(struct ceph_mds_client *mdsc,
> @@ -68,6 +77,37 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
>         iput(inode);
>  }
>
> +/*
> + * This function will try to lookup a realm inode.  If the inode is foun=
d
> + * (through an MDS LOOKUPINO operation), the realm->inode will be update=
d and
> + * the inode will also be added to an mdsc list which will be freed only=
 when
> + * the filesystem is umounted.
> + */
> +static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mds=
c,
> +                                            struct super_block *sb,
> +                                            struct ceph_snap_realm *real=
m)
> +{
> +       struct inode *in;
> +
> +       in =3D ceph_lookup_inode(sb, realm->ino);
> +       if (IS_ERR(in)) {
> +               pr_warn("Can't lookup inode %llx (err: %ld)\n",
> +                       realm->ino, PTR_ERR(in));
> +               return in;
> +       }
> +
> +       spin_lock(&mdsc->quotarealms_inodes_lock);
> +       list_add(&ceph_inode(in)->i_quotarealms_inode_item,
> +                &mdsc->quotarealms_inodes_list);
> +       spin_unlock(&mdsc->quotarealms_inodes_lock);
> +
> +       spin_lock(&realm->inodes_with_caps_lock);
> +       realm->inode =3D in;
> +       spin_unlock(&realm->inodes_with_caps_lock);
> +
> +       return in;
> +}
> +
>  /*
>   * This function walks through the snaprealm for an inode and returns th=
e
>   * ceph_snap_realm for the first snaprealm that has quotas set (either m=
ax_files
> @@ -76,9 +116,15 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
>   *
>   * Note that the caller is responsible for calling ceph_put_snap_realm()=
 on the
>   * returned realm.
> + *
> + * Callers of this function need to hold mdsc->snap_rwsem.  If there's t=
he need
> + * to do an inode lookup, this rwsem will be temporarily dropped.  Hence=
 the
> + * 'retry' argument: if rwsem needs to be dropped and 'retry' is 'true' =
this
> + * function will return -EAGAIN; otherwise, the whole operation will be
> + * restarted.
>   */
>  static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *m=
dsc,
> -                                              struct inode *inode)
> +                                              struct inode *inode, bool =
retry)
>  {
>         struct ceph_inode_info *ci =3D NULL;
>         struct ceph_snap_realm *realm, *next;
> @@ -88,6 +134,7 @@ static struct ceph_snap_realm *get_quota_realm(struct =
ceph_mds_client *mdsc,
>         if (ceph_snap(inode) !=3D CEPH_NOSNAP)
>                 return NULL;
>
> +restart:
>         realm =3D ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> @@ -98,8 +145,17 @@ static struct ceph_snap_realm *get_quota_realm(struct=
 ceph_mds_client *mdsc,
>                 spin_lock(&realm->inodes_with_caps_lock);
>                 in =3D realm->inode ? igrab(realm->inode) : NULL;
>                 spin_unlock(&realm->inodes_with_caps_lock);
> -               if (!in)
> -                       break;
> +               if (!in) {
> +                       up_read(&mdsc->snap_rwsem);
> +                       in =3D lookup_quotarealm_inode(mdsc, inode->i_sb,=
 realm);
> +                       down_read(&mdsc->snap_rwsem);
> +                       if (IS_ERR(in))
> +                               break;
> +                       ceph_put_snap_realm(mdsc, realm);
> +                       if (!retry)
> +                               return ERR_PTR(-EAGAIN);
> +                       goto restart;
> +               }
>
>                 ci =3D ceph_inode(in);
>                 has_quota =3D __ceph_has_any_quota(ci);
> @@ -125,9 +181,17 @@ bool ceph_quota_is_same_realm(struct inode *old, str=
uct inode *new)
>         struct ceph_snap_realm *old_realm, *new_realm;
>         bool is_same;
>
> +restart:
>         down_read(&mdsc->snap_rwsem);
> -       old_realm =3D get_quota_realm(mdsc, old);
> -       new_realm =3D get_quota_realm(mdsc, new);
> +       old_realm =3D get_quota_realm(mdsc, old, true);
> +       /* This needs to be atomic, so we need to hold snap_rwsem */

I don't understand this comment. get_quota_realm() unlock snap_rwsem
no matter the 'retry' parameter is true or not/


> +       new_realm =3D get_quota_realm(mdsc, new, false);
> +       if (PTR_ERR(new_realm) =3D=3D -EAGAIN) {
> +               up_read(&mdsc->snap_rwsem);
> +               if (old_realm)
> +                       ceph_put_snap_realm(mdsc, old_realm);
> +               goto restart;
> +       }
>         is_same =3D (old_realm =3D=3D new_realm);
>         up_read(&mdsc->snap_rwsem);
>
> @@ -166,6 +230,7 @@ static bool check_quota_exceeded(struct inode *inode,=
 enum quota_check_op op,
>                 return false;
>
>         down_read(&mdsc->snap_rwsem);
> +restart:
>         realm =3D ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> @@ -176,9 +241,15 @@ static bool check_quota_exceeded(struct inode *inode=
, enum quota_check_op op,
>                 spin_lock(&realm->inodes_with_caps_lock);
>                 in =3D realm->inode ? igrab(realm->inode) : NULL;
>                 spin_unlock(&realm->inodes_with_caps_lock);
> -               if (!in)
> -                       break;
> -
> +               if (!in) {

maybe we should  distinguish =E2=80=98realm->inode is null' from 'igrab fai=
ls'

> +                       up_read(&mdsc->snap_rwsem);
> +                       in =3D lookup_quotarealm_inode(mdsc, inode->i_sb,=
 realm);
> +                       down_read(&mdsc->snap_rwsem);
> +                       if (IS_ERR(in))
> +                               break;
> +                       ceph_put_snap_realm(mdsc, realm);
> +                       goto restart;
> +               }
>                 ci =3D ceph_inode(in);
>                 spin_lock(&ci->i_ceph_lock);
>                 if (op =3D=3D QUOTA_CHECK_MAX_FILES_OP) {
> @@ -314,7 +385,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *=
fsc, struct kstatfs *buf)
>         bool is_updated =3D false;
>
>         down_read(&mdsc->snap_rwsem);
> -       realm =3D get_quota_realm(mdsc, d_inode(fsc->sb->s_root));
> +       realm =3D get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
>         up_read(&mdsc->snap_rwsem);
>         if (!realm)
>                 return false;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index ce51e98b08ec..cc7766aeb73b 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -375,6 +375,8 @@ struct ceph_inode_info {
>         struct list_head i_snap_realm_item;
>         struct list_head i_snap_flush_item;
>
> +       struct list_head i_quotarealms_inode_item;
> +
>         struct work_struct i_wb_work;  /* writeback work */
>         struct work_struct i_pg_inv_work;  /* page invalidation work */
>
