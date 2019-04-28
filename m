Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F62C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765A120843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556458279;
	bh=z75bZVyApBtS5cqSxFYi3Pt3DZoYeBhYvlIzdFfUlLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UXGTpYQrxZffaTDdVqMkiAss7FpG/H99JgUr9DaUh4t7mhByKbMu2BiRU/DR9+EBc
	 7NZqVYMbKHIX3dohiZxh9KZERiLUt9cf4mfmacfwmYi2uERHJuwN/r/1m6DtSraNUJ
	 YD42XoSR2giexABoHqSLKBL138BJq4j8yp0w7Clg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfD1NbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 09:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfD1NbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 09:31:17 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B479F206A3;
        Sun, 28 Apr 2019 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556458275;
        bh=z75bZVyApBtS5cqSxFYi3Pt3DZoYeBhYvlIzdFfUlLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAUHc4H3jSqb0XY6Dyw75x9igckgmozFqOM2SliTjGkyBKem/ZTRcb5+ONzhBWiNE
         +lKbGEjv3yU2tw9EWFxx6CFKXMqqnpPvjDLKhpGgtDPAZhYvkGWrb0H036AYUjvDzM
         HwliVxtOGJzew6oE86+83JHD1KCsWV4mn5W/y+Jk=
Date:   Sun, 28 Apr 2019 06:31:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] f2fs: introduce DATA_GENERIC_ENHANCE
Message-ID: <20190428133115.GA37346@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190415072632.2158-1-yuchao0@huawei.com>
 <20190415072632.2158-2-yuchao0@huawei.com>
 <20190424093613.GA45953@jaegeuk-macbookpro.roam.corp.google.com>
 <2a519411-b9bb-f153-c8b9-8eaca1f66837@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a519411-b9bb-f153-c8b9-8eaca1f66837@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Chao Yu wrote:
