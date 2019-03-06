Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F441C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D01220663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wxHQHO6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfCFQsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:48:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbfCFQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oYLfeKDqsEd9TQdlvlkBmlhOzMiGam/M6Sb+u1913c4=; b=wxHQHO6sg5dByPaXmsK8i9EcQ
        T+FYGTM2E6WTJniU3+hbCP6Ao4ks9bOZMYgZIFKNWydoYu0FiUyZUyPm2AbBTLOYuz4nfWY+P2MTR
        Pv7cS1kiPNoUQuf1zn08xfzcgXNGy7nb4fUX6hLBYtMxTiCo2YJfPy/3+fnSVlj+zd4ypw8L+UkdO
        H8F4V6i7j9hDYHgZ0s4nle6Nx+rQlNpBLVs2aD++Vb30k543xtUcZjd8CumkOV7E9ozGtblsoxP6n
        /7ea2sKyJU5EQ2Miqbm+KvYj4E43tYYOlv/GzfJ+pHr3I/py845KsLtjQUGgJVZjw7/jhW+CCY1el
        ZmLXaFt3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1ZiV-000492-Uk; Wed, 06 Mar 2019 16:48:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 261DD2038D7DA; Wed,  6 Mar 2019 17:48:25 +0100 (CET)
Date:   Wed, 6 Mar 2019 17:48:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sched/core: check format and overflows in cgroup2 cpu.max
Message-ID: <20190306164825.GY32477@hirez.programming.kicks-ass.net>
References: <155125520155.293746.7017401430432481979.stgit@buzz>
 <20190305155741.GD50184@devbig004.ftw2.facebook.com>
 <4c0f1d90-b147-e1cd-20c1-0cdd869f4f15@yandex-team.ru>
 <20190306161154.GF50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306161154.GF50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:11:54AM -0800, Tejun Heo wrote:
> Hello, Konstantin.
> 
> On Tue, Mar 05, 2019 at 08:03:24PM +0300, Konstantin Khlebnikov wrote:
> > >Ditto as the blkio patch.  Unless there is a correctness problem, my
> > >preference is towards keeping the parsing functions simple and I don't
> > >think the kernel needs to play the role of strict input verifier here
> > >as long as the only foot getting shot is the user's own.
> > 
> > IMHO non-strict interface more likely hides bugs and could cause
> > problems for future changes.
> > 
> > Here is only only one fatal bug - buffer overflow in sscanf because
> > %s has no limit.
> 
> Ah, indeed.  Can you please post a patch to fix that problem first?
> 
> > Strict validation could be done as more strict sscanf variant or
> > some kind of extension for format string.
> 
> I don't necessarily disagree with you; however, what often ends up
> with these manually crafted parsing approach are 1. code which is
> unnecessarily difficult to follow 2. different subset of validations
> and parsing bugs (of course) everywhere.
> 
> Given the above, I tend to lean towards dump sscanf() parsing.  If we
> wanna improve the situation, I think the right thing to do is either
> improving sscanf or introducing new helpers to parse these things
> rather than hand-crafting each site.  It is really error-prone.

Always use a field width specifier with %s.  Which is exactly what the
proposed patch did IIRC.

Maybe that's something checkpatch could warn about.

