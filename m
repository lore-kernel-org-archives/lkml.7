Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94FCC606B0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7468321707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562629596;
	bh=4spNAL37b5SpdzFWlG6fdmA984ZUF9bZInFiZ1YetaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HlC77b42On34blppOSF6M8rurFKJtAyXW4lk9zJQMPOFlFZ+Mfbbp2vLl2I4I2FXf
	 7fMzKWYXuFIxvJcwqu/87CSYdu+Lo6Ytg9cdddaWE0HeArmeN1AftUXK18+xgu5gGv
	 P9mBBaQO1bCPrWi4xsFxTAQqe46Q9VTbQKNhOsY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfGHXqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfGHXqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:46:34 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912D120693;
        Mon,  8 Jul 2019 23:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562629593;
        bh=4spNAL37b5SpdzFWlG6fdmA984ZUF9bZInFiZ1YetaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjlmKyq5ApTeA8btkdvUqP6aRH+twrtxxAWZ7BLLnMK1XI1J6rOfQTOSFKR310l51
         RbXQY3ikZk49TzRLNWeDrgfC+0cH0LH/QeVXh4PKb8OcDN6vVZjw/Cwpq4zjz9vb+h
         c5KbpdwOdY1wF6F9ehBa7zBd9NEyySpmY5C5tpg8=
Date:   Mon, 8 Jul 2019 16:46:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Chen Gong <gongchen4@huawei.com>
Subject: Re: [PATCH] f2fs: allocate memory in batch in build_sit_info()
Message-ID: <20190708234633.GB21769@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190704081730.46414-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704081730.46414-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04, Chao Yu wrote:
> build_sit_info() allocate all bitmaps for each segment one by one,
> it's quite low efficiency, this pach changes to allocate large
> continuous memory at a time, and divide it and assign for each bitmaps

It may give more failure rate?

> of segment. For large size image, it can expect improving its mount
> speed.
> 
> Signed-off-by: Chen Gong <gongchen4@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 51 +++++++++++++++++++++--------------------------
>  fs/f2fs/segment.h |  1 +
>  2 files changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 402fbbbb2d7c..73c803af1f31 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3929,7 +3929,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>  	struct sit_info *sit_i;
>  	unsigned int sit_segs, start;
> -	char *src_bitmap;
> +	char *src_bitmap, *bitmap;
>  	unsigned int bitmap_size;
>  
>  	/* allocate memory for SIT information */
> @@ -3950,27 +3950,31 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	if (!sit_i->dirty_sentries_bitmap)
>  		return -ENOMEM;
>  
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 4;
> +#else
> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 3;
> +#endif
> +	sit_i->bitmap = f2fs_kzalloc(sbi, bitmap_size, GFP_KERNEL);
> +	if (!sit_i->bitmap)
> +		return -ENOMEM;
> +
> +	bitmap = sit_i->bitmap;
> +
>  	for (start = 0; start < MAIN_SEGS(sbi); start++) {
> -		sit_i->sentries[start].cur_valid_map
> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> -		sit_i->sentries[start].ckpt_valid_map
> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> -		if (!sit_i->sentries[start].cur_valid_map ||
> -				!sit_i->sentries[start].ckpt_valid_map)
> -			return -ENOMEM;
> +		sit_i->sentries[start].cur_valid_map = bitmap;
> +		bitmap += SIT_VBLOCK_MAP_SIZE;
> +
> +		sit_i->sentries[start].ckpt_valid_map = bitmap;
> +		bitmap += SIT_VBLOCK_MAP_SIZE;
>  
>  #ifdef CONFIG_F2FS_CHECK_FS
> -		sit_i->sentries[start].cur_valid_map_mir
> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> -		if (!sit_i->sentries[start].cur_valid_map_mir)
> -			return -ENOMEM;
> +		sit_i->sentries[start].cur_valid_map_mir = bitmap;
> +		bitmap += SIT_VBLOCK_MAP_SIZE;
>  #endif
>  
> -		sit_i->sentries[start].discard_map
> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
> -							GFP_KERNEL);
> -		if (!sit_i->sentries[start].discard_map)
> -			return -ENOMEM;
> +		sit_i->sentries[start].discard_map = bitmap;
> +		bitmap += SIT_VBLOCK_MAP_SIZE;
>  	}
>  
>  	sit_i->tmp_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> @@ -4440,21 +4444,12 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
>  static void destroy_sit_info(struct f2fs_sb_info *sbi)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
> -	unsigned int start;
>  
>  	if (!sit_i)
>  		return;
>  
> -	if (sit_i->sentries) {
> -		for (start = 0; start < MAIN_SEGS(sbi); start++) {
> -			kvfree(sit_i->sentries[start].cur_valid_map);
> -#ifdef CONFIG_F2FS_CHECK_FS
> -			kvfree(sit_i->sentries[start].cur_valid_map_mir);
> -#endif
> -			kvfree(sit_i->sentries[start].ckpt_valid_map);
> -			kvfree(sit_i->sentries[start].discard_map);
> -		}
> -	}
> +	if (sit_i->sentries)
> +		kvfree(sit_i->bitmap);
>  	kvfree(sit_i->tmp_map);
>  
>  	kvfree(sit_i->sentries);
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 2fd53462fa27..4d171b489130 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -226,6 +226,7 @@ struct sit_info {
>  	block_t sit_base_addr;		/* start block address of SIT area */
>  	block_t sit_blocks;		/* # of blocks used by SIT area */
>  	block_t written_valid_blocks;	/* # of valid blocks in main area */
> +	char *bitmap;			/* all bitmaps pointer */
>  	char *sit_bitmap;		/* SIT bitmap pointer */
>  #ifdef CONFIG_F2FS_CHECK_FS
>  	char *sit_bitmap_mir;		/* SIT bitmap mirror */
> -- 
> 2.18.0.rc1
