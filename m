Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B70EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6777216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfHFDYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:24:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729383AbfHFDYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:24:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4475FF721CE4C434936;
        Tue,  6 Aug 2019 11:24:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 6 Aug 2019
 11:24:10 +0800
Subject: Re: [PATCH v2] f2fs: fix wrong available node count calculation
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190805102725.27834-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7a47ec24-2352-7438-bed2-493a89d5c576@huawei.com>
Date:   Tue, 6 Aug 2019 11:24:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190805102725.27834-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/5 18:27, Chao Yu wrote:
> In mkfs, we have counted quota file's node number in cp.valid_node_count,
> so we have to avoid wrong substraction of quota node number in
> .available_nid/.avail_node_count calculation.
> 
> f2fs_write_check_point_pack()
> {
> ..
> 	set_cp(valid_node_count, 1 + c.quota_inum + c.lpf_inum);
> 
> Fixes: 292c196a3695 ("reserve nid resource for quota sysfile")

Jaegeuk,

Could you help to add prefix "f2fs: " into commit tile in your branch, I missed
to add it. :P

Thanks,

> Fixes: 7b63f72f73af ("f2fs: fix to do sanity check on valid node/block count")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c  | 2 +-
>  fs/f2fs/super.c | 6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a18b2a895771..d9ba1db2d01e 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2964,7 +2964,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>  
>  	/* not used nids: 0, node, meta, (and root counted as valid node) */
>  	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
> -				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
> +						F2FS_RESERVED_NODE_NUM;
>  	nm_i->nid_cnt[FREE_NID] = 0;
>  	nm_i->nid_cnt[PREALLOC_NID] = 0;
>  	nm_i->nat_cnt = 0;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6a7f1166d068..118a31f90a37 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1297,8 +1297,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	else
>  		buf->f_bavail = 0;
>  
> -	avail_node_count = sbi->total_node_count - sbi->nquota_files -
> -						F2FS_RESERVED_NODE_NUM;
> +	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>  
>  	if (avail_node_count > user_block_count) {
>  		buf->f_files = user_block_count;
> @@ -2750,8 +2749,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>  	}
>  
>  	valid_node_count = le32_to_cpu(ckpt->valid_node_count);
> -	avail_node_count = sbi->total_node_count - sbi->nquota_files -
> -						F2FS_RESERVED_NODE_NUM;
> +	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>  	if (valid_node_count > avail_node_count) {
>  		f2fs_err(sbi, "Wrong valid_node_count: %u, avail_node_count: %u",
>  			 valid_node_count, avail_node_count);
> 
