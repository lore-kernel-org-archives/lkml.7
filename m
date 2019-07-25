Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD82C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288DF2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbfGYCmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:42:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389268AbfGYCmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:42:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 92F071EC6B027ABCF126;
        Thu, 25 Jul 2019 10:42:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 10:42:19 +0800
Subject: Re: [PATCH] f2fs: use EINVAL for invalid superblock
To:     Icenowy Zheng <icenowy@aosc.io>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190724130656.29436-1-icenowy@aosc.io>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <eb0b1035-6554-61b6-a4c8-9c67b707c6a2@huawei.com>
Date:   Thu, 25 Jul 2019 10:42:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190724130656.29436-1-icenowy@aosc.io>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

Yes, I can see that mount_block_root() calls ksys_mount(), however it handles 0,
EACCES and EINVAL error code..., but as manual of mount(2) said that there are
lots of error number it can return, so I suggest we'd better fix below error
handling.

		int err = do_mount_root(name, p, flags, root_mount_data);
		switch (err) {
			case 0:
				goto out;
			case -EACCES:
			case -EINVAL:
				continue;
		}

In another point, I agreed that we should not just return -EFSCORRUPTED for all
failure cases of sanity_check_raw_super(), EINVAL should be returned correctly
if the filesystem magic number is not f2fs' one, and EFSCORRUPTED for the other
cases.

Thanks,

On 2019/7/24 21:06, Icenowy Zheng wrote:
> The kernel mount_block_root() function expects -EACESS or -EINVAL for a
> unmountable filesystem when trying to mount the root with different
> filesystem types.
> 
> However, in 5.3-rc1 the behavior when F2FS code cannot find valid block
> changed to return -EFSCORRUPTED(-EUCLEAN), and this error code makes
> mount_block_root() fail when trying to probe F2FS. As invalid
> superblocks mean the filesystem cannot be recognized as F2FS (it might
> be another FS), returning -EINVAL seems more reasonable, and other
> filesystems also do this.
> 
> Change back the return value to -EINVAL when no valid superblocks are
> found.
> 
> Fixes: 10f966bbf521 ("f2fs: use generic EFSBADCRC/EFSCORRUPTED")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> This commit fixes a regression introduced in v5.3-rc1, which leads to
> btrfs / cannot be mounted if no initrd is used and both f2fs and btrfs
> are built-in.
> 
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6de6cda44031..949309b9f1b8 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2873,7 +2873,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
>  		if (sanity_check_raw_super(sbi, bh)) {
>  			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
>  				 block + 1);
> -			err = -EFSCORRUPTED;
> +			err = -EINVAL;
>  			brelse(bh);
>  			continue;
>  		}
> 
