Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C54C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505D3206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnuXBnzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgAGVpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:45:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46122 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgAGVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:45:39 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so909847ioi.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vATZ2I6qLWTRmJyedjY1p/3tWHu7nyVmPgxExmIoeW0=;
        b=xnuXBnzis+Zv2GHXvk4yiKwT4aLgl/Vk1ictUtVB6HkxJrDFr7fSZXM+5yc/GSGAOi
         5/pxxgfYolQnhXDCtHlqWqE1/yYgEAes9xwSPLJ4xAjv1PzMW7C6cGuh4uQR6codMvbU
         0BDmlLE+5yV8YUNTBe/NITzaMw3yAlMvdNiqaeDp2Mbn0UKx/KIXGnA3yUmlK736GNqA
         b1NStY6VmH0PU4cy6Fnbv2RH0LbbzZrdr6WFKg9W9NZRZ+tWBBQoQYAQiy+rUi2Z1W//
         AGgvUJv/K4hdNdffMAfBc/CYbeWCBl3HFnxmNQji/zZzHM14hZUHc+DqWxgvOMVANO0q
         ZWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vATZ2I6qLWTRmJyedjY1p/3tWHu7nyVmPgxExmIoeW0=;
        b=JipeFWRDgKDQYrIenr1NAVZsbh3lsyCPB5MgOhwBcKmjEp+Jh75LqjTH/LdT0ueXkC
         g8LiDT/qwLm5a2Hd0hA7P/Rvxs0wnhHGSFi1ejB6sBTP0DTNYSSodUWXHSVX5jE9Jt+b
         sCV+oJ1kJE5i8CbqGCvmrSOr9VnnxyQxIZAadg1IHDdj3LBMWJgTqRDhIgrVEqM7LkQt
         VrdNx+J7KUspjIQt2Ast0yzdN3qJpCgMrGqYf27BbeAbmEO+UPs4TjZVoErnaajvKlsZ
         b5cKmB00XfpgBDxeaFPNjie/LTuHkPk4NlUqKfBkV0rjks/zI4ZmglErDHM664xtY5dQ
         7udw==
X-Gm-Message-State: APjAAAVr68sBZoVRuhY6T3oJKMhS2jtn859LDVFBIuXKiM59gRDOsmec
        cLccFM1TCST5YG8Encq2Yh8rNSbB2kK54JP0pRnRfw==
X-Google-Smtp-Source: APXvYqxOzOdvDkGYAtOM+qxzM+2WQRIG4faZJJMAUauKecgQbe0fheiTzFluCzDWawdnR/rp42WyzuxbMHUZK57AyQs=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr839437iom.57.1578433538850;
 Tue, 07 Jan 2020 13:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20200107120310.9632-1-leo.yan@linaro.org>
In-Reply-To: <20200107120310.9632-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 7 Jan 2020 14:45:27 -0700
Message-ID: <CANLsYkzs67NXpszueKTM5y05KrOUf-yaphs3Y7yC8P2sNz3YwQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf parse: Copy string to perf_evsel_config_term
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Tue, 7 Jan 2020 at 05:03, Leo Yan <leo.yan@linaro.org> wrote:
>
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
> In the data structure perf_evsel_config_term, this patch adds
> 'char *str' pointer in the val union and new field 'free_str'.  When the
> union is used as a string pointer, 'free_str' will be set to true;
> finally it's flag to tell perf_evsel__free_config_terms() to free the
> string with perf_evsel_config_term::val.str.

Many thanks for digging into this and stepping forward to provide a
solution - it is much appreciated.

>
> Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/evsel.c        |  2 ++
>  tools/perf/util/evsel_config.h |  2 ++
>  tools/perf/util/parse-events.c | 56 +++++++++++++++++++++-------------
>  3 files changed, 39 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a69e64236120..ab9925cc1aa7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
>
>         list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
>                 list_del_init(&term->list);
> +               if (term->free_str)
> +                       free(term->val.str);

This will do the trick but we can definitely do better.

