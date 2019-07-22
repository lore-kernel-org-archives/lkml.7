Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D48C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7B921955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbfGVWR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:17:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfGVWRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:17:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2ADA4ACDF;
        Mon, 22 Jul 2019 22:17:25 +0000 (UTC)
Received: from krava (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id E43865D9C8;
        Mon, 22 Jul 2019 22:17:20 +0000 (UTC)
Date:   Tue, 23 Jul 2019 00:17:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 38/79] libperf: Add perf_evlist__init function
Message-ID: <20190722221719.GA1152@krava>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-39-jolsa@kernel.org>
 <20190722193925.GV3624@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722193925.GV3624@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Jul 2019 22:17:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:39:25PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> 
> I'm applying it to fix this issue and avoid a bisection break. I'm now
> going to run 'perf test' after each cset too. And probably the next cset
> has this issue as well, i.e. reordering of initialization in the
> perf_evsel__init() case.
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index aacddd9b2d64..f4aa6cf80559 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -49,11 +49,11 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>  
>  	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
>  		INIT_HLIST_HEAD(&evlist->heads[i]);
> +	perf_evlist__init(&evlist->core);

right, needs to be before perf_evlist__set_maps call

thanks,
jirka

>  	perf_evlist__set_maps(evlist, cpus, threads);
>  	fdarray__init(&evlist->pollfd, 64);
>  	evlist->workload.pid = -1;
>  	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
> -	perf_evlist__init(&evlist->core);
>  }
>  
>  struct evlist *evlist__new(void)
