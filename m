Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C9CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990BE2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbfJWIRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:17:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389987AbfJWIRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:17:02 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00703BF957FC376344C8;
        Wed, 23 Oct 2019 16:16:59 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 23 Oct
 2019 16:15:30 +0800
Subject: Re: [PATCH v4] erofs: support superblock checksum
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <chao@kernel.org>,
        <linux-erofs@lists.ozlabs.org>
CC:     Gao Xiang <xiang@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191022180620.19638-1-pratikshinde320@gmail.com>
 <20191023040557.230886-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
Date:   Wed, 23 Oct 2019 16:15:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023040557.230886-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xiang, Pratik,

On 2019/10/23 12:05, Gao Xiang wrote:
> From: Pratik Shinde <pratikshinde320@gmail.com>
> 
> Introduce superblock checksum feature in order to check
> a number of given blocks at mounting time.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> changes from v3:
>  (based on Pratik's v3 patch)
>  - add LIBCRC32C dependency;
>  - use kmap() in order to avoid sleeping in atomic context;
>  - skip the first 1024 byte for x86 boot sector,
>    co-tested with userspace utils,
>    https://lore.kernel.org/r/20191023034957.184711-1-gaoxiang25@huawei.com
> 
>  fs/erofs/Kconfig    |  1 +
>  fs/erofs/erofs_fs.h |  6 +++--
>  fs/erofs/internal.h |  2 ++
>  fs/erofs/super.c    | 53 +++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 9d634d3a1845..74b0aaa7114c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -3,6 +3,7 @@
>  config EROFS_FS
>  	tristate "EROFS filesystem support"
>  	depends on BLOCK
> +	select LIBCRC32C
>  	help
>  	  EROFS (Enhanced Read-Only File System) is a lightweight
>  	  read-only file system with modern designs (eg. page-sized
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index b1ee5654750d..461913be1d1c 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -11,6 +11,8 @@
>  
>  #define EROFS_SUPER_OFFSET      1024
>  
> +#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
> +
>  /*
>   * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
>   * be incompatible with this kernel version.
> @@ -37,8 +39,8 @@ struct erofs_super_block {
>  	__u8 uuid[16];          /* 128-bit uuid for volume */
>  	__u8 volume_name[16];   /* volume name */
>  	__le32 feature_incompat;
> -
> -	__u8 reserved2[44];
> +	__le32 chksum_blocks;	/* number of blocks used for checksum */
> +	__u8 reserved2[40];
>  };
>  
>  /*
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 544a453f3076..a3778f597bf6 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -85,6 +85,7 @@ struct erofs_sb_info {
>  
>  	u8 uuid[16];                    /* 128-bit uuid for volume */
>  	u8 volume_name[16];             /* volume name */
> +	u32 feature_compat;
>  	u32 feature_incompat;
>  
>  	unsigned int mount_opt;
> @@ -426,6 +427,7 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> +#define EFSBADCRC       EBADMSG         /* Bad CRC detected */
>  
>  #endif	/* __EROFS_INTERNAL_H */
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0e369494f2f2..18d1ec18a671 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -9,6 +9,7 @@
>  #include <linux/statfs.h>
>  #include <linux/parser.h>
>  #include <linux/seq_file.h>
> +#include <linux/crc32c.h>
>  #include "xattr.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -46,6 +47,47 @@ void _erofs_info(struct super_block *sb, const char *function,
>  	va_end(args);
>  }
>  
> +static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
> +{
> +	struct erofs_super_block *dsb;
> +	u32 expected_crc, nblocks, crc;
> +	void *kaddr;
> +	struct page *page;
> +	int i;
> +
> +	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
> +		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
> +	if (!dsb)
> +		return -ENOMEM;
> +
> +	expected_crc = le32_to_cpu(dsb->checksum);
> +	nblocks = le32_to_cpu(dsb->chksum_blocks);

Now, we try to use nblocks's value before checking its validation, I guess fuzz
test can easily make the value extreme larger, result in checking latter blocks
unnecessarily.

IMO, we'd better
1. check validation of superblock to make sure all fields in sb are valid
2. use .nblocks to count and check payload blocks following sb

Thanks,

> +	dsb->checksum = 0;
> +	/* to allow for x86 boot sectors and other oddities. */
> +	crc = crc32c(~0, dsb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
> +	kfree(dsb);
> +
> +	for (i = 1; i < nblocks; i++) {
> +		page = erofs_get_meta_page(sb, i);
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
> +
> +		kaddr = kmap_atomic(page);
> +		crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
> +		kunmap_atomic(kaddr);
> +
> +		unlock_page(page);
> +		put_page(page);
> +	}
> +
> +	if (crc != expected_crc) {
> +		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
> +			  crc, expected_crc);
> +		return -EFSBADCRC;
> +	}
> +	return 0;
> +}
> +
>  static void erofs_inode_init_once(void *ptr)
>  {
>  	struct erofs_inode *vi = ptr;
> @@ -112,7 +154,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  
>  	sbi = EROFS_SB(sb);
>  
> -	data = kmap_atomic(page);
> +	data = kmap(page);
>  	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>  
>  	ret = -EINVAL;
> @@ -121,6 +163,13 @@ static int erofs_read_superblock(struct super_block *sb)
>  		goto out;
>  	}
>  
> +	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
> +	if (sbi->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
> +		ret = erofs_superblock_csum_verify(sb, data);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	blkszbits = dsb->blkszbits;
>  	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>  	if (blkszbits != LOG_BLOCK_SIZE) {
> @@ -155,7 +204,7 @@ static int erofs_read_superblock(struct super_block *sb)
>  	}
>  	ret = 0;
>  out:
> -	kunmap_atomic(data);
> +	kunmap(data);
>  	put_page(page);
>  	return ret;
>  }
> 