Part of his comments on V2, Jiri hinted that we should move to a
common perf_evsel_config_term::str to replace {callgraph, drv_cfg,
branch}, something that will work because we have
perf_evsel_config_term::type.  That means  functions
apply_config_terms() and cs_etm_set_sink_attr() need to be modified
but the changes are quite small and well worth for the benefit they'll
carry.

With that the above becomes neat and clean.

Thanks,
Mathieu

>                 free(term);
>         }
>  }
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index 1f8d2fe0b66e..dfc28738e071 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -32,6 +32,7 @@ enum evsel_term_type {
>  struct perf_evsel_config_term {
>         struct list_head      list;
>         enum evsel_term_type  type;
> +       bool                  free_str;
>         union {
>                 u64           period;
>                 u64           freq;
> @@ -48,6 +49,7 @@ struct perf_evsel_config_term {
>                 bool          aux_output;
>                 u32           aux_sample_size;
>                 u64           cfg_chg;
> +               char          *str;



>         } val;
>         bool weak;
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ed7c008b9c8b..83fb149b9485 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1220,7 +1220,6 @@ static int get_config_terms(struct list_head *head_config,
>                             struct list_head *head_terms __maybe_unused)
>  {
>  #define ADD_CONFIG_TERM(__type, __name, __val)                 \
> -do {                                                           \
>         struct perf_evsel_config_term *__t;                     \
>                                                                 \
>         __t = zalloc(sizeof(*__t));                             \
> @@ -1229,9 +1228,24 @@ do {                                                             \
>                                                                 \
>         INIT_LIST_HEAD(&__t->list);                             \
>         __t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;   \
> -       __t->val.__name = __val;                                \
>         __t->weak       = term->weak;                           \
> -       list_add_tail(&__t->list, head_terms);                  \
> +       list_add_tail(&__t->list, head_terms)
> +
> +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)             \
> +do {                                                           \
> +       ADD_CONFIG_TERM(__type, __name, __val);                 \
> +       __t->val.__name = __val;                                \
> +} while (0)
> +
> +#define ADD_CONFIG_TERM_STR(__type, __name, __val)             \
> +do {                                                           \
> +       ADD_CONFIG_TERM(__type, __name, __val);                 \
> +       __t->val.__name = strdup(__val);                        \
> +       if (!__t->val.__name) {                                 \
> +               zfree(&__t);                                    \
> +               return -ENOMEM;                                 \
> +       }                                                       \
> +       __t->free_str = true;                                   \
>  } while (0)
>
>         struct parse_events_term *term;
> @@ -1239,53 +1253,53 @@ do {                                                            \
>         list_for_each_entry(term, head_config, list) {
>                 switch (term->type_term) {
>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> -                       ADD_CONFIG_TERM(PERIOD, period, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> -                       ADD_CONFIG_TERM(FREQ, freq, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_TIME:
> -                       ADD_CONFIG_TERM(TIME, time, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> -                       ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
> +                       ADD_CONFIG_TERM_STR(CALLGRAPH, callgraph, term->val.str);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> -                       ADD_CONFIG_TERM(BRANCH, branch, term->val.str);
> +                       ADD_CONFIG_TERM_STR(BRANCH, branch, term->val.str);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> -                       ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(STACK_USER, stack_user, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_INHERIT:
> -                       ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
> +                       ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 1 : 0);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> -                       ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
> +                       ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 0 : 1);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> -                       ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> -                       ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> -                       ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
> +                       ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 1 : 0);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> -                       ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
> +                       ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 0 : 1);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> -                       ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
> +                       ADD_CONFIG_TERM_STR(DRV_CFG, drv_cfg, term->val.str);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_PERCORE:
> -                       ADD_CONFIG_TERM(PERCORE, percore,
> -                                       term->val.num ? true : false);
> +                       ADD_CONFIG_TERM_VAL(PERCORE, percore,
> +                                           term->val.num ? true : false);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> -                       ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
> +                       ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> -                       ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
>                         break;
>                 default:
>                         break;
> @@ -1322,7 +1336,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
>         }
>
>         if (bits)
> -               ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
> +               ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
>
>  #undef ADD_CONFIG_TERM
>         return 0;
> --
> 2.17.1
>
