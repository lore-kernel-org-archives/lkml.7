Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2511C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF588206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfDQLOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:14:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729522AbfDQLOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:14:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EBC8AF01;
        Wed, 17 Apr 2019 11:14:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 504F41E15AE; Wed, 17 Apr 2019 13:14:08 +0200 (CEST)
Date:   Wed, 17 Apr 2019 13:14:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jan Kara <jack@suse.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] udf: fix an uninitialized read bug and remove dead
 code
Message-ID: <20190417111408.GB26435@quack2.suse.cz>
References: <1555351086-3935-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555351086-3935-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-04-19 12:58:06, Wenwen Wang wrote:
> In udf_lookup(), the pointer 'fi' is a local variable initialized by the
> return value of the function call udf_find_entry(). However, if the macro
> 'UDF_RECOVERY' is defined, this variable will become uninitialized if the
> else branch is not taken, which can potentially cause incorrect results in
> the following execution.
> 
> To fix this issue, this patch drops the whole code in the ifdef
> 'UDF_RECOVERY' region, as it is dead code.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Thanks for the patch. I've added it to my tree.

								Honza

> ---
>  fs/udf/namei.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 58cc241..77b6d89 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -304,21 +304,6 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
>  	if (dentry->d_name.len > UDF_NAME_LEN)
>  		return ERR_PTR(-ENAMETOOLONG);
>  
> -#ifdef UDF_RECOVERY
> -	/* temporary shorthand for specifying files by inode number */
> -	if (!strncmp(dentry->d_name.name, ".B=", 3)) {
> -		struct kernel_lb_addr lb = {
> -			.logicalBlockNum = 0,
> -			.partitionReferenceNum =
> -				simple_strtoul(dentry->d_name.name + 3,
> -						NULL, 0),
> -		};
> -		inode = udf_iget(dir->i_sb, lb);
> -		if (IS_ERR(inode))
> -			return inode;
> -	} else
> -#endif /* UDF_RECOVERY */
> -
>  	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
>  	if (IS_ERR(fi))
>  		return ERR_CAST(fi);
> -- 
> 2.7.4
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
