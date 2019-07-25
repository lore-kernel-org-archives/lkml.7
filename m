Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9076C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8345622BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564022919;
	bh=YWxaVqhUBxhNakctl9Qk/YX4ee0cDSELqHl7XG/98z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ujqsb+6iQcyjKvvfgys39SDD27/pp9MiC5xUmzzyVCtdjcVdjHeFfEB3LbMANgeWN
	 xMDXIoQhBPkyD5W/eDxIrIGlbIlCBk2uuYDf+2L3QAjLvihT2QZLSbvIGZwUtf4N8N
	 hEnXdGW9m58h+LqFetHUhHoX9uuIkPKrRFJT2HcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbfGYCsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388165AbfGYCsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:48:37 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7990F22BE8;
        Thu, 25 Jul 2019 02:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564022916;
        bh=YWxaVqhUBxhNakctl9Qk/YX4ee0cDSELqHl7XG/98z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JnzxG+M3g1veiHLMx35BlJ7hi4YjM+QUckJY7zP4n5e9rvPCtvpWqldrs7tU3huZs
         hZOBCxuM8mEGlJRvz3bg3AO7O+QhhzX0By2Aw3ys0sPHaSLDvv1YFxOVg8B9xrErpp
         1krPoi09vQ1iDFBWz29WXlNbysr39DZYUzdfWAFo=
Date:   Wed, 24 Jul 2019 19:48:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
Message-Id: <20190724194835.59947a6b4df3c2ae7816470d@linux-foundation.org>
In-Reply-To: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2019 04:49:04 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> When running ltp's oom test with kmemleak enabled, the below warning was
> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> passed in:
> 
> ...
>
> The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, kmemleak has
> __GFP_NOFAIL set all the time due to commit
> d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
> with fault injection").
> 
> The fault-injection would not try to fail slab or page allocation if
> __GFP_NOFAIL is used and that commit tries to turn off fault injection
> for kmemleak allocation.  Although __GFP_NOFAIL doesn't guarantee no
> failure for all the cases (i.e. non-blockable allocation may fail), it
> still makes sense to the most cases.  Kmemleak is also a debugging tool,
> so it sounds not worth changing the behavior.
> 
> It also meaks sense to keep the warning, so just document the special
> case in the comment.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4531,8 +4531,14 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>  	 */
>  	if (gfp_mask & __GFP_NOFAIL) {
>  		/*
> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> -		 * of any new users that actually require GFP_NOWAIT
> +		 * The users of the __GFP_NOFAIL are expected be blockable,
> +		 * and this is true for the most cases except for kmemleak.
> +		 * The kmemleak pass in __GFP_NOFAIL to skip fault injection,
> +		 * however kmemleak may allocate object at some non-blockable
> +		 * context to trigger this warning.
> +		 *
> +		 * Keep this warning since it is still useful for the most
> +		 * normal cases.
>  		 */

Comment has rather a lot of typos.  I'd normally fix them but I think
I'll duck this patch until the kmemleak situation is addressed, so we
can add a kmemleakless long-term comment, if desired.

