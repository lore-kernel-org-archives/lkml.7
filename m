Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC5C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8652075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 01:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfE0BtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 21:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfE0BtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 21:49:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 349AD3092664;
        Mon, 27 May 2019 01:49:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC4D15C3FD;
        Mon, 27 May 2019 01:49:14 +0000 (UTC)
Date:   Sun, 26 May 2019 21:49:14 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm-region-hash: fix a missing-check bug in __rh_alloc()
Message-ID: <20190527014913.GA10098@redhat.com>
References: <20190527005034.GA16907@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527005034.GA16907@zhanggen-UX430UQ>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 27 May 2019 01:49:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26 2019 at  8:50pm -0400,
Gen Zhang <blackgod016574@gmail.com> wrote:

> In function __rh_alloc(), the pointer nreg is allocated a memory space
> via kmalloc(). And it is used in the following codes. However, when 
> there is a memory allocation error, kmalloc() fails. Thus null pointer
> dereference may happen. And it will cause the kernel to crash. Therefore,
> we should check the return value and handle the error.
> Further, in __rh_find(), we should also check the return value and
> handle the error.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
> index 1f76045..2fa1641 100644
> --- a/drivers/md/dm-region-hash.c
> +++ b/drivers/md/dm-region-hash.c
> @@ -290,8 +290,11 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
>  	struct dm_region *reg, *nreg;
>  
>  	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
> -	if (unlikely(!nreg))
> +	if (unlikely(!nreg)) {
>  		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
> +		if (!nreg)
> +			return NULL;
> +	}
>  
>  	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
>  		      DM_RH_CLEAN : DM_RH_NOSYNC;

This patch isn't needed.  __GFP_NOFAIL means the allocation won't fail.

And there are many other users of __GFP_NOFAIL that don't check for
failure.  

Mike
