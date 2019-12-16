Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E38C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156EF206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfLPRGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:06:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:46142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfLPRFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:05:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16A57AC4B;
        Mon, 16 Dec 2019 17:05:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 69A611E0B2E; Mon, 16 Dec 2019 18:05:53 +0100 (CET)
Date:   Mon, 16 Dec 2019 18:05:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     akpm@linux-foundation.org, zhengbin13@huawei.com, jack@suse.cz,
        yanaijie@huawei.com, darrick.wong@oracle.com, linux.bhar@gmail.com,
        hariprasad.kelam@gmail.com, deepa.kernel@gmail.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] reiserfs: prevent NULL pointer dereference in
 reiserfs_insert_item()
Message-ID: <20191216170553.GA16051@quack2.suse.cz>
References: <79c5135d-ff25-1cc9-4e99-9f572b88cc00@huawei.com>
 <20c04f55-aa48-d28a-f8ff-1efed8a38f3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c04f55-aa48-d28a-f8ff-1efed8a38f3a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-12-19 20:05:32, Yunfeng Ye wrote:
> The variable inode may be NULL in reiserfs_insert_item(), but there is
> no check before accessing the member of inode.
> 
> Fix this by adding NULL pointer check before calling reiserfs_debug().
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Thanks, I've added the patch to my tree.

								Honza

> ---
>  fs/reiserfs/stree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
> index da9ebe33882b..bb4973aefbb1 100644
> --- a/fs/reiserfs/stree.c
> +++ b/fs/reiserfs/stree.c
> @@ -2246,7 +2246,8 @@ int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
>  	/* also releases the path */
>  	unfix_nodes(&s_ins_balance);
>  #ifdef REISERQUOTA_DEBUG
> -	reiserfs_debug(th->t_super, REISERFS_DEBUG_CODE,
> +	if (inode)
> +		reiserfs_debug(th->t_super, REISERFS_DEBUG_CODE,
>  		       "reiserquota insert_item(): freeing %u id=%u type=%c",
>  		       quota_bytes, inode->i_uid, head2type(ih));
>  #endif
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
