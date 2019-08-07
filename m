Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9470C32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B3B21BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfHGLqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfHGLqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:46:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B877881103;
        Wed,  7 Aug 2019 11:46:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7681B5DC1E;
        Wed,  7 Aug 2019 11:46:03 +0000 (UTC)
Date:   Wed, 7 Aug 2019 13:46:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2 2/4] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Message-ID: <20190807114602.GB9605@krava>
References: <cover.1565146171.git.ilubashe@akamai.com>
 <70ce92d9c252bbafa883a6b5b3c96cf10d1a5b31.1565146171.git.ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ce92d9c252bbafa883a6b5b3c96cf10d1a5b31.1565146171.git.ilubashe@akamai.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 07 Aug 2019 11:46:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:35:55PM -0400, Igor Lubashev wrote:
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

wouldn't this removal break the compilation on arm?

jirka

> -	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
> +	bool privileged = perf_event_paranoid_check(-1);
>  	struct evsel *tracking_evsel;
>  	int err;

SNIP
