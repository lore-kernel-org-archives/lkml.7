Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C34C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68401206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLAlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:41:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:35425 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfKLAlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:41:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 16:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; 
   d="scan'208";a="206919826"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2019 16:41:00 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C0B43300860; Mon, 11 Nov 2019 16:41:00 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:41:00 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/13] perf evsel: Support opening on a specific CPU
Message-ID: <20191112004100.GH573472@tassilo.jf.intel.com>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-10-andi@firstfloor.org>
 <20191111133033.GC12923@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111133033.GC12923@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 02:30:33PM +0100, Jiri Olsa wrote:
> On Thu, Nov 07, 2019 at 10:16:42AM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> 
> SNIP
> 
> >  int perf_evsel__open_per_thread(struct evsel *evsel,
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index b10d5ba21966..54513d70c109 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -223,7 +223,8 @@ int evsel__enable(struct evsel *evsel);
> >  int evsel__disable(struct evsel *evsel);
> >  
> >  int perf_evsel__open_per_cpu(struct evsel *evsel,
> > -			     struct perf_cpu_map *cpus);
> > +			     struct perf_cpu_map *cpus,
> > +			     int cpu);
> >  int perf_evsel__open_per_thread(struct evsel *evsel,
> >  				struct perf_thread_map *threads);
> >  int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 6822e4ffe224..36dc95032e4c 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -517,7 +517,7 @@ int create_perf_stat_counter(struct evsel *evsel,
> >  	}
> >  
> >  	if (target__has_cpu(target) && !target__has_per_thread(target))
> > -		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
> > +		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), -1);
> 
> how will -1 owrk in here? it will end up as:
> 
>    perf_evsel__open_per_cpu
>     evsel__open_cpu( ...., start_cpu = -1, end_cpu = -1 + 1)
>       for (cpu = start_cpu; cpu < end_cpu; cpu++) {

Yes you're right. The problem was the splitting of the patches.
With the two patches combined it works. So the end result is good,
just a bad intermediate step.

I will merge them again.

It seems better than creating something complicated here that
will just be undone next patch again.

-Andi
