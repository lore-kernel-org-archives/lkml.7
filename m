Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E607C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45D920665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C4tiwGrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfFXUiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:38:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfFXUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g9Kc3M2XzlQsZ42pdKJZfNvaMS17HAF5866mWARfI/o=; b=C4tiwGrXnLH5PWKVQIib3u+KFc
        W5jwlPiBbllr/NclCmfYVLP7R/ZAatW3vEOhbPegDRc9DE1z5QHUTJmz2Ks2+vEn716E3c+pF7cZR
        IH/OV8B6YT9P62899SDtdD1zUrkrpRzsSsbfdHE9cGrFlOBF9uCdskldE+rfVC5zS7AhdeufZ7ZbN
        dWgnylmEZvTvVT/kH3L9vryIUR+XYFGc6AT6j3pcWvbcdCSY2MGT5vfrgOq/9JjQKJLjAUhYDmukx
        ZSb8EYfFmW6/F/Y4A3T4NoiUtsJ/aeoY1G/PTm7audTmOOievOdGj/cOovypfakVqI2L49gQl7IeO
        RJO2Lngg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfVid-0003d0-JG; Mon, 24 Jun 2019 20:37:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DCBF20A5CE80; Mon, 24 Jun 2019 22:37:37 +0200 (CEST)
Date:   Mon, 24 Jun 2019 22:37:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190624203737.GL3436@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:45:54PM -0700, Joe Perches wrote:
> On Mon, 2019-06-24 at 21:31 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 24, 2019 at 11:19:13AM -0500, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > cases where we are expecting to fall through.
> > > 
> > > This patch fixes the following warnings:
> > > 
> > > arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
> > > arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    pmem = true;
> > >    ~~~~~^~~~~~
> > > arch/x86/events/intel/core.c:4960:2: note: here
> > >   case INTEL_FAM6_SKYLAKE_MOBILE:
> > >   ^~~~
> > > arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    pmem = true;
> > >    ~~~~~^~~~~~
> > > arch/x86/events/intel/core.c:5009:2: note: here
> > >   case INTEL_FAM6_ICELAKE_MOBILE:
> > >   ^~~~
> > > 
> > > Warning level 3 was used: -Wimplicit-fallthrough=3
> > > 
> > > This patch is part of the ongoing efforts to enable
> > > -Wimplicit-fallthrough.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > I still consider it an abomination that the C parser looks at comments
> > -- other than to delete them, but OK I suppose, I'll take it.
> 
> I still believe Arnaldo's/Miguel's/Shawn's/my et al. suggestion of
> 
> #define __fallthrough __attribute__((fallthrough))
> 
> is far better.
> 
> https://lkml.org/lkml/2017/2/9/845
> https://lkml.org/lkml/2017/2/10/485
> https://lore.kernel.org/lkml/20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com/
> https://lore.kernel.org/lkml/20190617155643.GA32544@amd/

Oh yes, worlds better. Please, can we haz that instead?
