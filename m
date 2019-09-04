Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CD822CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfIDHXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:23:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728209AbfIDHXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:23:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF44BB6B9;
        Wed,  4 Sep 2019 07:23:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4783E1E37A2; Wed,  4 Sep 2019 09:23:33 +0200 (CEST)
Date:   Wed, 4 Sep 2019 09:23:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext2: Delete an unnecessary check before brelse()
Message-ID: <20190904072333.GB8225@quack2.suse.cz>
References: <51dea296-2207-ebc0-bac3-13f3e5c3b235@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51dea296-2207-ebc0-bac3-13f3e5c3b235@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-09-19 14:44:08, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Sep 2019 14:40:18 +0200
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks. Added to my tree.

								Honza

> ---
>  fs/ext2/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index baa36c6fb71e..30c630d73f0f 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -162,8 +162,7 @@ static void ext2_put_super (struct super_block * sb)
>  	}
>  	db_count = sbi->s_gdb_count;
>  	for (i = 0; i < db_count; i++)
> -		if (sbi->s_group_desc[i])
> -			brelse (sbi->s_group_desc[i]);
> +		brelse(sbi->s_group_desc[i]);
>  	kfree(sbi->s_group_desc);
>  	kfree(sbi->s_debts);
>  	percpu_counter_destroy(&sbi->s_freeblocks_counter);
> --
> 2.23.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
