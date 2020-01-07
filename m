Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B1EC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7EB2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/XA8gIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgAGLma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:42:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42826 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgAGLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:42:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so23116064plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 03:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4Fzm7pwLQAcS1Jd+OhxNSot5siYFBi6H9WNlBgLg1Q=;
        b=I/XA8gIkAPUsspz4NagzlFkc7P4CDsoiEd9Nrwp3aNJzbTrIhU9hQf3qs+34MB+iwU
         PP0YOkIxpMZuCUUWaFQYUkJkkCFkkwSjbZU3XZr1djLcfo/XLKAvOH8Obao525XBjm8C
         RZ5nQZWaVW0OJ9LSgX5tK5AmkVex4Ppobg46RIwUpyeznWgpqsFPJB0DJJZlkhGeSMdf
         aBvVdqYkfW7bQcStACGIv7XXrDED4pDdwY02LqOhY7+hhAurPaq5/3ZNwsfbr8pXlHFM
         VVB+0tyKJa7FYv37Pu6A2oVpxUATqU8n2ys05/BBoHCmnxvuK0SEz1FVL3V+G5nJP+F9
         xZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4Fzm7pwLQAcS1Jd+OhxNSot5siYFBi6H9WNlBgLg1Q=;
        b=nDVUqB8eFZAgaVOUGNC8ufjsGMe6u+2csudhrcEv6LCWmnxaWjdK2SHTjzUfA3SAHF
         cWVMyIgcsw2tDCfKSxYESZyhauWxJ7yHicNJN6+ONssWNYRve8OAiMGobCxRtgi3JUAD
         abll2rIpabtbcO7j3hJp3gBCUWlPvZU6kQ7iNy463I6kGHnW3JhvjcSd6nrMlnQDaVSG
         0uG/33QFxCpvmzKaysAEuWQuPN/zMacjkX9+MJziVwNEg3zzzd0Nihyib2srHwpI6x7B
         Zx2A043lf3Y0eGHLoIp1mFj9wkv1Ersxi5jJ3y+st/DfPxpbyzafC/1CXOUyB+tfDwFu
         QTZg==
X-Gm-Message-State: APjAAAXYFDPOC/2kPipTrAHckL4p4QisncpV5Z2XIZXz4vv8AgzBijsg
        83nQj/R7I3myO8cHgEgiE9boHA==
X-Google-Smtp-Source: APXvYqxjbsHub2RsuZu42EEwhQex3wo7w/hJeFDerfVmirt96N+asYR1dCEnFpirArWt4hasciDkEQ==
X-Received: by 2002:a17:90a:d995:: with SMTP id d21mr49025818pjv.118.1578397349464;
        Tue, 07 Jan 2020 03:42:29 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id w131sm84148250pfc.16.2020.01.07.03.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 03:42:28 -0800 (PST)
Date:   Tue, 7 Jan 2020 19:42:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200107114216.GB23348@leoy-ThinkPad-X240s>
References: <20200107031828.23103-1-leo.yan@linaro.org>
 <20200107091609.GB290055@krava>
 <20200107100906.GA23348@leoy-ThinkPad-X240s>
 <20200107102848.GF290055@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107102848.GF290055@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Jan 07, 2020 at 11:28:48AM +0100, Jiri Olsa wrote:
