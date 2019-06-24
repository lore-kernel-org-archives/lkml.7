Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfFXTqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:46:00 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:47796 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbfFXTp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:45:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 797CD1801C5E9;
        Mon, 24 Jun 2019 19:45:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: run93_50df21c86a335
X-Filterd-Recvd-Size: 3000
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 19:45:55 +0000 (UTC)
Message-ID: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Date:   Mon, 24 Jun 2019 12:45:54 -0700
In-Reply-To: <20190624193123.GI3436@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
         <20190624193123.GI3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 21:31 +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2019 at 11:19:13AM -0500, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> > 
> > This patch fixes the following warnings:
> > 
> > arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
> > arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    pmem = true;
> >    ~~~~~^~~~~~
> > arch/x86/events/intel/core.c:4960:2: note: here
> >   case INTEL_FAM6_SKYLAKE_MOBILE:
> >   ^~~~
> > arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    pmem = true;
> >    ~~~~~^~~~~~
> > arch/x86/events/intel/core.c:5009:2: note: here
> >   case INTEL_FAM6_ICELAKE_MOBILE:
> >   ^~~~
> > 
> > Warning level 3 was used: -Wimplicit-fallthrough=3
> > 
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I still consider it an abomination that the C parser looks at comments
> -- other than to delete them, but OK I suppose, I'll take it.

I still believe Arnaldo's/Miguel's/Shawn's/my et al. suggestion of

#define __fallthrough __attribute__((fallthrough))

is far better.

https://lkml.org/lkml/2017/2/9/845
https://lkml.org/lkml/2017/2/10/485
https://lore.kernel.org/lkml/20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com/
https://lore.kernel.org/lkml/20190617155643.GA32544@amd/



