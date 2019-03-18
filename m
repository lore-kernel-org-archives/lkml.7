Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FF920850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePx/Uh1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCRNGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:06:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44091 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCRNGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:06:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id m65so1925629qkl.11;
        Mon, 18 Mar 2019 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PFJG/hTMYv+5yf+l45UqDGPUJwRUui3R5QGb2GgzFE=;
        b=ePx/Uh1lzi2mH2UfelOfAdxTGu8OxzDhCyspJYrtBzHwjTJ5xTA5zYWG14vXbBAwud
         JjdbeJxCfOK+5BihXRjp+SvjlugGRNrVw2iK6u5JwfDiPls42kdfehI53X/eCJI7KWju
         NIANlozyQSh/IsJHFADgQqbINUK3DjR8KsYOsMSijWOKYOeKuk5mrG7DQ8tjyTvhTRxY
         +UiwegcBMNQxtCdwzIG8nARrce2dfTSfHHkABFv/Mro8HvJQoR89TPt9IcSF0XI//LPT
         GcdRCoOYVMaf6K3MDaQq+NaVMl8oFtIN33jvqrl+RjmCqZaE8kJTX5Vwa+I4zPXJl3xe
         iCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PFJG/hTMYv+5yf+l45UqDGPUJwRUui3R5QGb2GgzFE=;
        b=Gs+R3+H0FKYSmDH18IziS+1cMf2/HQ9/TdB3k6TAAHlni7EoQ6upgPL62veRLe3hsO
         bTOdLc6jc32bDMPz8hL+PDb1iPRHWMZ6xuPDy1hBZB1XY8vFIrN7n4cFG2TEN+BlxMK2
         Lavl/EHv42eXScYJGINqN5TgVQvXon5RCc6TVECkz/I1pOFQemNpsZ/g3XvAA/ZkHZBN
         R9oOLMjRXHPJ6jCp6kP8dfmdjk+z/b/nOP3wF5lcwwBj8+R2LYE/W6yl7HsJKY9I68EU
         IeJQMXsN8iM77ScRxG2HGAf3XCvVWLbC6gobV3COCBCBUX6+W2eCsyhVrvzXrqDdmiqU
         74jA==
X-Gm-Message-State: APjAAAU0zeUVCftbo+jYSTsHh/1XQJhqVN7qkmB/S28bd70f165uINE6
        tY6ut/7tvteQOGvfP71NB1ag27HkIiGZ4ZcxjX8=
X-Google-Smtp-Source: APXvYqyfc2vhJSDCs+p3f/WEc0ybNJXI7PVfGFG8Lkkls5M5bEm5HqKDrDYFqqVg7rwHjhSfuPQlwzM+UKx56oUJ/ms=
X-Received: by 2002:a37:9542:: with SMTP id x63mr4644461qkd.354.1552914399552;
 Mon, 18 Mar 2019 06:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190312142019.30936-1-lhenriques@suse.com> <20190312142019.30936-3-lhenriques@suse.com>
