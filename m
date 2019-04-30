Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1526420652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qo6Zu4jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfD3JIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:08:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfD3JIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5LeyePv8boWGcH4KPGrx7rqnJWTC/Vl0CKf2NuqyLI8=; b=Qo6Zu4jpmkDm5c67d3gJCncnv
        dfxtBDWJrG072fpTqWkGIC4aLX9FPl1sK0f3S219gUZ2vk/uTd0kVsOWgbb5TSp7JIGXqiRlYiibe
        ct8k/y15Iv09qhXpi8y6yKbvw9EKcIIz5+EdZ/ZPiUMuK2zecOndehWNm6CnEkScnGJJeCwOKHh2X
        XBOy7fhGdQINSS9CbIog5f6z2+A8RFJCs9PlqOntOQDxmvOXZSyeES7QEc5mU+I6WvdMEThgYpD6A
        Zzsr2Php3no4lb619xijC3FcOCy7X8D9iMItb0VgzFabGp5zcS8DfLwYa0OTYxSphzMPsueLr6Uzz
        71jxUs2TA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLOkr-0007nJ-Hd; Tue, 30 Apr 2019 09:08:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0707729AAD2A8; Tue, 30 Apr 2019 11:08:48 +0200 (CEST)
Date:   Tue, 30 Apr 2019 11:08:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     kan.liang@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, tj@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 3/4] perf cgroup: Add cgroup ID as a key of RB tree
Message-ID: <20190430090847.GM2623@hirez.programming.kicks-ass.net>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
 <CAP-5=fUKeyj=yFCBdeKgtTP=e8DYL_5zLi=gF9OeiOFquuD7YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUKeyj=yFCBdeKgtTP=e8DYL_5zLi=gF9OeiOFquuD7YQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Mon, Apr 29, 2019 at 04:02:33PM -0700, Ian Rogers wrote:
> This is very interesting. How does the code handle cgroup hierarchies?
> For example, if we have:
> 
> cgroup0 is the cgroup root
> cgroup1 whose parent is cgroup0
> cgroup2 whose parent is cgroup1
> 
> we have task0 running in cgroup0, task1 in cgroup1, task2 in cgroup2
> and then a perf command line like:
> perf stat -e cycles,cycles,cycles -G cgroup0,cgroup1,cgroup2 --no-merge sleep 10
> 
> we expected 3 cycles counts:
>  - for cgroup0 including task2, task1 and task0
>  - for cgroup1 including task2 and task1
>  - for cgroup2 just including task2
> 
> It looks as though:
> +       if (next && (next->cpu == event->cpu) && (next->cgrp_id ==
> event->cgrp_id))
> 
> will mean that events will only consider cgroups that directly match
> the cgroup of the event. Ie we'd get 3 cycles counts of:
>  - for cgroup0 just task0
>  - for cgroup1 just task1
>  - for cgroup2 just task2

Yeah, I think you're right; the proposed code doesn't capture the
hierarchy thing at all.
