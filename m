Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A48C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF9B20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEj/4pjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgAGKJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:09:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34876 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:09:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so28290261pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fh3O8FUS+JCaHVqiFhhe/nxdGVYnjX+clSRFCRVmmSc=;
        b=WEj/4pjLqYeWkhO4fPA2gWoyp2dTldapkfo5J6bAbs4Zc/pXMjpiepqKcuqzsChChk
         dqe5KngBAc5495qHgTeaeAcGQlWwLY/w12nWO3uSqZum5uSW9SxvbCxjsmnpx+Hxbzq+
         WOomnQlNh4KK9QtHQZmmPIIrflycK21GH7NwiU85exl8F1Hj1FHYT8f1/+W1xWjIVlvN
         xaTSRZyOWtD7C3U0nqNLcc4SODc1npJB45+3ovHya+q7dykrN/G6u97u2UZ9rwTOBYIg
         kPQi3Tk8r9/0feyK/oPGrl52vyIYB9++lHZRAA9JZqd9Xab0DPFKP7h+jQt2dFSXUMqS
         O/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fh3O8FUS+JCaHVqiFhhe/nxdGVYnjX+clSRFCRVmmSc=;
        b=q1A5C2DSY2ebx9KFIhaFaxPDGQphzFYNXtpqheixOQf0Yt/YSCYQhchLMTfIcZ8KA/
         L2XnDAK6zmNKHqXNhhHXeYhaohgUekY2YN19tONo/1fQ+8CmDBdlRkPKSMNhOR2xGiGn
         YzZPHPCM4iYXGrczL1QkeWbbPSLj3bwn2wdFam6uPSaHP5a6zGnFd2o/f4sQYwBUXq/D
         iJm3LyH+UCbTm8uEny4oKWxaWeEklXG7EvMYIv5dFVoKVTD5wzr3Th44G+QC80RxfnK5
         o8U4VRYLgroQL5W6EJItmAF7fyNE9ok4IfITc4pTQW0OfNyCVjvXOORJv7YD/ex6WW31
         dIew==
X-Gm-Message-State: APjAAAVClYkOW5yJ5s4kNH5cGc/P7tNRpxNdW6AOxmTgvkbfMZ7JKqGn
        xwdbqw3yBdHBbVX9I1l7HEqALw==
X-Google-Smtp-Source: APXvYqxuxwCZxGb94u3QAgwT++lUAP9pGgnpEQ8eegAoy2lxtaF9se1JNXDYZssEdSDTpmpzZ1x10A==
X-Received: by 2002:a63:e0f:: with SMTP id d15mr114718655pgl.255.1578391759665;
        Tue, 07 Jan 2020 02:09:19 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id h26sm87622119pfr.9.2020.01.07.02.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 02:09:19 -0800 (PST)
Date:   Tue, 7 Jan 2020 18:09:06 +0800
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
Message-ID: <20200107100906.GA23348@leoy-ThinkPad-X240s>
References: <20200107031828.23103-1-leo.yan@linaro.org>
 <20200107091609.GB290055@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107091609.GB290055@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:16:09AM +0100, Jiri Olsa wrote:

[...]

> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index ed7c008b9c8b..49b26504bee3 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1220,7 +1220,6 @@ static int get_config_terms(struct list_head *head_config,
> >  			    struct list_head *head_terms __maybe_unused)
> >  {
> >  #define ADD_CONFIG_TERM(__type, __name, __val)			\
> > -do {								\
> >  	struct perf_evsel_config_term *__t;			\
> >  								\
> >  	__t = zalloc(sizeof(*__t));				\
> > @@ -1229,9 +1228,23 @@ do {								\
> >  								\
> >  	INIT_LIST_HEAD(&__t->list);				\
> >  	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
> > -	__t->val.__name = __val;				\
> >  	__t->weak	= term->weak;				\
> > -	list_add_tail(&__t->list, head_terms);			\
> > +	list_add_tail(&__t->list, head_terms)
> > +
> > +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
> > +do {								\
> > +	ADD_CONFIG_TERM(__type, __name, __val);			\
> > +	__t->val.__name = __val;				\
> > +} while (0)
> > +
> > +#define ADD_CONFIG_TERM_STR(__type, __name, __val)		\
> > +do {								\
> > +	ADD_CONFIG_TERM(__type, __name, __val);			\
> > +	__t->val.__name = strdup(__val);			\
> > +	if (!__t->val.__name) {					\
> > +		zfree(&__t);					\
> > +		return -ENOMEM;					\
> > +	}							\
> >  } while (0)
> 
> hum, I did not check yesterday how we release perf_evsel_config_term
> objects, but looks like now we need to release those pointers in here:
>   perf_evsel__free_config_terms

My bad!  I did some check for releasing but missed this function.

Will spin a new patch for this.  Since '__t->val' is an union type, so
for the releasing, I think we need to use below code.

Please let me know if this is okay for you?

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a69e64236120..fc659cdbd3ce 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1264,7 +1264,19 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
        struct perf_evsel_config_term *term, *h;
 
        list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
+               int type = term->type;
+
                list_del_init(&term->list);
+
+               if (type == PARSE_EVENTS__TERM_TYPE_CALLGRAPH)
+                       zfree(&term->val.callgraph);
+
+               if (type == PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE)
+                       zfree(&term->val.branch);
+
+               if (type == PARSE_EVENTS__TERM_TYPE_DRV_CFG)
+                       zfree(&term->val.drv_cfg);
+
                free(term);
        }
 }

Thanks,
Leo
