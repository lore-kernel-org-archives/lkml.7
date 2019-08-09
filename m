Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1415CC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09BE20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407336AbfHIPUS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:20:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:57666 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:20:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="193407759"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2019 08:20:16 -0700
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX152.ger.corp.intel.com (163.33.192.66) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 9 Aug 2019 16:20:15 +0100
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.234]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.65]) with mapi id 14.03.0439.000;
 Fri, 9 Aug 2019 16:20:14 +0100
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] perf_sample_id::idx
Thread-Topic: [RFC] perf_sample_id::idx
Thread-Index: AQHVTpS7rTvIss1V/EeFgZ8uqS0dgqby7KPA
Date:   Fri, 9 Aug 2019 15:20:14 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C5B1DB0@IRSMSX106.ger.corp.intel.com>
References: <20190809092736.GA9377@krava>
In-Reply-To: <20190809092736.GA9377@krava>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTg2ZTAzMzctZWY1Yy00YmQ1LTg1NWEtNTc5ZTFjOWNmYWE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid3JhU1hXQVdQK2pwV0xFaElHYnROSEtvVWxmK016ZEhHSVwvTlloMCsrU21QVXBwTG52dXpCdnFqdFdqTUZjQzUifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be used for AUX area sampling.  A sample will have AUX area data that will be queued for decoding, where there are separate queues for each CPU (per-cpu tracing) or task (per-thread tracing).  The sample ID can be used to lookup 'idx' which is effectively the queue number.

> -----Original Message-----
> From: Jiri Olsa [mailto:jolsa@redhat.com]
> Sent: Friday, August 9, 2019 12:28 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>; Ingo Molnar
> <mingo@kernel.org>; Namhyung Kim <namhyung@kernel.org>; Alexander
> Shishkin <alexander.shishkin@linux.intel.com>; Peter Zijlstra
> <a.p.zijlstra@chello.nl>; Michael Petlan <mpetlan@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: [RFC] perf_sample_id::idx
> 
> hi,
> what's the perf_sample_id::idx for? It was added in here:
>   3c659eedada2 perf tools: Add id index
> 
> but I dont see any practical usage of it in the sources, when I remove it like
> below, I get clean build
> 
> any idea?
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h index
> 70841d115349..24b90f68d616 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -498,7 +498,7 @@ struct tracing_data_event {
> 
>  struct id_index_entry {
>  	u64 id;
> -	u64 idx;
> +	u64 idx; /* deprecated */
>  	u64 cpu;
>  	u64 tid;
>  };
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c index
> c4489a1ad6bc..e55133cacb64 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -519,11 +519,11 @@ int perf_evlist__id_add_fd(struct evlist *evlist,  }
> 
>  static void perf_evlist__set_sid_idx(struct evlist *evlist,
> -				     struct evsel *evsel, int idx, int cpu,
> +				     struct evsel *evsel, int cpu,
>  				     int thread)
>  {
>  	struct perf_sample_id *sid = SID(evsel, cpu, thread);
> -	sid->idx = idx;
> +
>  	if (evlist->core.cpus && cpu >= 0)
>  		sid->cpu = evlist->core.cpus->map[cpu];
>  	else
> @@ -795,8 +795,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist
> *evlist, int idx,
>  			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
>  						   fd) < 0)
>  				return -1;
> -			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
> -						 thread);
> +			perf_evlist__set_sid_idx(evlist, evsel, cpu, thread);
>  		}
>  	}
> 
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h index
> 3cf35aa782b9..b9d864933d75 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -23,7 +23,6 @@ struct perf_sample_id {
>  	struct hlist_node 	node;
>  	u64		 	id;
>  	struct evsel		*evsel;
> -	int			idx;
>  	int			cpu;
>  	pid_t			tid;
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c index
> b9fe71d11bf6..2642d60aa875 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2394,7 +2394,6 @@ int perf_event__process_id_index(struct
> perf_session *session,
>  		sid = perf_evlist__id2sid(evlist, e->id);
>  		if (!sid)
>  			return -ENOENT;
> -		sid->idx = e->idx;
>  		sid->cpu = e->cpu;
>  		sid->tid = e->tid;
>  	}
> @@ -2454,7 +2453,7 @@ int perf_event__synthesize_id_index(struct
> perf_tool *tool,
>  				return -ENOENT;
>  			}
> 
> -			e->idx = sid->idx;
> +			e->idx = -1;
>  			e->cpu = sid->cpu;
>  			e->tid = sid->tid;
>  		}
