Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA28C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41E3205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfD2Oxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:53:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59450 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbfD2Oxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:53:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A6E80D;
        Mon, 29 Apr 2019 07:53:39 -0700 (PDT)
Received: from [10.32.98.83] (e111474-lin.manchester.arm.com [10.32.98.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187983F5C1;
        Mon, 29 Apr 2019 07:53:37 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] perf cs-etm: Always allocate memory for
 cs_etm_queue::prev_packet
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190428083228.20246-1-leo.yan@linaro.org>
From:   Robert Walker <robert.walker@arm.com>
Message-ID: <bba9c934-2ee9-4c0a-b3c8-52c901f740db@arm.com>
Date:   Mon, 29 Apr 2019 15:53:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190428083228.20246-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/04/2019 09:32, Leo Yan wrote:
> Robert Walker reported a segmentation fault is observed when process
> CoreSight trace data; this issue can be easily reproduced by the
> command 'perf report --itrace=i1000i' for decoding tracing data.
>
> If neither the 'b' flag (synthesize branches events) nor 'l' flag
> (synthesize last branch entries) are specified to option '--itrace',
> cs_etm_queue::prev_packet will not been initialised.  After merging
> the code to support exception packets and sample flags, there
> introduced a number of uses of cs_etm_queue::prev_packet without
> checking whether it is valid, for these cases any accessing to
> uninitialised prev_packet will cause crash.
>
> As cs_etm_queue::prev_packet is used more widely now and it's already
> hard to follow which functions have been called in a context where the
> validity of cs_etm_queue::prev_packet has been checked, this patch
> always allocates memory for cs_etm_queue::prev_packet.
>
> Reported-by: Robert Walker <robert.walker@arm.com>
> Suggested-by: Robert Walker <robert.walker@arm.com>
> Fixes: 7100b12cf474 ("perf cs-etm: Generate branch sample for exception packet")
> Fixes: 24fff5eb2b93 ("perf cs-etm: Avoid stale branch samples when flush packet")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   tools/perf/util/cs-etm.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

I've tested these with the trace from the HiKey960 and the segfault no 
longer occurs

Tested-by: Robert Walker <robert.walker@arm.com>

Regards

Rob

>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 110804936fc3..054b480aab04 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -422,11 +422,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>   	if (!etmq->packet)
>   		goto out_free;
>   
> -	if (etm->synth_opts.last_branch || etm->sample_branches) {
> -		etmq->prev_packet = zalloc(szp);
> -		if (!etmq->prev_packet)
> -			goto out_free;
> -	}
> +	etmq->prev_packet = zalloc(szp);
> +	if (!etmq->prev_packet)
> +		goto out_free;
>   
>   	if (etm->synth_opts.last_branch) {
>   		size_t sz = sizeof(struct branch_stack);
