Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDABC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA82220880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfDOQFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:05:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727499AbfDOQFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:05:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4400DAF93;
        Mon, 15 Apr 2019 16:05:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E0D321E09BA; Mon, 15 Apr 2019 18:05:17 +0200 (CEST)
Date:   Mon, 15 Apr 2019 18:05:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jan Kara <jack@suse.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udf: fix an uninitialized read bug
Message-ID: <20190415160517.GH13684@quack2.suse.cz>
References: <1555341984-3282-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555341984-3282-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-04-19 10:26:24, Wenwen Wang wrote:
> In udf_lookup(), the pointer 'fi' is a local variable initialized by the
> return value of the function call udf_find_entry(). However, if the macro
> 'UDF_RECOVERY' is defined, this variable will become uninitialized if the
> else branch is not taken, which can potentially cause incorrect results in
> the following execution.
> 
> This patch simply initializes this local pointer to NULL.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Thanks for the patch! A better fix is to drop the whole UDF_RECOVERY ifdef
and what's in it. It is just dead code anyway.

								Honza

> ---
>  fs/udf/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 58cc241..9d499e1 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -299,7 +299,7 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
>  	struct inode *inode = NULL;
>  	struct fileIdentDesc cfi;
>  	struct udf_fileident_bh fibh;
> -	struct fileIdentDesc *fi;
> +	struct fileIdentDesc *fi = NULL;
>  
>  	if (dentry->d_name.len > UDF_NAME_LEN)
>  		return ERR_PTR(-ENAMETOOLONG);
> -- 
> 2.7.4
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
