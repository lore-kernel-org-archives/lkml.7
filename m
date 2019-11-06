Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB88C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D82C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNtZDjxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfKFUAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:00:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45185 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFUAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:00:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so25755570qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdHGX85NuSXpuKb+v6CLEXA54COcOzGEih/czBtcds0=;
        b=dNtZDjxAJTBD+6ONSgBs1YbSW2rb9jiZ++eQsjHiSFZvEDCf/Rd/vQoANGEkBHHE+/
         Qw2fzgPect47K4Kd6hqV3hi98ya9y7rHDep+m1uMn6S9TlCM9k4nGG3HSISsyAkKKRJI
         Nrlo+vd10FH305RjGch9MxyJe9ADjAz9c8TpPt6C+5hWSkCqWVy4PG68BelOqnDsZbg5
         BR8/yxglsYpWf4xIvyRy59x/cWtc/c3tZZjO95CC+1Nh2ST4i9LQPGJNMruRGIOh9Oil
         9Q5O5PrMiAZLKqTirjk75MWt21ZwIhxeAxN7Qu4/NjRI1SQe4ktFQw8dffYiK0Mn7WIo
         50nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdHGX85NuSXpuKb+v6CLEXA54COcOzGEih/czBtcds0=;
        b=arbr8KGDeLv10K0PGV0bBYrjZ7W6tw3RrfFZUYmHIyl2GM56gcKLtN+qPRiI6mZAKs
         X9qotVXtbPTfHPWAiTG9raHtii82Ay+RYEU+Eg7DjsS5mmAKKV+HRP8jDnh6homXwSP/
         dDQTo4oBNFWxWQ1AY6mDMmSoy5oK9kf7OrKSKIl7IhSw+2SgTsu59KeBLKRbRQklMGFA
         ZAPawFbFxsvJc+XSkJUu8EYCcx9lG4ydeIpPFhA+D1PLMqX/eF7KkOnQIhOnkMYNhqwD
         5csZRVmdmJEIn3m93xE4jljIG2q8rnQyrsUeSpXeOjCon1vcwFTxyuVwnthuFxC10+6k
         S84Q==
X-Gm-Message-State: APjAAAWU7rJ75ZxlfNbICi4uxkdes8HUmCOrHytJBtvvJv4arVni4p1F
        9bTCC4m5F0PdAbRxUyka/Xc=
X-Google-Smtp-Source: APXvYqwCxS97Uurs3b2yXYIw0NEEy4BGweu5f2CDacutmsILEaxcSC6OmbYFxkLZo+6jfTbuqtLGcA==
X-Received: by 2002:a37:a281:: with SMTP id l123mr3761910qke.135.1573070413263;
        Wed, 06 Nov 2019 12:00:13 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id j7sm9416672qkd.46.2019.11.06.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 12:00:12 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1119940B1D; Wed,  6 Nov 2019 17:00:04 -0300 (-03)
Date:   Wed, 6 Nov 2019 17:00:04 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 5/5] perf probe: Trace a magic number if variable is not
 found
Message-ID: <20191106200004.GA13829@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
 <157291304860.19771.9006634463376439737.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157291304860.19771.9006634463376439737.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 05, 2019 at 09:17:28AM +0900, Masami Hiramatsu escreveu:
> Trace a magic number as immediate value if the target variable
> is not found at some probe points which is based on one probe
> event.
> 
> This feature is good for the case if you trace a source code
> line with some local variables, which is compiled into several
> instructions and some of the variables are optimized out on
> some instructions. Even if so, with this feature, perf probe
> trace a magic number instead of such disappeared variables and
> fold those probes on one event.

This too depends on a function introduced in previous patches on hold.

- Arnaldo
 
