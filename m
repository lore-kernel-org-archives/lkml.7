Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322C9C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081662173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEIKvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:51:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfEIKvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:51:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51078AC2D;
        Thu,  9 May 2019 10:51:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 264201E3C7F; Thu,  9 May 2019 12:51:10 +0200 (CEST)
Date:   Thu, 9 May 2019 12:51:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmail.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: add dqi_dirty_list description to comment of
 Dquot List Management
Message-ID: <20190509105110.GE23589@quack2.suse.cz>
References: <1557106743-19157-1-git-send-email-cgxu519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557106743-19157-1-git-send-email-cgxu519@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-05-19 09:39:03, Chengguang Xu wrote:
> Actually there are four lists for dquot management, so add
> the description of dqui_dirty_list to comment.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmail.com>

Thanks applied with small addition:

Note that some filesystems do dirty dquot tracking on their own (e.g. in a
journal) and thus don't use dqi_dirty_list.

								Honza

> ---
>  fs/quota/dquot.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index fc20e06c56ba..6a236bdaef89 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -223,9 +223,9 @@ static void put_quota_format(struct quota_format_type *fmt)
>  
>  /*
>   * Dquot List Management:
> - * The quota code uses three lists for dquot management: the inuse_list,
> - * free_dquots, and dquot_hash[] array. A single dquot structure may be
> - * on all three lists, depending on its current state.
> + * The quota code uses four lists for dquot management: the inuse_list,
> + * free_dquots, dqi_dirty_list, and dquot_hash[] array. A single dquot
> + * structure may be on some of those lists, depending on its current state.
>   *
>   * All dquots are placed to the end of inuse_list when first created, and this
>   * list is used for invalidate operation, which must look at every dquot.
> @@ -236,6 +236,10 @@ static void put_quota_format(struct quota_format_type *fmt)
>   * dqstats.free_dquots gives the number of dquots on the list. When
>   * dquot is invalidated it's completely released from memory.
>   *
> + * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
> + * dirtied, and this list is searched when writeback diry dquots to
> + * quota file.
> + *
>   * Dquots with a specific identity (device, type and id) are placed on
>   * one of the dquot_hash[] hash chains. The provides an efficient search
>   * mechanism to locate a specific dquot.
> -- 
> 2.17.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
