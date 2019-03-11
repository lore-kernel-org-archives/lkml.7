Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37097C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22032075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6NbYU+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCKRJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:09:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33510 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKRJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:09:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id x9so3159854qkf.0;
        Mon, 11 Mar 2019 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GYyFo9Ke4R9b+Qc9mZN2Q1BR1TWCxwJbKNme/IMKmjQ=;
        b=l6NbYU+YLoj8D7vdRsQZ5DAYOflt3N3bmSZr2CfsaCCHSVHHLmVUFphhqVPxspxWZh
         S04rOWi+IpP3HL1YpMI2VUaBagGtInkfdSEDe8lKjJoLS2JBRZcq9bqCJLnu/IS+mCT9
         qEF/C/LOBwu/ByCGcLtpZKaLih9mYax0KUQ7oS5C0a+RZ15RTELNafA2vhpAIYK6zl6u
         3F5n3jaI2OQ0pQzfFqfnA/VhNIcHzEuUFo8FnRz798hzMU+lPXX6UYJKRvkSvIcrJzm0
         LXWeaa1h3BnJeCVHXf2J38pHRZELFXz0rcwid3R7T2odqDuBYS/NdsS8nkBGy0oNx3I4
         a0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYyFo9Ke4R9b+Qc9mZN2Q1BR1TWCxwJbKNme/IMKmjQ=;
        b=qL4uJC6KUj4mfBIEtI91WTQBs1xoOaG5VVVbWDnF5LpM0M33dYhlipZIV1RwaCMSw7
         R5cdvJZWY/AlVWOyZNJ//DN7DRpmzwDItEl1fnwjw+UL1LhMkD8q9YlpbX38R+XYL7m8
         MwT2o+ltoNeW/8dp8OymNizTofByNm2llSFIMKhX2LLEDLiJTR/RwPS9dRcGPkcs7Lit
         YXuMBaufS16py402OaSlbuXTvEzsZSuSEyYCkPWDU2pLI7D+kOt1UqPe2K/8k2K0BlGY
         HEXlZDDq9HGPkck7zepIdBrahuXxIWUT48Ur+fAAYtzPcEmojLD6XdmaGB7vXesyG1pL
         Snfg==
X-Gm-Message-State: APjAAAUbnOFQusf2RbDZBMOul/MAQy9QsEfWk2I1Bg9mZGQN5a8giedn
        cqiAGhROcAc81Zt6garW4waoNUjf60U=
X-Google-Smtp-Source: APXvYqyY6K4p2UPSEdS9WBuMMbFJQUkpc5Ch4rn4NEIduDX1X8CG2VizUhGSnJo1rdA1l6/rq7DiyA==
X-Received: by 2002:a37:4fd5:: with SMTP id d204mr25298565qkb.90.1552324148702;
        Mon, 11 Mar 2019 10:09:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id w8sm5282461qkw.80.2019.03.11.10.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:09:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F27A34039C; Mon, 11 Mar 2019 14:09:04 -0300 (-03)
Date:   Mon, 11 Mar 2019 14:09:04 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 06/11] perf tools report: Support builtin perf script
 in scripts menu
Message-ID: <20190311170904.GS10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-7-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-7-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:57AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The scripts menu traditionally only showed custom perf scripts.
> 
> Allow to run standard perf script with useful default options too.

Thanks, applied.
 
