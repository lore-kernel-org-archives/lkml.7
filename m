Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524DDC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FFA20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fQ5dFKej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfHDOvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 10:51:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43228 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfHDOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 10:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P/zOwjyMDiKc1v+p6ZRShkdB95dG/e//ZfkvMl5MS6k=; b=fQ5dFKej4xq/uXyqVPRhDbpqO
        JKakj5ZDbulmYdas8afErzvQ14ng2iQhML5AylUqQ5YGMjBL0Lyaf1T4WDcAxVZ3S++TSCSxlZjdI
        +z4MIsjfZ8S32xhXyoB2AkCMc10JlIdNZhtFO71r7M7ERibwg6DZzsKj57cY0g+/HVzXBfdnOIJau
        o/LcoktysARDOgRfkCEFTNyy3oDb9+JIuvDa7FT7eAYjCaBCaC6idhPklWk4mV1zwqt3qCDEMOc6w
        F5sS94w6gmuimthekjWC8hYOWFjD5bJ3V+MVzsTWN4w5QghIf3eqjES0HZb4EbK5Gl1Erp8cJ4Tko
        ODLQ009Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huHqW-0007QM-RM; Sun, 04 Aug 2019 14:50:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 962A620274D79; Sun,  4 Aug 2019 16:50:51 +0200 (CEST)
Date:   Sun, 4 Aug 2019 16:50:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 01/14] rcu/nocb: Atomic ->len field in
 rcu_segcblist structure
Message-ID: <20190804145051.GG2349@hirez.programming.kicks-ass.net>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-1-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802151501.13069-1-paulmck@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:14:48AM -0700, Paul E. McKenney wrote:
> +/*
> + * Exchange the numeric length of the specified rcu_segcblist structure
> + * with the specified value.  This can cause the ->len field to disagree
> + * with the actual number of callbacks on the structure.  This exchange is
> + * fully ordered with respect to the callers accesses both before and after.
> + */
> +long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	return atomic_long_xchg(&rsclp->len, v);
> +#else
> +	long ret = rsclp->len;
> +
> +	smp_mb(); /* Up to the caller! */
> +	WRITE_ONCE(rsclp->len, v);
> +	smp_mb(); /* Up to the caller! */
> +	return ret;
> +#endif
> +}

That one's weird; for matching semantics the load needs to be between
the memory barriers.
