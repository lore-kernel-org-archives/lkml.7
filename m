Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE81C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD30D229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfGXIdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXIdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:33:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1E1E3082E61;
        Wed, 24 Jul 2019 08:33:52 +0000 (UTC)
Received: from krava (unknown [10.40.205.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id E4A17601B7;
        Wed, 24 Jul 2019 08:33:46 +0000 (UTC)
Date:   Wed, 24 Jul 2019 10:33:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC 00/79] perf tools: Initial libperf separation
Message-ID: <20190724083345.GA5860@krava>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <327EF79F-4573-4387-8DA5-24FFD9EDBBB1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327EF79F-4573-4387-8DA5-24FFD9EDBBB1@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 24 Jul 2019 08:33:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 07:42:50AM +0000, Song Liu wrote:
> Hi Jiri,
> 
> > On Jul 21, 2019, at 4:23 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > hi,
> > we have long term goal to separate some of the perf functionality
> > into library. This patchset is initial effort on separating some
> > of the interface.
> > 
> > Currently only the basic counting interface is exported, it allows
> > to:
> >  - create cpu/threads maps
> >  - create evlist/evsel objects
> >  - add evsel objects into evlist
> >  - open/close evlist/evsel objects
> >  - enable/disable events
> >  - read evsel counts
> 
> Based on my understanding, evsel and evlist are abstractions in
> perf utilities. I think most other tools that use perf UAPIs are 
> not built based on these abstractions. I looked at a few internal

AFAICS some abstraction is needed to carry on the needed stuff
like mmaps, counts, group links, PMU details (type, cpus..)

> tools. Most of them just uses sys_perf_event_open() and struct 
> perf_event_attr. I am not sure whether these tools would adopt
> libperf, as libperf changes their existing concepts/abstractions.

well, besides that we wanted to do this separation for tools/* sake,
I think that once libperf shares more interface on sampling and pmu
events parsing, it will be considerable choice also for out of the
tree tools

> > 
> > The initial effort was to have total separation of the objects
> > from perf code, but it showed not to be a good way. The amount
> > of changed code was too big with high chance for regressions,
> > mainly because of the code embedding one of the above objects
> > statically.
> > 
> > We took the other approach of sharing the objects/struct details
> > within the perf and libperf code. This way we can keep perf
> > functionality without any major changes and the libperf users
> > are still separated from the object/struct details. We can move
> > to total libperf's objects separation gradually in future.
> 
> I found some duplicated logic between libperf and perf, for 
> example, perf_evlist__open() and evlist__open(). Do we plan to 
> merge them in the future? 

yea, as I wrote in the perf_evsel__open patch changelog:

  It's a simplified version of evsel__open without fallback
  stuff. We can try to merge it in the future to libperf,
  but it has many glitches.

some of the API can be shared right away, some needs more
changes and consideration

thanks,
jirka
