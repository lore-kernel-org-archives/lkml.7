Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A14C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABAE20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH9BQn5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCGH3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:29:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41503 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGH3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:29:37 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so15989498qtp.8;
        Wed, 06 Mar 2019 23:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=283VgPlb9jiQymbfepk1RGlaIANYONXROMP0wW6tbqo=;
        b=ZH9BQn5QmYH7EFlAV2a7hYMT68/dQ+k+1W2M2Zek6zMTEXa/0FHm2S+P4JfrWyg4jc
         NX32jAnxqhoBk5ZmfsW5eX3v9eBD7a//XfzUFNXxRiSB4lOBcZYX6OO2Pzqpc6oLeTUy
         w8+nFgJg4/yKPrqBOXGcS7Vy5JIN7Y53QPojBJIzR/dUxC8sjIP4UH3hpZWZsrZGTb4w
         w8G1PdMvyWELcVCLqaQc7LGqgl5Mah6hqMKpiPQWHZZlAKNdXH2JSbMfOZPp+HE9byvF
         3ja6065/zux9Fj4eTFe+XgEEg3/sV2ClK7DWb1nTWhKlU9seZ5XvgdPQb+mXnmsjX8ZM
         Amtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=283VgPlb9jiQymbfepk1RGlaIANYONXROMP0wW6tbqo=;
        b=OUFgAop1K4sz77avWzEEfClpBAJwRPOc02P6vP9xFO3QDzyqJfkneG4VqXjfD0zsbd
         GV+Ui9S6vuz0GcCxFMQA8IeMu1cyxyMp27Tif26YRNQi41qyH4EYxCgAxCqEabiofytF
         0ylcxv0Fk7LILawiERjS13HBQtfKvAxmyDOlQDBPwd+wO22MifnalBBbtZa6Y0950HOm
         XJMvbx17mraU0k05M6Jh1NrWoDfSRaPMGEO0goa/8NmehcRwc1fWeZOrf8gFpLX73KEO
         k9Pv5zv2oOIQIB6U/gusj11HibMq8I1zQshPId8SXSeYpUlVFOpqLLTvof1ZwPY59uLB
         /5hA==
X-Gm-Message-State: APjAAAUmvsnyIhDAXlzfLZ8Obd9G2DG75DZys9fDBVGXwclHjj5kPM67
        M+7y994BxAthfVem+DWNLHSDh86ev6IG9OTvRBQ=
X-Google-Smtp-Source: APXvYqyUqs2EZa+bNPWSkVQM8KUWd6Z9mhC4RKQalTv7ODc0hRQ4ykB+qG8fY9dx8+JE6i+9jxoLQC5h3yYntEVbfyU=
X-Received: by 2002:a0c:a8d4:: with SMTP id h20mr9724571qvc.46.1551943776052;
 Wed, 06 Mar 2019 23:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20190301175752.17808-1-lhenriques@suse.com> <20190301175752.17808-3-lhenriques@suse.com>
 <CAAM7YAmPSoEaJ6tXUtp+f56SV-Tqr6VKP4RquV0FA+LYkR8Rxg@mail.gmail.com> <87va0vamog.fsf@suse.com>
In-Reply-To: <87va0vamog.fsf@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Thu, 7 Mar 2019 15:29:24 +0800
Message-ID: <CAAM7YAmapiFwj=sY+vCUyOU1mPZE2sk4_ZYPYAk06iPDd_utzQ@mail.gmail.com>
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

