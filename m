Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D3C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1E8208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDTDFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:05:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2561 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfDTDFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:05:09 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id BC27E47654C311B55469;
        Sat, 20 Apr 2019 11:05:06 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 20 Apr 2019 11:05:06 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 20 Apr 2019 11:05:06 +0800
Subject: Re: [PATCH] f2fs: Force type conversion from __le32 to u32
To:     Bharath Vedartham <linux.bhar@gmail.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190418073510.GA11396@bharath12345-Inspiron-5559>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <00548c37-765a-a2df-9ddf-d53c6ae6bae7@huawei.com>
Date:   Sat, 20 Apr 2019 11:05:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190418073510.GA11396@bharath12345-Inspiron-5559>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/18 15:35, Bharath Vedartham wrote:
> This patch forces type conversion from __le32 to u32 to prevent sparse
> warnings like:
> warning: restricted __le32 degrades to integer
> 
> dir.c:
> fscrypt_fname_disk_to_usr takes a hash of type u32 as it's second arg
> but de->hash_code is of type __le32.
> 
> node.c
> NULL_ADDR is of type u32 but block_addr is of type __le32.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  fs/f2fs/dir.c  | 2 +-
>  fs/f2fs/node.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 59bc460..4f39872 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -828,7 +828,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>  			int save_len = fstr->len;
>  
>  			err = fscrypt_fname_disk_to_usr(d->inode,
> -						(u32)de->hash_code, 0,

le32_to_cpu(de->hash_code)

> +						(__force u32)de->hash_code, 0,
>  						&de_name, fstr);
>  			if (err)
>  				goto out;
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 3f99ab2..9e333a5 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2706,7 +2706,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>  		i = 1;
>  	}
>  	for (; i < NAT_ENTRY_PER_BLOCK; i++) {
> -		if (nat_blk->entries[i].block_addr != NULL_ADDR)
> +		if ((__force u32)nat_blk->entries[i].block_addr != NULL_ADDR)

block_t blkaddr = le32_to_cpu(nat_blk->entries[i].block_addr);

if (blkaddr != NULL_ADDR)

Thanks,

>  			valid++;
>  	}
>  	if (valid == 0) {
> 
