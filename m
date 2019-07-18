Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D908BC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC379205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfGRCjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:39:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727804AbfGRCjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:39:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9EE5BB0F0EA6FD46A821;
        Thu, 18 Jul 2019 10:39:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 10:39:30 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to read source block before
 invalidating it
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190718013718.70335-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8049131e-4200-83c8-516a-8fa03a238e29@huawei.com>
Date:   Thu, 18 Jul 2019 10:39:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190718013718.70335-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/18 9:37, Jaegeuk Kim wrote:
> f2fs_allocate_data_block() invalidates old block address and enable new block
> address. Then, if we try to read old block by f2fs_submit_page_bio(), it will
> give WARN due to reading invalid blocks.
> 
> Let's make the order sanely back.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 57 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6691f526fa40..35c5453ab874 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -740,6 +740,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  	block_t newaddr;
>  	int err = 0;
>  	bool lfs_mode = test_opt(fio.sbi, LFS);
> +	bool submitted = false;
>  
>  	/* do not read out */
>  	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
> @@ -796,6 +797,20 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  	if (lfs_mode)
>  		down_write(&fio.sbi->io_order_lock);
>  
> +	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
> +			fio.old_blkaddr, false);
> +	if (!mpage)
> +		goto put_out;

Needs to release io_order_lock.

> +
> +	if (!PageUptodate(mpage)) {
> +		err = f2fs_submit_page_bio(&fio);
> +		if (err) {
> +			f2fs_put_page(mpage, 1);
> +			goto put_out;

Ditto.

Thanks,

> +		}
> +		submitted = true;
> +	}
> +
>  	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
>  					&sum, CURSEG_COLD_DATA, NULL, false);
>  
> @@ -803,44 +818,34 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
>  	if (!fio.encrypted_page) {
>  		err = -ENOMEM;
> -		goto recover_block;
> -	}
> -
> -	mpage = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
> -					fio.old_blkaddr, FGP_LOCK, GFP_NOFS);
> -	if (mpage) {
> -		bool updated = false;
> -
> -		if (PageUptodate(mpage)) {
> -			memcpy(page_address(fio.encrypted_page),
> -					page_address(mpage), PAGE_SIZE);
> -			updated = true;
> -		}
>  		f2fs_put_page(mpage, 1);
> -		invalidate_mapping_pages(META_MAPPING(fio.sbi),
> -					fio.old_blkaddr, fio.old_blkaddr);
> -		if (updated)
> -			goto write_page;
> +		goto recover_block;
>  	}
>  
> -	err = f2fs_submit_page_bio(&fio);
> -	if (err)
> -		goto put_page_out;
> -
> -	/* write page */
> -	lock_page(fio.encrypted_page);
> +	if (!submitted)
> +		goto write_page;
>  
> -	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
> +	/* read source block */
> +	lock_page(mpage);
> +	if (unlikely(mpage->mapping != META_MAPPING(fio.sbi))) {
>  		err = -EIO;
> +		f2fs_put_page(mpage, 1);
>  		goto put_page_out;
>  	}
> -	if (unlikely(!PageUptodate(fio.encrypted_page))) {
> +	if (unlikely(!PageUptodate(mpage))) {
>  		err = -EIO;
> +		f2fs_put_page(mpage, 1);
>  		goto put_page_out;
>  	}
> -
>  write_page:
> +	/* write target block */
>  	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
> +	memcpy(page_address(fio.encrypted_page),
> +				page_address(mpage), PAGE_SIZE);
> +	f2fs_put_page(mpage, 1);
> +	invalidate_mapping_pages(META_MAPPING(fio.sbi),
> +				fio.old_blkaddr, fio.old_blkaddr);
> +
>  	set_page_dirty(fio.encrypted_page);
>  	if (clear_page_dirty_for_io(fio.encrypted_page))
>  		dec_page_count(fio.sbi, F2FS_DIRTY_META);
> 
