Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1248220882
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsA6l+Ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfICWH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:07:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41146 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:07:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so5129979pfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xyqj5HyWdFbW4BPgeZq1CM5418QyoyNXiQU5VxTQbtc=;
        b=nsA6l+Ha2FFi4VBb0F0uWiZiigDZwKek/olDL51vD8SpAe8XFT/s4OpuVKir4GbSx4
         rXcYC1/+VhWmsT2aAz0jiI4lOkSqLWoRZBV+jGc/tAW+VQQF+7gYUcD15KCsiQLT6kzC
         AEeplgAuLFvEK4J9o/C6X88Rpv0hvWujXLib3Dq9YVCYCMLqKvLfb/Uv4OPQJCw5yXC2
         5YAmHCKpXKXEyAIssble4tDsISkB9TRIEJmp0NT0VdKpZap55VBhFIsAOPZ5gTWhTi4A
         Ll05VUT1pAV/a0hdziLPiqRfi73fvocQBsrH8ilBRE7W5OxmcyDUqUt4DTVKFDkS0yF4
         k3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xyqj5HyWdFbW4BPgeZq1CM5418QyoyNXiQU5VxTQbtc=;
        b=HOCMSpwLfqXc2XC6v6YS2U+3UFt+aYQZOSDITCBwVfQGwa0KgVO2WuoLLwho3vlplL
         6zg2QjreHWp79aXp19Gowe6MIvHW/vySne2cD0QJ4a8DGerxEvpnnmQ/LMPyg0X9BSCO
         5BpRQGt1LFziSAyC+dM3ttGWFN7QVvGT2tNTPswTrrCw335544odRMLX+ZLiDzVmrnRv
         HEYZ5U95X/Q1VfYrnmFMPuACZk9cCUGA2mOegbJd2049xXcldPZNBjWvGU3f5Z6J7g5R
         MrbsXh+9EOncULhcPW8kNum833pilDttTDENUxzKO0jrcA6NB+mH5aTo52wVz/zRdJzy
         YMXw==
X-Gm-Message-State: APjAAAWPyi1NXuF5jExrWiDmU++oICQMY3b8x6wy7v2E8whrlre+Twr8
        NKwo5Id3xwFIT3660ztc/WMfHg==
X-Google-Smtp-Source: APXvYqxsSRqBiVf5iRXpEV7HJElzXLdICeegbw39QL0RCNGLwECf6l/l16uZspZ0J4FdMyte/RTmMg==
X-Received: by 2002:a62:7641:: with SMTP id r62mr41077659pfc.201.1567548446176;
        Tue, 03 Sep 2019 15:07:26 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 74sm3173206pfy.78.2019.09.03.15.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 15:07:25 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:07:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <Robert.Walker@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 2/3] perf cs-etm: Add callchain to instruction sample
Message-ID: <20190903220723.GC25787@xps15>
References: <20190830062421.31275-1-leo.yan@linaro.org>
 <20190830062421.31275-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830062421.31275-3-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:24:20PM +0800, Leo Yan wrote:
> Firstly, this patch adds support for the thread stack; when every branch
> packet is coming we will push or pop the stack based on the sample
> flags.
> 
> Secondly, based on the thread stack we can synthesize call chain for the
> instruction sample, this can be used by itrace option '--itrace=g'.
>

