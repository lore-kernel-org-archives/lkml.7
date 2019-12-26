Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1113EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD292080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLZDoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 22:44:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbfLZDoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:44:55 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 861DFF9DD7EAD9D01967;
        Thu, 26 Dec 2019 11:44:52 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 26 Dec
 2019 11:44:44 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
To:     YueHaibing <yuehaibing@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191224124359.15040-1-yuehaibing@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <673efe18-d528-2e9b-6d44-a6a7a22086f3@huawei.com>
Date:   Thu, 26 Dec 2019 11:44:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191224124359.15040-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/24 20:43, YueHaibing wrote:
> fs/f2fs/segment.c: In function fix_curseg_write_pointer:
> fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not used [-Wunused-but-set-variable]
> 
> It is never used since commit 362d8a920384 ("f2fs: Check
> write pointer consistency of open zones") , so remove it.

Thanks for the fix!

Do you mind merging this patch to original patch? as it's still
pending in dev branch.

Thanks,

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/f2fs/segment.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a951953..72cf257 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4482,14 +4482,13 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
>  	struct f2fs_dev_info *zbd;
>  	struct blk_zone zone;
>  	unsigned int cs_section, wp_segno, wp_blkoff, wp_sector_off;
> -	block_t cs_zone_block, wp_block, cs_block;
> +	block_t cs_zone_block, wp_block;
>  	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
>  	sector_t zone_sector;
>  	int err;
>  
>  	cs_section = GET_SEC_FROM_SEG(sbi, cs->segno);
>  	cs_zone_block = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, cs_section));
> -	cs_block = START_BLOCK(sbi, cs->segno) + cs->next_blkoff;
>  
>  	zbd = get_target_zoned_dev(sbi, cs_zone_block);
>  	if (!zbd)
> 
