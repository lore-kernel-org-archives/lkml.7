Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E254C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFE9218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556052237;
	bh=iZcjfKLoyfuYnmOUWC4K0MAFDsL7Zw7tp4jJqBMS+e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yo2wp99vfDZrq5KTQBWA2vhtIgFw9BAfNpqrl97UGLofKpc7y+SqDqMNyWxiuZOO1
	 HiHwPxqNxNMeexEspvZWxwjJuzOnYZLcf8Mr1AZqj3YFKNpEVHf4NQswp90Ni1tPzm
	 2/qdRbEs8zu3Ahs2UT0Z6B9Ek6FyZ555hWiQ7BK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfDWUn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWUn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:43:56 -0400
Received: from localhost (unknown [92.54.175.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C5E217D9;
        Tue, 23 Apr 2019 20:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556052235;
        bh=iZcjfKLoyfuYnmOUWC4K0MAFDsL7Zw7tp4jJqBMS+e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTUg3V9wEcvbaRKi+qIskCk7Bmerv6E3JfIL2RPMgxsq/XP1rfiQmDLVfFt7pdfmW
         FSl8DGcClxygS87yEx0PTfCwV5smLeNYFxx5npdunXMbwADMQYGXgpdBOFNJ3qdZB5
         K4ELVmdAn3EO5Q9Hf+Wkdym5QO5EbChHLoXIDqyY=
Date:   Tue, 23 Apr 2019 21:43:51 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: allow unfixed f2fs_checkpoint.checksum_offset
Message-ID: <20190423204351.GA87257@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190422093353.61014-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422093353.61014-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22, Chao Yu wrote:
> Previously, f2fs_checkpoint.checksum_offset points fixed position of
> f2fs_checkpoint structure:
> 
> "#define CP_CHKSUM_OFFSET	4092"
> 
> It is unnecessary, and it breaks the consecutiveness of nat and sit
> bitmap stored across checkpoint park block and payload blocks.
> 
> This patch allows f2fs to handle unfixed .checksum_offset.
> 
> In addition, for the case checksum value is stored in the middle of
> checkpoint park, calculating checksum value with superposition method
> like we did for inode_checksum.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c    | 27 +++++++++++++++++++++------
>  include/linux/f2fs_fs.h |  4 ++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 441814607b13..a25556aef8cc 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -794,13 +794,27 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>  	}
>  }
>  
> +static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
> +						struct f2fs_checkpoint *ckpt)
> +{
> +	unsigned int chksum_ofs = le32_to_cpu(ckpt->checksum_offset);
> +	__u32 chksum;
> +
> +	chksum = f2fs_crc32(sbi, ckpt, chksum_ofs);
> +	if (chksum_ofs < CP_CHKSUM_OFFSET) {
> +		chksum_ofs += sizeof(chksum);
> +		chksum = f2fs_chksum(sbi, chksum, (__u8 *)ckpt + chksum_ofs,
> +						F2FS_BLKSIZE - chksum_ofs);

Do we need to cover __cp_payload(sbi) * blksize - chksum_ofs?

> +	}
> +	return chksum;
> +}
> +
>  static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>  		struct f2fs_checkpoint **cp_block, struct page **cp_page,
>  		unsigned long long *version)
>  {
> -	unsigned long blk_size = sbi->blocksize;
>  	size_t crc_offset = 0;
> -	__u32 crc = 0;
> +	__u32 crc;
>  
>  	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
>  	if (IS_ERR(*cp_page))
> @@ -809,15 +823,16 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
>  	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
>  
>  	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
> -	if (crc_offset > (blk_size - sizeof(__le32))) {
> +	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
> +			crc_offset > CP_CHKSUM_OFFSET) {
>  		f2fs_put_page(*cp_page, 1);
>  		f2fs_msg(sbi->sb, KERN_WARNING,
>  			"invalid crc_offset: %zu", crc_offset);
>  		return -EINVAL;
>  	}
>  
> -	crc = cur_cp_crc(*cp_block);
> -	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
> +	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
> +	if (crc != cur_cp_crc(*cp_block)) {
>  		f2fs_put_page(*cp_page, 1);
>  		f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");
>  		return -EINVAL;
> @@ -1425,7 +1440,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
>  	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
>  
> -	crc32 = f2fs_crc32(sbi, ckpt, le32_to_cpu(ckpt->checksum_offset));
> +	crc32 = f2fs_checkpoint_chksum(sbi, ckpt);
>  	*((__le32 *)((unsigned char *)ckpt +
>  				le32_to_cpu(ckpt->checksum_offset)))
>  				= cpu_to_le32(crc32);
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 55da9abed023..65559900d4d7 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -164,6 +164,10 @@ struct f2fs_checkpoint {
>  	unsigned char sit_nat_version_bitmap[1];
>  } __packed;
>  
> +#define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
> +#define CP_MIN_CHKSUM_OFFSET						\
> +	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))
> +
>  /*
>   * For orphan inode management
>   */
> -- 
> 2.18.0.rc1
