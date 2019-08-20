Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ABCC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C4216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfHTJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:12:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728771AbfHTJMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:12:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D3DE6B93F5B37132134D;
        Tue, 20 Aug 2019 17:12:25 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 20 Aug
 2019 17:12:17 +0800
Subject: Re: [PATCH v2] f2fs: allocate memory in batch in build_sit_info()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chen Gong <gongchen4@huawei.com>
References: <20190726074120.3278-1-yuchao0@huawei.com>
 <20190819202007.GA23891@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <99a2713a-50d2-8a77-87d9-661ab7ed3a0c@huawei.com>
Date:   Tue, 20 Aug 2019 17:12:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190819202007.GA23891@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/20 4:20, Jaegeuk Kim wrote:
> On 07/26, Chao Yu wrote:
>> build_sit_info() allocate all bitmaps for each segment one by one,
>> it's quite low efficiency, this pach changes to allocate large
>> continuous memory at a time, and divide it and assign for each bitmaps
>> of segment. For large size image, it can expect improving its mount
>> speed.
> 
> Hmm, I hit a kernel panic when mounting a partition during fault injection test:
> 
> 726 #ifdef CONFIG_F2FS_CHECK_FS
> 727         if (f2fs_test_bit(offset, sit_i->sit_bitmap) !=
> 728                         f2fs_test_bit(offset, sit_i->sit_bitmap_mir))
> 729                 f2fs_bug_on(sbi, 1);
> 730 #endif

We didn't change anything about sit_i->sit_bitmap{_mir,}, it's so wired we panic
here... :(

I double check the change, but find nothing suspicious, btw, my fault injection
testcase shows normal.

Jaegeuk, do you have any idea about this issue?

Thanks,

> 
> For your information, I'm testing without this patch.
> 
> Thanks,
> 
>>
>> Signed-off-by: Chen Gong <gongchen4@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - fix warning triggered in kmalloc() if requested memory size exceeds 4MB.
>>  fs/f2fs/segment.c | 51 +++++++++++++++++++++--------------------------
>>  fs/f2fs/segment.h |  1 +
>>  2 files changed, 24 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index a661ac32e829..d720eacd9c57 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3941,7 +3941,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>>  	struct sit_info *sit_i;
>>  	unsigned int sit_segs, start;
>> -	char *src_bitmap;
>> +	char *src_bitmap, *bitmap;
>>  	unsigned int bitmap_size;
>>  
>>  	/* allocate memory for SIT information */
>> @@ -3964,27 +3964,31 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>>  	if (!sit_i->dirty_sentries_bitmap)
>>  		return -ENOMEM;
>>  
>> +#ifdef CONFIG_F2FS_CHECK_FS
>> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 4;
>> +#else
>> +	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 3;
>> +#endif
>> +	sit_i->bitmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
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
>> @@ -4492,21 +4496,12 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
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
>> index b74602813a05..ec4d568fd58c 100644
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
> .
> 
