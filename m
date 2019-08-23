Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453AA233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbfHWBKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:10:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387656AbfHWBKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:10:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A3F7B9633B95D8F850;
        Fri, 23 Aug 2019 09:10:26 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 23 Aug
 2019 09:10:24 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allocate memory in batch in
 build_sit_info()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190726074120.3278-1-yuchao0@huawei.com>
 <20190819202007.GA23891@jaegeuk-macbookpro.roam.corp.google.com>
 <99a2713a-50d2-8a77-87d9-661ab7ed3a0c@huawei.com>
 <20190820174121.GB58214@jaegeuk-macbookpro.roam.corp.google.com>
 <20190822174736.GA88722@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4ce7de89-fafb-3796-ae90-8132d2c819cf@huawei.com>
Date:   Fri, 23 Aug 2019 09:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190822174736.GA88722@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/23 1:47, Jaegeuk Kim wrote:
> On 08/20, Jaegeuk Kim wrote:
>> On 08/20, Chao Yu wrote:
>>> On 2019/8/20 4:20, Jaegeuk Kim wrote:
>>>> On 07/26, Chao Yu wrote:
>>>>> build_sit_info() allocate all bitmaps for each segment one by one,
>>>>> it's quite low efficiency, this pach changes to allocate large
>>>>> continuous memory at a time, and divide it and assign for each bitmaps
>>>>> of segment. For large size image, it can expect improving its mount
>>>>> speed.
>>>>
>>>> Hmm, I hit a kernel panic when mounting a partition during fault injection test:
>>>>
>>>> 726 #ifdef CONFIG_F2FS_CHECK_FS
>>>> 727         if (f2fs_test_bit(offset, sit_i->sit_bitmap) !=
>>>> 728                         f2fs_test_bit(offset, sit_i->sit_bitmap_mir))
>>>> 729                 f2fs_bug_on(sbi, 1);
>>>> 730 #endif
>>>
>>> We didn't change anything about sit_i->sit_bitmap{_mir,}, it's so wired we panic
>>> here... :(
>>>
>>> I double check the change, but find nothing suspicious, btw, my fault injection
>>> testcase shows normal.
>>>
>>> Jaegeuk, do you have any idea about this issue?
>>
>> I'm bisecting. :P
> 
> It was caused by wrong bitmap size in "f2fs: Fix indefinite loop in f2fs_gc()".
> Fixed by:

Good catch! This alternative one looks good to me.

Thanks,

> ---
>  fs/f2fs/segment.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9b20ce3b87cc..cc230fc829e1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3950,7 +3950,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	struct sit_info *sit_i;
>  	unsigned int sit_segs, start;
>  	char *src_bitmap, *bitmap;
> -	unsigned int bitmap_size;
> +	unsigned int bitmap_size, main_bitmap_size, sit_bitmap_size;
>  
>  	/* allocate memory for SIT information */
>  	sit_i = f2fs_kzalloc(sbi, sizeof(struct sit_info), GFP_KERNEL);
> @@ -3966,8 +3966,8 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	if (!sit_i->sentries)
>  		return -ENOMEM;
>  
> -	bitmap_size = f2fs_bitmap_size(MAIN_SEGS(sbi));
> -	sit_i->dirty_sentries_bitmap = f2fs_kvzalloc(sbi, bitmap_size,
> +	main_bitmap_size = f2fs_bitmap_size(MAIN_SEGS(sbi));
> +	sit_i->dirty_sentries_bitmap = f2fs_kvzalloc(sbi, main_bitmap_size,
>  								GFP_KERNEL);
>  	if (!sit_i->dirty_sentries_bitmap)
>  		return -ENOMEM;
> @@ -4016,19 +4016,21 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	sit_segs = le32_to_cpu(raw_super->segment_count_sit) >> 1;
>  
>  	/* setup SIT bitmap from ckeckpoint pack */
> -	bitmap_size = __bitmap_size(sbi, SIT_BITMAP);
> +	sit_bitmap_size = __bitmap_size(sbi, SIT_BITMAP);
>  	src_bitmap = __bitmap_ptr(sbi, SIT_BITMAP);
>  
> -	sit_i->sit_bitmap = kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);
> +	sit_i->sit_bitmap = kmemdup(src_bitmap, sit_bitmap_size, GFP_KERNEL);
>  	if (!sit_i->sit_bitmap)
>  		return -ENOMEM;
>  
>  #ifdef CONFIG_F2FS_CHECK_FS
> -	sit_i->sit_bitmap_mir = kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);
> +	sit_i->sit_bitmap_mir = kmemdup(src_bitmap,
> +					sit_bitmap_size, GFP_KERNEL);
>  	if (!sit_i->sit_bitmap_mir)
>  		return -ENOMEM;
>  
> -	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> +	sit_i->invalid_segmap = f2fs_kvzalloc(sbi,
> +					main_bitmap_size, GFP_KERNEL);
>  	if (!sit_i->invalid_segmap)
>  		return -ENOMEM;
>  #endif
> @@ -4039,7 +4041,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  	sit_i->sit_base_addr = le32_to_cpu(raw_super->sit_blkaddr);
>  	sit_i->sit_blocks = sit_segs << sbi->log_blocks_per_seg;
>  	sit_i->written_valid_blocks = 0;
> -	sit_i->bitmap_size = bitmap_size;
> +	sit_i->bitmap_size = sit_bitmap_size;
>  	sit_i->dirty_sentries = 0;
>  	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
>  	sit_i->elapsed_time = le64_to_cpu(sbi->ckpt->elapsed_time);
> 
