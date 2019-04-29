Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E2C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACBC2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfD2Vt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:49:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729368AbfD2Vt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:49:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C907ABD7;
        Mon, 29 Apr 2019 21:49:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 124071E3BEC; Mon, 29 Apr 2019 23:49:56 +0200 (CEST)
Date:   Mon, 29 Apr 2019 23:49:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: set init_needed flag only when successfully
 getting dquot
Message-ID: <20190429214956.GA6740@quack2.suse.cz>
References: <20190428053921.5984-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428053921.5984-1-cgxu519@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 28-04-19 13:39:21, Chengguang Xu wrote:
> Set init_needed flag only when successfully getting dquot,
> so that we can skip unnecessary subsequent operation.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Thanks for the patch but I don't think it's really useful. It will be very
rare that we race with quotaoff of dqget() fails due to error. So the
additional overhead of iterating over dquots doesn't really matter in that
case.

								Honza

> ---
>  fs/quota/dquot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index fc20e06c56ba..8d4ce2a2b5c8 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1449,8 +1449,6 @@ static int __dquot_initialize(struct inode *inode, int type)
>  		if (!sb_has_quota_active(sb, cnt))
>  			continue;
> 
> -		init_needed = 1;
> -
>  		switch (cnt) {
>  		case USRQUOTA:
>  			qid = make_kqid_uid(inode->i_uid);
> @@ -1475,6 +1473,9 @@ static int __dquot_initialize(struct inode *inode, int type)
>  			dquot = NULL;
>  		}
>  		got[cnt] = dquot;
> +
> +		if (got[cnt])
> +			init_needed = 1;
>  	}
> 
>  	/* All required i_dquot has been initialized */
> --
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
