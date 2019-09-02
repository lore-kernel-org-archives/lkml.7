Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F1C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588872173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfIBOQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfIBOQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:16:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0ECEB3084288;
        Mon,  2 Sep 2019 14:16:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id DA1975D6A7;
        Mon,  2 Sep 2019 14:16:47 +0000 (UTC)
Date:   Mon, 2 Sep 2019 16:16:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] perf tools: Add perf_env__numa_node function
Message-ID: <20190902141647.GC19702@krava>
References: <20190902121255.536-1-jolsa@kernel.org>
 <20190902121255.536-3-jolsa@kernel.org>
 <20190902135710.GB8396@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902135710.GB8396@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 02 Sep 2019 14:16:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:57:10AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 02, 2019 at 02:12:54PM +0200, Jiri Olsa escreveu:
> > To speed up cpu to node lookup, adding perf_env__numa_node
> > function, that creates cpu array on the first lookup, that
> > holds numa nodes for each stored cpu.
> > 
> > Link: http://lkml.kernel.org/n/tip-qqwxklhissf3yjyuaszh6480@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/env.c | 35 +++++++++++++++++++++++++++++++++++
> >  tools/perf/util/env.h |  6 ++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 3baca06786fb..6385961e45df 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -179,6 +179,7 @@ void perf_env__exit(struct perf_env *env)
> >  	zfree(&env->sibling_threads);
> >  	zfree(&env->pmu_mappings);
> >  	zfree(&env->cpu);
> > +	zfree(&env->numa_map);
> >  
> >  	for (i = 0; i < env->nr_numa_nodes; i++)
> >  		perf_cpu_map__put(env->numa_nodes[i].map);
> > @@ -338,3 +339,37 @@ const char *perf_env__arch(struct perf_env *env)
> >  
> >  	return normalize_arch(arch_name);
> >  }
> > +
> > +
> > +int perf_env__numa_node(struct perf_env *env, int cpu)
> > +{
> > +	if (!env->nr_numa_map) {
> > +		struct numa_node *nn;
> > +		int i, nr = 0;
> > +
> > +		for (i = 0; i < env->nr_numa_nodes; i++) {
> > +			nn = &env->numa_nodes[i];
> > +			nr = max(nr, perf_cpu_map__max(nn->map));
> > +		}
> > +
> > +		nr++;
> > +		env->numa_map = zalloc(nr * sizeof(int));
> 
> Why do you use zalloc()...
> 
> > +		if (!env->numa_map)
> > +			return -1;
> 
> Only to right after allocating it set all entries to -1?
> 
> That zalloc() should be downgraded to a plain malloc(), right?
> 
> The setting to -1 is because we may have holes in the array, right? I
> think this deserves a comment here as well.

yea, I added that later on and missed the zalloc above ;-)

I'll send new version

thanks,
jirka
