Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28ACC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F1F212F5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n6gLvJ4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfDYNbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:31:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDYNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JagkmGQThoio8nzTcPyiVBlqYMqMnTmLSHWAxIWzKgU=; b=n6gLvJ4++JvnAx6DJBMO5bl6BS
        TbBJVre4l2dFpW1DoTFhDsvNgw2R55OYdzlaYCvM0XH44PXznoxEnjzAINhl9cXfe6QEAEuR8LIL+
        yDeeI5/H33d+g67zX7g9ZANOlZZQVB+PtQ0elsQkbdTZmzAUXruZ7X7ViAtIM2484236bmyAO/A4V
        ENM0tmdqnjhLr1kSkWczLRaYknkJerf9mo++6TimDCPQbBJb23Id3uXUujzUwZdZfhyapvQlKzDpS
        fYpifsz1uUNUvYy9YBs3IaQ8/67b2iUpMErDXNTejZnPfdo+J5csKfyxNcJLInwyxgx4Z19IDKHc5
        oPdhP9fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJeSy-0006CO-B1; Thu, 25 Apr 2019 13:31:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D879729C42EE3; Thu, 25 Apr 2019 15:31:05 +0200 (CEST)
Date:   Thu, 25 Apr 2019 15:31:05 +0200
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
Subject: Re: Re: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb()
 wreckage
Message-ID: <20190425133105.GV4038@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
 <5b13fd3b.c031.16a54452744.Coremail.huangpei@loongson.cn>
 <20190425122611.GT4038@hirez.programming.kicks-ass.net>
 <2ff11adc.c051.16a548cd90c.Coremail.huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ff11adc.c051.16a548cd90c.Coremail.huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:51:17PM +0800, huangpei@loongson.cn wrote:

> > So basically the initial value of @v is set to 1.
> > 
> > Then CPU-1 does atomic_add_unless(v, 1, 0)
> >      CPU-2 does atomic_set(v, 0)
> > 
> > If CPU1 goes first, it will see 1, which is not 0 and thus add 1 to 1
> > and obtains 2. Then CPU2 goes and writes 0, so the exist clause sees
> > v==0 and doesn't observe 2.
> > 
> > The other way around, CPU-2 goes first, writes a 0, then CPU-1 goes and
> > observes the 0, finds it matches 0 and doesn't add.  Again, the exist
> > clause will find 0 doesn't match 2.
> > 
> > This all goes unstuck if interleaved like:
> > 
> > 
> > 	CPU-1			CPU-2
> > 
> > 				xor	t0, t0
> > 1:	ll	t0, v
> > 	bez	t0, 2f
> > 				sw	t0, v
> > 	add	t0, t1
> > 	sc	t0, v
> > 	beqz t0, 1b
> > 
> > (sorry if I got the MIPS asm wrong; it's not something I normally write)
> > 
> > And the store-word from CPU-2 doesn't make the SC from CPU-1 fail.
> > 
> 
> loongson's llsc bug DOES NOT fail this litmus( we will not get V=2)；
> 
> only speculative memory access from CPU-1 can "blind" CPU-1(here blind means do ll/sc
>  wrong）, this speculative memory access can be observed corrently by CPU2. In this 
> case, sw from CPU-2 can get I , which can be observed by CPU-1, and clear llbit，then 
> failed sc. 

I'm not following, suppose CPU-1 happens as a speculation (imagine
whatever code is required to make that happen before). CPU-2 sw will
cause I on CPU-1's ll but, as in the previous email, CPU-1 will continue
as if it still has E and complete the SC.

That is; I'm just not seeing why this case would be different from two
competing LL/SCs.

