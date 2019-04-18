Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAFD2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbfDROCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:02:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729331AbfDROCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:02:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E48F829D6BD7A36F1819;
        Thu, 18 Apr 2019 22:01:58 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 18 Apr
 2019 22:01:53 +0800
Subject: Re: [RFC PATCH 05/62] erofs: switch to ->free_inode()
To:     Al Viro <viro@ZenIV.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-5-viro@ZenIV.linux.org.uk>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <e6cddba8-7b0a-6f05-a71a-51b8219f2159@huawei.com>
Date:   Thu, 18 Apr 2019 22:01:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190416175340.21068-5-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/17 1:52, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

It seems more clear than before :) Thanks for taking erofs into consideration as well,

Acked-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/super.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> index 15c784fba879..700cbd460807 100644
> --- a/drivers/staging/erofs/super.c
> +++ b/drivers/staging/erofs/super.c
> @@ -57,9 +57,8 @@ static struct inode *alloc_inode(struct super_block *sb)
>  	return &vi->vfs_inode;
>  }
>  
> -static void i_callback(struct rcu_head *head)
> +static void free_inode(struct inode *inode)
>  {
> -	struct inode *inode = container_of(head, struct inode, i_rcu);
>  	struct erofs_vnode *vi = EROFS_V(inode);
>  
>  	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
> @@ -71,11 +70,6 @@ static void i_callback(struct rcu_head *head)
>  	kmem_cache_free(erofs_inode_cachep, vi);
>  }
>  
> -static void destroy_inode(struct inode *inode)
> -{
> -	call_rcu(&inode->i_rcu, i_callback);
> -}
> -
>  static int superblock_read(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi;
> @@ -668,7 +662,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
>  const struct super_operations erofs_sops = {
>  	.put_super = erofs_put_super,
>  	.alloc_inode = alloc_inode,
> -	.destroy_inode = destroy_inode,
> +	.free_inode = free_inode,
>  	.statfs = erofs_statfs,
>  	.show_options = erofs_show_options,
>  	.remount_fs = erofs_remount,
> 
