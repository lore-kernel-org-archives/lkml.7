Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76A9C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758B6206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kLcR4jFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfDYHeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:34:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47714 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfDYHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YtZsY6i2xCXgiHs5ESM9B01vo1Wm1BqaMdwefo9q1IY=; b=kLcR4jFZEsAAzh9RjDF3H10nTs
        6XiPoyLnyN9ThnCwwkAfcl1sRmbf5UCtJTGIAVYvEmwWf83jF+nos28dtSqVyykcUQLKhEh2c1lP/
        tfy5SdBRhFzh2pl9Yp8tugM4ETF/ae+ZqMHt7uCBUB4GeZKa2CDLLpstoaoyQENrX42wH/kaTorOA
        UVApIiIsa2ey3z6wdNzQoj5cWxXgZ01UDkkJTN2OWfSvMXnkLLRzCtXOJH4QhAPeNBFMdgQOdZnw1
        fj+jKJisPs5pSCaO8g/OvRTVRCqHoV5bt5OsjWMx1FnmksbqASqPBDrUMREV+rG7eXSqjUxtcROVn
        IQL2v2Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJYtB-0000UY-Pf; Thu, 25 Apr 2019 07:33:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 796CD20D0A200; Thu, 25 Apr 2019 09:33:48 +0200 (CEST)
Date:   Thu, 25 Apr 2019 09:33:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     huangpei@loongson.cn
Cc:     Paul Burton <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
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
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Message-ID: <20190425073348.GV11158@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Thu, Apr 25, 2019 at 12:58:50PM +0800, huangpei@loongson.cn wrote:
> In my opinion. patch 2/3 is about Loongson's bug, and patch 4/5 is another theme.

Agreed; it's just that looking at the MIPS code to fix 4/5 made me trip
over this stuff.

> Let me explain the bug more specific:
> 
> the bug ONLY matters in following situation:
> 
> #. more than one cpu (assume cpu A and B) doing ll/sc on same shared
> var V
> 
> #. speculative memory access from A cause A erroneously succeed sc
> operation, since the erroneously successful sc operation violate the
> coherence protocol. (here coherence protocol means the rules that CPU
> follow to implement ll/sc right)
> 
> #. B succeed sc operation too, but this sc operation is right both
> logically and follow the coherence protocol, and makes A's sc wrong
> logically since only ONE sc operation can succeed.

(I know your coherence protocol is probably more complicated than MESI,
but bear with me)

So A speculatively gets V's line in Exclusive mode, speculates the Lock
flag is still there and completes the Store. This speculative store then
leaks out and violates MESI because there _should_ only be one Exclusive
owner of a line (B).

Something like that?

> If it is not LL/SC but other memory access from B on V, A's ll/sc can
> follow the atomic semantics even if A violate the coherence protocol
> in the same situation.

*shudder*...

  C atomic-set

  {
	  atomic_set(v, 1);
  }

  P1(atomic_t *v)
  {
	  atomic_add_unless(v, 1, 0);
  }

  P2(atomic_t *v)
  {
	  atomic_set(v, 0);
  }

  exists
  (v=2)

So that one will still work? (that is, v=2 is forbidden)

> In one word， the bug only affect local cpu‘s ll/sc operation, and
> affect MP system.

Because it is a coherence issue, triggered by a reorder. OK.

> PS:
> 
> If local_t is only ll/sc manipulated by current CPU， then no need fix it.

It _should_ be CPU local, but this was not at all clear from reading the
original changelog nor the comment with loongson_llsc_mb().
