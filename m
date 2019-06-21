Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8BAC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF5621537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfFUJyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:54:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbfFUJyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:54:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE75F25CFA34DA6EF421;
        Fri, 21 Jun 2019 17:54:46 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 17:54:39 +0800
Subject: Re: [PATCH -next] f2fs: Use div_u64*() for 64-bit divisions
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190620143800.20640-1-geert@linux-m68k.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <dd980fec-d507-6969-cd86-971bafb401c2@huawei.com>
Date:   Fri, 21 Jun 2019 17:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620143800.20640-1-geert@linux-m68k.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Since the original patch hasn't been merged to upstream, I think we can merge
this into original patch, how do you think?

On 2019/6/20 22:38, Geert Uytterhoeven wrote:
> On 32-bit (e.g. m68k):
> 
>     fs/f2fs/gc.o: In function `f2fs_resize_fs':
>     gc.c:(.text+0x3056): undefined reference to `__umoddi3'
>     gc.c:(.text+0x30c4): undefined reference to `__udivdi3'
> 
> Fix this by using div_u64_rem() and div_u64() for 64-by-32 modulo resp.
> division operations.
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: d2ae7494d043bfaf ("f2fs: ioctl for removing a range from F2FS")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> This assumes BLKS_PER_SEC(sbi) is 32-bit.
> 
>     #define BLKS_PER_SEC(sbi)                                       \
> 	    ((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
> 
> Notes:
>   1. f2fs_sb_info.segs_per_sec and f2fs_sb_info.blocks_per_seg are both
>      unsigned int,
>   2. The multiplication is done in 32-bit arithmetic, hence the result
>      is of type unsigned int.
>   3. Is it guaranteed that the result will always fit in 32-bit, or can
>      this overflow?
>   4. fs/f2fs/debug.c:update_sit_info() assigns BLKS_PER_SEC(sbi) to
>      unsigned long long blks_per_sec, anticipating a 64-bit value.
> ---
>  fs/f2fs/gc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5b1076505ade9f84..c65f87f11de029f4 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1438,13 +1438,15 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	unsigned int secs;
>  	int gc_mode, gc_type;
>  	int err = 0;
> +	__u32 rem;
>  
>  	old_block_count = le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
>  	if (block_count > old_block_count)
>  		return -EINVAL;
>  
>  	/* new fs size should align to section size */
> -	if (block_count % BLKS_PER_SEC(sbi))
> +	div_u64_rem(block_count, BLKS_PER_SEC(sbi), &rem);
> +	if (rem)
>  		return -EINVAL;
>  
>  	if (block_count == old_block_count)
> @@ -1463,7 +1465,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	freeze_bdev(sbi->sb->s_bdev);
>  
>  	shrunk_blocks = old_block_count - block_count;
> -	secs = shrunk_blocks / BLKS_PER_SEC(sbi);
> +	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
>  	spin_lock(&sbi->stat_lock);
>  	if (shrunk_blocks + valid_user_blocks(sbi) +
>  		sbi->current_reserved_blocks + sbi->unusable_block_count +
> 
