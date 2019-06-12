Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4DFC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4D52086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407522AbfFLBHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:07:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405839AbfFLBHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:07:33 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A0C9D575BAF6CA96BF3;
        Wed, 12 Jun 2019 09:07:31 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 09:07:29 +0800
Subject: Re: [PATCH] fs: gfs2: Use IS_ERR_OR_NULL
To:     Andreas Gruenbacher <agruenba@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Bob Peterson <rpeterso@redhat.com>,
        <cluster-devel@redhat.com>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190611162326.26967-1-agruenba@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <723b26e2-fb94-0634-1f58-fdd9eabae945@huawei.com>
Date:   Wed, 12 Jun 2019 09:07:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611162326.26967-1-agruenba@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/12 0:23, Andreas Gruenbacher wrote:
> Kefeng,
> 
> On Wed, 5 Jun 2019 at 16:17, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Use IS_ERR_OR_NULL where appropriate.
> 
> It seems there are several more instances in which IS_ERR_OR_NULL should
> be used (see below).
> 

Right, will collect the following changes and send a new one, thanks.

> Thanks,
> Andreas
> 
> ---
>  fs/gfs2/dir.c        | 2 +-
>  fs/gfs2/glock.c      | 2 +-
>  fs/gfs2/inode.c      | 2 +-
>  fs/gfs2/ops_fstype.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 3925efd3fd83..761a37a3c656 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -753,7 +753,7 @@ static struct gfs2_dirent *gfs2_dirent_split_alloc(struct inode *inode,
>  	struct gfs2_dirent *dent;
>  	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size,
>  				gfs2_dirent_find_offset, name, ptr);
> -	if (!dent || IS_ERR(dent))
> +	if (IS_ERR_OR_NULL(dent))
>  		return dent;
>  	return do_init_dirent(inode, dent, name, bh,
>  			      (unsigned)(ptr - (void *)dent));
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 15c605cfcfc8..f6281470a182 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -684,7 +684,7 @@ static void delete_work_func(struct work_struct *work)
>  		goto out;
>  
>  	inode = gfs2_lookup_by_inum(sdp, no_addr, NULL, GFS2_BLKST_UNLINKED);
> -	if (inode && !IS_ERR(inode)) {
> +	if (!IS_ERR_OR_NULL(inode)) {
>  		d_prune_aliases(inode);
>  		iput(inode);
>  	}
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 998051c4aea7..1cc99da705fc 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -796,7 +796,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
>  fail_gunlock:
>  	gfs2_dir_no_add(&da);
>  	gfs2_glock_dq_uninit(ghs);
> -	if (inode && !IS_ERR(inode)) {
> +	if (!IS_ERR_OR_NULL(inode)) {
>  		clear_nlink(inode);
>  		if (!free_vfs_inode)
>  			mark_inode_dirty(inode);
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index f5312f3b58ee..d35772d90b0a 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -579,7 +579,7 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
>  
>  		INIT_WORK(&jd->jd_work, gfs2_recover_func);
>  		jd->jd_inode = gfs2_lookupi(sdp->sd_jindex, &name, 1);
> -		if (!jd->jd_inode || IS_ERR(jd->jd_inode)) {
> +		if (IS_ERR_OR_NULL(jd->jd_inode)) {
>  			if (!jd->jd_inode)
>  				error = -ENOENT;
>  			else
> 

