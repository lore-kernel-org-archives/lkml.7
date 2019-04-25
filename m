Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F0C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A82081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfDYPGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:06:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:38116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbfDYPF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:05:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD77CAE5E;
        Thu, 25 Apr 2019 15:05:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5129B1E15BE; Thu, 25 Apr 2019 17:05:58 +0200 (CEST)
Date:   Thu, 25 Apr 2019 17:05:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jiang Biao <benbjiang@tencent.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/quota: erase unused but set variable warning
Message-ID: <20190425150558.GA32215@quack2.suse.cz>
References: <20190424005857.82284-1-benbjiang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424005857.82284-1-benbjiang@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-04-19 08:58:57, Jiang Biao wrote:
> Local variable *reserved* of remove_dquot_ref() is only used if
> define CONFIG_QUOTA_DEBUG, but not ebraced in CONFIG_QUOTA_DEBUG
> macro, which leads to unused-but-set-variable warning when compiling.
> 
> This patch ebrace it into CONFIG_QUOTA_DEBUG macro like what is done
> in add_dquot_ref().
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index fc20e06c56ba..14ee4c6deba1 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1049,7 +1049,9 @@ static void remove_dquot_ref(struct super_block *sb, int type,
>  		struct list_head *tofree_head)
>  {
>  	struct inode *inode;
> +#ifdef CONFIG_QUOTA_DEBUG
>  	int reserved = 0;
> +#endif
>  
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> @@ -1061,8 +1063,10 @@ static void remove_dquot_ref(struct super_block *sb, int type,
>  		 */
>  		spin_lock(&dq_data_lock);
>  		if (!IS_NOQUOTA(inode)) {
> +#ifdef CONFIG_QUOTA_DEBUG
>  			if (unlikely(inode_get_rsv_space(inode) > 0))
>  				reserved = 1;
> +#endif
>  			remove_inode_dquot_ref(inode, type, tofree_head);
>  		}
>  		spin_unlock(&dq_data_lock);
> -- 
> 2.17.2 (Apple Git-113)
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
