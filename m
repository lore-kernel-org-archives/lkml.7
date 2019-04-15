Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338C2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA922070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfDOJuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:50:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:57758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfDOJuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:50:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D200B025;
        Mon, 15 Apr 2019 09:50:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 074BC1E42AA; Mon, 15 Apr 2019 11:50:34 +0200 (CEST)
Date:   Mon, 15 Apr 2019 11:50:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: remvoe redundant variable assignment
Message-ID: <20190415095033.GB13684@quack2.suse.cz>
References: <20190414135855.2536-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414135855.2536-1-cgxu519@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 14-04-19 21:58:55, Chengguang Xu wrote:
> The assignment of variable ret is redundant because the
> value of ret is 0 after calling v2_read_header() in normal
> case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Thanks for the patch. Yes, you are correct the assignment is redundant but
this way it is more obvious what we're going to return and there are also
less chances we'll break the logic when adding some code using 'ret' in the
middle of v2_read_file_info().

								Honza

> ---
>  fs/quota/quota_v2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
> index a73e5b34db41..25d36607be6e 100644
> --- a/fs/quota/quota_v2.c
> +++ b/fs/quota/quota_v2.c
> @@ -158,7 +158,6 @@ static int v2_read_file_info(struct super_block *sb, int type)
>  		qinfo->dqi_entry_size = sizeof(struct v2r1_disk_dqblk);
>  		qinfo->dqi_ops = &v2r1_qtree_ops;
>  	}
> -	ret = 0;
>  out:
>  	up_read(&dqopt->dqio_sem);
>  	return ret;
> --
> 2.17.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
