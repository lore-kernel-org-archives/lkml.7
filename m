Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A918720645
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZ0cvBhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfCOQ3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:29:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfCOQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6NCNx+aXeeCLMExDDZ5FoIOlHmU2VL9ClcIKwb1QWLU=; b=MZ0cvBhkjEPFQ8x0Fn9vXJHTP
        lFBza9x4qU4VczcR4YkIROT68WD+5r5Tdh7sbYFaalR/0C8eTyhkDVIrYN7uNjwBbRaOs87T1TSvu
        toz2ZSeu5TtjksF8YctY3OaLbbOhRWay6FPJAbnGfMBJy7OM6RiP256a+JdGkOnxO/GSz6moI/9lI
        w78NJ7EXbuuZKs72R75RjO/0O6vkgSdWPU9Pr1ueeRvkRmYAsfr1i0q/SiFBNvsoyHPxHfR3AoxAH
        czr6WJonpANeZmQZvaEJSGpi+SIWBO/qlBuOOMjcuTX4Ml1dXf4kdOSGj/oMnsOAVvc5dc8v4vnUb
        mNXlYUPaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4phq-00073j-02; Fri, 15 Mar 2019 16:29:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73057239158BA; Fri, 15 Mar 2019 17:29:11 +0100 (CET)
Date:   Fri, 15 Mar 2019 17:29:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/fair: Limit sched_cfs_period_timer loop to avoid
 hard lockup
Message-ID: <20190315162911.GA5996@hirez.programming.kicks-ass.net>
References: <20190313150826.16862-1-pauld@redhat.com>
 <20190315101150.GV5996@hirez.programming.kicks-ass.net>
 <20190315133042.GB27131@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315133042.GB27131@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 09:30:42AM -0400, Phil Auld wrote:
> On Fri, Mar 15, 2019 at 11:11:50AM +0100 Peter Zijlstra wrote:

> > Computers _suck_ at /100. And since you're free to pick the constant,
> > pick a power of two, computers love those.
> > 
> 
> Fair enough, I was thinking percents. And also that once we get in
> here it's not a really hot path.

I've seen people say that before; but that's not something I can relate
to. The basic idea is fractions.

