Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8589FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6328422CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfIDHsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:48:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727787AbfIDHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:48:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7216B67C;
        Wed,  4 Sep 2019 07:48:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 793BC1E37A2; Wed,  4 Sep 2019 09:48:30 +0200 (CEST)
Date:   Wed, 4 Sep 2019 09:48:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Jan Kara <jack@suse.com>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs-udf: Delete an unnecessary check before brelse()
Message-ID: <20190904074830.GD8225@quack2.suse.cz>
References: <a254c1d1-0109-ab51-c67a-edc5c1c4b4cd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a254c1d1-0109-ab51-c67a-edc5c1c4b4cd@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-09-19 21:15:58, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Sep 2019 21:12:09 +0200
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for the patch. Added to my tree.

								Honza

> ---
>  fs/udf/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 56da1e1680ea..0cd0be642a2f 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -273,8 +273,7 @@ static void udf_sb_free_bitmap(struct udf_bitmap *bitmap)
>  	int nr_groups = bitmap->s_nr_groups;
> 
>  	for (i = 0; i < nr_groups; i++)
> -		if (bitmap->s_block_bitmap[i])
> -			brelse(bitmap->s_block_bitmap[i]);
> +		brelse(bitmap->s_block_bitmap[i]);
> 
>  	kvfree(bitmap);
>  }
> --
> 2.23.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
