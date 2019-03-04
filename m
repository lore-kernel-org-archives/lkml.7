Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB88C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F75206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwwITTU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCDHkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:40:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32961 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfCDHkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:40:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id x9so2323462qkf.0;
        Sun, 03 Mar 2019 23:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtQIuVX7UKqb56LkNOPz+IGu74jM/ubDRVQwn51lG+o=;
        b=GwwITTU4nXxccYiDhWiAdMOwyuPJtuTFEQutC8RewfyBtSKEwRifMI5bVRUuBZdV0k
         L7GQEJkZQxxalRhqXQbFpY4w3Y/OEVFlkreptJE8lsVhSqX5iN8DKgObrJrmz9rw7KyO
         IBgN3UyxnnCNr/ApC1o+Zh722tCrPJheSBu2IRqSKhJcHxRS3SDHvpgDyKUYz8kVUhCs
         9WbMnDv/TmYo4dcdSF7o+v3F6zoIVyeXqWzgsOnHYDUQFQcDTUHz0lansrPrWuA1wP7A
         M9nATQaEv8Xf9fqNrguuJ83BXRdtaeOObuGq5i8H3gPZqSjck1N0FIHf7cXVZNnRxZJN
         9g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtQIuVX7UKqb56LkNOPz+IGu74jM/ubDRVQwn51lG+o=;
        b=Pl46oP05bMip0zqgJ6geYBsNzLA9yyb6+vRy2DbyGsT4X1pAzuA4ODWv9I0TxI/kRd
         Z2wrEAWaiYCJDwRQI2Boq2SEZOWtHo/UQQhK8fvMUhVtUp0ZhwTrTbMdE5TaJDUcP24y
         JLahHAmW5hQHXxrst5WyS3TiEfH/z2GLdmLcj6uLsYd/sYkd/9XMeK0aEyc6XOmjFT0c
         +mLnlrTWbjXNJ9GWYfiY58rD6p1Nk8uvT2i/F9RaeElrcVGgu4QZhLKpa81nsbXJxq5y
         X/VWZ4Os7wD2Jd0wQWCdaoGjwChc2VkXi/MAJkxYUdZbdIk3t9iX022wocKDm0DEJaI+
         ZSKw==
X-Gm-Message-State: APjAAAW5gqaZb+HAN34w2RzePFI3vsnmHxG7o8CAsTm35iXEiN2jkVkW
        p1KFnCm2gAaFN6vCTt4UvifkiAF1YH3Ou9oYUJw=
X-Google-Smtp-Source: APXvYqyJoOHvzoi4nmq2E3CW0ZxdKThWBW5Ard0EWtJbz9jbKpH/uqu+5ACSQims8TqNVYtOkPPMVymWtOf+zhJ16vs=
X-Received: by 2002:a05:620a:1348:: with SMTP id c8mr12953098qkl.246.1551685233554;
 Sun, 03 Mar 2019 23:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20190301175752.17808-1-lhenriques@suse.com> <20190301175752.17808-3-lhenriques@suse.com>
In-Reply-To: <20190301175752.17808-3-lhenriques@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Mon, 4 Mar 2019 15:40:22 +0800
Message-ID: <CAAM7YAmPSoEaJ6tXUtp+f56SV-Tqr6VKP4RquV0FA+LYkR8Rxg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] ceph: quota: fix quota subdir mounts
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

On Sat, Mar 2, 2019 at 3:13 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> The CephFS kernel client doesn't enforce quotas that are set in a
> directory that isn't visible in the mount point.  For example, given the
> path '/dir1/dir2', if quotas are set in 'dir1' and the mount is done in with
>
>   mount -t ceph <server>:<port>:/dir1/ /mnt
>
> then the client can't access the 'dir1' inode from the quota realm dir2
> belongs to.
>
> This patch fixes this by simply doing an MDS LOOKUPINO Op and grabbing a
> reference to it (so that it doesn't disappear again).  This also requires an
> extra field in ceph_snap_realm so that we know we have to release that
> reference when destroying the realm.
>

This may cause circle reference if somehow an inode owned by snaprealm
get moved into mount subdir (other clients do rename).  how about
holding these inodes in mds_client?

> Links: https://tracker.ceph.com/issues/3848
> Reported-by: Hendrik Peyerl <hpeyerl@plusline.net>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/caps.c  |  2 +-
>  fs/ceph/quota.c | 30 +++++++++++++++++++++++++++---
>  fs/ceph/snap.c  |  3 +++
>  fs/ceph/super.h |  2 ++
>  4 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index bba28a5034ba..e79994ff53d6 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1035,7 +1035,7 @@ static void drop_inode_snap_realm(struct ceph_inode_info *ci)
>         list_del_init(&ci->i_snap_realm_item);
>         ci->i_snap_realm_counter++;
>         ci->i_snap_realm = NULL;
> -       if (realm->ino == ci->i_vino.ino)
> +       if ((realm->ino == ci->i_vino.ino) && !realm->own_inode)
>                 realm->inode = NULL;
>         spin_unlock(&realm->inodes_with_caps_lock);
>         ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 9455d3aef0c3..f6b972d222e4 100644
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
> @@ -166,6 +175,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>                 return false;
>
>         down_read(&mdsc->snap_rwsem);
> +restart:
>         realm = ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> @@ -176,8 +186,22 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>                 spin_lock(&realm->inodes_with_caps_lock);
>                 in = realm->inode ? igrab(realm->inode) : NULL;
>                 spin_unlock(&realm->inodes_with_caps_lock);
> -               if (!in)
> -                       break;
> +               if (!in) {
> +                       up_read(&mdsc->snap_rwsem);
> +                       in = ceph_lookup_inode(inode->i_sb, realm->ino);
> +                       down_read(&mdsc->snap_rwsem);
> +                       if (IS_ERR(in)) {
> +                               pr_warn("Can't lookup inode %llx (err: %ld)\n",
> +                                       realm->ino, PTR_ERR(in));
> +                               break;
> +                       }
> +                       spin_lock(&realm->inodes_with_caps_lock);
> +                       realm->inode = in;
> +                       realm->own_inode = true;
> +                       spin_unlock(&realm->inodes_with_caps_lock);
> +                       ceph_put_snap_realm(mdsc, realm);
> +                       goto restart;
> +               }
>
>                 ci = ceph_inode(in);
>                 spin_lock(&ci->i_ceph_lock);
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index f74193da0e09..c84ed8e8526a 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -117,6 +117,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
>
>         atomic_set(&realm->nref, 1);    /* for caller */
>         realm->ino = ino;
> +       realm->own_inode = false;
>         INIT_LIST_HEAD(&realm->children);
>         INIT_LIST_HEAD(&realm->child_item);
>         INIT_LIST_HEAD(&realm->empty_item);
> @@ -184,6 +185,8 @@ static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
>         kfree(realm->prior_parent_snaps);
>         kfree(realm->snaps);
>         ceph_put_snap_context(realm->cached_context);
> +       if (realm->own_inode && realm->inode)
> +               iput(realm->inode);
>         kfree(realm);
>  }
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index ce51e98b08ec..3f0d74d2150f 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -764,6 +764,8 @@ struct ceph_snap_realm {
>         atomic_t nref;
>         struct rb_node node;
>
> +       bool own_inode;     /* true if we hold a ref to the inode */
> +
>         u64 created, seq;
>         u64 parent_ino;
>         u64 parent_since;   /* snapid when our current parent became so */