> On 2019-4-24 17:36, Jaegeuk Kim wrote:
> > On 04/15, Chao Yu wrote:
> >> Previously, f2fs_is_valid_blkaddr(, blkaddr, DATA_GENERIC) will check
> >> whether @blkaddr locates in main area or not.
> >>
> >> That check is weak, since the block address in range of main area can
> >> point to the address which is not valid in segment info table, and we
> >> can not detect such condition, we may suffer worse corruption as system
> >> continues running.
> >>
> >> So this patch introduce DATA_GENERIC_ENHANCE to enhance the sanity check
> >> which trigger SIT bitmap check rather than only range check.
> >>
> >> This patch did below changes as wel:
> >> - set SBI_NEED_FSCK in f2fs_is_valid_blkaddr().
> >> - get rid of is_valid_data_blkaddr() to avoid panic if blkaddr is invalid.
> >> - introduce verify_fio_blkaddr() to wrap fio {new,old}_blkaddr validation check.
> >> - spread blkaddr check in:
> >>  * f2fs_get_node_info()
> >>  * __read_out_blkaddrs()
> >>  * f2fs_submit_page_read()
> >>  * ra_data_block()
> >>  * do_recover_data()
> >>
> >> This patch can fix bug reported from bugzilla below:
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203215
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203223
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203231
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203235
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203241
> > 
> > Hi Chao,
> > 
> > This introduces failures on xfstests/generic/446, and I'm testing the below
> > patch on top of this. Could you check this patch, so that I could combine
> > both of them?
> > 
> > From 8c1808c1743ad75d1ad8d1dc5a53910edaf7afd7 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Wed, 24 Apr 2019 00:21:07 +0100
> > Subject: [PATCH] f2fs: consider data race on read and truncation on
> >  DATA_GENERIC_ENHANCE
> > 
> > DATA_GENERIC_ENHANCE enhanced to validate block addresses on read/write paths.
> > But, xfstest/generic/446 compalins some generated kernel messages saying invalid
> > bitmap was detected when reading a block. The reaons is, when we get the
> > block addresses from extent_cache, there is no lock to synchronize it from
> > truncating the blocks in parallel.
> > 
> > This patch tries to return EFAULT without warning and setting SBI_NEED_FSCK
> > in this case.
> > 
> > Fixes: ("f2fs: introduce DATA_GENERIC_ENHANCE")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 35 ++++++++++++++++++-----------------
> >  fs/f2fs/data.c       | 25 ++++++++++++++++++-------
> >  fs/f2fs/f2fs.h       |  6 ++++++
> >  fs/f2fs/gc.c         |  9 ++++++---
> >  4 files changed, 48 insertions(+), 27 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index e37fbbf843a5..805a33088e82 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -130,26 +130,28 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
> >  	return __get_meta_page(sbi, index, false);
> >  }
> >  
> > -static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr)
> > +static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
> > +							int type)
> >  {
> >  	struct seg_entry *se;
> >  	unsigned int segno, offset;
> >  	bool exist;
> >  
> > +	if (type != DATA_GENERIC_ENHANCE && type != DATA_GENERIC_ENHANCE_READ)
> > +		return true;
> > +
> >  	segno = GET_SEGNO(sbi, blkaddr);
> >  	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> >  	se = get_seg_entry(sbi, segno);
> >  
> >  	exist = f2fs_test_bit(offset, se->cur_valid_map);
> > -
> > -	if (!exist) {
> > +	if (!exist && type == DATA_GENERIC_ENHANCE) {
> >  		f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
> >  			"blkaddr:%u, sit bitmap:%d", blkaddr, exist);
> >  		set_sbi_flag(sbi, SBI_NEED_FSCK);
> >  		WARN_ON(1);
> > -		return false;
> >  	}
> > -	return true;
> > +	return exist;
> >  }
> >  
> >  bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> > @@ -173,23 +175,22 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >  			return false;
> >  		break;
> >  	case META_POR:
> > +		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
> > +			blkaddr < MAIN_BLKADDR(sbi)))
> > +			return false;
> > +		break;
> >  	case DATA_GENERIC:
> >  	case DATA_GENERIC_ENHANCE:
> > +	case DATA_GENERIC_ENHANCE_READ:
> >  		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
> > -			blkaddr < MAIN_BLKADDR(sbi))) {
> > -			if (type == DATA_GENERIC ||
> > -				type == DATA_GENERIC_ENHANCE) {
> > -				f2fs_msg(sbi->sb, KERN_WARNING,
> > -					"access invalid blkaddr:%u", blkaddr);
> > -				set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -				WARN_ON(1);
> > -			}
> > +				blkaddr < MAIN_BLKADDR(sbi))) {
> > +			f2fs_msg(sbi->sb, KERN_WARNING,
> > +				"access invalid blkaddr:%u", blkaddr);
> > +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +			WARN_ON(1);
> >  			return false;
> >  		} else {
> > -			if (type == DATA_GENERIC_ENHANCE) {
> > -				if (!__is_bitmap_valid(sbi, blkaddr))
> > -					return false;
> > -			}
> > +			return __is_bitmap_valid(sbi, blkaddr, type);
> >  		}
> >  		break;
> >  	case META_GENERIC:
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 34d248ac9e0f..d32a82f25f5a 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -564,9 +564,6 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
> >  	struct bio_post_read_ctx *ctx;
> >  	unsigned int post_read_steps = 0;
> >  
> > -	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> > -		return ERR_PTR(-EFAULT);
> > -
> >  	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
> >  	if (!bio)
> >  		return ERR_PTR(-ENOMEM);
> > @@ -597,9 +594,6 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
> >  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	struct bio *bio;
> >  
> > -	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> > -		return -EFAULT;
> > -
> >  	bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0);
> >  	if (IS_ERR(bio))
> >  		return PTR_ERR(bio);
> > @@ -741,6 +735,11 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
> >  
> >  	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
> >  		dn.data_blkaddr = ei.blk + index - ei.fofs;
> > +		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blkaddr,
> > +						DATA_GENERIC_ENHANCE_READ)) {
> 
> If I'm not missing anything, we just need use DATA_GENERIC_ENHANCE_READ to cover
> below two paths:
> - gc_data_segment -> f2fs_get_read_data_page
> - move_data_page -> f2fs_get_lock_data_page -> f2fs_get_read_data_page
> 
> Other paths which calls f2fs_get_read_data_page is safe to verify blkaddr with
> DATA_GENERIC_ENHANCE?

The rule for here is, if block address is given by extent cache, we need to use
ENHANCE_READ. If it's coming from dnode lock, I think it'd be safe.

> 
> > +			err = -EFAULT;
> > +			goto put_err;
> > +		}
> >  		goto got_it;
> >  	}
> >  
> > @@ -754,6 +753,13 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
> >  		err = -ENOENT;
> >  		goto put_err;
> >  	}
> > +	if (dn.data_blkaddr != NEW_ADDR &&
> > +			!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> > +						dn.data_blkaddr,
> > +						DATA_GENERIC_ENHANCE)) {
> > +		err = -EFAULT;
> > +		goto put_err;
> > +	}
> >  got_it:
> >  	if (PageUptodate(page)) {
> >  		unlock_page(page);
> > @@ -1566,7 +1572,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
> >  		}
> >  
> >  		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
> > -							DATA_GENERIC_ENHANCE)) {
> > +						DATA_GENERIC_ENHANCE_READ)) {
> >  			ret = -EFAULT;
> >  			goto out;
> >  		}
> > @@ -2528,6 +2534,11 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
> >  		zero_user_segment(page, 0, PAGE_SIZE);
> >  		SetPageUptodate(page);
> >  	} else {
> > +		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> > +				DATA_GENERIC_ENHANCE_READ)) {
> 
> Need DATA_GENERIC_ENHANCE because write() is exclusive with truncate() due to
> inode_lock()?
> 
> Thanks,
> 
> > +			err = -EFAULT;
> > +			goto fail;
> > +		}
> >  		err = f2fs_submit_page_read(inode, page, blkaddr);
> >  		if (err)
> >  			goto fail;
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index f5ffc09705eb..533fafca68f4 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -212,6 +212,12 @@ enum {
> >  	META_POR,
> >  	DATA_GENERIC,		/* check range only */
> >  	DATA_GENERIC_ENHANCE,	/* strong check on range and segment bitmap */
> > +	DATA_GENERIC_ENHANCE_READ,	/*
> > +					 * strong check on range and segment
> > +					 * bitmap but no warning due to race
> > +					 * condition of read on truncated area
> > +					 * by extent_cache
> > +					 */
> >  	META_GENERIC,
> >  };
> >  
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 3a097949b5d4..963fb4571fd9 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -656,6 +656,11 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
> >  
> >  	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
> >  		dn.data_blkaddr = ei.blk + index - ei.fofs;
> > +		if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
> > +						DATA_GENERIC_ENHANCE_READ))) {
> > +			err = -EFAULT;
> > +			goto put_page;
> > +		}
> >  		goto got_it;
> >  	}
> >  
> > @@ -669,14 +674,12 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
> >  		err = -ENOENT;
> >  		goto put_page;
> >  	}
> > -
> > -got_it:
> >  	if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
> >  						DATA_GENERIC_ENHANCE))) {
> >  		err = -EFAULT;
> >  		goto put_page;
> >  	}
> > -
> > +got_it:
> >  	/* read page */
> >  	fio.page = page;
> >  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
> > 
