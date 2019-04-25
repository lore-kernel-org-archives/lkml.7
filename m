Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A5BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA09B217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVNVK6lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfDYHe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:34:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDYHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h67vG0bl/xud0pkDbwWxlwJcQ5+GKV0iRLlkLH6pnJU=; b=tVNVK6ljLmjwJn8v4OP0XDQ6q
        pwibaRzMjqzP7Q5Gemz2z/hy/UMYneC2oCbyREnySjVl9pDNt5xS/xdTHfGslnlOdEuAophF/aI2/
        OfzxVN59fkZ/2p+U9fHnohe+pJ47BOa37JQjGWnaTFntrdErLZ2fOjW7a3phJqG5eEqcT5E8LYs9l
        oNv9t3xri9tRgcVbm/P8OxtiW0DXAspr4WmBKxbw13LRpPgTH0Wz7GPi+O2oPNbtzNLFlRyz10BY8
        P1N9/himo61F2GusKQWHYSu4fTgd7kX7pXSKbBX1rzs/gBIJNCf3VfeES/cKW5/x4qnHzVZhDYXVB
        Sz9Hcncxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYu4-0000BE-Dv; Thu, 25 Apr 2019 07:34:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BACE220D0A200; Thu, 25 Apr 2019 09:34:42 +0200 (CEST)
Date:   Thu, 25 Apr 2019 09:34:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 4/5] mips/atomic: Fix smp_mb__{before,after}_atomic()
Message-ID: <20190425073442.GW11158@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.751367532@infradead.org>
 <20190424212422.bykvyho3jqw6jz6w@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424212422.bykvyho3jqw6jz6w@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:24:31PM +0000, Paul Burton wrote:
> Hi Peter,
> 
> On Wed, Apr 24, 2019 at 02:37:00PM +0200, Peter Zijlstra wrote:
> > --- a/arch/mips/include/asm/barrier.h
> > +++ b/arch/mips/include/asm/barrier.h
> > @@ -230,9 +238,6 @@
> >  #define nudge_writes() mb()
> >  #endif
> >  
> > -#define __smp_mb__before_atomic()	__smp_mb__before_llsc()
> > -#define __smp_mb__after_atomic()	smp_llsc_mb()
> > -
> >  /*
> >   * Some Loongson 3 CPUs have a bug wherein execution of a memory access (load,
> >   * store or pref) in between an ll & sc can cause the sc instruction to
> 
> I think this bit should be part of patch 3, where you currently add a
> second definition of these 2 macros.

Whoops, indeed.

> Otherwise this one looks reasonable to me.

Great, thanks!