In most cases using the word "secondly" is a good indication the patch should be
split.
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 74 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 882a0718033d..ad573d3bd305 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -17,6 +17,7 @@
>  #include <stdlib.h>
>  
>  #include "auxtrace.h"
> +#include "callchain.h"
>  #include "color.h"
>  #include "cs-etm.h"
>  #include "cs-etm-decoder/cs-etm-decoder.h"
> @@ -69,6 +70,7 @@ struct cs_etm_traceid_queue {
>  	size_t last_branch_pos;
>  	union perf_event *event_buf;
>  	struct thread *thread;
> +	struct ip_callchain *chain;
>  	struct branch_stack *last_branch;
>  	struct branch_stack *last_branch_rb;
>  	struct cs_etm_packet *prev_packet;
> @@ -246,6 +248,16 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>  	if (!tidq->prev_packet)
>  		goto out_free;
>  
> +	if (etm->synth_opts.callchain) {
> +		size_t sz = sizeof(struct ip_callchain);
> +
> +		/* Add 1 to callchain_sz for callchain context */
> +		sz += (etm->synth_opts.callchain_sz + 1) * sizeof(u64);
> +		tidq->chain = zalloc(sz);
> +		if (!tidq->chain)
> +			goto out_free;
> +	}
> +
>  	if (etm->synth_opts.last_branch) {
>  		size_t sz = sizeof(struct branch_stack);
>  
> @@ -270,6 +282,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>  	zfree(&tidq->last_branch);
>  	zfree(&tidq->prev_packet);
>  	zfree(&tidq->packet);
> +	zfree(&tidq->chain);
>  out:
>  	return rc;
>  }
> @@ -541,6 +554,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>  		zfree(&tidq->last_branch_rb);
>  		zfree(&tidq->prev_packet);
>  		zfree(&tidq->packet);
> +		zfree(&tidq->chain);
>  		zfree(&tidq);
>  
>  		/*
> @@ -1121,6 +1135,41 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>  			   sample->insn_len, (void *)sample->insn);
>  }
>  
> +static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
> +				    struct cs_etm_traceid_queue *tidq)
> +{
> +	struct cs_etm_auxtrace *etm = etmq->etm;
> +	u8 trace_chan_id = tidq->trace_chan_id;
> +	int insn_len;
> +	u64 from_ip, to_ip;
> +
> +	if (etm->synth_opts.callchain || etm->synth_opts.thread_stack) {
> +
> +		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
> +		to_ip = cs_etm__first_executed_instr(tidq->packet);
> +
> +		/*
> +		 * T32 instruction size might be 32-bit or 16-bit, decide by
> +		 * calling cs_etm__t32_instr_size().
> +		 */
> +		if (tidq->prev_packet->isa == CS_ETM_ISA_T32)
> +			insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> +							  from_ip);
> +		/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> +		else
> +			insn_len = 4;
> +
> +		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
> +				    tidq->prev_packet->flags,
> +				    from_ip, to_ip, insn_len,
> +				    etmq->buffer->buffer_nr);
> +	} else {
> +		thread_stack__set_trace_nr(tidq->thread,
> +					   tidq->prev_packet->cpu,
> +					   etmq->buffer->buffer_nr);

Please add a comment on what the above does.  As a rule of thumb I add a comment
per addition in a patch in order to help people understand what is happening and
some of the reasonning behing the code.

> +	}
> +}
> +
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  					    struct cs_etm_traceid_queue *tidq,
>  					    u64 addr, u64 period)
> @@ -1146,6 +1195,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  
>  	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
>  
> +	if (etm->synth_opts.callchain) {
> +		thread_stack__sample(tidq->thread, tidq->packet->cpu,
> +				     tidq->chain,
> +				     etm->synth_opts.callchain_sz + 1,
> +				     sample.ip, etm->kernel_start);
> +		sample.callchain = tidq->chain;
> +	}
> +
>  	if (etm->synth_opts.last_branch) {
>  		cs_etm__copy_last_branch_rb(etmq, tidq);
>  		sample.branch_stack = tidq->last_branch;
> @@ -1329,6 +1386,8 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
>  	}
>  
> +	if (etm->synth_opts.callchain)
> +		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
>  	if (etm->synth_opts.last_branch)
>  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>  
> @@ -1397,6 +1456,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  		tidq->period_instructions = instrs_over;
>  	}
>  
> +	if (tidq->prev_packet->last_instr_taken_branch)
> +		cs_etm__add_stack_event(etmq, tidq);
> +
>  	if (etm->sample_branches) {
>  		bool generate_sample = false;
>  
> @@ -2596,7 +2658,17 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	} else {
>  		itrace_synth_opts__set_default(&etm->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
> -		etm->synth_opts.callchain = false;
> +
> +		etm->synth_opts.thread_stack =
> +				session->itrace_synth_opts->thread_stack;
> +	}
> +
> +	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
> +		symbol_conf.use_callchain = true;
> +		if (callchain_register_param(&callchain_param) < 0) {
> +			symbol_conf.use_callchain = false;
> +			etm->synth_opts.callchain = false;
> +		}
>  	}
>  
>  	err = cs_etm__synth_events(etm, session);
> -- 
> 2.17.1
> 
