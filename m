Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CECC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EA320656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfD2Ox7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:53:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59486 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbfD2Ox7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:53:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 780D280D;
        Mon, 29 Apr 2019 07:53:58 -0700 (PDT)
Received: from [10.32.98.83] (e111474-lin.manchester.arm.com [10.32.98.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B00D73F5C1;
        Mon, 29 Apr 2019 07:53:56 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] perf cs-etm: Don't check cs_etm_queue::prev_packet
 validity
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
 <20190428083228.20246-2-leo.yan@linaro.org>
From:   Robert Walker <robert.walker@arm.com>
Message-ID: <c4aa2f1e-b539-c092-f15d-3337271a1d2f@arm.com>
Date:   Mon, 29 Apr 2019 15:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190428083228.20246-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/04/2019 09:32, Leo Yan wrote:
> Since cs_etm_queue::prev_packet is allocated for all cases, it will
> never be NULL pointer; now validity checking prev_packet is pointless,
> remove all of them.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   tools/perf/util/cs-etm.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Tested-by: Robert Walker <robert.walker@arm.com>

Regards

Rob

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 054b480aab04..de488b43f440 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -979,7 +979,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>   	 * PREV_PACKET is a branch.
>   	 */
>   	if (etm->synth_opts.last_branch &&
> -	    etmq->prev_packet &&
>   	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
>   	    etmq->prev_packet->last_instr_taken_branch)
>   		cs_etm__update_last_branch_rb(etmq);
> @@ -1012,7 +1011,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>   		etmq->period_instructions = instrs_over;
>   	}
>   
> -	if (etm->sample_branches && etmq->prev_packet) {
> +	if (etm->sample_branches) {
>   		bool generate_sample = false;
>   
>   		/* Generate sample for tracing on packet */
> @@ -1069,9 +1068,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
>   	struct cs_etm_auxtrace *etm = etmq->etm;
>   	struct cs_etm_packet *tmp;
>   
> -	if (!etmq->prev_packet)
> -		return 0;
> -
>   	/* Handle start tracing packet */
>   	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
>   		goto swap_packet;
