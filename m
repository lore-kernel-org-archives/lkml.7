Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D003C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF49217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556052988;
	bh=/mtfMlT9S3bu8R68XKGKKANO3H3+CHMMD/N/At2uZ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CKSAKArr6ERhndsctd+owZJV7lY52A6PHVr3fIBm8mjz3Fufm+dkr0f+I5yo82iT9
	 5sFRHD86RqN8ow7iVHxjuX9JGaFbGiXB+AXqad9mCkfu9t81XIOXDAFUf/n178Wmgj
	 QWbofwaWiJ6MEfSM9+agRNkm7j73DZY5WgwPPO1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfDWU4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfDWU4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:56:23 -0400
Received: from localhost (unknown [92.54.175.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE0721773;
        Tue, 23 Apr 2019 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556052982;
        bh=/mtfMlT9S3bu8R68XKGKKANO3H3+CHMMD/N/At2uZ8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4ckFskA+iO/JpcMOKUW7HwheN17guohnUamW+b73A7sSC17/SSuFDBkyS5XFHVk0
         grjrz+ZEEd67xCwiB86Tdv+Xt3Zw9Lhn5aEmzK5e48n0iHQGhhXqDB8ReR8nZdKSkY
         PKsqv3RPC4cu+eOQWaUlI1A01hWPWiq4K3bDuWtY=
Date:   Tue, 23 Apr 2019 21:56:19 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: allow unfixed
 f2fs_checkpoint.checksum_offset
Message-ID: <20190423205619.GB87257@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190422093353.61014-1-yuchao0@huawei.com>
 <20190423204351.GA87257@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423204351.GA87257@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23, Jaegeuk Kim wrote:
> On 04/22, Chao Yu wrote:
> > Previously, f2fs_checkpoint.checksum_offset points fixed position of
> > f2fs_checkpoint structure:
> > 
> > "#define CP_CHKSUM_OFFSET	4092"
> > 
> > It is unnecessary, and it breaks the consecutiveness of nat and sit
> > bitmap stored across checkpoint park block and payload blocks.
> > 
> > This patch allows f2fs to handle unfixed .checksum_offset.
> > 
> > In addition, for the case checksum value is stored in the middle of
> > checkpoint park, calculating checksum value with superposition method
> > like we did for inode_checksum.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/checkpoint.c    | 27 +++++++++++++++++++++------
> >  include/linux/f2fs_fs.h |  4 ++++
> >  2 files changed, 25 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 441814607b13..a25556aef8cc 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -794,13 +794,27 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
> >  	}
> >  }
> >  
> > +static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
> > +						struct f2fs_checkpoint *ckpt)
> > +{
> > +	unsigned int chksum_ofs = le32_to_cpu(ckpt->checksum_offset);
> > +	__u32 chksum;
> > +
> > +	chksum = f2fs_crc32(sbi, ckpt, chksum_ofs);
> > +	if (chksum_ofs < CP_CHKSUM_OFFSET) {
> > +		chksum_ofs += sizeof(chksum);
> > +		chksum = f2fs_chksum(sbi, chksum, (__u8 *)ckpt + chksum_ofs,
> > +						F2FS_BLKSIZE - chksum_ofs);
> 
> Do we need to cover __cp_payload(sbi) * blksize - chksum_ofs?

Self answer - it'd be fine to get 4KB only, since payload will be covered
by entire checkpoint pack.

> 
> > +	}
> > +	return chksum;
> > +}
> > +
> >  static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
> >  		struct f2fs_checkpoint **cp_block, struct page **cp_page,
> >  		unsigned long long *version)
> >  {
> > -	unsigned long blk_size = sbi->blocksize;
> >  	size_t crc_offset = 0;
> > -	__u32 crc = 0;
> > +	__u32 crc;
> >  
> >  	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
> >  	if (IS_ERR(*cp_page))
> > @@ -809,15 +823,16 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
> >  	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
> >  
> >  	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
> > -	if (crc_offset > (blk_size - sizeof(__le32))) {
> > +	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
> > +			crc_offset > CP_CHKSUM_OFFSET) {
> >  		f2fs_put_page(*cp_page, 1);
> >  		f2fs_msg(sbi->sb, KERN_WARNING,
> >  			"invalid crc_offset: %zu", crc_offset);
> >  		return -EINVAL;
> >  	}
> >  
> > -	crc = cur_cp_crc(*cp_block);
> > -	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
> > +	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
> > +	if (crc != cur_cp_crc(*cp_block)) {
> >  		f2fs_put_page(*cp_page, 1);
> >  		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
> >  		return -EINVAL;
> > @@ -1425,7 +1440,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
> >  	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
> >  
> > -	crc32 = f2fs_crc32(sbi, ckpt, le32_to_cpu(ckpt->checksum_offset));
> > +	crc32 = f2fs_checkpoint_chksum(sbi, ckpt);
> >  	*((__le32 *)((unsigned char *)ckpt +
> >  				le32_to_cpu(ckpt->checksum_offset)))
> >  				= cpu_to_le32(crc32);
> > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> > index 55da9abed023..65559900d4d7 100644
> > --- a/include/linux/f2fs_fs.h
> > +++ b/include/linux/f2fs_fs.h
> > @@ -164,6 +164,10 @@ struct f2fs_checkpoint {
> >  	unsigned char sit_nat_version_bitmap[1];
> >  } __packed;
> >  
> > +#define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
> > +#define CP_MIN_CHKSUM_OFFSET						\
> > +	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))
> > +
> >  /*
> >   * For orphan inode management
> >   */
> > -- 
> > 2.18.0.rc1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