> On Tue, Jan 07, 2020 at 06:09:06PM +0800, Leo Yan wrote:
> > On Tue, Jan 07, 2020 at 10:16:09AM +0100, Jiri Olsa wrote:
> > 
> > [...]
> > 
> > > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > > index ed7c008b9c8b..49b26504bee3 100644
> > > > --- a/tools/perf/util/parse-events.c
> > > > +++ b/tools/perf/util/parse-events.c
> > > > @@ -1220,7 +1220,6 @@ static int get_config_terms(struct list_head *head_config,
> > > >  			    struct list_head *head_terms __maybe_unused)
> > > >  {
> > > >  #define ADD_CONFIG_TERM(__type, __name, __val)			\
> > > > -do {								\
> > > >  	struct perf_evsel_config_term *__t;			\
> > > >  								\
> > > >  	__t = zalloc(sizeof(*__t));				\
> > > > @@ -1229,9 +1228,23 @@ do {								\
> > > >  								\
> > > >  	INIT_LIST_HEAD(&__t->list);				\
> > > >  	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
> > > > -	__t->val.__name = __val;				\
> > > >  	__t->weak	= term->weak;				\
> > > > -	list_add_tail(&__t->list, head_terms);			\
> > > > +	list_add_tail(&__t->list, head_terms)
> > > > +
> > > > +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
> > > > +do {								\
> > > > +	ADD_CONFIG_TERM(__type, __name, __val);			\
> > > > +	__t->val.__name = __val;				\
> > > > +} while (0)
> > > > +
> > > > +#define ADD_CONFIG_TERM_STR(__type, __name, __val)		\
> > > > +do {								\
> > > > +	ADD_CONFIG_TERM(__type, __name, __val);			\
> > > > +	__t->val.__name = strdup(__val);			\
> > > > +	if (!__t->val.__name) {					\
> > > > +		zfree(&__t);					\
> > > > +		return -ENOMEM;					\
> > > > +	}							\
> > > >  } while (0)
> > > 
> > > hum, I did not check yesterday how we release perf_evsel_config_term
> > > objects, but looks like now we need to release those pointers in here:
> > >   perf_evsel__free_config_terms
> > 
> > My bad!  I did some check for releasing but missed this function.
> > 
> > Will spin a new patch for this.  Since '__t->val' is an union type, so
> > for the releasing, I think we need to use below code.
> > 
> > Please let me know if this is okay for you?
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a69e64236120..fc659cdbd3ce 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1264,7 +1264,19 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
> >         struct perf_evsel_config_term *term, *h;
> >  
> >         list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
> > +               int type = term->type;
> > +
> >                 list_del_init(&term->list);
> > +
> > +               if (type == PARSE_EVENTS__TERM_TYPE_CALLGRAPH)
> > +                       zfree(&term->val.callgraph);
> > +
> > +               if (type == PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE)
> > +                       zfree(&term->val.branch);
> > +
> > +               if (type == PARSE_EVENTS__TERM_TYPE_DRV_CFG)
> > +                       zfree(&term->val.drv_cfg);
> > +
> >                 free(term);
> >         }
> 
> we would need to update perf_evsel__free_config_terms all the time
> we add new term.. which does not happen too often, but that's another
> reason we will probably forget that ;-)
> 
> I wonder we could make it generic with the 'char*' pointer in
> the val union like in the below.. totaly untested
> 
> also we might not need to pass __name to ADD_CONFIG_TERM_STR
> and ADD_CONFIG_TERM any more and just initialize 'str' pointer

Makes sense.  Will spin a new patch with following this idea and send
out soon.

Thanks a lot for suggestions!
Leo

> ---
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a69e64236120..ab9925cc1aa7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
>  
>  	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
>  		list_del_init(&term->list);
> +		if (term->free_str)
> +			free(term->val.str);
>  		free(term);
>  	}
>  }
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index 1f8d2fe0b66e..dfc28738e071 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -32,6 +32,7 @@ enum evsel_term_type {
>  struct perf_evsel_config_term {
>  	struct list_head      list;
>  	enum evsel_term_type  type;
> +	bool		      free_str;
>  	union {
>  		u64	      period;
>  		u64	      freq;
> @@ -48,6 +49,7 @@ struct perf_evsel_config_term {
>  		bool	      aux_output;
>  		u32	      aux_sample_size;
>  		u64	      cfg_chg;
> +		char	      *str;
>  	} val;
>  	bool weak;
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 49b26504bee3..83fb149b9485 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1245,6 +1245,7 @@ do {								\
>  		zfree(&__t);					\
>  		return -ENOMEM;					\
>  	}							\
> +	__t->free_str = true;					\
>  } while (0)
>  
>  	struct parse_events_term *term;
> 
