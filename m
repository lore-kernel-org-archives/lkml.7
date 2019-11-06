Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746AC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DAB2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MxTz7+SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfKFJPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:15:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lP3B/Vo/I9QdPeICg8iLU3blMa8/4rNF6jQ70MKhNEE=; b=MxTz7+SYoIl9TfF4qivxyCl8M
        13eawyPsRgqgr/jFGPKK7kvfBToC+PEGon12F+fceZjh3hZqWgxuYjY8eGJS5tLVYWzoGPJKu8N3V
        b8IzbFgK5H4WZFk5C6VGtuUs+s0huTanouG2bVxauYEEbYDReru7jPpeOkUwTyWUfDNWxMZW3ALwl
        Muh2K0VHSDAm74aX8qeBwZELXqXbwbMIMEHPSnRQl7JsBJjDSD/Xo+UhUwTsD9bqn9VxMUSPgOxah
        pVnp5Mr5zbTUvy1Ob2LeAtgB7UFpUd3uLAQMCqXrLz9+7g3tzi1qxwyvRg2x5iXZCSIdNgDtQACo8
        TMJiLUOFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSHP2-0008Eo-Tw; Wed, 06 Nov 2019 09:15:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF546301A79;
        Wed,  6 Nov 2019 10:13:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0364029A4C2C5; Wed,  6 Nov 2019 10:14:58 +0100 (CET)
Date:   Wed, 6 Nov 2019 10:14:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Message-ID: <20191106091458.GS4131@hirez.programming.kicks-ass.net>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
 <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
 <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
 <20191105201623.GG3079@worktop.programming.kicks-ass.net>
 <23D48724-55B7-45A3-A77A-56BAD57937F9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23D48724-55B7-45A3-A77A-56BAD57937F9@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:06:06PM +0000, Song Liu wrote:
> 
> 
> > On Nov 5, 2019, at 12:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, Nov 05, 2019 at 05:11:08PM +0000, Song Liu wrote:
> > 
> >>> I think we can use one of the event as master. We need to be careful when
> >>> the master event is removed, but it should be doable. Let me try. 
> >> 
> >> Actually, there is a bigger issue when we use one event as the master: what
> >> shall we do if the master event is not running? Say it is an cgroup event, 
> >> and the cgroup is not running on this cpu. An extra master (and all these
> >> array hacks) help us get O(1) complexity in such scenario. 
> >> 
> >> Do you have suggestions on how to solve this problem? Maybe we can keep the 
> >> extra master, and try get rid of the double alloc? 
> > 
> > Right, you have to consider scope when sharing. The master should be the
> > largest scope event and any slaves should be complete subsets.
> > 
> > Without much thought this seems a fairly straight forward constraint;
> > that is, given cgroups I'm not immediately seeing how we can violate
> > that.
> > 
> > Basically, pick the cgroup event nearest to the root as the master.
> > We have to have logic to re-elect the master anyway for deletion, so
> > changing it on add shouldn't be different.
> > 
> > (obviously the root-cgroup is cpu-wide and always on, and if you have
> > two events from disjoint subtrees they have no overlap, so it doesn't
> > make sense to share anyway)
> 
> Hmm... I didn't think about cgroup structure with this much detail. And 
> this is very interesting idea. 
> 
> OTOH, non-cgroup event could also be inactive. For example, when we have 
> to rotate events, we may schedule slave before master. 

Right, although I suppose in that case you can do what you did in your
patch here. If someone did IOC_DISABLE on the master, we'd have to
re-elect a master -- obviously (and IOC_ENABLE).

> And if the master is in an event group, it will be more complicated...

Hurmph, do you actually have that use-case? And yes, this one is tricky.

Would it be sufficient if we disallow group events to be master (but
allow them to be slaves) ?

> Currently, we already have two separate scopes in sharing: one for cpu_ctx, 
> the other for task_ctx. I would like to enable as much sharing as possible
> with in each ctx. 

Right, although at plumbers you mentioned the idea of sticking
per-task-per-cpu events on the cpu context (as opposed on the task
context where they live today), which is interesting (it's basically an
extention of the cgroup scheduling to per-task scope).
