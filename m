Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8046C233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566572261;
	bh=lUZVzj62LY1E4yZhmdisUFDLbkNHl2Ewg/KwzQn5eck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PPr+i3ja3YD4uIdCuNCKJ+RiW4DdklKMOoTe3IxCbiJUOO4JDB00qZVsMmnlVbUgA
	 BaC4AZpW/dO1mpDaxjHeZyheV9QpBTdnsRs3QaT73OjP2srp96DHzDbRPzzCt39E2M
	 oCxDAp8AoU11nhzpTEFKr6yReurOLTKkAVv5O+68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394118AbfHWO5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfHWO5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:57:39 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C57922CEC;
        Fri, 23 Aug 2019 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572259;
        bh=lUZVzj62LY1E4yZhmdisUFDLbkNHl2Ewg/KwzQn5eck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D55i0IXM4OYqcIZA6lxzHWwEBKjkxSBCkpBSixu0Osu7AcKt9NYWzKCUlRTCVroJ6
         VyZnUwoSgGFsrpK0FSnfmUuU2UuZP/JSUDEHc7Wh0LhnUaIDLpTFYvzmPWubmp3p9A
         p6X8oji0CLLMdSblC0oVI9Im0hxsT90NNA/xfUO8=
Date:   Fri, 23 Aug 2019 07:57:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: introduce {page,io}_is_mergeable() for
 readability
Message-ID: <20190823145738.GA35310@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190712085542.4068-1-yuchao0@huawei.com>
 <28424a84-67aa-c8e9-99c3-475be89206ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28424a84-67aa-c8e9-99c3-475be89206ac@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23, Chao Yu wrote:
> On 2019/7/12 16:55, Chao Yu wrote:
> > Wrap merge condition into function for readability, no logic change.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> > v2: remove bio validation check in page_is_mergeable().
> >  fs/f2fs/data.c | 40 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 33 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 6a8db4abdf5f..f1e401f9fc13 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -482,6 +482,33 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
> >  	return 0;
> >  }
> >  
> > +static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
> > +				block_t last_blkaddr, block_t cur_blkaddr)
> > +{
> > +	if (last_blkaddr != cur_blkaddr)
> 
> if (last_blkaddr + 1 != cur_blkaddr)
> 
> Merge condition is wrong here.
> 
> > +		return false;
> > +	return __same_bdev(sbi, cur_blkaddr, bio);
> > +}
> > +
> > +static bool io_type_is_mergeable(struct f2fs_bio_info *io,
> > +						struct f2fs_io_info *fio)
> > +{
> > +	if (io->fio.op != fio->op)
> > +		return false;
> > +	return io->fio.op_flags == fio->op_flags;
> > +}
> > +
> > +static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
> > +					struct f2fs_bio_info *io,
> > +					struct f2fs_io_info *fio,
> > +					block_t last_blkaddr,
> > +					block_t cur_blkaddr)
> > +{
> > +	if (!page_is_mergeable(sbi, bio, last_blkaddr, cur_blkaddr))
> > +		return false;
> > +	return io_type_is_mergeable(io, fio);
> > +}
> > +
> >  int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >  {
> >  	struct bio *bio = *fio->bio;
> > @@ -495,8 +522,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >  	trace_f2fs_submit_page_bio(page, fio);
> >  	f2fs_trace_ios(fio, 0);
> >  
> > -	if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
> > -			!__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
> > +	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> > +						fio->new_blkaddr)) {
> >  		__submit_bio(fio->sbi, bio, fio->type);
> >  		bio = NULL;
> >  	}
> > @@ -569,9 +596,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
> >  
> >  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> >  
> > -	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
> > -	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
> > -			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
> > +	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
> > +			io->last_block_in_bio, fio->new_blkaddr))
> >  		__submit_merged_bio(io);
> >  alloc_new:
> >  	if (io->bio == NULL) {
> > @@ -1643,8 +1669,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
> >  	 * This page will go to BIO.  Do we need to send this
> >  	 * BIO off first?
> >  	 */
> > -	if (bio && (*last_block_in_bio != block_nr - 1 ||
> > -		!__same_bdev(F2FS_I_SB(inode), block_nr, bio))) {
> > +	if (bio && !page_is_mergeable(F2FS_I_SB(inode), bio,
> > +				*last_block_in_bio, block_nr - 1)) {
> 
> *last_block_in_bio, block_nr)
> 
> Sorry, anyway, let me send v2.

Fixed, thanks,

> 
> >  submit_and_realloc:
> >  		__submit_bio(F2FS_I_SB(inode), bio, DATA);
> >  		bio = NULL;
> > 
