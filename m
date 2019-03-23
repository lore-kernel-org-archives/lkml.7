Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980AEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDCA218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCWPE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWPE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD0E5F74B8;
        Sat, 23 Mar 2019 15:04:26 +0000 (UTC)
Received: from krava (ovpn-204-22.brq.redhat.com [10.40.204.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id D3B57601AE;
        Sat, 23 Mar 2019 15:04:23 +0000 (UTC)
Date:   Sat, 23 Mar 2019 16:04:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf tools: Move precise_ip detection into
 perf_evsel__open
Message-ID: <20190323150422.GA22122@krava>
References: <20190305161319.GC17272@tassilo.jf.intel.com>
 <20190305162854.GB4533@krava>
 <20190305164017.GD17272@tassilo.jf.intel.com>
 <20190307153500.GC29474@krava>
 <20190307165123.GE7535@tassilo.jf.intel.com>
 <20190314140124.GE4406@krava>
 <20190314154911.GE24002@tassilo.jf.intel.com>
 <20190315121546.GB1400@krava>
 <20190315143504.GA24482@kernel.org>
 <20190315145225.GC5200@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315145225.GC5200@krava>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 23 Mar 2019 15:04:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 03:52:25PM +0100, Jiri Olsa wrote:
> On Fri, Mar 15, 2019 at 11:35:04AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > +static void display_attr(struct perf_event_attr *attr)
> > > +{
> > > +	if (verbose >= 2) {
> > > +		fprintf(stderr, "%.60s\n", graph_dotted_line);
> > > +		fprintf(stderr, "perf_event_attr:\n");
> > > +		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
> > > +		fprintf(stderr, "%.60s\n", graph_dotted_line);
> > > +	}
> > > +}
> > > +
> > > +static int perf_event_open(struct perf_evsel *evsel,
> > > +			   pid_t pid, int cpu, int group_fd,
> > > +			   unsigned long flags)
> > 
> > 
> > The patch is ok, but I think the naming of this function is too generic,
> > so I'm renaming it to:
> > 
> > static int perf_evsel__open_adjust_precise_ip(struct perf_evsel *evsel,
> > 					      pid_t pid, int cpu, int group_fd,
> > 					      unsigned long flags)
> > 
> > Ok?
> 
> ok
> 
> > 
> > The perf_evsel__open() code is already complex with that fallback
> > mechanism, this is just one more way of fallbacking when asking the
> > kernel for something that may fail.
> > 
> > In fact what happens if the precise_ip that is being asked _is_
> > supported but sys_perf_event_open() fails because some other
> > perf_event_attr attribute that is set is not supported? 
> 
> it's outside the scope of standard feature fallback code,
> so we will try it for any possible fallback variant, so:
> 
> we will try all possible precise_ip (3,2,1,0) and they will
> all fail because of the unsupported attribute - so we will
> restore the precise_ip back and continue in standard fallback
> code that will eventualy switch that attribute off
> 
> > 
> > I see, it gets it back restored to what the user asked so that the
> > standard fallback is tried, ok, I'll apply with just the rename for this
> > function,
> 
> thanks,
> jirka

ping, there's rebased version in my perf/fixes branch

jirka
