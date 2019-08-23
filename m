Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A94F22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CnMhbM30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405000AbfHWIuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:50:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36270 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbfHWIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wxFK1aA0wANvaZBFOZeC8vmeMYoAclgIu5T4D4G9HXQ=; b=CnMhbM30GaWTsXZGmRo6LbfVn
        Ygk8oEXFMbQJrjHRsVys7xjJznnhhiyAm+CJuRLiyNLXi9SSH2AH2BEU4WOOO1o+HjieCWYT5IVU7
        UjHMMhMUHjvb2306/QG19Tyzns9cyblu5PmRBKi1qgSIO1KjKzt/Y1u1S6XBDQTX5tzlkNPSZJM4F
        uu7eI8xJdEKgRIMViW6/9iQW7qamlk6L8o0zs/ucAg8Uo5EVpn4fsnn6/vThBJ77LM9oo1bgVxCMj
        8b39v7+8BGwwWuGNUBnsT7jAszMZnussiZeUsag/eo3qdcJQw5/wvkfJmr4SiQCP9rKSKcScuraif
        W4p7C5zfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i15Gg-0007R6-6x; Fri, 23 Aug 2019 08:49:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A2D1307510;
        Fri, 23 Aug 2019 10:49:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD24120B3358F; Fri, 23 Aug 2019 10:49:56 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:49:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] drm/i915: use might_lock_nested in get_pages
 annotation
Message-ID: <20190823084956.GF2369@hirez.programming.kicks-ass.net>
References: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
 <20190820081951.25053-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820081951.25053-3-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:19:51AM +0200, Daniel Vetter wrote:
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> index a0b1fa8a3224..b3fd6aac93bc 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> @@ -233,10 +233,26 @@ void __i915_gem_object_set_pages(struct drm_i915_gem_object *obj,
>  int ____i915_gem_object_get_pages(struct drm_i915_gem_object *obj);
>  int __i915_gem_object_get_pages(struct drm_i915_gem_object *obj);
>  
> +enum i915_mm_subclass { /* lockdep subclass for obj->mm.lock/struct_mutex */
> +	I915_MM_NORMAL = 0,
> +	/*
> +	 * Only used by struct_mutex, when called "recursively" from
> +	 * direct-reclaim-esque. Safe because there is only every one
> +	 * struct_mutex in the entire system. */
> +	I915_MM_SHRINKER = 1,
> +	/*
> +	 * Used for obj->mm.lock when allocating pages. Safe because the object
> +	 * isn't yet on any LRU, and therefore the shrinker can't deadlock on
> +	 * it. As soon as the object has pages, obj->mm.lock nests within
> +	 * fs_reclaim.
> +	 */
> +	I915_MM_GET_PAGES = 1,

Those comments are inconsistently styled; if you move them, might as
well fix that too :-)

> +};
> +
