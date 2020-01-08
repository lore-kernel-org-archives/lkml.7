Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D377C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F15A20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgAHKLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:11:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:42036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAHKLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:11:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8B80BADC8;
        Wed,  8 Jan 2020 10:11:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5C1BA1E0B47; Wed,  8 Jan 2020 11:11:18 +0100 (CET)
Date:   Wed, 8 Jan 2020 11:11:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/3] udf: Fix spelling in EXT_NEXT_EXTENT_ALLOCDESCS
Message-ID: <20200108101118.GB20521@quack2.suse.cz>
References: <20200107134425.GE25547@quack2.suse.cz>
 <20200107212904.30471-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107212904.30471-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! Much easier to review now :) I've queued your patches to my tree.

								Honza

On Tue 07-01-20 22:29:02, Pali Rohár wrote:
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> ---
>  fs/udf/ecma_167.h | 2 +-
>  fs/udf/inode.c    | 6 +++---
>  fs/udf/truncate.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index fb7f2c7be..e7b889e01 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -757,7 +757,7 @@ struct partitionIntegrityEntry {
>  #define EXT_RECORDED_ALLOCATED		0x00000000
>  #define EXT_NOT_RECORDED_ALLOCATED	0x40000000
>  #define EXT_NOT_RECORDED_NOT_ALLOCATED	0x80000000
> -#define EXT_NEXT_EXTENT_ALLOCDECS	0xC0000000
> +#define EXT_NEXT_EXTENT_ALLOCDESCS	0xC0000000
>  
>  /* Long Allocation Descriptor (ECMA 167r3 4/14.14.2) */
>  
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index ea80036d7..e875bc566 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1981,10 +1981,10 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
>  
>  		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
>  		udf_write_aext(inode, epos, &nepos.block,
> -			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
> +			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDESCS, 0);
>  	} else {
>  		__udf_add_aext(inode, epos, &nepos.block,
> -			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
> +			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDESCS, 0);
>  	}
>  
>  	brelse(epos->bh);
> @@ -2143,7 +2143,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>  	unsigned int indirections = 0;
>  
>  	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
> -	       (EXT_NEXT_EXTENT_ALLOCDECS >> 30)) {
> +	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
>  		udf_pblk_t block;
>  
>  		if (++indirections > UDF_MAX_INDIR_EXTS) {
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 63a47f1e1..532cda996 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -241,7 +241,7 @@ int udf_truncate_extents(struct inode *inode)
>  
>  	while ((etype = udf_current_aext(inode, &epos, &eloc,
>  					 &elen, 0)) != -1) {
> -		if (etype == (EXT_NEXT_EXTENT_ALLOCDECS >> 30)) {
> +		if (etype == (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
>  			udf_write_aext(inode, &epos, &neloc, nelen, 0);
>  			if (indirect_ext_len) {
>  				/* We managed to free all extents in the
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
