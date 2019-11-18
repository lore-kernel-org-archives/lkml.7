Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FDEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28852206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HCSLdVCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKRIhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:37:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfKRIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7gdu4QtSwTVYGFr0DEQzTVwl9le/XW1hhgMrsqBvhbI=; b=HCSLdVCHt8vRSSMe6c7sRBRxI
        wZ2rRjE0dW9TiqXvPq+imrBnPnOdD1mGS1Hkh7LWnnwtRS1JU8sqqwTkHx4wRKNFDlk/gBGGfWAIj
        OXGMBmNZlOigeaIRFDTRIhAwIxnIb4GbKu+phKRrL2dVfV8/7jaJbDWgZKCHCFz4D3UMlNI+1+AlY
        rizC2nn24w6YNL+LJznkq5AJte+u63qjfFotokN13MWsARWeAz7vNH1JbbKJEQvv3BP8/fnmowZ5x
        kGvgJIBlnwALxct1pHe6Bbc79Djj0vws0ulBJRiwujGJPPDXq2XDkDZVolVEo5+D0eXYLX9dKHx2D
        G/j5iig4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWcXQ-0006F3-RK; Mon, 18 Nov 2019 08:37:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81BD13011FE;
        Mon, 18 Nov 2019 09:36:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5B0F2B133323; Mon, 18 Nov 2019 09:37:33 +0100 (CET)
Date:   Mon, 18 Nov 2019 09:37:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 08/10] perf: cache perf_event_groups_first for cgroups
Message-ID: <20191118083733.GT4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-9-irogers@google.com>
 <20191114102544.GS4131@hirez.programming.kicks-ass.net>
 <CAP-5=fUpwG833vooezqyYpKQdJ1k-RN=2E0fPHG3832h9qECLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUpwG833vooezqyYpKQdJ1k-RN=2E0fPHG3832h9qECLQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 05:20:52PM -0800, Ian Rogers wrote:
> On Thu, Nov 14, 2019 at 2:25 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > > @@ -1706,18 +1738,10 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
> > >                       continue;
> > >               }
> > >  #ifdef CONFIG_CGROUP_PERF
> > > -             node_cgrp_id = 0;
> > > -             if (node_event->cgrp && node_event->cgrp->css.cgroup)
> > > -                     node_cgrp_id = node_event->cgrp->css.cgroup->id;
> > > -
> > > -             if (cgrp_id < node_cgrp_id) {
> > > +             if (node_event->cgrp) {
> > >                       node = node->rb_left;
> > >                       continue;
> > >               }
> > > -             if (cgrp_id > node_cgrp_id) {
> > > -                     node = node->rb_right;
> > > -                     continue;
> > > -             }
> > >  #endif
> > >               match = node_event;
> > >               node = node->rb_left;
> >
> > Also, just leave that in and let callers have: .cgrp = NULL. Then you
> > can forgo that monstrous name.
> 
> Done. It is a shame that there is some extra logic for the task/no-cgroup case.

Yes, OTOH the primitive is consistent and more generic and possibly the
compiler will notice and fix it for us, it is a static function after
all, so it can be more agressive.
