Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B8AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADE92084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfKSQDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:03:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:46268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbfKSQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:03:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9A1BB30B;
        Tue, 19 Nov 2019 16:03:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 187A01E47E5; Tue, 19 Nov 2019 17:03:43 +0100 (CET)
Date:   Tue, 19 Nov 2019 17:03:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: remove unnecessary check in dquot_add_inodes()
 and dquot_add_space()
Message-ID: <20191119160343.GA2440@quack2.suse.cz>
References: <20191117132028.19564-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117132028.19564-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 17-11-19 21:20:28, Chengguang Xu wrote:
> After passed grace time we treat softlimit as hardlimit,
> so we don't have to compare desire usage with softlimit
> in this place.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks for the patch! I guess you mean that when dqb_itime is set, we are
sure that softlimit is exceeded. You are right but the benefit of your
change is not big and I prefer to keep the current "defensive" condition.

								Honza

> ---
>  fs/quota/dquot.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..97740077afac 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1283,7 +1283,6 @@ static int dquot_add_inodes(struct dquot *dquot, qsize_t inodes,
>  	}
>  
>  	if (dquot->dq_dqb.dqb_isoftlimit &&
> -	    newinodes > dquot->dq_dqb.dqb_isoftlimit &&
>  	    dquot->dq_dqb.dqb_itime &&
>  	    ktime_get_real_seconds() >= dquot->dq_dqb.dqb_itime &&
>              !ignore_hardlimit(dquot)) {
> @@ -1333,7 +1332,6 @@ static int dquot_add_space(struct dquot *dquot, qsize_t space,
>  	}
>  
>  	if (dquot->dq_dqb.dqb_bsoftlimit &&
> -	    tspace > dquot->dq_dqb.dqb_bsoftlimit &&
>  	    dquot->dq_dqb.dqb_btime &&
>  	    ktime_get_real_seconds() >= dquot->dq_dqb.dqb_btime &&
>              !ignore_hardlimit(dquot)) {
> -- 
> 2.21.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
