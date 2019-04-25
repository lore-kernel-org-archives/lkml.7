Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF156C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8922F218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfDYJ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:59:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729329AbfDYJ75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:59:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CCEC0AEDB;
        Thu, 25 Apr 2019 09:59:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 59B971E15BE; Thu, 25 Apr 2019 11:59:55 +0200 (CEST)
Date:   Thu, 25 Apr 2019 11:59:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: fix wrong indentation
Message-ID: <20190425095955.GA23471@quack2.suse.cz>
References: <20190419054601.23752-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419054601.23752-1-cgxu519@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-04-19 13:46:01, Chengguang Xu wrote:
> We need to check return code only when calling ->read_dqblk(),
> so fix it properly.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index fc20e06c56ba..934b8f3f9e57 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -424,10 +424,11 @@ int dquot_acquire(struct dquot *dquot)
>  	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> 
>  	mutex_lock(&dquot->dq_lock);
> -	if (!test_bit(DQ_READ_B, &dquot->dq_flags))
> +	if (!test_bit(DQ_READ_B, &dquot->dq_flags)) {
>  		ret = dqopt->ops[dquot->dq_id.type]->read_dqblk(dquot);
> -	if (ret < 0)
> -		goto out_iolock;
> +		if (ret < 0)
> +			goto out_iolock;
> +	}
>  	/* Make sure flags update is visible after dquot has been filled */
>  	smp_mb__before_atomic();
>  	set_bit(DQ_READ_B, &dquot->dq_flags);
> --
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
