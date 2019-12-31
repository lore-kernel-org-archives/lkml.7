Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C207FC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D7520730
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577753196;
	bh=bsm8Figya2B2zyGRA/XNh7qJHHQtFRMmmya6bRM0TFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iaH4ONvPIZ5bH979wlOfoeIM/85w9Aox5XFBuN77g8LBd6gIS/kqJxAOEgVEeLEbQ
	 HRCiDe033i48fHEGf2GK+Myg842R9KEIvmb8VITkMJnWbmzJpWw+E7HNNkVRMjPyeW
	 0YerNVOivQVmpRrAT+y7I0FElgttNClxmOhJHOfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfLaAqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbfLaAqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:46:35 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39475206CB;
        Tue, 31 Dec 2019 00:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577753194;
        bh=bsm8Figya2B2zyGRA/XNh7qJHHQtFRMmmya6bRM0TFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yNksmIVnWCXqTbbkoqqK4ojzm2qGuC4rGoxMDLN4oQ0HNZ0VMhknfU8DvjpHuZFTI
         YMvnvbs/lYM1fpsM3L4zl3jSY8OpA7dLZbv9pQnDzy4JLb+wLsQ6TUVXIij1Ur6AVL
         EknEc3DYZNvAOnfGyCk4BgeWjuJHIZkgStgairEU=
Date:   Mon, 30 Dec 2019 16:46:33 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [RFC PATCH v5] f2fs: support data compression
Message-ID: <20191231004633.GA85441@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <20191218214619.GA20072@jaegeuk-macbookpro.roam.corp.google.com>
 <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Sorry for the delay.
> 
> On 2019/12/19 5:46, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > I still see some diffs from my latest testing version, so please check anything
> > that you made additionally from here.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=25d18e19a91e60837d36368ee939db13fd16dc64
> 
> I've checked the diff and picked up valid parts, could you please check and
> comment on it?
> 
> ---
>  fs/f2fs/compress.c |  8 ++++----
>  fs/f2fs/data.c     | 18 +++++++++++++++---
>  fs/f2fs/f2fs.h     |  3 +++
>  fs/f2fs/file.c     |  1 -
>  4 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index af23ed6deffd..1bc86a54ad71 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -593,7 +593,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  							fgp_flag, GFP_NOFS);
>  		if (!page) {
>  			ret = -ENOMEM;
> -			goto unlock_pages;
> +			goto release_pages;
>  		}
> 
>  		if (PageUptodate(page))
> @@ -608,13 +608,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
>  						&last_block_in_bio, false);
>  		if (ret)
> -			goto release_pages;
> +			goto unlock_pages;
>  		if (bio)
>  			f2fs_submit_bio(sbi, bio, DATA);
> 
>  		ret = f2fs_init_compress_ctx(cc);
>  		if (ret)
> -			goto release_pages;
> +			goto unlock_pages;
>  	}
> 
>  	for (i = 0; i < cc->cluster_size; i++) {
> @@ -762,7 +762,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	if (err)
>  		goto out_unlock_op;
> 
> -	psize = (cc->rpages[last_index]->index + 1) << PAGE_SHIFT;
> +	psize = (loff_t)(cc->rpages[last_index]->index + 1) << PAGE_SHIFT;
> 
>  	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
>  	if (err)
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 19cd03450066..f1f5c701228d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -184,13 +184,18 @@ static void f2fs_decompress_work(struct bio_post_read_ctx *ctx)
>  }
> 
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> +void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
> +{
> +	f2fs_decompress_end_io(rpages, cluster_size, false, true);
> +}
> +
>  static void f2fs_verify_bio(struct bio *bio)
>  {
>  	struct page *page = bio_first_page_all(bio);
>  	struct decompress_io_ctx *dic =
>  			(struct decompress_io_ctx *)page_private(page);
> 
> -	f2fs_decompress_end_io(dic->rpages, dic->cluster_size, false, true);
> +	f2fs_verify_pages(dic->rpages, dic->cluster_size);
>  	f2fs_free_dic(dic);
>  }
>  #endif
> @@ -507,10 +512,16 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
>  	bio_for_each_segment_all(bvec, bio, iter_all) {
>  		struct page *target = bvec->bv_page;
> 
> -		if (fscrypt_is_bounce_page(target))
> +		if (fscrypt_is_bounce_page(target)) {
>  			target = fscrypt_pagecache_page(target);
> -		if (f2fs_is_compressed_page(target))
> +			if (IS_ERR(target))
> +				continue;
> +		}
> +		if (f2fs_is_compressed_page(target)) {
>  			target = f2fs_compress_control_page(target);
> +			if (IS_ERR(target))
> +				continue;
> +		}
> 
>  		if (inode && inode == target->mapping->host)
>  			return true;
> @@ -2039,6 +2050,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  	if (ret)
>  		goto out;
> 
> +	/* cluster was overwritten as normal cluster */
>  	if (dn.data_blkaddr != COMPRESS_ADDR)
>  		goto out;
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5d55cef66410..17d2af4eeafb 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2719,6 +2719,7 @@ static inline void set_compress_context(struct inode *inode)
>  			1 << F2FS_I(inode)->i_log_cluster_size;
>  	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
>  	set_inode_flag(inode, FI_COMPRESSED_FILE);
> +	stat_inc_compr_inode(inode);
>  }
> 
>  static inline unsigned int addrs_per_inode(struct inode *inode)
> @@ -3961,6 +3962,8 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  		return true;
>  	if (f2fs_is_multi_device(sbi))
>  		return true;
> +	if (f2fs_compressed_file(inode))
> +		return true;
>  	/*
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>  	 * all IOs can be serialized by log-structured write.
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index bde5612f37f5..9aeadf14413c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1828,7 +1828,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  				return -EINVAL;
> 
>  			set_compress_context(inode);
> -			stat_inc_compr_inode(inode);

As this breaks the count, I'll keep as is.

Thanks,

>  		}
>  	}
>  	if ((iflags ^ fi->i_flags) & F2FS_NOCOMP_FL) {
> -- 
> 2.18.0.rc1
> 
> Thanks,
