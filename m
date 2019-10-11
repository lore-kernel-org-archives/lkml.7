Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA49C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CA12084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXmpi7ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfJKURy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:17:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42113 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfJKURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:17:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so1291610pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urKtgcUqAkGp8KZBc5+oZtHTmWIcz82tEFRNTfuvdn4=;
        b=AXmpi7kejzX23jX+27pOe3agKp/6or0QiTrtZTRQk8imHTwVDIPlt7zAlpLwHTDmuM
         WcAdOnI30lpOnV/urS4PpjaIT4siN4pVPGVW9CMRtzjT1g1A2gepjSRffqI+FCRphsWm
         dZSPAUK+NPEgFsvkDPV2yCTh8mAFw/G++hRzIU/bu5REGQW9JRIS3mp/dELwY5++Q8tb
         oMPdMuFGBhDhl6LtGzArcMzLzVIJpfeYHiCONqiYz1jXhquUFROPQpLtkSikFAuax+50
         SF6uPoFyJ5awRs+H+rCfPJ3wysh4NOF5TO7VVo7LwYT8ALPeMEuijne7GVDpmPOluO7L
         pm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urKtgcUqAkGp8KZBc5+oZtHTmWIcz82tEFRNTfuvdn4=;
        b=ZMhOH0Zt0AABGevDbyS5T2pqjiGlo/JT7G2PdocAs0w8OtmJ2KNJGrnOnQiDx6Jhzq
         JgjdK2AA4RddyiPWiv1abuMeNR3J/0w+PYStff78gwILlR7NwHzBWE221GglFOKi9gUV
         AmeEBLB0qT/8TQ/XoDBu6ZZdEGM8+FVMz5I9zv2VNO6NmSapS6tN2H1h31Ko78RCMxyZ
         azobRsfYwMDgPrz6kEVeWgg/LnuhJmUQj2lpcj6cRybNC8QvDOkhVJwJH/Od+ZT1TwNV
         5E2tou6LtONxFTSyk5GR+yc48rD1AxVDbIc1kVUyTUvcryr9bVk/5+teXzRtbY90GX/r
         /Prw==
X-Gm-Message-State: APjAAAXHeGj8oeINvcumawbk0CB4zJzShPTcHVsse8Vx/DY1Pidzn/Gl
        yzCk7p2Ng0hXwyloorE5fbIMBA==
X-Google-Smtp-Source: APXvYqy38uKd8VmnBen9hFXQxvk0j0GYq4h83Htd1vNyCXJhBgpeD8RsBQrvhqjAymF9cy+J3yvh8g==
X-Received: by 2002:a17:90a:9306:: with SMTP id p6mr19281294pjo.68.1570825073251;
        Fri, 11 Oct 2019 13:17:53 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z13sm11344787pfg.172.2019.10.11.13.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 13:17:52 -0700 (PDT)
Date:   Fri, 11 Oct 2019 14:17:50 -0600
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
Subject: Re: [PATCH v3 6/6] perf cs-etm: Synchronize instruction sample with
 the thread stack
Message-ID: <20191011201750.GD13688@xps15>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005091614.11635-7-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 05:16:14PM +0800, Leo Yan wrote:
> The synthesized flow use 'tidq->packet' for instruction samples; on the
> other hand, 'tidp->prev_packet' is used to generate the thread stack and
> the branch samples, this results in the instruction samples using one
> packet ahead than thread stack and branch samples ('tidp->prev_packet'
> vs 'tidq->packet').
> 
> This leads to an instruction's callchain error as shows in below
> example:
> 
>   main  1579        100      instructions:
>   	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
>   	ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
>   	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
>   	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
>   	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
>   	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
>   	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> 
> In the callchain log, for the two continuous lines the up line contains
> one child function info and the followed line contains the caller
> function info, and so forth.  So the first two lines are:
> 
>   perf_event_update_userpage+0x4c  => the sampled instruction
>   perf_event_update_userpage+0x48  => the parent function's calling
> 
> The child function and parent function both are the same function
> perf_event_update_userpage(), but this isn't a recursive function, thus
> the sequence for perf_event_update_userpage() calling itself shouldn't
> never happen.  This callchain error is caused by the instruction sample
> using an ahead packet than the thread stack, the thread stack is deferred
> to process the new packet and misses to pop stack if it is just a return
> packet.
> 
> To fix this issue, we can simply change to use 'tidq->prev_packet' to
> generate the instruction samples, this allows the thread stack to push
> and pop synchronously with instruction sample.  Finally, the callchain
> can be displayed correctly as below:
> 
>   main  1579        100      instructions:
> 	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
> 	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
> 	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
> 	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
> 	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
> 	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 56e501cd2f5f..fa969dcb45d2 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1419,7 +1419,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  	struct cs_etm_packet *tmp;
>  	int ret;
>  	u8 trace_chan_id = tidq->trace_chan_id;
> -	u64 instrs_executed = tidq->packet->instr_count;
> +	u64 instrs_executed = tidq->prev_packet->instr_count;
>  
>  	tidq->period_instructions += instrs_executed;
>  
> @@ -1450,7 +1450,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  		 */
>  		s64 offset = (instrs_executed - instrs_over - 1);
>  		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
> -					      tidq->packet, offset);
> +					      tidq->prev_packet, offset);

I have tested this set in --per-thread mode and things are working as
advertised. Did you see how things look like in CPU-wide scenarios?

Thanks,
Mathieu

>  
>  		ret = cs_etm__synth_instruction_sample(
>  			etmq, tidq, addr, etm->instructions_sample_period);
> -- 
> 2.17.1
> 