In-Reply-To: <20190312142019.30936-3-lhenriques@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Mon, 18 Mar 2019 21:06:28 +0800
Message-ID: <CAAM7YAkksn_w6Nsm0D7HVGh59ysAJyHptXQ886xD9DAVGhxNEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:22 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> The CephFS kernel client does not enforce quotas set in a directory that
> isn't visible from the mount point.  For example, given the path
> '/dir1/dir2', if quotas are set in 'dir1' and the filesystem is mounted with
>
>   mount -t ceph <server>:<port>:/dir1/ /mnt
>
> then the client won't be able to access 'dir1' inode, even if 'dir2' belongs
> to a quota realm that points to it.
>
> This patch fixes this issue by simply doing an MDS LOOKUPINO operation for
> unknown inodes.  Any inode reference obtained this way will be added to a
> list in ceph_mds_client, and will only be released when the filesystem is
> umounted.
>
> Link: https://tracker.ceph.com/issues/38482
> Reported-by: Hendrik Peyerl <hpeyerl@plusline.net>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/mds_client.c |  15 ++++++
>  fs/ceph/mds_client.h |   2 +
>  fs/ceph/quota.c      | 106 +++++++++++++++++++++++++++++++++++++++----
>  fs/ceph/super.h      |   2 +
>  4 files changed, 115 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 163fc74bf221..1dc24c3525fe 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3656,6 +3656,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
>         mdsc->max_sessions = 0;
>         mdsc->stopping = 0;
>         atomic64_set(&mdsc->quotarealms_count, 0);
> +       INIT_LIST_HEAD(&mdsc->quotarealms_inodes_list);
> +       spin_lock_init(&mdsc->quotarealms_inodes_lock);
>         mdsc->last_snap_seq = 0;
>         init_rwsem(&mdsc->snap_rwsem);
>         mdsc->snap_realms = RB_ROOT;
> @@ -3726,6 +3728,8 @@ static void wait_requests(struct ceph_mds_client *mdsc)
>   */
>  void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
>  {
> +       struct ceph_inode_info *ci;
> +
>         dout("pre_umount\n");
>         mdsc->stopping = 1;
>
> @@ -3738,6 +3742,17 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
>          * their inode/dcache refs
>          */
>         ceph_msgr_flush();
> +       /*
> +        * It's now safe to clean quotarealms_inode_list without holding
> +        * mdsc->quotarealms_inodes_lock
> +        */
> +       while (!list_empty(&mdsc->quotarealms_inodes_list)) {
> +               ci = list_first_entry(&mdsc->quotarealms_inodes_list,
> +                                     struct ceph_inode_info,
> +                                     i_quotarealms_inode_item);
> +               list_del(&ci->i_quotarealms_inode_item);
> +               iput(&ci->vfs_inode);
> +       }
>  }
>
>  /*
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 729da155ebf0..58968fb338ec 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -329,6 +329,8 @@ struct ceph_mds_client {
>         int                     stopping;      /* true if shutting down */
>
>         atomic64_t              quotarealms_count; /* # realms with quota */
> +       struct list_head        quotarealms_inodes_list;
> +       spinlock_t              quotarealms_inodes_lock;
>
>         /*
>          * snap_rwsem will cover cap linkage into snaprealms, and
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 9455d3aef0c3..d1ab1b331c0d 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -22,7 +22,16 @@ void ceph_adjust_quota_realms_count(struct inode *inode, bool inc)
>  static inline bool ceph_has_realms_with_quotas(struct inode *inode)
>  {
>         struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
> -       return atomic64_read(&mdsc->quotarealms_count) > 0;
> +       struct super_block *sb = mdsc->fsc->sb;
> +
> +       if (atomic64_read(&mdsc->quotarealms_count) > 0)
> +               return true;
> +       /* if root is the real CephFS root, we don't have quota realms */
> +       if (sb->s_root->d_inode &&
> +           (sb->s_root->d_inode->i_ino == CEPH_INO_ROOT))
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
> + * This function will try to lookup a realm inode.  If the inode is found
> + * (through an MDS LOOKUPINO operation), the realm->inode will be updated and
> + * the inode will also be added to an mdsc list which will be freed only when
> + * the filesystem is umounted.
> + */
> +static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
> +                                            struct super_block *sb,
> +                                            struct ceph_snap_realm *realm)
> +{
> +       struct inode *in;
> +
> +       in = ceph_lookup_inode(sb, realm->ino);
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
Multiple threads can call this function for the same inode at the same
time. need to handle this. Besides, client needs to record lookupino
error. Otherwise, client may repeatedly send useless request.


> +       spin_lock(&realm->inodes_with_caps_lock);
> +       realm->inode = in;

reply of lookup_ino should alreadly set realm->inode

> +       spin_unlock(&realm->inodes_with_caps_lock);
> +
> +       return in;
> +}
> +
>  /*
>   * This function walks through the snaprealm for an inode and returns the
>   * ceph_snap_realm for the first snaprealm that has quotas set (either max_files
> @@ -76,9 +116,15 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
>   *
>   * Note that the caller is responsible for calling ceph_put_snap_realm() on the
>   * returned realm.
> + *
> + * Callers of this function need to hold mdsc->snap_rwsem.  However, if there's
> + * a need to do an inode lookup, this rwsem will be temporarily dropped.  Hence
> + * the 'retry' argument: if rwsem needs to be dropped and 'retry' is 'false'
> + * this function will return -EAGAIN; otherwise, the snaprealms walk-through
> + * will be restarted.
>   */
>  static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
> -                                              struct inode *inode)
> +                                              struct inode *inode, bool retry)
>  {
>         struct ceph_inode_info *ci = NULL;
>         struct ceph_snap_realm *realm, *next;
> @@ -88,6 +134,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>         if (ceph_snap(inode) != CEPH_NOSNAP)
>                 return NULL;
>
> +restart:
>         realm = ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> @@ -95,11 +142,25 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>                 pr_err_ratelimited("get_quota_realm: ino (%llx.%llx) "
>                                    "null i_snap_realm\n", ceph_vinop(inode));
>         while (realm) {
> +               bool has_inode;
> +
>                 spin_lock(&realm->inodes_with_caps_lock);
> -               in = realm->inode ? igrab(realm->inode) : NULL;
> +               has_inode = realm->inode;
> +               in = has_inode ? igrab(realm->inode) : NULL;
>                 spin_unlock(&realm->inodes_with_caps_lock);
> -               if (!in)
> +               if (has_inode && !in)
>                         break;
> +               if (!in) {
> +                       up_read(&mdsc->snap_rwsem);
> +                       in = lookup_quotarealm_inode(mdsc, inode->i_sb, realm);
> +                       down_read(&mdsc->snap_rwsem);
> +                       if (IS_ERR(in))
> +                               break;
> +                       ceph_put_snap_realm(mdsc, realm);
> +                       if (!retry)
> +                               return ERR_PTR(-EAGAIN);
> +                       goto restart;
> +               }
>
>                 ci = ceph_inode(in);
>                 has_quota = __ceph_has_any_quota(ci);
> @@ -125,9 +186,22 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
>         struct ceph_snap_realm *old_realm, *new_realm;
>         bool is_same;
>
> +restart:
> +       /*
> +        * We need to lookup 2 quota realms atomically, i.e. with snap_rwsem.
> +        * However, get_quota_realm may drop it temporarily.  By setting the
> +        * 'retry' parameter to 'false', we'll get -EAGAIN if the rwsem was
> +        * dropped and we can then restart the whole operation.
> +        */
>         down_read(&mdsc->snap_rwsem);
> -       old_realm = get_quota_realm(mdsc, old);
> -       new_realm = get_quota_realm(mdsc, new);
> +       old_realm = get_quota_realm(mdsc, old, true);
> +       new_realm = get_quota_realm(mdsc, new, false);
> +       if (PTR_ERR(new_realm) == -EAGAIN) {
> +               up_read(&mdsc->snap_rwsem);
> +               if (old_realm)
> +                       ceph_put_snap_realm(mdsc, old_realm);
> +               goto restart;
> +       }
>         is_same = (old_realm == new_realm);
>         up_read(&mdsc->snap_rwsem);
>
> @@ -166,6 +240,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>                 return false;
>
>         down_read(&mdsc->snap_rwsem);
> +restart:
>         realm = ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> @@ -173,12 +248,23 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>                 pr_err_ratelimited("check_quota_exceeded: ino (%llx.%llx) "
>                                    "null i_snap_realm\n", ceph_vinop(inode));
>         while (realm) {
> +               bool has_inode;
> +
>                 spin_lock(&realm->inodes_with_caps_lock);
> -               in = realm->inode ? igrab(realm->inode) : NULL;
> +               has_inode = realm->inode;
> +               in = has_inode ? igrab(realm->inode) : NULL;
>                 spin_unlock(&realm->inodes_with_caps_lock);
> -               if (!in)
> +               if (has_inode && !in)
>                         break;
> -
> +               if (!in) {
> +                       up_read(&mdsc->snap_rwsem);
> +                       in = lookup_quotarealm_inode(mdsc, inode->i_sb, realm);
> +                       down_read(&mdsc->snap_rwsem);
> +                       if (IS_ERR(in))
> +                               break;
> +                       ceph_put_snap_realm(mdsc, realm);
> +                       goto restart;
> +               }
>                 ci = ceph_inode(in);
>                 spin_lock(&ci->i_ceph_lock);
>                 if (op == QUOTA_CHECK_MAX_FILES_OP) {
> @@ -314,7 +400,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>         bool is_updated = false;
>
>         down_read(&mdsc->snap_rwsem);
> -       realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root));
> +       realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
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
