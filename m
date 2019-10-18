Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280CACA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BF021897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOKNSUKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394287AbfJRQEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:04:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41284 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbfJRQEu (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:04:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so5751207qkg.8
        for <Linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2qNjrLijH8E5oqk0eQ0/FojyjkuavPo/W6OeacETx8=;
        b=iOKNSUKtjl0Mrs+WVoGfhAFrnTLUHiU60y1QBbYzbZjTKxqVGsVzWcNIO9DYD1+V6I
         y1bQHClzcxdlBKh+Rq1i7ACWmPJiHsRxM65lyGG4l7s9UXX2/XGAbWoF4VDeqNV5e/hq
         lLz+nfzTpb8w0JQIPwoCXr83ufLBy/nXDqRhqn8a6V+5j+UXdFTgt6nM0bBj6cYFT8vF
         T/JZHC9qpjYjEy8J6JQUbiYoplys2eYfxky5qaOOfjhu/DnxPsgFBuRSJbvmvLDWCssD
         8JTRSEKxQjmtv+xUUwDrlw4UaRJ4LdT30+29k8qAaYvlJF7WT8Z7gMcRXLPQM36qBzwC
         wexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2qNjrLijH8E5oqk0eQ0/FojyjkuavPo/W6OeacETx8=;
        b=tzuXPuE+7+0+YRaMS7tJra9jgPFf6rBn0sE0gI3mb7ze0c58lN6OSQHzkkz6pLLlm2
         HfOdZ+zULagFAaTYA/m6K/wNHhhdMrSItAeGkIJT2zF5jPh54AC5IbgFLJjOsjjapwuM
         3eb9L6eDUM6Ji9t8d2VGuuWU62YlX4z5bXXZR3HGm00wlmEMIysR4iHSDhC4Yba2wrDj
         5OuF6IvFi4QjCsxanhHK+bJyRL5ibfb95kktB6G62KwfEuRb72nE2TktqjBzywmFgHeb
         m1Qwjam3Ed0fwE4IbBnvtSpM7gqPAcqFETG9AT/1p16uXNitv4/hT+8Uywc1KImIT7dT
         cZcQ==
X-Gm-Message-State: APjAAAXTnpzD8D3Vcllc2/kyI1xAQBXb2u40jJADZntW3jtSlKqIyKUV
        tgrTsUVh2PuZX8Sg8BwbqvQ=
X-Google-Smtp-Source: APXvYqwP5jTpFU9PRGvXkCoRbKHf8dEnb5UuBeufKKrzeydPy4wzWKFZ621D9HrLRR2QVjhkWdWhtQ==
X-Received: by 2002:a05:620a:14ae:: with SMTP id x14mr2765368qkj.326.1571414688458;
        Fri, 18 Oct 2019 09:04:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h10sm3747960qtk.18.2019.10.18.09.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:04:47 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD1774DD66; Fri, 18 Oct 2019 13:04:44 -0300 (-03)
Date:   Fri, 18 Oct 2019 13:04:44 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf list: Hide deprecated events by default
Message-ID: <20191018160444.GA10682@kernel.org>
References: <20191015025357.8708-1-yao.jin@linux.intel.com>
 <69db965c-fdf3-0114-7317-8bf430b041a1@linux.intel.com>
 <20191018142412.GA1189@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018142412.GA1189@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 18, 2019 at 04:24:12PM +0200, Jiri Olsa escreveu:
> On Fri, Oct 18, 2019 at 10:09:44PM +0800, Jin, Yao wrote:
> > Since now we go back to this version, can this patch be accepted?
> 
> right, sry
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied.
 
> thanks,
> jirka
> 
> > 
> > Thanks
> > Jin Yao
> > 
> > On 10/15/2019 10:53 AM, Jin Yao wrote:
> > > There are some deprecated events listed by perf list. But we can't remove
> > > them from perf list with ease because some old scripts may use them.
> > > 
> > > Deprecated events are old names of renamed events.  When an event gets
> > > renamed the old name is kept around for some time and marked with
> > > Deprecated. The newer Intel event lists in the tree already have these
> > > headers.
> > > 
> > > So we need to keep them in the event list, but provide a new option to
> > > show them. The new option is "--deprecated".
> > > 
> > > With this patch, the deprecated events are hidden by default but they can
> > > be displayed when option "--deprecated" is enabled.
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/Documentation/perf-list.txt |  3 +++
> > >   tools/perf/builtin-list.c              | 14 ++++++++++----
> > >   tools/perf/pmu-events/jevents.c        | 26 ++++++++++++++++++++------
> > >   tools/perf/pmu-events/jevents.h        |  3 ++-
> > >   tools/perf/pmu-events/pmu-events.h     |  1 +
> > >   tools/perf/util/parse-events.c         |  4 ++--
> > >   tools/perf/util/parse-events.h         |  2 +-
> > >   tools/perf/util/pmu.c                  | 17 +++++++++++++----
> > >   tools/perf/util/pmu.h                  |  4 +++-
> > >   9 files changed, 55 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> > > index 18ed1b0fceb3..6345db33c533 100644
> > > --- a/tools/perf/Documentation/perf-list.txt
> > > +++ b/tools/perf/Documentation/perf-list.txt
> > > @@ -36,6 +36,9 @@ Enable debugging output.
> > >   Print how named events are resolved internally into perf events, and also
> > >   any extra expressions computed by perf stat.
> > > +--deprecated::
> > > +Print deprecated events. By default the deprecated events are hidden.
> > > +
> > >   [[EVENT_MODIFIERS]]
> > >   EVENT MODIFIERS
> > >   ---------------
> > > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > > index 08e62ae9d37e..965ef017496f 100644
> > > --- a/tools/perf/builtin-list.c
> > > +++ b/tools/perf/builtin-list.c
> > > @@ -26,6 +26,7 @@ int cmd_list(int argc, const char **argv)
> > >   	int i;
> > >   	bool raw_dump = false;
> > >   	bool long_desc_flag = false;
> > > +	bool deprecated = false;
> > >   	struct option list_options[] = {
> > >   		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
> > >   		OPT_BOOLEAN('d', "desc", &desc_flag,
> > > @@ -34,6 +35,8 @@ int cmd_list(int argc, const char **argv)
> > >   			    "Print longer event descriptions."),
> > >   		OPT_BOOLEAN(0, "details", &details_flag,
> > >   			    "Print information on the perf event names and expressions used internally by events."),
> > > +		OPT_BOOLEAN(0, "deprecated", &deprecated,
> > > +			    "Print deprecated events."),
> > >   		OPT_INCR(0, "debug", &verbose,
> > >   			     "Enable debugging output"),
> > >   		OPT_END()
> > > @@ -55,7 +58,7 @@ int cmd_list(int argc, const char **argv)
> > >   	if (argc == 0) {
> > >   		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
> > > -				details_flag);
> > > +				details_flag, deprecated);
> > >   		return 0;
> > >   	}
> > > @@ -78,7 +81,8 @@ int cmd_list(int argc, const char **argv)
> > >   			print_hwcache_events(NULL, raw_dump);
> > >   		else if (strcmp(argv[i], "pmu") == 0)
> > >   			print_pmu_events(NULL, raw_dump, !desc_flag,
> > > -						long_desc_flag, details_flag);
> > > +						long_desc_flag, details_flag,
> > > +						deprecated);
> > >   		else if (strcmp(argv[i], "sdt") == 0)
> > >   			print_sdt_events(NULL, NULL, raw_dump);
> > >   		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
> > > @@ -91,7 +95,8 @@ int cmd_list(int argc, const char **argv)
> > >   			if (sep == NULL) {
> > >   				print_events(argv[i], raw_dump, !desc_flag,
> > >   							long_desc_flag,
> > > -							details_flag);
> > > +							details_flag,
> > > +							deprecated);
> > >   				continue;
> > >   			}
> > >   			sep_idx = sep - argv[i];
> > > @@ -117,7 +122,8 @@ int cmd_list(int argc, const char **argv)
> > >   			print_hwcache_events(s, raw_dump);
> > >   			print_pmu_events(s, raw_dump, !desc_flag,
> > >   						long_desc_flag,
> > > -						details_flag);
> > > +						details_flag,
> > > +						deprecated);
> > >   			print_tracepoint_events(NULL, s, raw_dump);
> > >   			print_sdt_events(NULL, s, raw_dump);
> > >   			metricgroup__print(true, true, s, raw_dump, details_flag);
> > > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > > index e2837260ca4d..7d69727f44bd 100644
> > > --- a/tools/perf/pmu-events/jevents.c
> > > +++ b/tools/perf/pmu-events/jevents.c
> > > @@ -322,7 +322,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
> > >   				    char *desc, char *long_desc,
> > >   				    char *pmu, char *unit, char *perpkg,
> > >   				    char *metric_expr,
> > > -				    char *metric_name, char *metric_group)
> > > +				    char *metric_name, char *metric_group,
> > > +				    char *deprecated)
> > >   {
> > >   	struct perf_entry_data *pd = data;
> > >   	FILE *outfp = pd->outfp;
> > > @@ -354,6 +355,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
> > >   		fprintf(outfp, "\t.metric_name = \"%s\",\n", metric_name);
> > >   	if (metric_group)
> > >   		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
> > > +	if (deprecated)
> > > +		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
> > >   	fprintf(outfp, "},\n");
> > >   	return 0;
> > > @@ -371,6 +374,7 @@ struct event_struct {
> > >   	char *metric_expr;
> > >   	char *metric_name;
> > >   	char *metric_group;
> > > +	char *deprecated;
> > >   };
> > >   #define ADD_EVENT_FIELD(field) do { if (field) {		\
> > > @@ -398,6 +402,7 @@ struct event_struct {
> > >   	op(metric_expr);					\
> > >   	op(metric_name);					\
> > >   	op(metric_group);					\
> > > +	op(deprecated);						\
> > >   } while (0)
> > >   static LIST_HEAD(arch_std_events);
> > > @@ -416,7 +421,8 @@ static void free_arch_std_events(void)
> > >   static int save_arch_std_events(void *data, char *name, char *event,
> > >   				char *desc, char *long_desc, char *pmu,
> > >   				char *unit, char *perpkg, char *metric_expr,
> > > -				char *metric_name, char *metric_group)
> > > +				char *metric_name, char *metric_group,
> > > +				char *deprecated)
> > >   {
> > >   	struct event_struct *es;
> > > @@ -479,7 +485,8 @@ static int
> > >   try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> > >   	  char **name, char **long_desc, char **pmu, char **filter,
> > >   	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
> > > -	  char **metric_group, unsigned long long eventcode)
> > > +	  char **metric_group, unsigned long long eventcode,
> > > +	  char **deprecated)
> > >   {
> > >   	/* try to find matching event from arch standard values */
> > >   	struct event_struct *es;
> > > @@ -507,7 +514,8 @@ int json_events(const char *fn,
> > >   		      char *long_desc,
> > >   		      char *pmu, char *unit, char *perpkg,
> > >   		      char *metric_expr,
> > > -		      char *metric_name, char *metric_group),
> > > +		      char *metric_name, char *metric_group,
> > > +		      char *deprecated),
> > >   	  void *data)
> > >   {
> > >   	int err;
> > > @@ -536,6 +544,7 @@ int json_events(const char *fn,
> > >   		char *metric_expr = NULL;
> > >   		char *metric_name = NULL;
> > >   		char *metric_group = NULL;
> > > +		char *deprecated = NULL;
> > >   		char *arch_std = NULL;
> > >   		unsigned long long eventcode = 0;
> > >   		struct msrmap *msr = NULL;
> > > @@ -614,6 +623,8 @@ int json_events(const char *fn,
> > >   				addfield(map, &unit, "", "", val);
> > >   			} else if (json_streq(map, field, "PerPkg")) {
> > >   				addfield(map, &perpkg, "", "", val);
> > > +			} else if (json_streq(map, field, "Deprecated")) {
> > > +				addfield(map, &deprecated, "", "", val);
> > >   			} else if (json_streq(map, field, "MetricName")) {
> > >   				addfield(map, &metric_name, "", "", val);
> > >   			} else if (json_streq(map, field, "MetricGroup")) {
> > > @@ -658,12 +669,14 @@ int json_events(const char *fn,
> > >   			err = try_fixup(fn, arch_std, &event, &desc, &name,
> > >   					&long_desc, &pmu, &filter, &perpkg,
> > >   					&unit, &metric_expr, &metric_name,
> > > -					&metric_group, eventcode);
> > > +					&metric_group, eventcode,
> > > +					&deprecated);
> > >   			if (err)
> > >   				goto free_strings;
> > >   		}
> > >   		err = func(data, name, real_event(name, event), desc, long_desc,
> > > -			   pmu, unit, perpkg, metric_expr, metric_name, metric_group);
> > > +			   pmu, unit, perpkg, metric_expr, metric_name,
> > > +			   metric_group, deprecated);
> > >   free_strings:
> > >   		free(event);
> > >   		free(desc);
> > > @@ -673,6 +686,7 @@ int json_events(const char *fn,
> > >   		free(pmu);
> > >   		free(filter);
> > >   		free(perpkg);
> > > +		free(deprecated);
> > >   		free(unit);
> > >   		free(metric_expr);
> > >   		free(metric_name);
> > > diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> > > index 4684c673c445..5cda49a42143 100644
> > > --- a/tools/perf/pmu-events/jevents.h
> > > +++ b/tools/perf/pmu-events/jevents.h
> > > @@ -7,7 +7,8 @@ int json_events(const char *fn,
> > >   				char *long_desc,
> > >   				char *pmu,
> > >   				char *unit, char *perpkg, char *metric_expr,
> > > -				char *metric_name, char *metric_group),
> > > +				char *metric_name, char *metric_group,
> > > +				char *deprecated),
> > >   		void *data);
> > >   char *get_cpu_str(void);
> > > diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> > > index 92a4d15ee0b9..caeb577d36c9 100644
> > > --- a/tools/perf/pmu-events/pmu-events.h
> > > +++ b/tools/perf/pmu-events/pmu-events.h
> > > @@ -17,6 +17,7 @@ struct pmu_event {
> > >   	const char *metric_expr;
> > >   	const char *metric_name;
> > >   	const char *metric_group;
> > > +	const char *deprecated;
> > >   };
> > >   /*
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index b5e2adef49de..db882f630f7e 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -2600,7 +2600,7 @@ void print_symbol_events(const char *event_glob, unsigned type,
> > >    * Print the help text for the event symbols:
> > >    */
> > >   void print_events(const char *event_glob, bool name_only, bool quiet_flag,
> > > -			bool long_desc, bool details_flag)
> > > +			bool long_desc, bool details_flag, bool deprecated)
> > >   {
> > >   	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
> > >   			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
> > > @@ -2612,7 +2612,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
> > >   	print_hwcache_events(event_glob, name_only);
> > >   	print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
> > > -			details_flag);
> > > +			details_flag, deprecated);
> > >   	if (event_glob != NULL)
> > >   		return;
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > > index 616ca1eda0eb..769e07cddaa2 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -195,7 +195,7 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
> > >   			       int idx, const char *str);
> > >   void print_events(const char *event_glob, bool name_only, bool quiet,
> > > -		  bool long_desc, bool details_flag);
> > > +		  bool long_desc, bool details_flag, bool deprecated);
> > >   struct event_symbol {
> > >   	const char	*symbol;
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 5608da82ad23..adbe97e941dd 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -308,7 +308,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> > >   				 char *long_desc, char *topic,
> > >   				 char *unit, char *perpkg,
> > >   				 char *metric_expr,
> > > -				 char *metric_name)
> > > +				 char *metric_name,
> > > +				 char *deprecated)
> > >   {
> > >   	struct parse_events_term *term;
> > >   	struct perf_pmu_alias *alias;
> > > @@ -325,6 +326,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> > >   	alias->unit[0] = '\0';
> > >   	alias->per_pkg = false;
> > >   	alias->snapshot = false;
> > > +	alias->deprecated = false;
> > >   	ret = parse_events_terms(&alias->terms, val);
> > >   	if (ret) {
> > > @@ -379,6 +381,9 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> > >   	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
> > >   	alias->str = strdup(newval);
> > > +	if (deprecated)
> > > +		alias->deprecated = true;
> > > +
> > >   	if (!perf_pmu_merge_alias(alias, list))
> > >   		list_add_tail(&alias->list, list);
> > > @@ -400,7 +405,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
> > >   	strim(buf);
> > >   	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
> > > -				     NULL, NULL, NULL);
> > > +				     NULL, NULL, NULL, NULL);
> > >   }
> > >   static inline bool pmu_alias_info_file(char *name)
> > > @@ -787,7 +792,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
> > >   				(char *)pe->long_desc, (char *)pe->topic,
> > >   				(char *)pe->unit, (char *)pe->perpkg,
> > >   				(char *)pe->metric_expr,
> > > -				(char *)pe->metric_name);
> > > +				(char *)pe->metric_name,
> > > +				(char *)pe->deprecated);
> > >   	}
> > >   }
> > > @@ -1383,7 +1389,7 @@ static void wordwrap(char *s, int start, int max, int corr)
> > >   }
> > >   void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
> > > -			bool long_desc, bool details_flag)
> > > +			bool long_desc, bool details_flag, bool deprecated)
> > >   {
> > >   	struct perf_pmu *pmu;
> > >   	struct perf_pmu_alias *alias;
> > > @@ -1414,6 +1420,9 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
> > >   				format_alias(buf, sizeof(buf), pmu, alias);
> > >   			bool is_cpu = !strcmp(pmu->name, "cpu");
> > > +			if (alias->deprecated && !deprecated)
> > > +				continue;
> > > +
> > >   			if (event_glob != NULL &&
> > >   			    !(strglobmatch_nocase(name, event_glob) ||
> > >   			      (!is_cpu && strglobmatch_nocase(alias->name,
> > > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > > index f36ade6df76d..3e8cd31a89cc 100644
> > > --- a/tools/perf/util/pmu.h
> > > +++ b/tools/perf/util/pmu.h
> > > @@ -57,6 +57,7 @@ struct perf_pmu_alias {
> > >   	double scale;
> > >   	bool per_pkg;
> > >   	bool snapshot;
> > > +	bool deprecated;
> > >   	char *metric_expr;
> > >   	char *metric_name;
> > >   };
> > > @@ -85,7 +86,8 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
> > >   struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
> > >   void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
> > > -		      bool long_desc, bool details_flag);
> > > +		      bool long_desc, bool details_flag,
> > > +		      bool deprecated);
> > >   bool pmu_have_event(const char *pname, const char *name);
> > >   int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
> > > 

-- 

- Arnaldo