On Thu, Mar 7, 2019 at 2:21 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> "Yan, Zheng" <ukernel@gmail.com> writes:
>
> > On Sat, Mar 2, 2019 at 3:13 AM Luis Henriques <lhenriques@suse.com> wrote:
> >>
> >> The CephFS kernel client doesn't enforce quotas that are set in a
> >> directory that isn't visible in the mount point.  For example, given the
> >> path '/dir1/dir2', if quotas are set in 'dir1' and the mount is done in with
> >>
> >>   mount -t ceph <server>:<port>:/dir1/ /mnt
> >>
> >> then the client can't access the 'dir1' inode from the quota realm dir2
> >> belongs to.
> >>
> >> This patch fixes this by simply doing an MDS LOOKUPINO Op and grabbing a
> >> reference to it (so that it doesn't disappear again).  This also requires an
> >> extra field in ceph_snap_realm so that we know we have to release that
> >> reference when destroying the realm.
> >>
> >
> > This may cause circle reference if somehow an inode owned by snaprealm
> > get moved into mount subdir (other clients do rename).  how about
> > holding these inodes in mds_client?
>
> Ok, before proceeded any further I wanted to make sure that what you
> were suggesting was something like the patch below.  It simply keeps a
> list of inodes in ceph_mds_client until the filesystem is umounted,
> iput()ing them at that point.
>
yes,

> I'm sure I'm missing another place where the reference should be
> dropped, but I couldn't figure it out yet.  It can't be
> ceph_destroy_inode; drop_inode_snap_realm is a possibility, but what if
> the inode becomes visible in the meantime?  Well, I'll continue thinking
> about it.

why do you think we need to clean up the references at other place.
what problem you encountered.

Regards
Yan, Zheng
>
> Function get_quota_realm() should have a similar construct to lookup
> inodes.  But it's a bit more tricky, because ceph_quota_is_same_realm()
> requires snap_rwsem to be held for the 2 invocations of
> get_quota_realm.
>
> Cheers,
> --
> Luis
>
> From a429a4c167186781bd235a25d72be893baf9e029 Mon Sep 17 00:00:00 2001
> From: Luis Henriques <lhenriques@suse.com>
> Date: Wed, 6 Mar 2019 17:58:04 +0000
> Subject: [PATCH] ceph: quota: fix quota subdir mounts (II)
>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/mds_client.c | 14 ++++++++++++++
>  fs/ceph/mds_client.h |  2 ++
>  fs/ceph/quota.c      | 34 ++++++++++++++++++++++++++++++----
>  fs/ceph/super.h      |  2 ++
>  4 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 163fc74bf221..72c5ce5e4209 100644
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
> @@ -3726,9 +3728,21 @@ static void wait_requests(struct ceph_mds_client *mdsc)
>   */
>  void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
>  {
> +       struct ceph_inode_info *ci;
> +
>         dout("pre_umount\n");
>         mdsc->stopping = 1;
>
> +       spin_lock(&mdsc->quotarealms_inodes_lock);
> +       while(!list_empty(&mdsc->quotarealms_inodes_list)) {
> +               ci = list_first_entry(&mdsc->quotarealms_inodes_list,
> +                                     struct ceph_inode_info,
> +                                     i_quotarealms_inode_item);
> +               list_del(&ci->i_quotarealms_inode_item);
> +               iput(&ci->vfs_inode);
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
>         int                     stopping;      /* true if shutting down */
>
>         atomic64_t              quotarealms_count; /* # realms with quota */
> +       struct list_head        quotarealms_inodes_list;
> +       spinlock_t              quotarealms_inodes_lock;
>
>         /*
>          * snap_rwsem will cover cap linkage into snaprealms, and
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 9455d3aef0c3..7d4dec9eea47 100644
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
> @@ -176,9 +186,25 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
>                 spin_lock(&realm->inodes_with_caps_lock);
>                 in = realm->inode ? igrab(realm->inode) : NULL;
>                 spin_unlock(&realm->inodes_with_caps_lock);
> -               if (!in)
> -                       break;
> -
> +               if (!in) {
> +                       up_read(&mdsc->snap_rwsem);
> +                       in = ceph_lookup_inode(inode->i_sb, realm->ino);
> +                       down_read(&mdsc->snap_rwsem);
> +                       if (IS_ERR(in)) {
> +                               pr_warn("Can't lookup inode %llx (err: %ld)\n",
> +                                       realm->ino, PTR_ERR(in));
> +                               break;
> +                       }
> +                       spin_lock(&mdsc->quotarealms_inodes_lock);
> +                       list_add(&ceph_inode(in)->i_quotarealms_inode_item,
> +                                &mdsc->quotarealms_inodes_list);
> +                       spin_unlock(&mdsc->quotarealms_inodes_lock);
> +                       spin_lock(&realm->inodes_with_caps_lock);
> +                       realm->inode = in;
> +                       spin_unlock(&realm->inodes_with_caps_lock);
> +                       ceph_put_snap_realm(mdsc, realm);
> +                       goto restart;
> +               }
>                 ci = ceph_inode(in);
>                 spin_lock(&ci->i_ceph_lock);
>                 if (op == QUOTA_CHECK_MAX_FILES_OP) {
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
