Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B322BC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B020848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Elvi86E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgABP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:26:53 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36884 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgABP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:26:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id z64so6670552oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 07:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HLORyds+NQWYZGd68wv5Oj9rb3JjV8dWr7/C7YSQkes=;
        b=Elvi86E9yh9iJOufOMAOq6PFcwaTKL7yZjpzZR/rZek4q/FijUoS0A7Xds0G3Zi8R8
         kFVbeuKGn/arq+tm8k/PI7GfIPVgv8QAoOM7zuOsvW1Bs5MgXWBMNL1P8R+DvnfGKRVg
         gdHEN1ty4H1PpXzG/5//0YHeuhoMXF4zf4ZJ4McgnpZn4wiDvvKCEV34LbYN0FYaQ+jF
         Ng61RumMjYK3giunLN7C/m1KqLntY7RPsZHbM0CHxZoBcMFGxJRk4PLpSNl4y3kFCNpl
         7JTzsffrcuKYBZShdbrV9jN9+NND1of7BNa6CQdrznv4RkOADMfChoyJx1BZQFA0nPy1
         Zh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLORyds+NQWYZGd68wv5Oj9rb3JjV8dWr7/C7YSQkes=;
        b=ZNpTtMcrzhuQIX1p1sHQ6yCKGhyO9CRFvoo9AN5mn38m2jxqLaB/DDQBrCx4uZZRPH
         6ID3JsrGmitVoSvgjlDKerA9vaSVbu32lu6whclkjuFR4P+LPnvqbQtxhUTi/zna4faZ
         dYgy9zij3u2jtZknM2Ewbs/I6ujQmDam5gcsExFtSmXpX+fBswudSp/8eaVXRUOvx+EI
         EJhJhoBGBLgZLKmuZOztcgzuLWYzo0dHm0O0zOzCHAL8/paVZhm9SsWVCKz3Pha4w+xA
         CqoVPHMG7Cgyw0qn3jav4IRo0LXNAcNsfcg1LUe9Tatgk9KfTU3ZW1B5qalTFvhwkrFy
         EOQQ==
X-Gm-Message-State: APjAAAU83K3Gr8d32vMKkk9lKMjASG/ePjdBWkvNgyrjTbyZ5fpPLuK/
        9DYifAXC0IoFzQtaN55Jre8jYw==
X-Google-Smtp-Source: APXvYqw3dnPWmHZ2y0eR66N9Qoyw1AUzVs831f1fOm5Ig+ZSnE9AvNdfqL7S9Qp1QXqkPS/RIhThXQ==
X-Received: by 2002:a05:6808:24e:: with SMTP id m14mr2374117oie.168.1577978812068;
        Thu, 02 Jan 2020 07:26:52 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id j10sm14445065otr.64.2020.01.02.07.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 07:26:51 -0800 (PST)
Date:   Thu, 2 Jan 2020 23:26:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200102152641.GA31626@leoy-ThinkPad-X240s>
References: <20200102151326.31342-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102151326.31342-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 11:13:26PM +0800, Leo Yan wrote:
> perf with CoreSight fails to record trace data with command:
> 
>   perf record -e cs_etm/@tmc_etr0/u --per-thread ls
>   failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
>   directory)/perf/
> 
> This failure is root caused with the commit 1dc925568f01 ("perf
> parse: Add a deep delete for parse event terms").
> 
> The log shows, cs_etm fails to parse the sink attribution; cs_etm event
> relies on the event configuration to pass sink name, but the event
> specific configuration data cannot be passed properly with flow:
> 
>   get_config_terms()
>     ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
>       __t->val.drv_cfg = term->val.str;
>         `> __t->val.drv_cfg is assigned to term->val.str;
> 
>   parse_events_terms__purge()
>     parse_events_term__delete()
>       zfree(&term->val.str);
>         `> term->val.str is freed and assigned to NULL pointer;
> 
>   cs_etm_set_sink_attr()
>     sink = __t->val.drv_cfg;
>       `> sink string has been freed.
> 
> To fix this issue, in the function get_config_terms(), this patch
> changes from directly assignment pointer value for the strings to
> use strdup() for allocation a new duplicate string for the cases:
> 
>   perf_evsel_config_term::val.callgraph
>   perf_evsel_config_term::val.branch
>   perf_evsel_config_term::val.drv_cfg.
> 
> Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Let me to loop Mathieu/Mike/Suzuki, sorry for spamming.

Thanks,
Leo

> ---
>  tools/perf/util/parse-events.c | 49 ++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ed7c008b9c8b..5972acdd40d6 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1220,7 +1220,6 @@ static int get_config_terms(struct list_head *head_config,
>  			    struct list_head *head_terms __maybe_unused)
>  {
>  #define ADD_CONFIG_TERM(__type, __name, __val)			\
> -do {								\
>  	struct perf_evsel_config_term *__t;			\
>  								\
>  	__t = zalloc(sizeof(*__t));				\
> @@ -1229,9 +1228,19 @@ do {								\
>  								\
>  	INIT_LIST_HEAD(&__t->list);				\
>  	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
> -	__t->val.__name = __val;				\
>  	__t->weak	= term->weak;				\
> -	list_add_tail(&__t->list, head_terms);			\
> +	list_add_tail(&__t->list, head_terms)
> +
> +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
> +do {								\
> +	ADD_CONFIG_TERM(__type, __name, __val);			\
> +	__t->val.__name = __val;				\
> +} while (0)
> +
> +#define ADD_CONFIG_TERM_STR(__type, __name, __val)		\
> +do {								\
> +	ADD_CONFIG_TERM(__type, __name, __val);			\
> +	__t->val.__name = strdup(__val);			\
>  } while (0)
>  
>  	struct parse_events_term *term;
> @@ -1239,53 +1248,53 @@ do {								\
>  	list_for_each_entry(term, head_config, list) {
>  		switch (term->type_term) {
>  		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> -			ADD_CONFIG_TERM(PERIOD, period, term->val.num);
> +			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> -			ADD_CONFIG_TERM(FREQ, freq, term->val.num);
> +			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_TIME:
> -			ADD_CONFIG_TERM(TIME, time, term->val.num);
> +			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> -			ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
> +			ADD_CONFIG_TERM_STR(CALLGRAPH, callgraph, term->val.str);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> -			ADD_CONFIG_TERM(BRANCH, branch, term->val.str);
> +			ADD_CONFIG_TERM_STR(BRANCH, branch, term->val.str);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> -			ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
> +			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_INHERIT:
> -			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 1 : 0);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> -			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
> +			ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 0 : 1);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> -			ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
> +			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> -			ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
> +			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> -			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 1 : 0);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> -			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
> +			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 0 : 1);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> -			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
> +			ADD_CONFIG_TERM_STR(DRV_CFG, drv_cfg, term->val.str);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_PERCORE:
> -			ADD_CONFIG_TERM(PERCORE, percore,
> +			ADD_CONFIG_TERM_VAL(PERCORE, percore,
>  					term->val.num ? true : false);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> -			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> -			ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
> +			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
>  			break;
>  		default:
>  			break;
> @@ -1322,7 +1331,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
>  	}
>  
>  	if (bits)
> -		ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
> +		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
>  
>  #undef ADD_CONFIG_TERM
>  	return 0;
> -- 
> 2.17.1
> 
