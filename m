Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B4CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA5D206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfJUGWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:22:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfJUGWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:22:34 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 4D12B4A03B8B412BD6DB;
        Mon, 21 Oct 2019 14:22:31 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 14:22:31 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 21 Oct 2019 14:22:30 +0800
Date:   Mon, 21 Oct 2019 14:25:25 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Pratik Shinde <pratikshinde320@gmail.com>
CC:     <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: code for verifying superblock checksum of an
 erofs image.
Message-ID: <20191021062522.GA165782@architecture4>
References: <20191020192828.10772-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191020192828.10772-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

Some comments as below...

On Mon, Oct 21, 2019 at 12:58:28AM +0530, Pratik Shinde wrote:
> Patch for kernel side changes of checksum feature.I used kernel's
> crc32c library for calculating the checksum.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  fs/erofs/erofs_fs.h |  5 +++--
>  fs/erofs/internal.h |  2 +-
>  fs/erofs/super.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index b1ee565..bab5506 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -17,6 +17,7 @@
>   */
>  #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
>  #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> +#define EROFS_FEATURE_SB_CHKSUM 0x0001

How about keeping in sync with erofs-utils?

>  
>  /* 128-byte erofs on-disk super block */
>  struct erofs_super_block {
> @@ -37,8 +38,8 @@ struct erofs_super_block {
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
> index 544a453..cd3af45 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -86,7 +86,7 @@ struct erofs_sb_info {
>  	u8 uuid[16];                    /* 128-bit uuid for volume */
>  	u8 volume_name[16];             /* volume name */
>  	u32 feature_incompat;
> -
> +	u32 features;

no use? and 
how about keeping in sync with erofs-utils, naming feature_compat as well? see,

https://lore.kernel.org/r/20191020141102.GA30399@hsiangkao-HP-ZHAN-66-Pro-G1/

>  	unsigned int mount_opt;
>  };
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0e36949..94e1d6a 100644
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
> @@ -46,6 +47,45 @@ void _erofs_info(struct super_block *sb, const char *function,
>  	va_end(args);
>  }
>  
> +static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
> +				       struct super_block *sb)

erofs_validate_sb_chksum(struct super_block *sb, void *sbdata)

Can we pass void *sbdata --- first page(block) instead?

> +{
> +	u32 disk_chksum = le32_to_cpu(dsb->checksum);
> +	u32 nblocks = le32_to_cpu(dsb->chksum_blocks);
> +	u32 crc;
> +	struct erofs_super_block *dsb2;
> +	char *buf;
> +	unsigned int off = 0;
> +	void *kaddr;
> +	struct page *page;
> +	int i, ret = -EINVAL;
> +
> +	buf = kmalloc(nblocks * EROFS_BLKSIZ, GFP_KERNEL);

IMO, I think we could just
 1) malloc EROFS_BLKSIZ;
 2) copy sbdata -> buf;
 3) dsb->checksum = 0;
 4) crc32c the first copied block;
 5) kfree.

or some better approach without allocating memory.

> +	if (!buf)
> +		goto out;

how about erroring out with proper return value?


> +	for (i = 0; i < nblocks; i++) {
> +		page = erofs_get_meta_page(sb, i);
> +		if (IS_ERR(page))

ditto.

> +			goto out;
> +		kaddr = kmap_atomic(page);
> +		(void) memcpy(buf + off, kaddr, EROFS_BLKSIZ);

we can call crc32c for multiple times, and no need to
get and calc 0-th block again...

and no memcpy at all.

> +		kunmap_atomic(kaddr);
> +		unlock_page(page);
> +		/* first page will be released by erofs_read_superblock */
> +		if (i != 0)
> +			put_page(page);
> +		off += EROFS_BLKSIZ;
> +	}
> +	dsb2 = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
> +	dsb2->checksum = 0;
> +	crc = crc32c(0, buf, nblocks * EROFS_BLKSIZ);
> +	if (crc != disk_chksum)
> +		goto out;
> +	ret = 0;
> +out:	kfree(buf);
> +	return ret;
> +}
> +
>  static void erofs_inode_init_once(void *ptr)
>  {
>  	struct erofs_inode *vi = ptr;
> @@ -109,18 +149,20 @@ static int erofs_read_superblock(struct super_block *sb)
>  		erofs_err(sb, "cannot read erofs superblock");
>  		return PTR_ERR(page);
>  	}
> -
>  	sbi = EROFS_SB(sb);
> -
>  	data = kmap_atomic(page);

should use kmap() then, because kmalloc() and get_meta_page() can sleep and
last for long time.

>  	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
> -
>  	ret = -EINVAL;
>  	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
>  		erofs_err(sb, "cannot find valid erofs superblock");
>  		goto out;
>  	}
> -
> +	if (dsb->feature_compat & EROFS_FEATURE_SB_CHKSUM) {
> +		if (erofs_validate_sb_chksum(dsb, sb)) {

		    erofs_validate_sb_chksum(sb, data)

> +			erofs_err(sb, "super block checksum incorrect");

It should be with a proper return value and corresponding messages,
see the related discussion:
https://lore.kernel.org/r/20190822090541.GA193349@architecture4/

Thanks,
Gao Xiang

> +			goto out;
> +		}
> +	}
>  	blkszbits = dsb->blkszbits;
>  	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>  	if (blkszbits != LOG_BLOCK_SIZE) {
> -- 
> 2.9.3
> 
