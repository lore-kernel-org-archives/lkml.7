Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426AAC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CE72075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577129555;
	bh=9xZo8MS17ymclDrHbF1C0xS+tnJ1Y5IWGQbRr7M9kkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sYnG17NVCt1MTnQdJNoDdjEZhGGpRQJRrs1Qb2KU1WamWRmDS1UAZO0hOyn3whZMF
	 hWxQHaGHP1ZRacTupg7tHI7/e0kxE72Qbx1RAIfceCxXAXBZzux/WuUScI+SrFgc+A
	 Oi4bAYUUSfEUXUBGlIHUWS9qjGhYwQt0GniNICac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLWT3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:29:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWT3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:29:53 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3117A20643;
        Mon, 23 Dec 2019 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577129392;
        bh=9xZo8MS17ymclDrHbF1C0xS+tnJ1Y5IWGQbRr7M9kkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nwn6s9KbMF15IjI1ZXuDaSE9Zju8WT9h4Lpb9pUfJXhj0qSfteIW55/zYysZwScIE
         BVOuvKY6q00D+l0hCtzUWO5z8gXFHKmiFv6ns7HndkBFJ62bs+dXrSkRsJW/40Eza/
         sGS+Ac+/Fg9mHX2J8av4LCPCcGlLRDwe1LUo84H4=
Date:   Mon, 23 Dec 2019 11:29:51 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [RFC PATCH v5] f2fs: support data compression
Message-ID: <20191223192951.GA49839@jaegeuk-macbookpro.roam.corp.google.com>
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

Let me test first and see the code change soon.

Thanks,

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
>  		}
>  	}
>  	if ((iflags ^ fi->i_flags) & F2FS_NOCOMP_FL) {
> -- 
> 2.18.0.rc1
> 
> Thanks,
