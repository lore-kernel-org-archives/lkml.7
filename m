Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27713C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E0E208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="COXfg54U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfFNM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:56:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=75ZK6uA+v8HWBuHLrrBEBKQG77OfYldSM/de/8si5No=; b=COXfg54UV0gR017XZ9SWUN/fNL
        9LgmRy/npcTpGelXHuFq9mYwJlBP9dWYq0TAZC9dYFPnuXBjrhTjMN3UhqNrt4t5+vO42K6cgmbgK
        o9ilSXIeCLsRBDCN1k0LaTHKZ0oriFE9AoHYXBaohI7UxbHGv+RvGCsOsfTVu9LZJBkmwByPK7y0m
        FYCAQn2lJXLCYWsX1bTf+sghfrFoIGVMMBhkcN96v70+biGd6vZqxPk+EvDUT4Yd5A4LrQfFBQF34
        OsHwCPwFL12WAguOwyUePNc1PjfaMoBpjREg/76wzpfwN5TG3/ShRM4lnCJ5E5bp206H57Z6eLBPs
        XXG1lOgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbll5-0004yM-1S; Fri, 14 Jun 2019 12:56:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60A052013F73F; Fri, 14 Jun 2019 14:56:41 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:56:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, thellstrom@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, lima@lists.freedesktop.org
Subject: Re: [PATCH 1/6] locking: add ww_mutex_(un)lock_for_each helpers
Message-ID: <20190614125641.GO3436@hirez.programming.kicks-ass.net>
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614124125.124181-2-christian.koenig@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:41:20PM +0200, Christian König wrote:
> The ww_mutex implementation allows for detection deadlocks when multiple
> threads try to acquire the same set of locks in different order.
> 
> The problem is that handling those deadlocks was the burden of the user of
> the ww_mutex implementation and at least some users didn't got that right
> on the first try.
> 
> I'm not a big fan of macros, but it still better then implementing the same
> logic at least halve a dozen times. So this patch adds two macros to lock
> and unlock multiple ww_mutex instances with the necessary deadlock handling.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/linux/ww_mutex.h | 75 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index 3af7c0e03be5..a0d893b5b114 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -369,4 +369,79 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>  	return mutex_is_locked(&lock->base);
>  }
>  
> +/**
> + * ww_mutex_unlock_for_each - cleanup after error or contention
> + * @loop: for loop code fragment iterating over all the locks
> + * @pos: code fragment returning the currently handled lock
> + * @contended: the last contended ww_mutex or NULL or ERR_PTR
> + *
> + * Helper to make cleanup after error or lock contention easier.
> + * First unlock the last contended lock and then all other locked ones.
> + */
> +#define ww_mutex_unlock_for_each(loop, pos, contended)	\
> +	if (!IS_ERR(contended)) {			\
> +		if (contended)				\
> +			ww_mutex_unlock(contended);	\
> +		contended = (pos);			\
> +		loop {					\
> +			if (contended == (pos))		\
> +				break;			\
> +			ww_mutex_unlock(pos);		\
> +		}					\
> +	}
> +
> +/**
> + * ww_mutex_lock_for_each - implement ww_mutex deadlock handling
> + * @loop: for loop code fragment iterating over all the locks
> + * @pos: code fragment returning the currently handled lock
> + * @contended: ww_mutex pointer variable for state handling
> + * @ret: int variable to store the return value of ww_mutex_lock()
> + * @intr: If true ww_mutex_lock_interruptible() is used
> + * @ctx: ww_acquire_ctx pointer for the locking
> + *
> + * This macro implements the necessary logic to lock multiple ww_mutex
> + * instances. Lock contention with backoff and re-locking is handled by the
> + * macro so that the loop body only need to handle other errors and
> + * successfully acquired locks.
> + *
> + * With the @loop and @pos code fragment it is possible to apply this logic
> + * to all kind of containers (array, list, tree, etc...) holding multiple
> + * ww_mutex instances.
> + *
> + * @contended is used to hold the current state we are in. -ENOENT is used to
> + * signal that we are just starting the handling. -EDEADLK means that the
> + * current position is contended and we need to restart the loop after locking
> + * it. NULL means that there is no contention to be handled. Any other value is
> + * the last contended ww_mutex.
> + */
> +#define ww_mutex_lock_for_each(loop, pos, contended, ret, intr, ctx)	\
> +	for (contended = ERR_PTR(-ENOENT); ({				\
> +		__label__ relock, next;					\
> +		ret = -ENOENT;						\
> +		if (contended == ERR_PTR(-ENOENT))			\
> +			contended = NULL;				\
> +		else if (contended == ERR_PTR(-EDEADLK))		\
> +			contended = (pos);				\
> +		else							\
> +			goto next;					\
> +		loop {							\
> +			if (contended == (pos))	{			\
> +				contended = NULL;			\
> +				continue;				\
> +			}						\
> +relock:									\
> +			ret = !(intr) ? ww_mutex_lock(pos, ctx) :	\
> +				ww_mutex_lock_interruptible(pos, ctx);	\
> +			if (ret == -EDEADLK) {				\
> +				ww_mutex_unlock_for_each(loop, pos,	\
> +							 contended);	\
> +				contended = ERR_PTR(-EDEADLK);		\
> +				goto relock;				\
> +			}						\
> +			break;						\
> +next:									\
> +			continue;					\
> +		}							\
> +	}), ret != -ENOENT;)
> +

Yea gawds, that's eyebleeding bad, even for macros :/

It also breaks with pretty much all other *for_each*() macros in
existence by not actually including the loop itself but farming that out
to an argument statement (@loop), suggesting these really should not be
called for_each.


