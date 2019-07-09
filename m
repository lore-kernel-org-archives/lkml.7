Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A602C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2026E216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562648806;
	bh=vRLaNB39pENRx8xaYHGCilgHvRIBsh6uU1qpFKxiZUg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mJ4Czo7fdHypAa6s78JITNTugKxnWRtgwCtxYMLiRBHUkVYAMpTG5P/dWpKbGc6BB
	 LginHnOt/64gPLHerQvRu4lWzxpphTa69V+KKTieiJaFockTZPpwnLVD7I0cZQuZCs
	 zSKkTlWzDrwt0PXW+6erwc13BFUfN0/d8UsO9qqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGIFGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfGIFGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:06:44 -0400
Received: from [192.168.0.101] (unknown [49.65.245.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14CED2073D;
        Tue,  9 Jul 2019 05:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562648803;
        bh=vRLaNB39pENRx8xaYHGCilgHvRIBsh6uU1qpFKxiZUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JkBXnKwq258WetNLII677gJ2yQ9iCULpibiBmajAtfFg5IR+FSPzOeu3gAl4YxBtm
         AGTDmST91bdQFhcdSlks6oR2E0WSaDgeJ22T4T0jA86hsC1WsBHqJOTmZUER/yPYvx
         crYAwck8wyWbX8ycVhdZiaNPK7ZPLRb7i1EsHgog=
Subject: Re: [PATCH] f2fs: allocate memory in batch in build_sit_info()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chen Gong <gongchen4@huawei.com>
References: <20190704081730.46414-1-yuchao0@huawei.com>
 <20190708234633.GB21769@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <86fb078c-0f9e-8d08-7e3b-29a2b6c8b107@kernel.org>
Date:   Tue, 9 Jul 2019 13:06:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190708234633.GB21769@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-7-9 7:46, Jaegeuk Kim wrote:
> On 07/04, Chao Yu wrote:
>> build_sit_info() allocate all bitmaps for each segment one by one,
>> it's quite low efficiency, this pach changes to allocate large
>> continuous memory at a time, and divide it and assign for each bitmaps
> 
> It may give more failure rate?

For android, I think there should be no problem, since while startup, memory
should be sufficient for f2fs mount.
For server or desktop, if there is any failure on memory allocation,
f2fs_kzalloc will fallback to vmalloc, so that would not be worse than before,
right?

Or if you worry about this really, could we add a fast path:

build_sit_info()
 - try allocate sit_i->bitmap
  - success: divide memory
 - fail: fallback to old method

Thanks,

> 
>> of segment. For large size image, it can expect improving its mount
>> speed.
>>
>> Signed-off-by: Chen Gong <gongchen4@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 51 +++++++++++++++++++++--------------------------
>>  fs/f2fs/segment.h |  1 +
>>  2 files changed, 24 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 402fbbbb2d7c..73c803af1f31 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3929,7 +3929,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>>  	struct sit_info *sit_i;
>>  	unsigned int sit_segs, start;
>> -	char *src_bitmap;
>> +	char *src_bitmap, *bitmap;
>>  	unsigned int bitmap_size;
>>  
>>  	/* allocate memory for SIT information */
>> @@ -3950,27 +3950,31 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>>  	if (!sit_i->dirty_sentries_bitmap)
>>  		return -ENOMEM;
>>  
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 4;
>> +#else
>> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 3;
>> +#endif
>> +	sit_i->bitmap = f2fs_kzalloc(sbi, bitmap_size, GFP_KERNEL);
>> +	if (!sit_i->bitmap)
>> +		return -ENOMEM;
>> +
>> +	bitmap = sit_i->bitmap;
>> +
>>  	for (start = 0; start < MAIN_SEGS(sbi); start++) {
>> -		sit_i->sentries[start].cur_valid_map
>> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
>> -		sit_i->sentries[start].ckpt_valid_map
>> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
>> -		if (!sit_i->sentries[start].cur_valid_map ||
>> -				!sit_i->sentries[start].ckpt_valid_map)
>> -			return -ENOMEM;
>> +		sit_i->sentries[start].cur_valid_map = bitmap;
>> +		bitmap += SIT_VBLOCK_MAP_SIZE;
>> +
>> +		sit_i->sentries[start].ckpt_valid_map = bitmap;
>> +		bitmap += SIT_VBLOCK_MAP_SIZE;
>>  
>>  #ifdef CONFIG_F2FS_CHECK_FS
>> -		sit_i->sentries[start].cur_valid_map_mir
>> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
>> -		if (!sit_i->sentries[start].cur_valid_map_mir)
>> -			return -ENOMEM;
>> +		sit_i->sentries[start].cur_valid_map_mir = bitmap;
>> +		bitmap += SIT_VBLOCK_MAP_SIZE;
>>  #endif
>>  
>> -		sit_i->sentries[start].discard_map
>> -			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
>> -							GFP_KERNEL);
>> -		if (!sit_i->sentries[start].discard_map)
>> -			return -ENOMEM;
>> +		sit_i->sentries[start].discard_map = bitmap;
>> +		bitmap += SIT_VBLOCK_MAP_SIZE;
>>  	}
>>  
>>  	sit_i->tmp_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
>> @@ -4440,21 +4444,12 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
>>  static void destroy_sit_info(struct f2fs_sb_info *sbi)
>>  {
>>  	struct sit_info *sit_i = SIT_I(sbi);
>> -	unsigned int start;
>>  
>>  	if (!sit_i)
>>  		return;
>>  
>> -	if (sit_i->sentries) {
>> -		for (start = 0; start < MAIN_SEGS(sbi); start++) {
>> -			kvfree(sit_i->sentries[start].cur_valid_map);
>> -#ifdef CONFIG_F2FS_CHECK_FS
>> -			kvfree(sit_i->sentries[start].cur_valid_map_mir);
>> -#endif
>> -			kvfree(sit_i->sentries[start].ckpt_valid_map);
>> -			kvfree(sit_i->sentries[start].discard_map);
>> -		}
>> -	}
>> +	if (sit_i->sentries)
>> +		kvfree(sit_i->bitmap);
>>  	kvfree(sit_i->tmp_map);
>>  
>>  	kvfree(sit_i->sentries);
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 2fd53462fa27..4d171b489130 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -226,6 +226,7 @@ struct sit_info {
>>  	block_t sit_base_addr;		/* start block address of SIT area */
>>  	block_t sit_blocks;		/* # of blocks used by SIT area */
>>  	block_t written_valid_blocks;	/* # of valid blocks in main area */
>> +	char *bitmap;			/* all bitmaps pointer */
>>  	char *sit_bitmap;		/* SIT bitmap pointer */
>>  #ifdef CONFIG_F2FS_CHECK_FS
>>  	char *sit_bitmap_mir;		/* SIT bitmap mirror */
>> -- 
>> 2.18.0.rc1
