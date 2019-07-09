Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AA2C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9157E20861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfGIVDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728998AbfGIVDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:03:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 374FAAEE9;
        Tue,  9 Jul 2019 21:03:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 90CEB1E4376; Tue,  9 Jul 2019 23:03:43 +0200 (CEST)
Date:   Tue, 9 Jul 2019 23:03:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     " Steven J. Magnani " <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udf: Fix incorrect final NOT_ALLOCATED (hole) extent
 length
Message-ID: <20190709210343.GA2517@quack2.suse.cz>
References: <1561948775-5878-1-git-send-email-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561948775-5878-1-git-send-email-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30-06-19 21:39:35,  Steven J. Magnani  wrote:
> In some cases, using the 'truncate' command to extend a UDF file results
> in a mismatch between the length of the file's extents (specifically, due
> to incorrect length of the final NOT_ALLOCATED extent) and the information
> (file) length. The discrepancy can prevent other operating systems
> (i.e., Windows 10) from opening the file.
> 
> Two particular errors have been observed when extending a file:
> 
> 1. The final extent is larger than it should be, having been rounded up
>    to a multiple of the block size.
> 
> B. The final extent is not shorter than it should be, due to not having
>    been updated when the file's information length was increased.
> 
> Change since v1:
> Simplified udf_do_extend_file() API, partially by factoring out its
> handling of the "extending within the last file block" corner case.
> 
> Fixes: 2c948b3f86e5 ("udf: Avoid IO in udf_clear_inode")
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks for the patch! I have added it with some small modifications to my
tree. Below are the changes I did.

> --- a/fs/udf/inode.c	2019-05-24 21:17:33.659704533 -0500
> +++ b/fs/udf/inode.c	2019-06-29 21:10:48.938562957 -0500
> @@ -470,13 +470,15 @@ static struct buffer_head *udf_getblk(st
>  	return NULL;
>  }
>  
> -/* Extend the file by 'blocks' blocks, return the number of extents added */
> +/* Extend the file with new blocks totaling 'new_block_bytes',
> + * return the number of extents added
> + */
>  static int udf_do_extend_file(struct inode *inode,
>  			      struct extent_position *last_pos,
>  			      struct kernel_long_ad *last_ext,
> -			      sector_t blocks)
> +			      loff_t new_block_bytes)
>  {
> -	sector_t add;
> +	unsigned long add;

I've changed the type here to uint32_t since that's what we usually use for
extent size.

> +/* Extend the final block of the file to final_block_len bytes */
> +static int udf_do_extend_final_block(struct inode *inode,

Changed return type to void since the function doesn't return anything
useful.

> +				     struct extent_position *last_pos,
> +				     struct kernel_long_ad *last_ext,
> +				     unsigned long final_block_len)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct kernel_lb_addr tmploc;
> +	uint32_t tmplen;
> +	struct udf_inode_info *iinfo;
> +	unsigned long added_bytes;
> +
> +	iinfo = UDF_I(inode);
> +
> +	added_bytes = final_block_len -
> +		      (last_ext->extLength & (sb->s_blocksize - 1));
> +	last_ext->extLength += added_bytes;
> +	iinfo->i_lenExtents += added_bytes;
> +
> +	udf_write_aext(inode, last_pos, &last_ext->extLocation,
> +			last_ext->extLength, 1);
> +	/*
> +	 * We've rewritten the last extent but there may be empty
> +	 * indirect extent after it - enter it.
> +	 */
> +	udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
> +
> +	/* last_pos should point to the last written extent... */
> +	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
> +		last_pos->offset -= sizeof(struct short_ad);
> +	else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
> +		last_pos->offset -= sizeof(struct long_ad);
> +	else
> +		return -EIO;

I've dropped the updates of last_pos here. This function is used from a
single place and passed epos isn't used in any way after the function
returns.

> +
> +	return 0;
> +}
> +
>  static int udf_extend_file(struct inode *inode, loff_t newsize)
>  {
>  
> @@ -605,10 +643,12 @@ static int udf_extend_file(struct inode
>  	int8_t etype;
>  	struct super_block *sb = inode->i_sb;
>  	sector_t first_block = newsize >> sb->s_blocksize_bits, offset;
> +	unsigned long partial_final_block;

Again uint32_t here.

> @@ -643,7 +673,22 @@ static int udf_extend_file(struct inode
>  				      &extent.extLength, 0);
>  		extent.extLength |= etype << 30;
>  	}
> -	err = udf_do_extend_file(inode, &epos, &extent, offset);
> +
> +	partial_final_block = newsize & (sb->s_blocksize - 1);
> +
> +	/* File has extent covering the new size (could happen when extending
> +	 * inside a block)?
> +	 */
> +	if (within_final_block) {
> +		/* Extending file within the last file block */
> +		err = udf_do_extend_final_block(inode, &epos, &extent,
> +						partial_final_block);
> +	} else {
> +		loff_t add = (offset << sb->s_blocksize_bits) |

Typed 'offset' to loff_t before shifting. Otherwise the shift could
overflow for systems with 32-bit sector_t.

> +			     partial_final_block;
> +		err = udf_do_extend_file(inode, &epos, &extent, add);
> +	}
> +
>  	if (err < 0)
>  		goto out;
>  	err = 0;
...
> @@ -760,7 +806,8 @@ static sector_t inode_getblk(struct inod
>  			startnum = (offset > 0);
>  		}
>  		/* Create extents for the hole between EOF and offset */
> -		ret = udf_do_extend_file(inode, &prev_epos, laarr, offset);
> +		hole_len = offset << inode->i_sb->s_blocksize_bits;

The same as above.

> +		ret = udf_do_extend_file(inode, &prev_epos, laarr, hole_len);
>  		if (ret < 0) {
>  			*err = ret;
>  			newblock = 0;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
