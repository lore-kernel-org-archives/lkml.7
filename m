Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94009C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4363D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA9aubuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfDJMgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:36:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41290 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfDJMgq (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:36:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so2560971qta.8
        for <Linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6nOlimu+/imNrs25k+yVT7P82Yb3twc73LKhn//gGHA=;
        b=JA9aubuWfWVNsClXByYAQWJLQWGl46cLD1LJc1evjTtsgFIYekng8U6VnFHIWOFyzl
         tZ+t0OiQDi1Ms8yhNLv/Cyp1BmHn/e+KFojpSgZ/xoswqu2X9qKKw63iC+R4fr1Yj86o
         HcTDJRLyH/6Q1efADpqHe0Md083/4BYWs2dZNPcjL7jal3RnEaiDQPPRzaCgJphZY9bz
         RsA55CZXSyJhaGGPznBSKIQsjxg20ZWeJozuv7zIW9Rpu5jBD3yu0YO8GZegHmm23CK1
         y6CPuqUsF0aHRkLV7HtVdp437B6fBzNNeSFbgK9QfTQn05MKuB1ciFbZeDaTSHbjgNGb
         IU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6nOlimu+/imNrs25k+yVT7P82Yb3twc73LKhn//gGHA=;
        b=P5iE6jgRezySWE2UoDYn+d+8WvRAR4InQer/J5VJPkB/bud++zCLqE2Fy6nTnBfL7h
         MdMlYg3oOwZkajoyi3XFTV9cxRFqzjJh4nmDZ+cB2BuAFttq+Ynb8vEaovQN4JdtzizT
         P39cJDJ6kdeIaQxdOvlmwysnOAgBRYmXXrOb6ugTA7ovLbzLzz1H8AllgeGYYo80457k
         qWXVzAU/1i50L04ZfXSsEnWqHFe4VWgNfCyYY8TQjBNuD0F4g++MHPz90lYf3xPc7rpf
         hOYqx8Iq30t+TaZ1VtT6VKeERVsi9lpRRMOn+ugtsGiwCH5SlKeQWN7eY5qDJNCvUPlH
         2Low==
X-Gm-Message-State: APjAAAUwS9bc2Z1oLMBswYLUyscCnqJiU9jUFyeYNeRmCIamSw/XIVv7
        DS/4CR6xjZVnHtItyegIoX8gJfzw
X-Google-Smtp-Source: APXvYqzK6hgnBfnYFyUx+mrZH2o3PQAfyG019sEx7f0WcjZB5jE0uhCSqgmZv2OH3NyotQxoIiqOXA==
X-Received: by 2002:aed:2188:: with SMTP id l8mr10865497qtc.332.1554899805167;
        Wed, 10 Apr 2019 05:36:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id l6sm19931643qtd.0.2019.04.10.05.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 05:36:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75B1C4039C; Wed, 10 Apr 2019 09:36:41 -0300 (-03)
Date:   Wed, 10 Apr 2019 09:36:41 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/4] perf: Add a 'percore' event qualifier
Message-ID: <20190410123641.GA13888@kernel.org>
References: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
 <1552985816-20915-2-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552985816-20915-2-git-send-email-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 04:56:53PM +0800, Jin Yao escreveu:
> Add a 'percore' event qualifier, like cpu/event=0,umask=0x3,percore=1/,
> that sums up the event counts for both hardware threads in a core.
> 
> We can already do this with --per-core, but it's often useful to do
> this together with other metrics that are collected per hardware thread.
> So we need to support this per-core counting on a event level.
> 
> This can be implemented in only the user tool, no kernel support needed.
> 
>  v3:
>  ---
>  Simplify the code according to Jiri's comments.
>  Before:
>    "return term->val.percore ? true : false;"
>  Now:
>    "return term->val.percore;"
> 
>  v2:
>  ---
>  Change the qualifier name from 'coresum' to 'percore' according to
>  comments from Jiri and Andi.

I'm applying this, but please, don't forget to, when adding a new
qualifier, to update the documentation... I'm doing this for you this
time.

- Arnaldo
 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evsel.c        |  2 ++