> E.g. without this patch,
> # perf probe -D "pud_page_vaddr pud"
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> Failed to find 'pud' in this function.
> p:probe/pud_page_vaddr_L0 _text+23480787 pud=%ax:x64
> p:probe/pud_page_vaddr_L0 _text+23808289 pud=%bp:x64
> p:probe/pud_page_vaddr_L0 _text+23558066 pud=%ax:x64
> p:probe/pud_page_vaddr_L0 _text+327957 pud=%r8:x64
> p:probe/pud_page_vaddr_L0 _text+348032 pud=%bx:x64
> p:probe/pud_page_vaddr_L0 _text+23816654 pud=%bx:x64
> 
> With this patch,
> # perf probe -D "pud_page_vaddr pud" | head -n 10
> spurious_kernel_fault is blacklisted function, skip it.
> vmalloc_fault is blacklisted function, skip it.
> p:probe/pud_page_vaddr_L0 _text+23480787 pud=%ax:x64
> p:probe/pud_page_vaddr_L0 _text+148635 pud=\deade12d:x64
> p:probe/pud_page_vaddr_L0 _text+23808289 pud=%bp:x64
> p:probe/pud_page_vaddr_L0 _text+315510 pud=\deade12d:x64
> p:probe/pud_page_vaddr_L0 _text+23807045 pud=\deade12d:x64
> p:probe/pud_page_vaddr_L0 _text+23557349 pud=%ax:x64
> p:probe/pud_page_vaddr_L0 _text+313681 pud=%di:x64
> p:probe/pud_page_vaddr_L0 _text+313599 pud=\deade12d:x64
> p:probe/pud_page_vaddr_L0 _text+313477 pud=\deade12d:x64
> p:probe/pud_page_vaddr_L0 _text+323667 pud=\deade12d:x64
> 
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c  |    2 +
>  tools/perf/util/probe-event.h  |    3 ++
>  tools/perf/util/probe-finder.c |   62 +++++++++++++++++++++++++++++++++++++---
>  tools/perf/util/probe-finder.h |    1 +
>  4 files changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 23db6786c3ea..ceeb75849311 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -46,7 +46,7 @@
>  #define PERFPROBE_GROUP "probe"
>  
>  bool probe_event_dry_run;	/* Dry run flag */
> -struct probe_conf probe_conf;
> +struct probe_conf probe_conf = { .magic_num = DEFAULT_PROBE_MAGIC_NUM };
>  
>  #define semantic_error(msg ...) pr_err("Semantic error :" msg)
>  
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 96a319cd2378..4f0eb3a20c36 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -16,10 +16,13 @@ struct probe_conf {
>  	bool	no_inlines;
>  	bool	cache;
>  	int	max_probes;
> +	unsigned long	magic_num;
>  };
>  extern struct probe_conf probe_conf;
>  extern bool probe_event_dry_run;
>  
> +#define DEFAULT_PROBE_MAGIC_NUM	0xdeade12d	/* u32: 3735937325 */
> +
>  struct symbol;
>  
>  /* kprobe-tracer and uprobe-tracer tracing point */
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 2e3a468c8350..eff6063bebe6 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -536,6 +536,14 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
>  		return 0;
>  }
>  
> +static void print_var_not_found(const char *varname)
> +{
> +	pr_err("Failed to find the location of the '%s' variable at this address.\n"
> +	       " Perhaps it has been optimized out.\n"
> +	       " Use -V with the --range option to show '%s' location range.\n",
> +		varname, varname);
> +}
> +
>  /* Show a variables in kprobe event format */
>  static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
>  {
> @@ -547,11 +555,11 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
>  
>  	ret = convert_variable_location(vr_die, pf->addr, pf->fb_ops,
>  					&pf->sp_die, pf->machine, pf->tvar);
> +	if (ret == -ENOENT && pf->skip_empty_arg)
> +		/* This can be found in other place. skip it */
> +		return 0;
>  	if (ret == -ENOENT || ret == -EINVAL) {
> -		pr_err("Failed to find the location of the '%s' variable at this address.\n"
> -		       " Perhaps it has been optimized out.\n"
> -		       " Use -V with the --range option to show '%s' location range.\n",
> -		       pf->pvar->var, pf->pvar->var);
> +		print_var_not_found(pf->pvar->var);
>  	} else if (ret == -ENOTSUP)
>  		pr_err("Sorry, we don't support this variable location yet.\n");
>  	else if (ret == 0 && pf->pvar->field) {
> @@ -598,6 +606,8 @@ static int find_variable(Dwarf_Die *sc_die, struct probe_finder *pf)
>  		/* Search again in global variables */
>  		if (!die_find_variable_at(&pf->cu_die, pf->pvar->var,
>  						0, &vr_die)) {
> +			if (pf->skip_empty_arg)
> +				return 0;
>  			pr_warning("Failed to find '%s' in this function.\n",
>  				   pf->pvar->var);
>  			ret = -ENOENT;
> @@ -1348,6 +1358,44 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
>  	return ret;
>  }
>  
> +static int fill_empty_trace_arg(struct perf_probe_event *pev,
> +				struct probe_trace_event *tevs, int ntevs)
> +{
> +	char **valp;
> +	char *type;
> +	int i, j, ret;
> +
> +	for (i = 0; i < pev->nargs; i++) {
> +		type = NULL;
> +		for (j = 0; j < ntevs; j++) {
> +			if (tevs[j].args[i].value) {
> +				type = tevs[j].args[i].type;
> +				break;
> +			}
> +		}
> +		if (j == ntevs) {
> +			print_var_not_found(pev->args[i].var);
> +			return -ENOENT;
> +		}
> +		for (j = 0; j < ntevs; j++) {
> +			valp = &tevs[j].args[i].value;
> +			if (*valp)
> +				continue;
> +
> +			ret = asprintf(valp, "\\%lx", probe_conf.magic_num);
> +			if (ret < 0)
> +				return -ENOMEM;
> +			/* Note that type can be NULL */
> +			if (type) {
> +				tevs[j].args[i].type = strdup(type);
> +				if (!tevs[j].args[i].type)
> +					return -ENOMEM;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
>  /* Find probe_trace_events specified by perf_probe_event from debuginfo */
>  int debuginfo__find_trace_events(struct debuginfo *dbg,
>  				 struct perf_probe_event *pev,
> @@ -1366,7 +1414,13 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
>  	tf.tevs = *tevs;
>  	tf.ntevs = 0;
>  
> +	if (pev->event && pev->nargs != 0 && immediate_value_is_supported())
> +		tf.pf.skip_empty_arg = true;
> +
>  	ret = debuginfo__find_probes(dbg, &tf.pf);
> +	if (ret >= 0 && tf.pf.skip_empty_arg)
> +		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> +
>  	if (ret < 0) {
>  		for (i = 0; i < tf.ntevs; i++)
>  			clear_probe_trace_event(&tf.tevs[i]);
> diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
> index 670c477bf8cf..11be10080613 100644
> --- a/tools/perf/util/probe-finder.h
> +++ b/tools/perf/util/probe-finder.h
> @@ -87,6 +87,7 @@ struct probe_finder {
>  	unsigned int		machine;	/* Target machine arch */
>  	struct perf_probe_arg	*pvar;		/* Current target variable */
>  	struct probe_trace_arg	*tvar;		/* Current result variable */
> +	bool			skip_empty_arg;	/* Skip non-exist args */
>  };
>  
>  struct trace_event_finder {

-- 

- Arnaldo
