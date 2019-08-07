Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924DC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA5821BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfHGLoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:44:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:42800 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfHGLoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:44:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 04:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="168607169"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2019 04:44:17 -0700
Received: from [10.125.252.123] (abudanko-mobl.ccr.corp.intel.com [10.125.252.123])
        by linux.intel.com (Postfix) with ESMTP id 8386A58046E;
        Wed,  7 Aug 2019 04:44:14 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
To:     Igor Lubashev <ilubashe@akamai.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
References: <cover.1565146171.git.ilubashe@akamai.com>
 <70ce92d9c252bbafa883a6b5b3c96cf10d1a5b31.1565146171.git.ilubashe@akamai.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d23e60f3-addb-8971-90e2-3df16ccfcd76@linux.intel.com>
Date:   Wed, 7 Aug 2019 14:44:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <70ce92d9c252bbafa883a6b5b3c96cf10d1a5b31.1565146171.git.ilubashe@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.08.2019 6:35, Igor Lubashev wrote:
> The kernel is using CAP_SYS_ADMIN instead of euid==0 to override
> perf_event_paranoid check. Make perf do the same.
> 
> Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 3 ++-
>  tools/perf/arch/arm64/util/arm-spe.c | 4 ++--
>  tools/perf/arch/x86/util/intel-bts.c | 3 ++-
>  tools/perf/arch/x86/util/intel-pt.c  | 2 +-
>  tools/perf/util/evsel.c              | 2 +-
>  5 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 5cb07e8cb296..b87a1ca2968f 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -18,6 +18,7 @@
>  #include "../../perf.h"
>  #include "../../util/auxtrace.h"
>  #include "../../util/cpumap.h"
> +#include "../../util/event.h"
>  #include "../../util/evlist.h"
>  #include "../../util/evsel.h"
>  #include "../../util/pmu.h"
> @@ -254,7 +255,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>  	struct evsel *evsel, *cs_etm_evsel = NULL;
>  	struct perf_cpu_map *cpus = evlist->core.cpus;
> -	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
> +	bool privileged = perf_event_paranoid_check(-1);
>  	int err = 0;
>  
>  	ptr->evlist = evlist;
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 00915b8fd05b..200bc973371b 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -12,6 +12,7 @@
>  #include <time.h>
>  
>  #include "../../util/cpumap.h"
> +#include "../../util/event.h"
>  #include "../../util/evsel.h"
>  #include "../../util/evlist.h"
>  #include "../../util/session.h"
> @@ -65,8 +66,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	struct arm_spe_recording *sper =
>  			container_of(itr, struct arm_spe_recording, itr);
>  	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
> -	struct evsel *evsel, *arm_spe_evsel = NULL;

Makes sense to double check if it compiles with this change.

Regards,
Alexey

> -	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
> +	bool privileged = perf_event_paranoid_check(-1);
>  	struct evsel *tracking_evsel;
>  	int err;
>  
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index 7b23318ebd7b..56a76142e9fd 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -12,6 +12,7 @@
>  #include <linux/zalloc.h>
>  
>  #include "../../util/cpumap.h"
> +#include "../../util/event.h"
>  #include "../../util/evsel.h"
>  #include "../../util/evlist.h"
>  #include "../../util/session.h"
> @@ -107,7 +108,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
>  	struct evsel *evsel, *intel_bts_evsel = NULL;
>  	const struct perf_cpu_map *cpus = evlist->core.cpus;
> -	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
> +	bool privileged = perf_event_paranoid_check(-1);
>  
>  	btsr->evlist = evlist;
>  	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 218a4e694618..43d5088ee824 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -558,7 +558,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	bool have_timing_info, need_immediate = false;
>  	struct evsel *evsel, *intel_pt_evsel = NULL;
>  	const struct perf_cpu_map *cpus = evlist->core.cpus;
> -	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
> +	bool privileged = perf_event_paranoid_check(-1);
>  	u64 tsc_bit;
>  	int err;
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 64bc32ed6dfa..eafc134bf17c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -279,7 +279,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
>  
>  static bool perf_event_can_profile_kernel(void)
>  {
> -	return geteuid() == 0 || perf_event_paranoid() == -1;
> +	return perf_event_paranoid_check(-1);
>  }
>  
>  struct evsel *perf_evsel__new_cycles(bool precise)
> 
