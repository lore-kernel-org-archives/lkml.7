Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D98820854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfCONe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfCONe5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:34:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0159D7D0C4;
        Fri, 15 Mar 2019 13:34:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7D391001DC0;
        Fri, 15 Mar 2019 13:34:54 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:34:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/3] perf stat: Support coresum event qualifier
Message-ID: <20190315133453.GB5200@krava>
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
 <1552665856-27741-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552665856-27741-3-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 15 Mar 2019 13:34:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 12:04:15AM +0800, Jin Yao wrote:

SNIP

> +static void print_counter_aggrdata(struct perf_stat_config *config,
> +				   struct perf_evsel *counter, int s,
> +				   char *prefix, bool metric_only,
> +				   bool *first)
> +{
> +	struct aggr_data ad;
> +	FILE *output = config->output;
> +	u64 ena, run, val;
> +	int id, nr;
> +	double uval;
> +
> +	ad.id = id = config->aggr_map->map[s];
> +	ad.val = ad.ena = ad.run = 0;
> +	ad.nr = 0;
> +	if (!collect_data(config, counter, aggr_cb, &ad))
> +		return;
> +
> +	nr = ad.nr;
> +	ena = ad.ena;
> +	run = ad.run;
> +	val = ad.val;
> +	if (*first && metric_only) {
> +		*first = false;
> +		aggr_printout(config, counter, id, nr);
> +	}
> +	if (prefix && !metric_only)
> +		fprintf(output, "%s", prefix);
> +
> +	uval = val * counter->scale;
> +	printout(config, id, nr, counter, uval, prefix,
> +		 run, ena, 1.0, &rt_stat);
> +	if (!metric_only)
> +		fputc('\n', output);
> +}

plese put the factoring out of print_counter_aggrdata function
into separate patch

thanks,
jirka


> +
>  static void print_aggr(struct perf_stat_config *config,
>  		       struct perf_evlist *evlist,
>  		       char *prefix)
> @@ -606,9 +649,7 @@ static void print_aggr(struct perf_stat_config *config,
>  	bool metric_only = config->metric_only;
>  	FILE *output = config->output;
>  	struct perf_evsel *counter;
> -	int s, id, nr;
> -	double uval;
> -	u64 ena, run, val;
> +	int s;
>  	bool first;
>  
>  	if (!(config->aggr_map || config->aggr_get_id))
> @@ -621,36 +662,16 @@ static void print_aggr(struct perf_stat_config *config,
>  	 * Without each counter has its own line.
>  	 */
>  	for (s = 0; s < config->aggr_map->nr; s++) {
> -		struct aggr_data ad;
>  		if (prefix && metric_only)
>  			fprintf(output, "%s", prefix);
>  
> -		ad.id = id = config->aggr_map->map[s];
>  		first = true;
>  		evlist__for_each_entry(evlist, counter) {
>  			if (is_duration_time(counter))
>  				continue;
> -
> -			ad.val = ad.ena = ad.run = 0;
> -			ad.nr = 0;
> -			if (!collect_data(config, counter, aggr_cb, &ad))
> -				continue;
> -			nr = ad.nr;
> -			ena = ad.ena;
> -			run = ad.run;
> -			val = ad.val;
> -			if (first && metric_only) {
> -				first = false;
> -				aggr_printout(config, counter, id, nr);
> -			}
> -			if (prefix && !metric_only)
> -				fprintf(output, "%s", prefix);
> -
> -			uval = val * counter->scale;
> -			printout(config, id, nr, counter, uval, prefix,
> -				 run, ena, 1.0, &rt_stat);
> -			if (!metric_only)
> -				fputc('\n', output);
> +			print_counter_aggrdata(config, counter, s,
> +					       prefix, metric_only,
> +					       &first);

SNIP