>  tools/perf/util/evsel.h        |  3 +++
>  tools/perf/util/parse-events.c | 27 +++++++++++++++++++++++++++
>  tools/perf/util/parse-events.h |  1 +
>  tools/perf/util/parse-events.l |  1 +
>  5 files changed, 34 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3bbf73e..b900157 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -803,6 +803,8 @@ static void apply_config_terms(struct perf_evsel *evsel,
>  			break;
>  		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
>  			break;
> +		case PERF_EVSEL__CONFIG_TERM_PERCORE:
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index cc578e0..fd86689 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -50,6 +50,7 @@ enum term_type {
>  	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
>  	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
>  	PERF_EVSEL__CONFIG_TERM_BRANCH,
> +	PERF_EVSEL__CONFIG_TERM_PERCORE,
>  };
>  
>  struct perf_evsel_config_term {
> @@ -67,6 +68,7 @@ struct perf_evsel_config_term {
>  		bool	overwrite;
>  		char	*branch;
>  		unsigned long max_events;
> +		bool	percore;
>  	} val;
>  	bool weak;
>  };
> @@ -150,6 +152,7 @@ struct perf_evsel {
>  	struct perf_evsel	**metric_events;
>  	bool			collect_stat;
>  	bool			weak_group;
> +	bool			percore;
>  	const char		*pmu_name;
>  };
>  
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 4dcc01b..f77be35 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -930,6 +930,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
>  	[PARSE_EVENTS__TERM_TYPE_OVERWRITE]		= "overwrite",
>  	[PARSE_EVENTS__TERM_TYPE_NOOVERWRITE]		= "no-overwrite",
>  	[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
> +	[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
>  };
>  
>  static bool config_term_shrinked;
> @@ -950,6 +951,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
>  	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
>  	case PARSE_EVENTS__TERM_TYPE_NAME:
>  	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> +	case PARSE_EVENTS__TERM_TYPE_PERCORE:
>  		return true;
>  	default:
>  		if (!err)
> @@ -1041,6 +1043,14 @@ do {									   \
>  	case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
>  		CHECK_TYPE_VAL(NUM);
>  		break;
> +	case PARSE_EVENTS__TERM_TYPE_PERCORE:
> +		CHECK_TYPE_VAL(NUM);
> +		if ((unsigned int)term->val.num > 1) {
> +			err->str = strdup("expected 0 or 1");
> +			err->idx = term->err_val;
> +			return -EINVAL;
> +		}
> +		break;
>  	default:
>  		err->str = strdup("unknown term");
>  		err->idx = term->err_term;
> @@ -1179,6 +1189,10 @@ do {								\
>  		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>  			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
>  			break;
> +		case PARSE_EVENTS__TERM_TYPE_PERCORE:
> +			ADD_CONFIG_TERM(PERCORE, percore,
> +					term->val.num ? true : false);
> +			break;
>  		default:
>  			break;
>  		}
> @@ -1233,6 +1247,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  			 get_config_name(head_config), &config_terms);
>  }
>  
> +static bool config_term_percore(struct list_head *config_terms)
> +{
> +	struct perf_evsel_config_term *term;
> +
> +	list_for_each_entry(term, config_terms, list) {
> +		if (term->type == PERF_EVSEL__CONFIG_TERM_PERCORE)
> +			return term->val.percore;
> +	}
> +
> +	return false;
> +}
> +
>  int parse_events_add_pmu(struct parse_events_state *parse_state,
>  			 struct list_head *list, char *name,
>  			 struct list_head *head_config,
> @@ -1305,6 +1331,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		evsel->metric_name = info.metric_name;
>  		evsel->pmu_name = name;
>  		evsel->use_uncore_alias = use_uncore_alias;
> +		evsel->percore = config_term_percore(&evsel->config_terms);
>  	}
>  
>  	return evsel ? 0 : -ENOMEM;
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 5ed035c..ad4fbf3 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -75,6 +75,7 @@ enum {
>  	PARSE_EVENTS__TERM_TYPE_NOOVERWRITE,
>  	PARSE_EVENTS__TERM_TYPE_OVERWRITE,
>  	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
> +	PARSE_EVENTS__TERM_TYPE_PERCORE,
>  	__PARSE_EVENTS__TERM_TYPE_NR,
>  };
>  
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 7805c71..7e9f8dc 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -274,6 +274,7 @@ inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
>  no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
>  overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
>  no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
> +percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
>  ,			{ return ','; }
>  "/"			{ BEGIN(INITIAL); return '/'; }
>  {name_minus}		{ return str(yyscanner, PE_NAME); }
> -- 
> 2.7.4

-- 

- Arnaldo
