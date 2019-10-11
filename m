Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FFC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3605214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMeHCjXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfJKT7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:59:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44102 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfJKT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:59:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so4924842pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6afyqkADDxzCqdL1Z9t7tFq6tPUrGqNVvG+bqx/tL8=;
        b=sMeHCjXa86igWl2Il1mMfxFcQx9vzIadTmlxHGTv1pXq+lSMZkZ5/mD93OKn6zt5q8
         bK7BlobRwylUgRNcIHPOlRePif6gMvXeKhT+hXMTva8OeQ7q4oJaWOveQfcAmA2g7iAY
         fFUqADJDb3lf49Iyxack5K6WF3A593ez4NsfpjzmgSqmMIIPSfp6l95zKrRmRWFmyRHD
         K6ikUq7J6qaQpIcvqIycPIF/DnOkJNBXP8aypz6ZQ/+P7LD+HhyLdx6tPKrctdnRjYpe
         6bExI+yR4rtB4ZEEqbADI8TDTMI44+OLwlyiiu1ehIywzpFezKt2npeQ7fHnxYQ6pubd
         64XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6afyqkADDxzCqdL1Z9t7tFq6tPUrGqNVvG+bqx/tL8=;
        b=ED8lqw6Q56S2oiTqTdHH68i6TjTwMXZs+RzW6GkGijq2Q3eQVTx4rwWQ6w8J4cfd6l
         /kLHmK65vrgc5NRDLccxI9H0gQhWqlVYQRKVKdS1kYIqc35aUr8UmPxjY1lmtlyAJ2TV
         yk/Nr4P7muN7H7zRuRhR7E4HfxDTEIFxyLXKfxbc9tCJI9DCRLXoJ9AA4If3YSm/mXwQ
         nWBJ/KWOA8Hn4bT7pn7CpCptzvmNZhjCloHameSBQwRxMJE5HxbruZ7y56I3JBivWBmX
         sP/UHayKkS1KfQbznqHl8jDZcNxMy6Sig3JlcQe4ctqtyleFKk8SgWjYL8JczFa7hXtK
         MqYA==
X-Gm-Message-State: APjAAAVFaViv98hcRp+1XID2CAzEIYbbako0lnaSTXDyehbDUmm4U6rD
        v+xWHG9qju2pTi+sLVkUlUpYFw==
X-Google-Smtp-Source: APXvYqylwsJ9d2J6HlfZZitGB6aiBmOAV9bPlM9K1LmuILw5/+QvA9b6nghIV3JOTXZA3Kp1fcK0hw==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr16960423plp.218.1570823970966;
        Fri, 11 Oct 2019 12:59:30 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z2sm12447287pfq.58.2019.10.11.12.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 12:59:30 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:59:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 5/6] perf cs-etm: Support callchain for instruction
 sample
Message-ID: <20191011195928.GB13688@xps15>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-6-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005091614.11635-6-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 05:16:13PM +0800, Leo Yan wrote:
> Now CoreSight has supported the thread stack; based on the thread stack
> we can synthesize call chain for the instruction sample; the call chain
> can be injected by option '--itrace=g'.
> 
> Before:
> 
>   # perf script --itrace=g16l64i100
>             main  1579        100      instructions:  ffff0000102137f0 group_sched_in+0xb0 ([kernel.kallsyms])
>             main  1579        100      instructions:  ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
>             main  1579        100      instructions:  ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
>             main  1579        100      instructions:  ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
>             main  1579        100      instructions:  ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
>   [...]
> 
> After:
> 
>   # perf script --itrace=g16l64i100
> 
>   main  1579        100      instructions:
>           ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
>           ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> 
>   main  1579        100      instructions:
>           ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
>           ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
>           ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
>           ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> 
>   main  1579        100      instructions:
>           ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
>           ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
>           ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
>           ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
>           ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
>   [...]
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4b42f9c9bd34..56e501cd2f5f 100644
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
> @@ -74,6 +75,7 @@ struct cs_etm_traceid_queue {
>  	size_t last_branch_pos;
>  	union perf_event *event_buf;
>  	struct thread *thread;
> +	struct ip_callchain *chain;
>  	struct branch_stack *last_branch;
>  	struct branch_stack *last_branch_rb;
>  	struct cs_etm_packet *prev_packet;
> @@ -251,6 +253,16 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
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
> @@ -275,6 +287,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>  	zfree(&tidq->last_branch);
>  	zfree(&tidq->prev_packet);
>  	zfree(&tidq->packet);
> +	zfree(&tidq->chain);

Theoretically this should go two lines up, i.e just below
zfree(&tidq->prev_packet).  If you agree with the comment I did in 3/6 then it
is worth doing the above change, otherwise it can stay that way.

>  out:
>  	return rc;
>  }
> @@ -546,6 +559,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>  		zfree(&tidq->last_branch_rb);
>  		zfree(&tidq->prev_packet);
>  		zfree(&tidq->packet);
> +		zfree(&tidq->chain);

Same comment as above.  The rest looks good to me.

Mathieu

>  		zfree(&tidq);
>  
>  		/*
> @@ -1126,7 +1140,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
>  	int insn_len;
>  	u64 from_ip, to_ip;
>  
> -	if (etm->synth_opts.thread_stack) {
> +	if (etm->synth_opts.callchain || etm->synth_opts.thread_stack) {
>  		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
>  		to_ip = cs_etm__first_executed_instr(tidq->packet);
>  
> @@ -1182,6 +1196,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
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
> @@ -1369,6 +1391,8 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
>  	}
>  
> +	if (etm->synth_opts.callchain)
> +		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
>  	if (etm->synth_opts.last_branch)
>  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>  
> @@ -2639,7 +2663,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	} else {
>  		itrace_synth_opts__set_default(&etm->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
> -		etm->synth_opts.callchain = false;
>  		etm->synth_opts.thread_stack =
>  				session->itrace_synth_opts->thread_stack;
>  	}
> @@ -2651,6 +2674,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  		etm->branches_filter |= PERF_IP_FLAG_RETURN |
>  					PERF_IP_FLAG_TRACE_BEGIN;
>  
> +	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
> +		symbol_conf.use_callchain = true;
> +		if (callchain_register_param(&callchain_param) < 0) {
> +			symbol_conf.use_callchain = false;
> +			etm->synth_opts.callchain = false;
> +		}
> +	}
> +
>  	err = cs_etm__synth_events(etm, session);
>  	if (err)
>  		goto err_delete_thread;
> -- 
> 2.17.1
> 
