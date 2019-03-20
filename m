Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0617C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3802184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YICuk7Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfCTNOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:14:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50662 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfCTNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Y9UJzgLCZfKamuHvPKJ/dcF8diQvlm9dYrIZuFqaMQ=; b=YICuk7Zveju1OZnRt7qLn+i2u
        JtrQ6jW7YsvAlfpy+hMD8iwn+t+GLrF/xhAd/7KsAIdTLygNS59njk4489XmSIITPfej9uloqShkY
        gw4C0mrjMFwxlwkGQVu6dOXuxxVldx9+HIuSMQ52dj+eK5buCSLJnSgo6DiSzN62T29tBQ1jsS0VE
        2Nv0XlwUYuEPWWuGYMS7MyrQ4ddLq1rK8xr7jDMckbiIklZeYhf7m55A74QXoR13rBUJllUO3vdar
        vtx28CNHlB00aeim3GRwTR6Rx/RI6O6n42emrZOp9FXRHDP0eyKECt4D1rq/jt8dFqSgTx4T8hiMR
        xhBqfJqnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6b3C-0002su-8s; Wed, 20 Mar 2019 13:14:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 094312391A9C7; Wed, 20 Mar 2019 14:14:33 +0100 (CET)
Date:   Wed, 20 Mar 2019 14:14:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [RFC][PATCH 4/8] perf/x86: Remove PERF_X86_EVENT_COMMITTED
Message-ID: <20190320131432.GK6521@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.750219024@infradead.org>
 <CABPqkBQr4VbNQG9R9j8Di=6fSziUw1s_QLyE9L7nsMTdWd8GtQ@mail.gmail.com>
 <20190319210018.GP5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319210018.GP5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:00:18PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 19, 2019 at 01:48:18PM -0700, Stephane Eranian wrote:
> > On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > For x86_pmu_commit_txn(), cpuc->n_events is updated, but we can
> > > trivially compute the desired value with cpuc->n_txn -- the number of
> > > events added in this transaction.
> > >
> > I suggest you put this explanation in the code so that it is easier to
> > understand.
> 
> Right, I actually attempted writing that comment a few times but every
> time it became a mess. I'll try again, because you're quite right, this
> is a bit magical.

Ha! I found the comment, it's in patch 8 :-)
