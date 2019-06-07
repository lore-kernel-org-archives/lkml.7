Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0583BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97EB20684
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfFGJlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:41:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfFGJlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:41:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC907458;
        Fri,  7 Jun 2019 02:41:51 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4E023F96A;
        Fri,  7 Jun 2019 02:43:30 -0700 (PDT)
Subject: Re: [PATCH v2 02/17] perf tools: Configure timestsamp generation in
 CPU-wide mode
To:     mathieu.poirier@linaro.org, acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
 <20190524173508.29044-3-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c1507e8b-9ec8-a5c4-a398-20dcc47acaa8@arm.com>
Date:   Fri, 7 Jun 2019 10:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524173508.29044-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/05/2019 18:34, Mathieu Poirier wrote:
> When operating in CPU-wide mode tracers need to generate timestamps in
> order to correlate the code being traced on one CPU with what is executed
> on other CPUs.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 3912f0bf04ed..be1e4f20affa 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -99,6 +99,54 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>   	return err;
>   }
>   
> +static int cs_etm_set_timestamp(struct auxtrace_record *itr,
> +				struct perf_evsel *evsel, int cpu)
> +{
> +	struct cs_etm_recording *ptr;
> +	struct perf_pmu *cs_etm_pmu;
> +	char path[PATH_MAX];
> +	int err = -EINVAL;
> +	u32 val;
> +
> +	ptr = container_of(itr, struct cs_etm_recording, itr);
> +	cs_etm_pmu = ptr->cs_etm_pmu;
> +
> +	if (!cs_etm_is_etmv4(itr, cpu))
> +		goto out;
> +
> +	/* Get a handle on TRCIRD0 */
> +	snprintf(path, PATH_MAX, "cpu%d/%s",
> +		 cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
> +	err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
> +
> +	/* There was a problem reading the file, bailing out */
> +	if (err != 1) {
> +		pr_err("%s: can't read file %s\n",
> +		       CORESIGHT_ETM_PMU_NAME, path);
> +		goto out;
> +	}
> +
> +	/*
> +	 * TRCIDR0.TSSIZE, bit [28-24], indicates whether global timestamping
> +	 * is supported:
> +	 *  0b00000 Global timestamping is not implemented
> +	 *  0b00110 Implementation supports a maximum timestamp of 48bits.
> +	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
> +	 */
> +	val &= GENMASK(28, 24);
> +	if (!val) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* All good, let the kernel know */
> +	evsel->attr.config |= (1 << ETM_OPT_TS);
> +	err = 0;
> +
> +out:
> +	return err;
> +}
> +
>   static int cs_etm_set_option(struct auxtrace_record *itr,
>   			     struct perf_evsel *evsel, u32 option)
>   {
> @@ -118,6 +166,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
>   			if (err)
>   				goto out;
>   			break;
> +		case ETM_OPT_TS:
> +			err = cs_etm_set_timestamp(itr, evsel, i);
> +			if (err)
> +				goto out;
> +			break;
>   		default:
>   			goto out;
>   		}
> @@ -343,6 +396,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>   		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
>   		if (err)
>   			goto out;
> +
> +		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
> +		if (err)
> +			goto out;

nit: Could we not do this in one shot, say :

	cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS | ETM_OPT_CTXTID) ?

rather than iterating over the per-CPU events twice ? The cs_etm_set_option()
could simply replace the switch() to :

	if (option & ETM_OPT_1)
		do_something_for_1()
	if (option & ETM_OPT_2)
		do_something_for_2();
	if (option & ~(ETM_OPT_1 | ETM_OPT_2 |...))
		/* do unsupported option */


Cheers
Suzuki
