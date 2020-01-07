Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EBDC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A7D24679
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euYlXmko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgAGK3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:29:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31362 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgAGK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578392943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2VwNThOs8k0NyMyNmUvb48wtNrxq1mFSjsrYrQY1ik=;
        b=euYlXmkoitJwDf4Pe4wQwi2Az5iWEfJnFACH45uIkVHqPJpFJ1ZAsZ5WMiBDVuOZVgxuw+
        t7GiEmOJ8SpBKcbVyCkDSHpLYaVRLAr65MQbhsTd9Oj8HEf0frbV5Te2SvcS7cfluUMY+V
        1TCkw/hjivjUyA1yiVUjUEuc/3u/3js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-V6iqviFPO0mjNsLigzBYYQ-1; Tue, 07 Jan 2020 05:28:56 -0500
X-MC-Unique: V6iqviFPO0mjNsLigzBYYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1881A800D53;
        Tue,  7 Jan 2020 10:28:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D54A7DB53;
        Tue,  7 Jan 2020 10:28:50 +0000 (UTC)
Date:   Tue, 7 Jan 2020 11:28:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20200107102848.GF290055@krava>
References: <20200107031828.23103-1-leo.yan@linaro.org>
 <20200107091609.GB290055@krava>
 <20200107100906.GA23348@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107100906.GA23348@leoy-ThinkPad-X240s>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 06:09:06PM +0800, Leo Yan wrote:
> On Tue, Jan 07, 2020 at 10:16:09AM +0100, Jiri Olsa wrote:
> 
> [...]
> 
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index ed7c008b9c8b..49b26504bee3 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -1220,7 +1220,6 @@ static int get_config_terms(struct list_head *head_config,
> > >  			    struct list_head *head_terms __maybe_unused)
> > >  {
> > >  #define ADD_CONFIG_TERM(__type, __name, __val)			\
> > > -do {								\
> > >  	struct perf_evsel_config_term *__t;			\
> > >  								\
> > >  	__t = zalloc(sizeof(*__t));				\
> > > @@ -1229,9 +1228,23 @@ do {								\
> > >  								\
> > >  	INIT_LIST_HEAD(&__t->list);				\
> > >  	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
> > > -	__t->val.__name = __val;				\
> > >  	__t->weak	= term->weak;				\
> > > -	list_add_tail(&__t->list, head_terms);			\
> > > +	list_add_tail(&__t->list, head_terms)
> > > +
> > > +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
> > > +do {								\
> > > +	ADD_CONFIG_TERM(__type, __name, __val);			\
> > > +	__t->val.__name = __val;				\
> > > +} while (0)
> > > +
> > > +#define ADD_CONFIG_TERM_STR(__type, __name, __val)		\
> > > +do {								\
> > > +	ADD_CONFIG_TERM(__type, __name, __val);			\
> > > +	__t->val.__name = strdup(__val);			\
> > > +	if (!__t->val.__name) {					\
> > > +		zfree(&__t);					\
> > > +		return -ENOMEM;					\
> > > +	}							\
> > >  } while (0)
> > 
> > hum, I did not check yesterday how we release perf_evsel_config_term
> > objects, but looks like now we need to release those pointers in here:
> >   perf_evsel__free_config_terms
> 
> My bad!  I did some check for releasing but missed this function.
> 
> Will spin a new patch for this.  Since '__t->val' is an union type, so
> for the releasing, I think we need to use below code.
> 
> Please let me know if this is okay for you?
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a69e64236120..fc659cdbd3ce 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1264,7 +1264,19 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
>         struct perf_evsel_config_term *term, *h;
>  
>         list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
> +               int type = term->type;
> +
>                 list_del_init(&term->list);
> +
> +               if (type == PARSE_EVENTS__TERM_TYPE_CALLGRAPH)
> +                       zfree(&term->val.callgraph);
> +
> +               if (type == PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE)
> +                       zfree(&term->val.branch);
> +
> +               if (type == PARSE_EVENTS__TERM_TYPE_DRV_CFG)
> +                       zfree(&term->val.drv_cfg);
> +
>                 free(term);
>         }

we would need to update perf_evsel__free_config_terms all the time
we add new term.. which does not happen too often, but that's another
reason we will probably forget that ;-)

I wonder we could make it generic with the 'char*' pointer in
the val union like in the below.. totaly untested

also we might not need to pass __name to ADD_CONFIG_TERM_STR
and ADD_CONFIG_TERM any more and just initialize 'str' pointer

jirka


---
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a69e64236120..ab9925cc1aa7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 
 	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
 		list_del_init(&term->list);
+		if (term->free_str)
+			free(term->val.str);
 		free(term);
 	}
 }
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 1f8d2fe0b66e..dfc28738e071 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -32,6 +32,7 @@ enum evsel_term_type {
 struct perf_evsel_config_term {
 	struct list_head      list;
 	enum evsel_term_type  type;
+	bool		      free_str;
 	union {
 		u64	      period;
 		u64	      freq;
@@ -48,6 +49,7 @@ struct perf_evsel_config_term {
 		bool	      aux_output;
 		u32	      aux_sample_size;
 		u64	      cfg_chg;
+		char	      *str;
 	} val;
 	bool weak;
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 49b26504bee3..83fb149b9485 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1245,6 +1245,7 @@ do {								\
 		zfree(&__t);					\
 		return -ENOMEM;					\
 	}							\
+	__t->free_str = true;					\
 } while (0)
 
 	struct parse_events_term *term;

