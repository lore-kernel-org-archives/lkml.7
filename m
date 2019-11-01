Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25282CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2C320656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfKAPal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:30:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfKAPal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:30:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 842A731F;
        Fri,  1 Nov 2019 08:30:40 -0700 (PDT)
Received: from [10.0.2.15] (unknown [10.37.12.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A2133F719;
        Fri,  1 Nov 2019 08:30:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] perf cs-etm: Continuously record last branches
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
References: <20191101020750.29063-1-leo.yan@linaro.org>
 <20191101020750.29063-2-leo.yan@linaro.org>
From:   Robert Walker <robert.walker@arm.com>
Message-ID: <3dd30190-b266-826d-3e2d-91f1446cc5fc@arm.com>
Date:   Fri, 1 Nov 2019 15:30:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101020750.29063-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 02:07, Leo Yan wrote:
> Every time synthesize instruction sample, the last branches recording
> will be reset.  This would be fine if the instruction period is big
> enough, for example if we use the option '--itrace=i100000', the last
> branch array is reset for every instruction sample (10000 instructions
> per period); before generate the next instruction sample, there has the
> enough packets coming to fill last branch array.  On the other hand,
> if set a very small period, the packets will be significantly reduced
> between two continuous instruction samples, thus if the last branch
> array is reset for the previous instruction sample, it's almost empty
> for the next instruction sample.
>
> To allow the last branches to work for any instruction periods, this
> patch avoids to reset the last branches for every instruction sample
> and only reset it when flush the trace data.  The last branches will
> be reset only for two cases, one is for trace starting, another case
> is for discontinuous trace; thus it can continuously record last
> branches.

Is this the right thing to do?  This would cause profiling tools to 
count the same branch several times if it appears in multiple 
instruction samples, which could result in a biased profile.

The current implementation matches the behavior of intel_pt where the 
branch buffer is reset after each sample, so  the instruction sample 
only includes branches since the previous sample.

However x86 lbr (perf record -b) does appear to repeat the same full 
branch stack on several samples until a new stack is captured.

I'm not sure what the right or wrong answer is here.  For AutoFDO, we're 
likely to use a much bigger period (>10000 instructions) so won't be 
affected, but other tools might be.

Regards


Rob


> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   tools/perf/util/cs-etm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f5f855fff412..8be6d010ae84 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1153,9 +1153,6 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>   			"CS ETM Trace: failed to deliver instruction event, error %d\n",
>   			ret);
>   
> -	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> -
>   	return ret;
>   }
>   
> @@ -1486,6 +1483,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>   		tidq->prev_packet = tmp;
>   	}
>   
> +	/* Reset last branches after flush the trace */
> +	if (etm->synth_opts.last_branch)
> +		cs_etm__reset_last_branch_rb(tidq);
> +
>   	return err;
>   }
>   
