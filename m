Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5F5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9152620869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RerFe7f5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDLSV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:21:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLSV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kcg5V+LAV9+yv2o0tC140/vTCQou+OvG3Wvba+qMni0=; b=RerFe7f5xJiIOO8oGWKQ2Hzn8
        N1KEusOfC9r7/dUt1eMWqHrdfCwfQACHHFz+YjFQ5pvWBs7bfRH1xKFA5lBaL9wnmqHZ0vwuoZqLs
        YSHHAKBlZ+HqCZaK/G77N/SH0H3VzdT6GN6CyacPYAZvqd+4Y3VR+XZxf3fXhBFjUlfQt2xiftE4P
        2CiElNXvXi4AcwwrcTV6h1U8Rrjv8xkE7BHgur+u1im33RoPG3mci5u4ueUOoX1Bjq08TY7O9UqZy
        MxXkxlhsE5chW3GMjL+dG4K+gaLx2nnPBeWQ4qdTENLPCgS5ZwcjfxMgQtd+06BgKqpgF7Dwz3Gbp
        BuRq6jQwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF0ng-0003R1-EC; Fri, 12 Apr 2019 18:21:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3073929B23301; Fri, 12 Apr 2019 20:21:19 +0200 (CEST)
Date:   Fri, 12 Apr 2019 20:21:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Message-ID: <20190412182119.GE12232@hirez.programming.kicks-ass.net>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-3-longman@redhat.com>
 <20190411081224.GB4038@hirez.programming.kicks-ass.net>
 <29aca54a-536e-6e46-7e18-658914c34548@redhat.com>
 <20190412070209.GC129493@gmail.com>
 <20190412070545.GF11158@hirez.programming.kicks-ass.net>
 <20190412070904.GA45214@gmail.com>
 <b97eb5d5-1658-c405-e52e-2d20c4840948@redhat.com>
 <33b0111b-fe0f-eefc-59f4-f06d84d9cacc@redhat.com>
 <277e9c8e-8913-b251-4c98-dd2d4997d643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277e9c8e-8913-b251-4c98-dd2d4997d643@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 10:22:20AM -0400, Waiman Long wrote:
> Oh, I see that the WIP.locking/core is currently merged into master. I
> would say rwsem part1 patchset and patch 1 of part2 are stable. So I
> would suggest merging those into the the master will be good. The rests
> are still under review until I get an OK from Peter. If they miss the
> next merge window and have to postpone to 5.3, I am fine with that.

What I do is revert that branch so I can prod at your patches myself.

But yes, I have part1 queued. It is part2 that I am still staring at,
although today got eaten by other 'fun'.
