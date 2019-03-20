Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4269C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83EA21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfCTLsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:48:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727915AbfCTLsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7584ADED;
        Wed, 20 Mar 2019 11:48:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9CF4A1E4255; Wed, 20 Mar 2019 12:48:49 +0100 (CET)
Date:   Wed, 20 Mar 2019 12:48:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: code cleanup for __dquot_alloc_space()
Message-ID: <20190320114849.GC9485@quack2.suse.cz>
References: <20190320050400.20616-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320050400.20616-1-cgxu519@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 13:03:59, Chengguang Xu wrote:
> Replace (flags & DQUOT_SPACE_RESERVE) with
> variable reserve.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index fc20e06c56ba..00de508f9d2e 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1663,7 +1663,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>  		if (!dquots[cnt])
>  			continue;
> -		if (flags & DQUOT_SPACE_RESERVE) {
> +		if (reserve) {
>  			ret = dquot_add_space(dquots[cnt], 0, number, flags,
>  					      &warn[cnt]);
>  		} else {
> @@ -1676,7 +1676,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>  				if (!dquots[cnt])
>  					continue;
>  				spin_lock(&dquots[cnt]->dq_dqb_lock);
> -				if (flags & DQUOT_SPACE_RESERVE) {
> +				if (reserve) {
>  					dquots[cnt]->dq_dqb.dqb_rsvspace -=
>  									number;
>  				} else {
> --
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
