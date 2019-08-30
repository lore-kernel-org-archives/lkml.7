Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC565C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4B521897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZNTTPb+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfH3HfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:35:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3HfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jXZGykbK7fcCFdm1k42aGJ6dco0WwRrRvnakPuLcX6w=; b=ZNTTPb+CmszhANgH38A+BIutb
        DGT0soGfqg7qc/3wBwW5h/uOhVDqhow5wdji0O2TtcGJvv0Uv1Y1wuGw6VHzxfIks3NqcjV9TS7uU
        GlVg6rYQlQ4YAdUyDUkRQmd8NQScZEAq9fKwu+4gCbGMbFAB04+oERcrtgxdJnJBhGXWgipCuGkmB
        o+JTZSu4pX1TOareK5mhUWSsqDvNIrWqjZJ9f11XYwrL5bIpYbQAxDqKHpQVcy4+oJuMXZGouKZYc
        Uy4aHE3Ps0bCPKBtuJFFsYF1SlE5TK47C13mglAmAkgimI9IUo/zr9WOb++Bz5GyYVQ6Tp197x3M8
        QYGf1iQyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3bQq-0008GY-7i; Fri, 30 Aug 2019 07:34:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3673030008D;
        Fri, 30 Aug 2019 09:34:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D4F1202411AD; Fri, 30 Aug 2019 09:34:48 +0200 (CEST)
Date:   Fri, 30 Aug 2019 09:34:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20190830073448.GZ2369@hirez.programming.kicks-ass.net>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-2-namhyung@kernel.org>
 <20190828094459.GG2369@hirez.programming.kicks-ass.net>
 <CAM9d7cja=jh9ASa4ffCca34AHcB-aRkyWj9hAQbEoQf8qOcg9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cja=jh9ASa4ffCca34AHcB-aRkyWj9hAQbEoQf8qOcg9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:46:51PM +0900, Namhyung Kim wrote:
> Hi Peter,
> 
> On Wed, Aug 28, 2019 at 6:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> > > To support cgroup tracking, add CGROUP event to save a link between
> > > cgroup path and inode number.  The attr.cgroup bit was also added to
> > > enable cgroup tracking from userspace.
> > >
> > > This event will be generated when a new cgroup becomes active.
> > > Userspace might need to synthesize those events for existing cgroups.
> > >
> > > As aux_output change is also going on, I just added the bit here as
> > > well to remove possible conflicts later.
> >
> > Why do we want this?
> 
> I saw below [1] and thought you have the patch introduced aux_output
> and it's gonna to be merged soon.
> Also the tooling patches are already in the acme/perf/core
> so I just wanted to avoid conflicts.
> 
> Anyway, I'm ok with changing it.  Will remove in v2.

I seem to have confused both you and Arnaldo with this. This email
questions the Changelog as a whole, not just the aux thing (I send a
separate email for that).

This Changelog utterly fails to explain to me _why_ we need/want cgroup
tracking. So why do I want to review and possibly merge this? Changelog
needs to answer this.
