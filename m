Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F18C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1B220651
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbfGRDfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:35:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732771AbfGRDfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:35:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 074D541368B53B7E6E6E;
        Thu, 18 Jul 2019 11:35:39 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 11:35:36 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to read source block before
 invalidating it
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190718013718.70335-1-jaegeuk@kernel.org>
 <20190718031214.GA78336@jaegeuk-macbookpro.roam.corp.google.com>
 <19a25101-da74-de98-6ca4-a9fd9fa09ef2@huawei.com>
Message-ID: <c972a7f8-83ca-b204-30aa-1ed3d04cc708@huawei.com>
Date:   Thu, 18 Jul 2019 11:35:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <19a25101-da74-de98-6ca4-a9fd9fa09ef2@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/18 11:30, Chao Yu wrote:
> On 2019/7/18 11:12, Jaegeuk Kim wrote:
>> f2fs_allocate_data_block() invalidates old block address and enable new block
>> address. Then, if we try to read old block by f2fs_submit_page_bio(), it will
>> give WARN due to reading invalid blocks.
>>
>> Let's make the order sanely back.
> 
> Hmm.. to avoid WARM, we may suffer one more memcpy, I suspect this can reduce
> online resize or foreground gc ioctl performance...
> 
> Can we just relief to use DATA_GENERIC_ENHANCE_READ for this case...?

It's rare case, we can ignore this. :)

Thanks,

> 
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Except performance, I'm okay with this change.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
>> ---
>> v2:
>> I was fixing the comments. :)
>>
>>  fs/f2fs/gc.c | 70 +++++++++++++++++++++++++---------------------------
>>  1 file changed, 34 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 6691f526fa40..8974672db78f 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -796,6 +796,29 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>  	if (lfs_mode)
>>  		down_write(&fio.sbi->io_order_lock);
>>  
>> +	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
>> +					fio.old_blkaddr, false);
>> +	if (!mpage)
>> +		goto up_out;
>> +
>> +	fio.encrypted_page = mpage;
>> +
>> +	/* read source block in mpage */
>> +	if (!PageUptodate(mpage)) {
>> +		err = f2fs_submit_page_bio(&fio);
>> +		if (err) {
>> +			f2fs_put_page(mpage, 1);
>> +			goto up_out;
>> +		}
>> +		lock_page(mpage);
>> +		if (unlikely(mpage->mapping != META_MAPPING(fio.sbi) ||
>> +						!PageUptodate(mpage))) {
>> +			err = -EIO;
>> +			f2fs_put_page(mpage, 1);
>> +			goto up_out;
>> +		}
>> +	}
>> +
>>  	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
>>  					&sum, CURSEG_COLD_DATA, NULL, false);
>>  
>> @@ -803,44 +826,18 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>  				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
>>  	if (!fio.encrypted_page) {
>>  		err = -ENOMEM;
>> -		goto recover_block;
>> -	}
>> -
>> -	mpage = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
>> -					fio.old_blkaddr, FGP_LOCK, GFP_NOFS);
>> -	if (mpage) {
>> -		bool updated = false;
>> -
>> -		if (PageUptodate(mpage)) {
>> -			memcpy(page_address(fio.encrypted_page),
>> -					page_address(mpage), PAGE_SIZE);
>> -			updated = true;
>> -		}
>>  		f2fs_put_page(mpage, 1);
>> -		invalidate_mapping_pages(META_MAPPING(fio.sbi),
>> -					fio.old_blkaddr, fio.old_blkaddr);
>> -		if (updated)
>> -			goto write_page;
>> -	}
>> -
>> -	err = f2fs_submit_page_bio(&fio);
>> -	if (err)
>> -		goto put_page_out;
>> -
>> -	/* write page */
>> -	lock_page(fio.encrypted_page);
>> -
>> -	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
>> -		err = -EIO;
>> -		goto put_page_out;
>> -	}
>> -	if (unlikely(!PageUptodate(fio.encrypted_page))) {
>> -		err = -EIO;
>> -		goto put_page_out;
>> +		goto recover_block;
>>  	}
>>  
>> -write_page:
>> +	/* write target block */
>>  	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
>> +	memcpy(page_address(fio.encrypted_page),
>> +				page_address(mpage), PAGE_SIZE);
>> +	f2fs_put_page(mpage, 1);
>> +	invalidate_mapping_pages(META_MAPPING(fio.sbi),
>> +				fio.old_blkaddr, fio.old_blkaddr);
>> +
>>  	set_page_dirty(fio.encrypted_page);
>>  	if (clear_page_dirty_for_io(fio.encrypted_page))
>>  		dec_page_count(fio.sbi, F2FS_DIRTY_META);
>> @@ -871,11 +868,12 @@ static int move_data_block(struct inode *inode, block_t bidx,
>>  put_page_out:
>>  	f2fs_put_page(fio.encrypted_page, 1);
>>  recover_block:
>> -	if (lfs_mode)
>> -		up_write(&fio.sbi->io_order_lock);
>>  	if (err)
>>  		f2fs_do_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
>>  								true, true);
>> +up_out:
>> +	if (lfs_mode)
>> +		up_write(&fio.sbi->io_order_lock);
>>  put_out:
>>  	f2fs_put_dnode(&dn);
>>  out:
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
