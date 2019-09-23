Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF47C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6BB217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407585AbfIWKCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:02:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405454AbfIWKCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:02:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91FA3AF65;
        Mon, 23 Sep 2019 10:02:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 90AD61E4669; Mon, 23 Sep 2019 12:02:59 +0200 (CEST)
Date:   Mon, 23 Sep 2019 12:02:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: code cleanup for hash bits calculation
Message-ID: <20190923100259.GD20367@quack2.suse.cz>
References: <20190921015628.54335-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921015628.54335-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 21-09-19 09:56:28, Chengguang Xu wrote:
> Code cleanup for hash bits calculation by
> calling rounddown_pow_of_two() and ilog2()
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks for the patch! One comment below:

> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..679dd3b5db70 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2983,13 +2983,9 @@ static int __init dquot_init(void)
>  
>  	/* Find power-of-two hlist_heads which can fit into allocation */
>  	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
> -	dq_hash_bits = 0;
> -	do {
> -		dq_hash_bits++;
> -	} while (nr_hash >> dq_hash_bits);
> -	dq_hash_bits--;
> +	nr_hash = rounddown_pow_of_two(nr_hash);
> +	dq_hash_bits = ilog2(nr_hash);
>  
> -	nr_hash = 1UL << dq_hash_bits;

Why not just:
	dq_hash_bits = ilog2(nr_hash);
	nr_hash = 1UL << dq_hash_bits;

That way we need to compute fls() only once...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
