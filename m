Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EBDC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15458208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F5cNLzX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfFNNAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:00:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38586 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfFNNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7Rkc9ajSUNPMuXn98fb5It4RT88rdAp6rskTXMxEeDk=; b=F5cNLzX/I1UeT10wmgoVl8klSo
        5MKQ3/rlIx9BOZI+BUJ0avnaotx4JNbgBohOtU8tyhdZyPPkLij26PMLfZeupmfzn6J9N35RjLYuW
        0n1IB8VpqOAo9EcpnCpIal0l/VoLGDwCrazMadHbucaLpLCVz3qzma/CQLAptSb/BJZoZ1OFN3nlt
        xf5f+jnnAas5sS7MqWZ7Z0cwtHtF0ZS/PByijZkIlUrHMKzBh6zf9eNRhBQJDmA6NCxRPl5cyDp5g
        ttLFMVtDBY+QZLFeEkbuBXmKciQe7neIHSnahaRNDLquXtZpOj/srkV78ujlroWebEP29ihE/TvZ5
        RmLUBgPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hblny-0007pX-2X; Fri, 14 Jun 2019 12:59:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80D3E2013F741; Fri, 14 Jun 2019 14:59:40 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:59:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, thellstrom@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, lima@lists.freedesktop.org
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
Message-ID: <20190614125940.GP3436@hirez.programming.kicks-ass.net>
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614124125.124181-4-christian.koenig@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:41:22PM +0200, Christian König wrote:
> Use the provided macros instead of implementing deadlock handling on our own.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 49 ++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 50de138c89e0..6e4623d3bee2 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1307,51 +1307,26 @@ int
>  drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
>  			  struct ww_acquire_ctx *acquire_ctx)
>  {
> -	int contended = -1;
> +	struct ww_mutex *contended;
>  	int i, ret;
>  
>  	ww_acquire_init(acquire_ctx, &reservation_ww_class);
>  
> -retry:
> -	if (contended != -1) {
> -		struct drm_gem_object *obj = objs[contended];
> -
> -		ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
> -						       acquire_ctx);
> -		if (ret) {
> -			ww_acquire_done(acquire_ctx);
> -			return ret;
> -		}
> -	}
> -
> -	for (i = 0; i < count; i++) {
> -		if (i == contended)
> -			continue;
> -
> -		ret = ww_mutex_lock_interruptible(&objs[i]->resv->lock,
> -						  acquire_ctx);
> -		if (ret) {
> -			int j;
> -
> -			for (j = 0; j < i; j++)
> -				ww_mutex_unlock(&objs[j]->resv->lock);
> -
> -			if (contended != -1 && contended >= i)
> -				ww_mutex_unlock(&objs[contended]->resv->lock);
> -
> -			if (ret == -EDEADLK) {
> -				contended = i;
> -				goto retry;

retry here, starts the whole locking loop.

> -			}
> -
> -			ww_acquire_done(acquire_ctx);
> -			return ret;
> -		}
> -	}

+#define ww_mutex_unlock_for_each(loop, pos, contended) \
+       if (!IS_ERR(contended)) {                       \
+               if (contended)                          \
+                       ww_mutex_unlock(contended);     \
+               contended = (pos);                      \
+               loop {                                  \
+                       if (contended == (pos))         \
+                               break;                  \
+                       ww_mutex_unlock(pos);           \
+               }                                       \
+       }
+

+#define ww_mutex_lock_for_each(loop, pos, contended, ret, intr, ctx)   \
+       for (contended = ERR_PTR(-ENOENT); ({                           \
+               __label__ relock, next;                                 \
+               ret = -ENOENT;                                          \
+               if (contended == ERR_PTR(-ENOENT))                      \
+                       contended = NULL;                               \
+               else if (contended == ERR_PTR(-EDEADLK))                \
+                       contended = (pos);                              \
+               else                                                    \
+                       goto next;                                      \
+               loop {                                                  \
+                       if (contended == (pos)) {                       \
+                               contended = NULL;                       \
+                               continue;                               \
+                       }                                               \
+relock:                                                                        \
+                       ret = !(intr) ? ww_mutex_lock(pos, ctx) :       \
+                               ww_mutex_lock_interruptible(pos, ctx);  \
+                       if (ret == -EDEADLK) {                          \
+                               ww_mutex_unlock_for_each(loop, pos,     \
+                                                        contended);    \
+                               contended = ERR_PTR(-EDEADLK);          \
+                               goto relock;                            \

while relock here continues where it left of and doesn't restart @loop.
Or am I reading this monstrosity the wrong way?

+                       }                                               \
+                       break;                                          \
+next:                                                                  \
+                       continue;                                       \
+               }                                                       \
+       }), ret != -ENOENT;)
+

> +	ww_mutex_lock_for_each(for (i = 0; i < count; i++),
> +			       &objs[i]->resv->lock, contended, ret, true,
> +			       acquire_ctx)
> +		if (ret)
> +			goto error;
>  
>  	ww_acquire_done(acquire_ctx);
>  
>  	return 0;
> +
> +error:
> +	ww_mutex_unlock_for_each(for (i = 0; i < count; i++),
> +				 &objs[i]->resv->lock, contended);
> +	ww_acquire_done(acquire_ctx);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_gem_lock_reservations);

