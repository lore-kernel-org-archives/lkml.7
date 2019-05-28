Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936FAC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EC42081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfE1DCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 23:02:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727566AbfE1DCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:02:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2B808A1D392843CCC95B;
        Tue, 28 May 2019 11:02:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 11:02:11 +0800
Subject: Re: [PATCH v2 2/2] staging: erofs: fix i_blocks calculation
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190528023147.94117-2-gaoxiang25@huawei.com>
 <20190528023602.178923-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fe0ff7bb-b576-f949-d57a-2892d116b22f@huawei.com>
Date:   Tue, 28 May 2019 11:02:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190528023602.178923-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/28 10:36, Gao Xiang wrote:
> For compressed files, i_blocks should not be calculated
> by using i_size. i_u.compressed_blocks is used instead.
> 
> In addition, i_blocks was miscalculated for non-compressed
> files previously, fix it as well.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> change log v2:
>  - fix description in commit message
>  - fix to 'inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK'
> 
> Thanks,
> Gao Xiang
> 
>  drivers/staging/erofs/inode.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 8da144943ed6..6e67e018784e 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -20,6 +20,7 @@ static int read_inode(struct inode *inode, void *data)
>  	struct erofs_vnode *vi = EROFS_V(inode);
>  	struct erofs_inode_v1 *v1 = data;
>  	const unsigned int advise = le16_to_cpu(v1->i_advise);
> +	erofs_blk_t nblks = 0;
>  
>  	vi->data_mapping_mode = __inode_data_mapping(advise);
>  
> @@ -60,6 +61,10 @@ static int read_inode(struct inode *inode, void *data)
>  			le32_to_cpu(v2->i_ctime_nsec);
>  
>  		inode->i_size = le64_to_cpu(v2->i_size);
> +
> +		/* total blocks for compressed files */
> +		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
> +			nblks = v2->i_u.compressed_blocks;

Xiang,

It needs to use le32_to_cpu(). ;)

>  	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
>  		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>  
> @@ -90,6 +95,8 @@ static int read_inode(struct inode *inode, void *data)
>  			sbi->build_time_nsec;
>  
>  		inode->i_size = le32_to_cpu(v1->i_size);
> +		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
> +			nblks = v1->i_u.compressed_blocks;

Ditto.

Thanks,

>  	} else {
>  		errln("unsupported on-disk inode version %u of nid %llu",
>  		      __inode_version(advise), vi->nid);
> @@ -97,8 +104,11 @@ static int read_inode(struct inode *inode, void *data)
>  		return -EIO;
>  	}
>  
> -	/* measure inode.i_blocks as the generic filesystem */
> -	inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
> +	if (!nblks)
> +		/* measure inode.i_blocks as generic filesystems */
> +		inode->i_blocks = roundup(inode->i_size, EROFS_BLKSIZ) >> 9;
> +	else
> +		inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
>  	return 0;
>  }
>  
> 