> - Normal perf script
> - perf script with assembler (needs xed installed)
> - perf script with source code output (needs debuginfo)
> - perf script with custom arguments
> 
> Then we automatically select the right options to
> display the information in the perf.data file.
> 
> For example with -b display branch contexts.
> 
> It's not easily possible to check for xed's existence
> in advance.  perf script usually gives sensible error messages when
> it's not available.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2:
> Pass --inline if needed
> v3:
> Avoid compiler warnings. Allocate cmd buffer dynamically.
> Change formatting
> ---
>  tools/perf/ui/browsers/annotate.c |   2 +-
>  tools/perf/ui/browsers/hists.c    |  23 +++---
>  tools/perf/ui/browsers/scripts.c  | 127 +++++++++++++++++++++++-------
>  tools/perf/util/hist.h            |   8 +-
>  4 files changed, 120 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 35bdfd8b1e71..98d934a36d86 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -750,7 +750,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  			continue;
>  		case 'r':
>  			{
> -				script_browse(NULL);
> +				script_browse(NULL, NULL);
>  				continue;
>  			}
>  		case 'k':
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index f98aeac607dd..fb4430f8982c 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2344,6 +2344,7 @@ struct popup_action {
>  	struct thread 		*thread;
>  	struct map_symbol 	ms;
>  	int			socket;
> +	struct perf_evsel	*evsel;
>  
>  	int (*fn)(struct hist_browser *browser, struct popup_action *act);
>  };
> @@ -2566,7 +2567,7 @@ do_run_script(struct hist_browser *browser __maybe_unused,
>  		n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
>  	}
>  
> -	script_browse(script_opt);
> +	script_browse(script_opt, act->evsel);
>  	free(script_opt);
>  	return 0;
>  }
> @@ -2575,7 +2576,7 @@ static int
>  add_script_opt_2(struct hist_browser *browser __maybe_unused,
>  	       struct popup_action *act, char **optstr,
>  	       struct thread *thread, struct symbol *sym,
> -	       const char *tstr)
> +	       struct perf_evsel *evsel, const char *tstr)
>  {
>  
>  	if (thread) {
> @@ -2593,6 +2594,7 @@ add_script_opt_2(struct hist_browser *browser __maybe_unused,
>  
>  	act->thread = thread;
>  	act->ms.sym = sym;
> +	act->evsel = evsel;
>  	act->fn = do_run_script;
>  	return 1;
>  }
> @@ -2600,12 +2602,13 @@ add_script_opt_2(struct hist_browser *browser __maybe_unused,
>  static int
>  add_script_opt(struct hist_browser *browser,
>  	       struct popup_action *act, char **optstr,
> -	       struct thread *thread, struct symbol *sym)
> +	       struct thread *thread, struct symbol *sym,
> +	       struct perf_evsel *evsel)
>  {
>  	int n, j;
>  	struct hist_entry *he;
>  
> -	n = add_script_opt_2(browser, act, optstr, thread, sym, "");
> +	n = add_script_opt_2(browser, act, optstr, thread, sym, evsel, "");
>  
>  	he = hist_browser__selected_entry(browser);
>  	if (sort_order && strstr(sort_order, "time")) {
> @@ -2618,10 +2621,9 @@ add_script_opt(struct hist_browser *browser,
>  					       sizeof tstr - j);
>  		j += sprintf(tstr + j, "-");
>  		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
> -				          tstr + j,
> -				          sizeof tstr - j);
> +				          tstr + j, sizeof tstr - j);
>  		n += add_script_opt_2(browser, act, optstr, thread, sym,
> -					  tstr);
> +					  evsel, tstr);
>  		act->time = he->time;
>  	}
>  	return n;
> @@ -3092,7 +3094,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
>  				nr_options += add_script_opt(browser,
>  							     &actions[nr_options],
>  							     &options[nr_options],
> -							     thread, NULL);
> +							     thread, NULL, evsel);
>  			}
>  			/*
>  			 * Note that browser->selection != NULL
> @@ -3107,11 +3109,12 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
>  				nr_options += add_script_opt(browser,
>  							     &actions[nr_options],
>  							     &options[nr_options],
> -							     NULL, browser->selection->sym);
> +							     NULL, browser->selection->sym,
> +							     evsel);
>  			}
>  		}
>  		nr_options += add_script_opt(browser, &actions[nr_options],
> -					     &options[nr_options], NULL, NULL);
> +					     &options[nr_options], NULL, NULL, evsel);
>  		nr_options += add_switch_opt(browser, &actions[nr_options],
>  					     &options[nr_options]);
>  skip_scripting:
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 7f36630694bf..9e5f87558af6 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -17,36 +17,111 @@
>   */
>  #define SCRIPT_FULLPATH_LEN	256
>  
> +struct script_config {
> +	const char **names;
> +	char **paths;
> +	int index;
> +	const char *perf;
> +	char extra_format[256];
> +};
> +
> +void attr_to_script(char *extra_format, struct perf_event_attr *attr)
> +{
> +	extra_format[0] = 0;
> +	if (attr->read_format & PERF_FORMAT_GROUP)
> +		strcat(extra_format, " -F +metric");
> +	if (attr->sample_type & PERF_SAMPLE_BRANCH_STACK)
> +		strcat(extra_format, " -F +brstackinsn --xed");
> +	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
> +		strcat(extra_format, " -F +iregs");
> +	if (attr->sample_type & PERF_SAMPLE_REGS_USER)
> +		strcat(extra_format, " -F +uregs");
> +	if (attr->sample_type & PERF_SAMPLE_PHYS_ADDR)
> +		strcat(extra_format, " -F +phys_addr");
> +}
> +
> +static int add_script_option(const char *name, const char *opt,
> +			     struct script_config *c)
> +{
> +	c->names[c->index] = name;
> +	if (asprintf(&c->paths[c->index],
> +		     "%s script %s -F +metric %s %s",
> +		     c->perf, opt, symbol_conf.inline_name ? " --inline" : "",
> +		     c->extra_format) < 0)
> +		return -1;
> +	c->index++;
> +	return 0;
> +}
> +
>  /*
>   * When success, will copy the full path of the selected script
>   * into  the buffer pointed by script_name, and return 0.
>   * Return -1 on failure.
>   */
> -static int list_scripts(char *script_name)
> +static int list_scripts(char *script_name, bool *custom,
> +			struct perf_evsel *evsel)
>  {
> -	char *buf, *names[SCRIPT_MAX_NO], *paths[SCRIPT_MAX_NO];
> -	int i, num, choice, ret = -1;
> +	char *buf, *paths[SCRIPT_MAX_NO], *names[SCRIPT_MAX_NO];
> +	int i, num, choice;
> +	int ret = 0;
> +	int max_std, custom_perf;
> +	char pbuf[256];
> +	const char *perf = perf_exe(pbuf, sizeof pbuf);
> +	struct script_config scriptc = {
> +		.names = (const char **)names,
> +		.paths = paths,
> +		.perf = perf
> +	};
> +
> +	script_name[0] = 0;
>  
>  	/* Preset the script name to SCRIPT_NAMELEN */
>  	buf = malloc(SCRIPT_MAX_NO * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN));
>  	if (!buf)
> -		return ret;
> +		return -1;
> +
> +	if (evsel)
> +		attr_to_script(scriptc.extra_format, &evsel->attr);
> +	add_script_option("Show individual samples", "", &scriptc);
> +	add_script_option("Show individual samples with assembler", "-F +insn --xed",
> +			  &scriptc);
> +	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
> +			  &scriptc);
> +	custom_perf = scriptc.index;
> +	add_script_option("Show samples with custom perf script arguments", "", &scriptc);
> +	i = scriptc.index;
> +	max_std = i;
>  
> -	for (i = 0; i < SCRIPT_MAX_NO; i++) {
> -		names[i] = buf + i * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN);
> +	for (; i < SCRIPT_MAX_NO; i++) {
> +		names[i] = buf + (i - max_std) * (SCRIPT_NAMELEN + SCRIPT_FULLPATH_LEN);
>  		paths[i] = names[i] + SCRIPT_NAMELEN;
>  	}
>  
> -	num = find_scripts(names, paths);
> -	if (num > 0) {
> -		choice = ui__popup_menu(num, names);
> -		if (choice < num && choice >= 0) {
> -			strcpy(script_name, paths[choice]);
> -			ret = 0;
> -		}
> +	num = find_scripts(names + max_std, paths + max_std);
> +	if (num < 0)
> +		num = 0;
> +	choice = ui__popup_menu(num + max_std, (char * const *)names);
> +	if (choice < 0) {
> +		ret = -1;
> +		goto out;
>  	}
> +	if (choice == custom_perf) {
> +		char script_args[50];
> +		int key = ui_browser__input_window("perf script command",
> +				"Enter perf script command line (without perf script prefix)",
> +				script_args, "", 0);
> +		if (key != K_ENTER)
> +			return -1;
> +		sprintf(script_name, "%s script %s", perf, script_args);
> +	} else if (choice < num + max_std) {
> +		strcpy(script_name, paths[choice]);
> +	}
> +	*custom = choice >= max_std;
>  
> +out:
>  	free(buf);
> +	for (i = 0; i < max_std; i++)
> +		free(paths[i]);
>  	return ret;
>  }
>  
> @@ -66,27 +141,25 @@ static void run_script(char *cmd)
>  	SLsmg_refresh();
>  }
>  
> -int script_browse(const char *script_opt)
> +int script_browse(const char *script_opt, struct perf_evsel *evsel)
>  {
> -	char cmd[SCRIPT_FULLPATH_LEN*2], script_name[SCRIPT_FULLPATH_LEN];
> +	char *cmd, script_name[SCRIPT_FULLPATH_LEN];
> +	bool custom = false;
>  
>  	memset(script_name, 0, SCRIPT_FULLPATH_LEN);
> -	if (list_scripts(script_name))
> +	if (list_scripts(script_name, &custom, evsel))
>  		return -1;
>  
> -	sprintf(cmd, "perf script -s %s ", script_name);
> -
> -	if (script_opt)
> -		strcat(cmd, script_opt);
> -
> -	if (input_name) {
> -		strcat(cmd, " -i ");
> -		strcat(cmd, input_name);
> -	}
> -
> -	strcat(cmd, " 2>&1 | less");
> +	if (asprintf(&cmd, "%s%s %s %s%s 2>&1 | less",
> +			custom ? "perf script -s " : "",
> +			script_name,
> +			script_opt ? script_opt : "",
> +			input_name ? "-i " : "",
> +			input_name ? input_name : "") < 0)
> +		return -1;
>  
>  	run_script(cmd);
> +	free(cmd);
>  
>  	return 0;
>  }
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 6279eca56409..2113a6639cea 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -436,6 +436,8 @@ struct annotation_options;
>  
>  #ifdef HAVE_SLANG_SUPPORT
>  #include "../ui/keysyms.h"
> +void attr_to_script(char *buf, struct perf_event_attr *attr);
> +
>  int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
>  			     struct hist_browser_timer *hbt,
>  			     struct annotation_options *annotation_opts);
> @@ -450,7 +452,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
>  				  struct perf_env *env,
>  				  bool warn_lost_event,
>  				  struct annotation_options *annotation_options);
> -int script_browse(const char *script_opt);
> +
> +int script_browse(const char *script_opt, struct perf_evsel *evsel);
>  #else
>  static inline
>  int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
> @@ -479,7 +482,8 @@ static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
>  	return 0;
>  }
>  
> -static inline int script_browse(const char *script_opt __maybe_unused)
> +static inline int script_browse(const char *script_opt __maybe_unused,
> +				struct perf_evsel *evsel __maybe_unused)
>  {
>  	return 0;
>  }
> -- 
> 2.20.1

-- 

- Arnaldo
