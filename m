Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1052BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F8420644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392790AbfFMQjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:39:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730600AbfFMHJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1ABB06BE73A68DD261B2;
        Thu, 13 Jun 2019 15:09:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 15:09:25 +0800
Subject: Re: [PATCH] f2fs: add boundary check in inline_data_addr
To:     Randall Huang <huangrandall@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190612085800.11947-1-huangrandall@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e54b84ee-39a3-c518-8c9b-192fb9a92d27@huawei.com>
Date:   Thu, 13 Jun 2019 15:09:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190612085800.11947-1-huangrandall@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randall,

On 2019/6/12 16:58, Randall Huang wrote:
> Add boundary check in case of extra_size is larger
> than sizeof array "i_addr"
> 
> Signed-off-by: Randall Huang <huangrandall@google.com>
> ---
>  fs/f2fs/f2fs.h | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 760390f380b6..17f3858a00c3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2660,11 +2660,25 @@ static inline bool f2fs_is_drop_cache(struct inode *inode)
>  	return is_inode_flag_set(inode, FI_DROP_CACHE);
>  }
>  
> +#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
> +	(offsetof(struct f2fs_inode, i_extra_end) -	\
> +	offsetof(struct f2fs_inode, i_extra_isize))	\
> +
>  static inline void *inline_data_addr(struct inode *inode, struct page *page)
>  {
>  	struct f2fs_inode *ri = F2FS_INODE(page);
>  	int extra_size = get_extra_isize(inode);
>  
> +	if (extra_size < 0 || extra_size > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
> +		extra_size % sizeof(__le32)) {
> +		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_ERR,
> +			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
> +			"max: %zu",
> +			__func__, inode->i_ino, extra_size,
> +			F2FS_TOTAL_EXTRA_ATTR_SIZE);
> +		extra_size = 0;
> +	}

Oh, we have already did the sanity check on .i_extra_isize field in
sanity_check_inode(), why can it be changed after that? bit-transition of cache
or memory overflow?

Thanks,

> +
>  	return (void *)&(ri->i_addr[extra_size + DEF_INLINE_RESERVED_SIZE]);
>  }
>  
> @@ -2817,10 +2831,6 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
>  	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
>  
> -#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
> -	(offsetof(struct f2fs_inode, i_extra_end) -	\
> -	offsetof(struct f2fs_inode, i_extra_isize))	\
> -
>  #define F2FS_OLD_ATTRIBUTE_SIZE	(offsetof(struct f2fs_inode, i_addr))
>  #define F2FS_FITS_IN_INODE(f2fs_inode, extra_isize, field)		\
>  		((offsetof(typeof(*(f2fs_inode)), field) +	\
> 
