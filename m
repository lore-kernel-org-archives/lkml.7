Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40377C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162782146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHRTkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 15:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4885 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRTkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:40:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51B241955CF3;
        Sun, 18 Aug 2019 19:40:36 +0000 (UTC)
Received: from krava (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 740405FCA3;
        Sun, 18 Aug 2019 19:40:33 +0000 (UTC)
Date:   Sun, 18 Aug 2019 21:40:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 28/79] libperf: Add perf_cpu_map struct
Message-ID: <20190818194032.GA10666@krava>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-29-jolsa@kernel.org>
 <20190818140436.GA21854@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818140436.GA21854@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Sun, 18 Aug 2019 19:40:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 07:04:36AM -0700, Guenter Roeck wrote:
> On Sun, Jul 21, 2019 at 01:24:15PM +0200, Jiri Olsa wrote:
> > Adding perf_cpu_map struct into libperf.
> > 
> > It's added as a declaration into into:
> >   include/perf/cpumap.h
> > which will be included by users.
> > 
> > The perf_cpu_map struct definition is added into:
> >   include/internal/cpumap.h
> > 
> > which is not to be included by users, but shared
> > within perf and libperf.
> > 
> > We tried the total separation of the perf_cpu_map struct
> > in libperf, but it lead to complications and much bigger
> > changes in perf code, so we decided to share the declaration.
> > 
> > Link: http://lkml.kernel.org/n/tip-vhtr6a8apr7vkh2tou0r8896@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Hi,
> 
> this patch causes out-of-tree builds (make O=<destdir>) to fail.
> 
> In file included from tools/include/asm/atomic.h:6:0,
>                  from include/linux/atomic.h:5,
> 		 from tools/include/linux/refcount.h:41,
> 		 from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
> fatal error: asm/cmpxchg.h: No such file or directory
> 
> Bisect log attached.

hi,
I dont see any problem with v5.3-rc4, could you please send
the full compilation log (after make clean) from:

  $ make V=1 <your options>

also I can't make sense of that bisect, because I can't find
some of those commits.. what tree are you in?

thanks,
jirka

> 
> Guenter
> 
> ---
> # bad: [0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23] Add linux-next specific files for 20190816
> # good: [d45331b00ddb179e291766617259261c112db872] Linux 5.3-rc4
> git bisect start 'HEAD' 'v5.3-rc4'
> # good: [4e6eaeb715ab76095f7ea03fa5926c7aa541361e] Merge remote-tracking branch 'crypto/master'
> git bisect good 4e6eaeb715ab76095f7ea03fa5926c7aa541361e
> # good: [ef1c67aa73f33a29e3df672998056f18cb51468d] Merge remote-tracking branch 'sound-asoc/for-next'
> git bisect good ef1c67aa73f33a29e3df672998056f18cb51468d
> # bad: [f414a0d92534d55591e3c295f37f8db40d08659a] Merge remote-tracking branch 'char-misc/char-misc-next'
> git bisect bad f414a0d92534d55591e3c295f37f8db40d08659a
> # bad: [07f45358f90398b3bc44914a863317285a5dac55] Merge remote-tracking branch 'tip/auto-latest'
> git bisect bad 07f45358f90398b3bc44914a863317285a5dac55
> # good: [b8c9806513153eb258f565b2f359958a94c93816] Merge remote-tracking branch 'watchdog/master'
> git bisect good b8c9806513153eb258f565b2f359958a94c93816
> # bad: [7b9063c0c1c0b54db5eca8e4c36a926ee6234280] Merge branch 'sched/core'
> git bisect bad 7b9063c0c1c0b54db5eca8e4c36a926ee6234280
> # bad: [03617c22e31f32cbf0e4797e216db898fb898d90] libperf: Add threads to struct perf_evlist
> git bisect bad 03617c22e31f32cbf0e4797e216db898fb898d90
> # good: [5972d1e07bd95c7458e2d7f484391d69008affc7] perf evsel: Rename perf_evsel__open() to evsel__open()
> git bisect good 5972d1e07bd95c7458e2d7f484391d69008affc7
> # bad: [285a30c36d1e18e7e2afa24dae50ba5596be45e7] libperf: Add perf_evlist and perf_evsel structs
> git bisect bad 285a30c36d1e18e7e2afa24dae50ba5596be45e7
> # good: [47f9bccc79cb067103ad5e9790e0d01c94839429] libperf: Add build version support
> git bisect good 47f9bccc79cb067103ad5e9790e0d01c94839429
> # bad: [397721e06e52d017cfdd403f63284ed0995d4caf] libperf: Add perf_cpu_map__dummy_new() function
> git bisect bad 397721e06e52d017cfdd403f63284ed0995d4caf
> # good: [5b7f445d684fc287a2101e29d42d1fee19ae14ff] libperf: Add perf/core.h header
> git bisect good 5b7f445d684fc287a2101e29d42d1fee19ae14ff
> # bad: [959b83c769389b24d64759f60e64c4c62620ff02] libperf: Add perf_cpu_map struct
> git bisect bad 959b83c769389b24d64759f60e64c4c62620ff02
> # good: [a1556f8479ed58b8d5a33aef54578bad0165c7e7] libperf: Add debug output support
> git bisect good a1556f8479ed58b8d5a33aef54578bad0165c7e7
> # first bad commit: [959b83c769389b24d64759f60e64c4c62620ff02] libperf: Add perf_cpu_map struct
