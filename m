Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C70EC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142CF21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfGBLnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:43:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:57956 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfGBLnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:43:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 04:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,443,1557212400"; 
   d="scan'208";a="166156966"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2019 04:08:48 -0700
Subject: Re: [PATCH v1 10/11] perf intel-pt: Smatch: Fix potential NULL
 pointer dereference
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-11-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cfef1777-141e-4223-e0c1-1a3f3aee1d3c@intel.com>
Date:   Tue, 2 Jul 2019 14:07:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702103420.27540-11-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/07/19 1:34 PM, Leo Yan wrote:
> Based on the following report from Smatch, fix the potential
> NULL pointer dereference check.

It never is NULL.  Remove the NULL test if you want:

-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
+	if (session->itrace_synth_opts->set) {

But blindly making changes like below is questionable.

> 
>   tools/perf/util/intel-pt.c:3200
>   intel_pt_process_auxtrace_info() error: we previously assumed
>   'session->itrace_synth_opts' could be null (see line 3196)
> 
>   tools/perf/util/intel-pt.c:3206
>   intel_pt_process_auxtrace_info() warn: variable dereferenced before
>   check 'session->itrace_synth_opts' (see line 3200)
> 
> tools/perf/util/intel-pt.c
> 3196         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> 3197                 pt->synth_opts = *session->itrace_synth_opts;
> 3198         } else {
> 3199                 itrace_synth_opts__set_default(&pt->synth_opts,
> 3200                                 session->itrace_synth_opts->default_no_sample);
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 3201                 if (!session->itrace_synth_opts->default_no_sample &&
> 3202                     !session->itrace_synth_opts->inject) {
> 3203                         pt->synth_opts.branches = false;
> 3204                         pt->synth_opts.callchain = true;
> 3205                 }
> 3206                 if (session->itrace_synth_opts)
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 3207                         pt->synth_opts.thread_stack =
> 3208                                 session->itrace_synth_opts->thread_stack;
> 3209         }
> 
> To dismiss the potential NULL pointer dereference, this patch validates
> the pointer 'session->itrace_synth_opts' before access its elements.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/intel-pt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 550db6e77968..88b567bdf1f9 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3195,7 +3195,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  
>  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>  		pt->synth_opts = *session->itrace_synth_opts;
> -	} else {
> +	} else if (session->itrace_synth_opts) {
>  		itrace_synth_opts__set_default(&pt->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
>  		if (!session->itrace_synth_opts->default_no_sample &&
> @@ -3203,8 +3203,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  			pt->synth_opts.branches = false;
>  			pt->synth_opts.callchain = true;
>  		}
> -		if (session->itrace_synth_opts)
> -			pt->synth_opts.thread_stack =
> +		pt->synth_opts.thread_stack =
>  				session->itrace_synth_opts->thread_stack;
>  	}
>  
> 

