Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42482C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19642075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564379699;
	bh=Es0XHxeZvLEv07xBP9nni5sHh8xrD51dZ25CaXeHaIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cLjNqGHe68lGtnFVd7/JY6KCMmrFOxQylog6VsGhjCbxtfJgfkqoJLvkQmG1s+Yjo
	 MRAh/oIDSup85ssNtgAzpuU+tMOn9uqJymYck9Xm0efJhr3LusOenhlAjSD+xJPab3
	 96L0ryaiXNDiTY953vmGyTlnQ3QvGuCcXkkGIqj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfG2Fy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfG2Fy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:54:57 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADBA20659;
        Mon, 29 Jul 2019 05:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564379695;
        bh=Es0XHxeZvLEv07xBP9nni5sHh8xrD51dZ25CaXeHaIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hU1kuFnQV6yHMT39IlH8+xC7EBz07nbhhziXHh3iGWdGalxEF5niCbLeS8UbI0eC7
         PasfGwGXL356HtO/aaAAu4lJWvvhUVhsHkSFipovDkltkOhUt10y9W7AXvpk6+Caw/
         QFubjvaLIG4rTZO12dR+m+wPiD4dL+qMEpcgp3rA=
Date:   Sun, 28 Jul 2019 22:54:54 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to read source block before
 invalidating it
Message-ID: <20190729055454.GC94090@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190718013718.70335-1-jaegeuk@kernel.org>
 <20190718031214.GA78336@jaegeuk-macbookpro.roam.corp.google.com>
 <19a25101-da74-de98-6ca4-a9fd9fa09ef2@huawei.com>
 <20190718040005.GA81995@jaegeuk-macbookpro.roam.corp.google.com>
 <91dbfa33-cda0-e6e7-d62f-6604939142d4@huawei.com>
 <20190723012721.GA60134@jaegeuk-macbookpro.roam.corp.google.com>
 <45a9f47b-337c-527c-420d-b29e77a8ed22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a9f47b-337c-527c-420d-b29e77a8ed22@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23, Chao Yu wrote:
> On 2019/7/23 9:27, Jaegeuk Kim wrote:
> > On 07/18, Chao Yu wrote:
> >> On 2019/7/18 12:00, Jaegeuk Kim wrote:
> >>> On 07/18, Chao Yu wrote:
> >>>> On 2019/7/18 11:12, Jaegeuk Kim wrote:
> >>>>> f2fs_allocate_data_block() invalidates old block address and enable new block
> >>>>> address. Then, if we try to read old block by f2fs_submit_page_bio(), it will
> >>>>> give WARN due to reading invalid blocks.
> >>>>>
> >>>>> Let's make the order sanely back.
> >>>>
> >>>> Hmm.. to avoid WARM, we may suffer one more memcpy, I suspect this can reduce
> >>>> online resize or foreground gc ioctl performance...
> >>>
> >>> I worried about performance tho, more concern came to me that there may exist a
> >>> chance that other thread can allocate and write something in old block address.
> >>
> >> Me too, however, previous invalid block address should be reused after a
> >> checkpoint, and checkpoint should have invalidated meta cache already, so there
> >> shouldn't be any race here.
> > 
> > I think SSR can reuse that before checkpoint.
> 
> Yes, I should have considered that when I introduced readahead feature for
> migration of block, we've kept invalidating meta page cache in old block address
> whenever the block address is not valid.
> 
> quoted from ("f2fs: readahead encrypted block during GC")
> 
> "Note that for OPU, truncation, deletion, we need to invalid meta
> page after we invalid old block address, to make sure we won't load
> invalid data from target meta page during encrypted block migration."
> 
> But to avoid potential issue, how about just enable meta page cache during GC?
> that is saying we should truncate all valid meta cache after one section has
> been moved.

We may need to invalidate metapage when writing new data, which looks like
different issue.

> 
> One more concern is whether below case exists during SSR?
> - write 4k to fileA;
> - fsync fileA, 4k data is writebacked to lbaA;
> - write 4k to fileA;
> - kworker flushs 4k to lbaB; dnode contain lbaB didn't be persisted yet;
> - write 4k to fileB;
> - kworker flush 4k to lbaA due to SSR;
> - SPOR  -> dnode with lbaA will be recovered, however lbaA contains fileB's data..

Yes, it seems that's possible. We may need to keep another bitmap to record
all the block allocation?

