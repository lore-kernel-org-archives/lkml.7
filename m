Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfD3QGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:06:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:41562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfD3QGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:06:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 671E2AD17;
        Tue, 30 Apr 2019 16:06:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B5DB81E3BEC; Tue, 30 Apr 2019 18:06:20 +0200 (CEST)
Date:   Tue, 30 Apr 2019 18:06:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: check time limit when back out space/inode change
Message-ID: <20190430160620.GB14000@quack2.suse.cz>
References: <20190430064010.22406-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430064010.22406-1-cgxu519@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-04-19 14:40:10, Chengguang Xu wrote:
> When we fail from allocating inode/space, we back out
> the change we already did. In a special case which has
> exceeded soft limit by the change, we should also check
> time limit and reset it properly.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Good catch. Thanks for fixing this. I've added the patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 9d7dfc47c854..58f15a083dd1 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1681,13 +1681,11 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>  				if (!dquots[cnt])
>  					continue;
>  				spin_lock(&dquots[cnt]->dq_dqb_lock);
> -				if (reserve) {
> -					dquots[cnt]->dq_dqb.dqb_rsvspace -=
> -									number;
> -				} else {
> -					dquots[cnt]->dq_dqb.dqb_curspace -=
> -									number;
> -				}
> +				if (reserve)
> +					dquot_free_reserved_space(dquots[cnt],
> +								  number);
> +				else
> +					dquot_decr_space(dquots[cnt], number);
>  				spin_unlock(&dquots[cnt]->dq_dqb_lock);
>  			}
>  			spin_unlock(&inode->i_lock);
> @@ -1738,7 +1736,7 @@ int dquot_alloc_inode(struct inode *inode)
>  					continue;
>  				/* Back out changes we already did */
>  				spin_lock(&dquots[cnt]->dq_dqb_lock);
> -				dquots[cnt]->dq_dqb.dqb_curinodes--;
> +				dquot_decr_inodes(dquots[cnt], 1);
>  				spin_unlock(&dquots[cnt]->dq_dqb_lock);
>  			}
>  			goto warn_put_all;
> --
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
