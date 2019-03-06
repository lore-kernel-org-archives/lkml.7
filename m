Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6787EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CFC20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xv0M1+nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfCFQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:58:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCFQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Daoa5W1kY+eBrvLFATCAUtuqAOrV6WLhDnSOpJs+YPI=; b=xv0M1+nrrSu7k5Mo05NVEgL9/
        kT4xFZ3Ep3V9S/xn5mAvELAbckbjcru/R5AFSzl0bXygAZz3kFVEuZmlAOIxtXAhnzbmMtkUP0W6Y
        Q1yYaB4ZJnRWbfTgmyy2c6YE0YmRnVHftnIeXkuizSb4ne/Tg46aLB58/SHLhqxkINJatgwJ2MJrP
        bxbplBS6y9k7VdcyvvewGtWf9iKV9W+ofBPhe7hFFvZURE4KCg6oNXF+qgWMyeZsv1o+M4ITmLtxV
        Vxe58KN3NYoszX/Au4CAcly9TtB6X3F7KPS4dxSpVrnpccPDN9LawNqWfYmqnKdgS72AU6f74HOwU
        kTDWe01+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1ZsG-0004Av-Lm; Wed, 06 Mar 2019 16:58:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7263B20316505; Wed,  6 Mar 2019 17:58:31 +0100 (CET)
Date:   Wed, 6 Mar 2019 17:58:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190306165831.GZ32477@hirez.programming.kicks-ass.net>
References: <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <20190226150450.GW32477@hirez.programming.kicks-ass.net>
 <ab631777-7cbd-4658-fb99-05d60ec5a1ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab631777-7cbd-4658-fb99-05d60ec5a1ea@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:46:05AM +0900, Akira Yokosawa wrote:
> So, I'm looking at the macro RELOC_HIDE() defined in include/linux/compiler-gcc.h.

> Am I the only one who was not aware of this gcc-specific macro?

It's one I regularly see, but had forgotten about in this context.

However; you can also fix things by adding asm volatile ("":::"memory");
in places.

But that's not really the point; I would really rather have a cmdline
knob to fix things. That way we can compile the kernel with and without
and look for differences. -fno-unicorns or something :-)

While I understand some compiler people revel in UB and love to make
unicorns happen, I think in this case the produces result is utterly
insane.
