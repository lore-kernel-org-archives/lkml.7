Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B026AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF532070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfH0HlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4787 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfH0HlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:41:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81D33C0718BD;
        Tue, 27 Aug 2019 07:41:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3655D9F73;
        Tue, 27 Aug 2019 07:41:06 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:41:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190827074105.GA23260@krava>
References: <20190825181752.722-1-jolsa@kernel.org>
 <20190826160627.GE24801@kernel.org>
 <20190826161849.GF24801@kernel.org>
 <20190826165852.GC8926@krava>
 <20190826221419.GC21761@kernel.org>
 <20190826224136.GD21761@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826224136.GD21761@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 27 Aug 2019 07:41:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:41:36PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 26, 2019 at 07:14:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Aug 26, 2019 at 06:58:52PM +0200, Jiri Olsa escreveu:
> > > On Mon, Aug 26, 2019 at 01:18:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > > 
> > > SNIP
> > > 
> > > > [perfbuilder@490c2c7bdaab ~]$ grep 'printf("lost' /tmp/build/perf/builtin-sched.i
> > > >  printf("lost %" "l" "ll""u" " events on cpu %d\n", event->lost.lost, sample->cpu);
> > > > [perfbuilder@490c2c7bdaab ~]$
> > > > 
> > > > And if we do this on a fedora:30 x86_64:
> > > > 
> > > > $ make -C tools/perf O=/tmp/build/perf /tmp/build/perf/builtin-sched.i
> > > > [acme@quaco perf]$ grep -A4 'printf("lost' /tmp/build/perf/builtin-sched.i
> > > >  printf("lost %" "l" 
> > > > # 2646 "builtin-sched.c" 3 4
> > > >                 "l" "u" 
> > > > # 2646 "builtin-sched.c"
> > > >                          " events on cpu %d\n", event->lost.lost, sample->cpu);
> > > > [acme@quaco perf]$
> > > > 
> > > > I.e. on 32-bit arches we shouldn't add that extra "l", right?
> > > 
> > > hum, I guess we could #ifdef it 64/32 bits
> > 
> > I tried to figure out how to fix this better, but the int-ll64.h versus
> > int-l64.h versus how __u64 is defined got me confused and I ended up
> > with:
> > 
> > #if __WORDSIZE == 64
> 
> Make that:
> 
> #ifdef __LP64__ to build on Alpine/musl libc.

awesome, thanks ;-)

jirka
