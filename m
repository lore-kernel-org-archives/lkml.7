Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11F9218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568791547;
	bh=2f4GNVVT6zJOWZ2KcAsb/7F/dUlxL/Ds/Oi1ZvE+0gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GMN7ijm1gX1CDtV9C/TQ99FduPw4DXDuW1RxeiTSU1QTXNeMNmZVZO55NUW36eWmJ
	 G0LE6apn2nW6RkvXWe1jdNdmlG2+GLawDhVZpjTAEk7OVjeUZn3Tu2t4H67fpH5tZA
	 JiG7RA+kVFkv3qpoUzt8FeqpCyc4o/z1ETaHxnEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfIRHZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:25:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:36264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728599AbfIRHZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:25:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E9AAAD26;
        Wed, 18 Sep 2019 07:25:43 +0000 (UTC)
Date:   Wed, 18 Sep 2019 09:25:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     xiubli@redhat.com
Cc:     mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memalloc_noio: update the comment to make it cleaner
Message-ID: <20190918072542.GC12770@dhcp22.suse.cz>
References: <20190917232820.23504-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917232820.23504-1-xiubli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-09-19 04:58:20, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> The GFP_NOIO means all further allocations will implicitly drop
> both __GFP_IO and __GFP_FS flags and so they are safe for both the
> IO critical section and the the critical section from the allocation
> recursion point of view. Not only the __GFP_IO, which a bit confusing
> when reading the code or using the save/restore pair.

Historically GFP_NOIO has always implied GFP_NOFS as well. I can imagine
that this might come as an surprise for somebody not familiar with the
code though. I am wondering whether your update of the documentation
would be better off at __GFP_FS, __GFP_IO resp. GFP_NOFS, GFP_NOIO level.
This interface is simply a way to set a scoped NO{IO,FS} context.

> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  include/linux/sched/mm.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 4a7944078cc3..9bdc97e52de1 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -211,10 +211,11 @@ static inline void fs_reclaim_release(gfp_t gfp_mask) { }
>   * memalloc_noio_save - Marks implicit GFP_NOIO allocation scope.
>   *
>   * This functions marks the beginning of the GFP_NOIO allocation scope.
> - * All further allocations will implicitly drop __GFP_IO flag and so
> - * they are safe for the IO critical section from the allocation recursion
> - * point of view. Use memalloc_noio_restore to end the scope with flags
> - * returned by this function.
> + * All further allocations will implicitly drop __GFP_IO and __GFP_FS
> + * flags and so they are safe for both the IO critical section and the
> + * the critical section from the allocation recursion point of view. Use
> + * memalloc_noio_restore to end the scope with flags returned by this
> + * function.
>   *
>   * This function is safe to be used from any context.
>   */
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
