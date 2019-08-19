Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD42C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBEB206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566246018;
	bh=4nYmazHWizgJtX+xah/sZzCVBt1HQN/9Xta+OqPpl8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Afldam9hOHt6MV1bA6/dds02g3vArlUpVglkiQrxjh9Cb77oAbG2Ajb3Gni+QVj4f
	 Ea+myHLt9P8caQ1gLTt4k5MiwDz4nnz42ueAn9huTYZ34+pcTATZR01xhoHTVw5cDP
	 TdJblfqbHubrfboyGHAXuWkqkn0fZjP+fe88cMmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfHSUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfHSUUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:20:16 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 407222087E;
        Mon, 19 Aug 2019 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566246016;
        bh=4nYmazHWizgJtX+xah/sZzCVBt1HQN/9Xta+OqPpl8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zgl610Nhxsz+07IHam1QctsyK9J1ZSElKEM0KUiNUk6Q7RjrW5acg6g708Trqv17f
         foHm56LzVcG1tOA7lq0aaar6N/UAaVdQQ5Eao0YXAVXu9bWHDWwpbLP1uEh9yzneXc
         t9Yrw6g4MVxb6J52P+Ge7aGhovjFtX+YJ22v7rrI=
Date:   Mon, 19 Aug 2019 13:20:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Chen Gong <gongchen4@huawei.com>
Subject: Re: [PATCH v2] f2fs: allocate memory in batch in build_sit_info()
Message-ID: <20190819202007.GA23891@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190726074120.3278-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726074120.3278-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26, Chao Yu wrote:
> build_sit_info() allocate all bitmaps for each segment one by one,
> it's quite low efficiency, this pach changes to allocate large
> continuous memory at a time, and divide it and assign for each bitmaps
> of segment. For large size image, it can expect improving its mount
> speed.

Hmm, I hit a kernel panic when mounting a partition during fault injection test:

726 #ifdef CONFIG_F2FS_CHECK_FS
727         if (f2fs_test_bit(offset, sit_i->sit_bitmap) !=
728                         f2fs_test_bit(offset, sit_i->sit_bitmap_mir))
729                 f2fs_bug_on(sbi, 1);
730 #endif

For your information, I'm testing without this patch.

Thanks,

> 
> Signed-off-by: Chen Gong <gongchen4@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - fix warning triggered in kmalloc() if requested memory size exceeds 4MB.
>  fs/f2fs/segment.c | 51 +++++++++++++++++++++--------------------------
>  fs/f2fs/segment.h |  1 +
>  2 files changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a661ac32e829..d720eacd9c57 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3941,7 +3941,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>  	struct sit_info *sit_i;
>  	unsigned int sit_segs, start;
> -	char *src_bitmap;
> +	char *src_bitmap, *bitmap;
>  	unsigned int bitmap_size;
>  
>  	/* allocate memory for SIT information */
> @@ -3964,27 +3964,31 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	if (!sit_i->dirty_sentries_bitmap)
>  		return -ENOMEM;
>  
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 4;
> +#else
> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 3;
> +#endif
> +	sit_i->bitmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
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
> @@ -4492,21 +4496,12 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
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
> index b74602813a05..ec4d568fd58c 100644
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