> 
> Thanks,
> 
> > 
> >>
> >> 	/*
> >> 	 * invalidate intermediate page cache borrowed from meta inode
> >> 	 * which are used for migration of encrypted inode's blocks.
> >> 	 */
> >> 	if (f2fs_sb_has_encrypt(sbi))
> >> 		invalidate_mapping_pages(META_MAPPING(sbi),
> >> 				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Can we just relief to use DATA_GENERIC_ENHANCE_READ for this case...?
> >>>
> >>> We need to keep consistency for this api.
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>>>
> >>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>
> >>>> Except performance, I'm okay with this change.
> >>>>
> >>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>> ---
> >>>>> v2:
> >>>>> I was fixing the comments. :)
> >>>>>
> >>>>>  fs/f2fs/gc.c | 70 +++++++++++++++++++++++++---------------------------
> >>>>>  1 file changed, 34 insertions(+), 36 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>>>> index 6691f526fa40..8974672db78f 100644
> >>>>> --- a/fs/f2fs/gc.c
> >>>>> +++ b/fs/f2fs/gc.c
> >>>>> @@ -796,6 +796,29 @@ static int move_data_block(struct inode *inode, block_t bidx,
> >>>>>  	if (lfs_mode)
> >>>>>  		down_write(&fio.sbi->io_order_lock);
> >>>>>  
> >>>>> +	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
> >>>>> +					fio.old_blkaddr, false);
> >>>>> +	if (!mpage)
> >>>>> +		goto up_out;
> >>>>> +
> >>>>> +	fio.encrypted_page = mpage;
> >>>>> +
> >>>>> +	/* read source block in mpage */
> >>>>> +	if (!PageUptodate(mpage)) {
> >>>>> +		err = f2fs_submit_page_bio(&fio);
> >>>>> +		if (err) {
> >>>>> +			f2fs_put_page(mpage, 1);
> >>>>> +			goto up_out;
> >>>>> +		}
> >>>>> +		lock_page(mpage);
> >>>>> +		if (unlikely(mpage->mapping != META_MAPPING(fio.sbi) ||
> >>>>> +						!PageUptodate(mpage))) {
> >>>>> +			err = -EIO;
> >>>>> +			f2fs_put_page(mpage, 1);
> >>>>> +			goto up_out;
> >>>>> +		}
> >>>>> +	}
> >>>>> +
> >>>>>  	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
> >>>>>  					&sum, CURSEG_COLD_DATA, NULL, false);
> >>>>>  
> >>>>> @@ -803,44 +826,18 @@ static int move_data_block(struct inode *inode, block_t bidx,
> >>>>>  				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
> >>>>>  	if (!fio.encrypted_page) {
> >>>>>  		err = -ENOMEM;
> >>>>> -		goto recover_block;
> >>>>> -	}
> >>>>> -
> >>>>> -	mpage = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
> >>>>> -					fio.old_blkaddr, FGP_LOCK, GFP_NOFS);
> >>>>> -	if (mpage) {
> >>>>> -		bool updated = false;
> >>>>> -
> >>>>> -		if (PageUptodate(mpage)) {
> >>>>> -			memcpy(page_address(fio.encrypted_page),
> >>>>> -					page_address(mpage), PAGE_SIZE);
> >>>>> -			updated = true;
> >>>>> -		}
> >>>>>  		f2fs_put_page(mpage, 1);
> >>>>> -		invalidate_mapping_pages(META_MAPPING(fio.sbi),
> >>>>> -					fio.old_blkaddr, fio.old_blkaddr);
> >>>>> -		if (updated)
> >>>>> -			goto write_page;
> >>>>> -	}
> >>>>> -
> >>>>> -	err = f2fs_submit_page_bio(&fio);
> >>>>> -	if (err)
> >>>>> -		goto put_page_out;
> >>>>> -
> >>>>> -	/* write page */
> >>>>> -	lock_page(fio.encrypted_page);
> >>>>> -
> >>>>> -	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
> >>>>> -		err = -EIO;
> >>>>> -		goto put_page_out;
> >>>>> -	}
> >>>>> -	if (unlikely(!PageUptodate(fio.encrypted_page))) {
> >>>>> -		err = -EIO;
> >>>>> -		goto put_page_out;
> >>>>> +		goto recover_block;
> >>>>>  	}
> >>>>>  
> >>>>> -write_page:
> >>>>> +	/* write target block */
> >>>>>  	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
> >>>>> +	memcpy(page_address(fio.encrypted_page),
> >>>>> +				page_address(mpage), PAGE_SIZE);
> >>>>> +	f2fs_put_page(mpage, 1);
> >>>>> +	invalidate_mapping_pages(META_MAPPING(fio.sbi),
> >>>>> +				fio.old_blkaddr, fio.old_blkaddr);
> >>>>> +
> >>>>>  	set_page_dirty(fio.encrypted_page);
> >>>>>  	if (clear_page_dirty_for_io(fio.encrypted_page))
> >>>>>  		dec_page_count(fio.sbi, F2FS_DIRTY_META);
> >>>>> @@ -871,11 +868,12 @@ static int move_data_block(struct inode *inode, block_t bidx,
> >>>>>  put_page_out:
> >>>>>  	f2fs_put_page(fio.encrypted_page, 1);
> >>>>>  recover_block:
> >>>>> -	if (lfs_mode)
> >>>>> -		up_write(&fio.sbi->io_order_lock);
> >>>>>  	if (err)
> >>>>>  		f2fs_do_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
> >>>>>  								true, true);
> >>>>> +up_out:
> >>>>> +	if (lfs_mode)
> >>>>> +		up_write(&fio.sbi->io_order_lock);
> >>>>>  put_out:
> >>>>>  	f2fs_put_dnode(&dn);
> >>>>>  out:
> >>>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> Linux-f2fs-devel mailing list
> >>>> Linux-f2fs-devel@lists.sourceforge.net
> >>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>> .
> >>>
> > .
> > 
