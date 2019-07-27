Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E9EC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDA32085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfG0ONb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 10:13:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727589AbfG0ONa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 10:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC17CACC4;
        Sat, 27 Jul 2019 14:13:29 +0000 (UTC)
Subject: Re: [PATCH 2/3] bcache: use allocator reserves instead of watermarks
To:     Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        kent.overstreet@gmail.com
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564222799-10603-1-git-send-email-baiyaowei@cmss.chinamobile.com>
 <1564222799-10603-2-git-send-email-baiyaowei@cmss.chinamobile.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <4bc32702-9d83-1ac5-4c79-2d9e45123da8@suse.de>
Date:   Sat, 27 Jul 2019 22:13:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564222799-10603-2-git-send-email-baiyaowei@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/27 6:19 下午, Yaowei Bai wrote:
> Commit 78365411b344 ("bcache: Rework allocator reserves") introduced
> allocator reserves and dropped watermarks, let's keep this consistent
> to avoid confusing.
> 
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>

It is OK to me, I will add it to my for-test.

Thanks.

Coly Li

> ---
>  drivers/md/bcache/alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index c22c260..609df38 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -622,13 +622,13 @@ bool bch_alloc_sectors(struct cache_set *c,
>  	spin_lock(&c->data_bucket_lock);
>  
>  	while (!(b = pick_data_bucket(c, k, write_point, &alloc.key))) {
> -		unsigned int watermark = write_prio
> +		unsigned int reserve = write_prio
>  			? RESERVE_MOVINGGC
>  			: RESERVE_NONE;
>  
>  		spin_unlock(&c->data_bucket_lock);
>  
> -		if (bch_bucket_alloc_set(c, watermark, &alloc.key, 1, wait))
> +		if (bch_bucket_alloc_set(c, reserve, &alloc.key, 1, wait))
>  			return false;
>  
>  		spin_lock(&c->data_bucket_lock);
> 
