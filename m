Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B530C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58032213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h9lhySCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCSVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:00:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCSVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SsHLgtv2tYTObwwyC6qG+Qh49rThPaG6hGq1pZpjEfI=; b=h9lhySCSbvJtjaKQ17GSxzZXh
        JMbsgqsBoYOOQMnStPqPpuqpDwMpi5y+NBg4Cmg4vlnC5UZpezvbjKNq2VezKXeexQZCMZ5JDwM/u
        p4P1HWIUSWpWZtzIKHctOR6427ggauv6mOY+z7X0tZTwEI3J6EuX1pn0S/+akCbRlXV3Tvyi2pYNn
        4XK7g1Vl+aNt2XYX3gQmGDiQhNPC7pbdXbbQtF6KfzDGHmiTY8F8RV6+PLFZYjHo65i8khdtVS77L
        HR6hhJYKG+w/btEa05YENuxLe5ygX5k3ep/411lANSFwPMuJr0yABVIFBUTQoz7CU4VW5Z65BrtwC
        3wYV7zN1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6LqO-0008St-KG; Tue, 19 Mar 2019 21:00:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A91CD23CB6531; Tue, 19 Mar 2019 22:00:18 +0100 (CET)
Date:   Tue, 19 Mar 2019 22:00:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [RFC][PATCH 4/8] perf/x86: Remove PERF_X86_EVENT_COMMITTED
Message-ID: <20190319210018.GP5996@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.750219024@infradead.org>
 <CABPqkBQr4VbNQG9R9j8Di=6fSziUw1s_QLyE9L7nsMTdWd8GtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQr4VbNQG9R9j8Di=6fSziUw1s_QLyE9L7nsMTdWd8GtQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:48:18PM -0700, Stephane Eranian wrote:
> On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > For x86_pmu_commit_txn(), cpuc->n_events is updated, but we can
> > trivially compute the desired value with cpuc->n_txn -- the number of
> > events added in this transaction.
> >
> I suggest you put this explanation in the code so that it is easier to
> understand.

Right, I actually attempted writing that comment a few times but every
time it became a mess. I'll try again, because you're quite right, this
is a bit magical.

> > -               for (i = 0; i < n; i++) {
> > +               i = cpuc->n_events;
> > +               if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
> > +                       i -= cpuc->n_txn;
> > +
> > +               for (; i < n; i++) {
