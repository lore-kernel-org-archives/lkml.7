Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5EC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A3E206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfJGKQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:16:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727754AbfJGKQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 161ACB201;
        Mon,  7 Oct 2019 10:16:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 13A1D1E4815; Fri,  4 Oct 2019 10:11:06 +0200 (CEST)
Date:   Fri, 4 Oct 2019 10:11:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: avoid increasing DQST_LOOKUPS when iterating over
 dirty/inuse list
Message-ID: <20191004081106.GA13650@quack2.suse.cz>
References: <20190926083408.4269-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926083408.4269-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 16:34:08, Chengguang Xu wrote:
> It is meaningless to increase DQST_LOOKUPS number while iterating
> over dirty/inuse list, so just avoid it.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Yeah, makes sense. I've queued up your patch. Thanks!

								Honza

> ---
>  fs/quota/dquot.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..00a3c6df2ea3 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -595,7 +595,6 @@ int dquot_scan_active(struct super_block *sb,
>  		/* Now we have active dquot so we can just increase use count */
>  		atomic_inc(&dquot->dq_count);
>  		spin_unlock(&dq_list_lock);
> -		dqstats_inc(DQST_LOOKUPS);
>  		dqput(old_dquot);
>  		old_dquot = dquot;
>  		/*
> @@ -649,7 +648,6 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>  			 * use count */
>  			dqgrab(dquot);
>  			spin_unlock(&dq_list_lock);
> -			dqstats_inc(DQST_LOOKUPS);
>  			err = sb->dq_op->write_dquot(dquot);
>  			if (err) {
>  				/*
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
