Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13902C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D27233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6fmBKNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393064AbfHWItX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:49:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbfHWItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L/vkdcP05JWhGYT6635EGSEpeSPBO2zNysiTmrxCkEw=; b=B6fmBKNREv3wbYVEJbZKMQylr
        2QE8UM9F6/Eu480sbXo3kKT1SplNa1HQWh5VdAw1Ka1+0ZFxIqOGOK/ztOA+4XWWiO16yLgmfvCgr
        5jWDafwbqh+r4doQ1z9eNSBwZUQ590qOP6xjoRDsaRO/9+XsBOkgmtch16YsU48DjLXG6m8GxfXOa
        PaN1jnGH90cm4drdC3HyCDBY9PGmzmNeIhjN4RDEsnjl7Narv3X0ej9AzM6TWE2TdoC0B7LbQNVjV
        5FcaVV12fLFnfP4v4dR0/ZWhbV2MnChzI8s2cFVH/39hgE+ihzJUqdhlv15hHMaEQhq6ztLoAjZCT
        EkYmJapIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i15Fx-0007QZ-Ip; Fri, 23 Aug 2019 08:49:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69D73307510;
        Fri, 23 Aug 2019 10:48:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCFF620A21FD2; Fri, 23 Aug 2019 10:49:11 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:49:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] lockdep: add might_lock_nested()
Message-ID: <20190823084911.GE2369@hirez.programming.kicks-ass.net>
References: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
 <20190820081951.25053-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820081951.25053-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:19:50AM +0200, Daniel Vetter wrote:
> Necessary to annotate functions where we might acquire a
> mutex_lock_nested() or similar. Needed by i915.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/lockdep.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 38ea6178df7d..30f6172d6889 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -631,6 +631,13 @@ do {									\
>  	lock_acquire(&(lock)->dep_map, 0, 0, 1, 1, NULL, _THIS_IP_);	\
>  	lock_release(&(lock)->dep_map, 0, _THIS_IP_);			\
>  } while (0)
> +# define might_lock_nested(lock, subclass) 				\
> +do {									\
> +	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
> +	lock_acquire(&(lock)->dep_map, subclass, 0, 1, 1, NULL,		\
> +		     _THIS_IP_);					\
> +	lock_release(&(lock)->dep_map, 0, _THIS_IP_);		\
> +} while (0)
>  
>  #define lockdep_assert_irqs_enabled()	do {				\
>  		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> @@ -653,6 +660,7 @@ do {									\
>  #else
>  # define might_lock(lock) do { } while (0)
>  # define might_lock_read(lock) do { } while (0)
> +# define might_lock_nested(lock, subclass) do { } while (0)
>  # define lockdep_assert_irqs_enabled() do { } while (0)
>  # define lockdep_assert_irqs_disabled() do { } while (0)
>  # define lockdep_assert_in_irq() do { } while (0)
> -- 
> 2.23.0.rc1
> 
