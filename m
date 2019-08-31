Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A87C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290AE23697
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 09:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uu5mdBXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfHaJBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 05:01:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36954 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfHaJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xewVdUf11AxABQouRLx2CEX2BTZyyYycBHtYuCXEbi0=; b=Uu5mdBXkqKUK/Ypcu6rC0Qk+u
        byBFetK6ZHj2DMTkbYDtyid4TNew0hBVlqJ6re++7zza3ijqLPq3YUur3QpLsbZ7t4VlTqfIjRFYX
        ttY33DLlPd//YziDDT2S/2cPbYAE1jYRdEVGiVraLR2ljyvhSZ8Zzdsw/rgg0DXSuHm2aZPirlZNi
        OoRtHP+6HSqGHx4BjWDXbi3fMKkgX991I3//IRvjj2C1p/yg32s0eK25AK27XpKT1pPAkSd64eA3E
        gRHmAsjAoDdzUXFENvTTwv9M2BV8OOKwAXNo0YZ+kZ1CJkffHvnRVUb0Rqm7IugLIQ8dsOZEKRe/A
        FPgvHEwlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3zFk-0007T8-3v; Sat, 31 Aug 2019 09:01:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AF71301747;
        Sat, 31 Aug 2019 11:00:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 017BD29B2CD09; Sat, 31 Aug 2019 11:00:55 +0200 (CEST)
Date:   Sat, 31 Aug 2019 11:00:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     stern@rowland.harvard.edu, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com, paulmck@linux.ibm.com,
        will.deacon@arm.com, paul.burton@mips.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
Message-ID: <20190831090055.GH2369@hirez.programming.kicks-ass.net>
References: <20190613134317.734881240@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613134317.734881240@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:43:17PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> This all started when Andrea Parri found a 'surprising' behaviour for x86:
> 
>   http://lkml.kernel.org/r/20190418125412.GA10817@andrea
> 
> Basically we fail for:
> 
> 	*x = 1;
> 	atomic_inc(u);
> 	smp_mb__after_atomic();
> 	r0 = *y;
> 
> Because, while the atomic_inc() implies memory order, it
> (surprisingly) does not provide a compiler barrier. This then allows
> the compiler to re-order like so:
> 
> 	atomic_inc(u);
> 	*x = 1;
> 	smp_mb__after_atomic();
> 	r0 = *y;
> 
> Which the CPU is then allowed to re-order (under TSO rules) like:
> 
> 	atomic_inc(u);
> 	r0 = *y;
> 	*x = 1;
> 
> And this very much was not intended.
> 
> This had me audit all the (strong) architectures that had weak
> smp_mb__{before,after}_atomic: ia64, mips, sparc, s390, x86, xtensa.
> 
> Of those, only x86 and mips were affected. Looking at MIPS to solve this, led
> to the other MIPS patches.
> 
> All these patches have been through 0day for quite a while.
> 
> Paul, how do you want to route the MIPS bits?

Paul; afaict the MIPS patches still apply (ie. they've not made their
way into Linus' tree yet).

I thought you were going to take them?
