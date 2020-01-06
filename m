Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE502C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EF62146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYopsQwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgAFMzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:55:17 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41737 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgAFMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:55:16 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so42453387ils.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 04:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jw04yP0BtmCga5GDtI/uaCXgvPW9/k1x3K98MyMaeBk=;
        b=cYopsQwYieIprrXOs8tsBoBt18fC60PZEtO+XSVwDCaPIchL6eKyJ5I//UnSyFn4gq
         8BEocbj40TQuS/HFiSo+CwV5miUR9uiaiF9gWL6O6NtsbR3YrS30oQEH2G3Ql0BkGt6m
         RKs3+aVTVCqLJwS6qXlPeiLkSniNRqupe56R81TB/p3xl+Bqz6RPWn/D1IBXC89VmF7J
         4cPecbbWPtqPa/LTK3LTMiXQtFagFxza3lRp2fKqV7rKl5DoK90w6w8xXXEWIyv77UIm
         sSlFweA9lsFG25A2HJgdmjYsKSjdMdh0vTdLP8HXGklzGm0QXCyzlRB9bPWQQXxr4qWF
         uF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jw04yP0BtmCga5GDtI/uaCXgvPW9/k1x3K98MyMaeBk=;
        b=sYJqWGrTW4Tb8j12qAa+Es91gzrrG8Sns79mG4C20IyMFdwfwiXS8TTHHMWC5VhbKC
         gXsl148qF3oPxBTg4b7CKEYl7xY4d6mZF8CIQTk4mxh/OXpDu8NT43LCaTM1qCyfQv6J
         b2tD3CH0G5TyQheg0AAJ8N+fXvP/G/qgQFUgRIVXA9guZjVIn9IK9ZJdrDcXI7s5Z8db
         UNVbCkO033u7TEjO92EtnLnJxlKUmI2CMVHT/kxWT+gGDPeFs/AvItXxdazhrdl04zkW
         UjllFxdzfGw25VYpieS9Y5C2pcf2MftGAFfLEWz4rQsXCJEb6Hqo/jVK3gPxEQHLBawI
         Nwvg==
X-Gm-Message-State: APjAAAXIwXB7XCdzHbF5e3+vBPQxb73TWp1VH6YsOKBReW4nmYozFoBQ
        CP3RPcxBWD5ScGS4ys26WLaUAQ==
X-Google-Smtp-Source: APXvYqwDsqs0+9gVRtqUY4GzPI6NDhiqNJUvP/12fN58CVVxnnRlR+T+TpUDerqJI9Um9t5Z5gyQGA==
X-Received: by 2002:a92:d80f:: with SMTP id y15mr87676368ilm.225.1578315314782;
        Mon, 06 Jan 2020 04:55:14 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1058-79.members.linode.com. [45.33.121.79])
        by smtp.gmail.com with ESMTPSA id u29sm23991791ill.62.2020.01.06.04.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 04:55:14 -0800 (PST)
Date:   Mon, 6 Jan 2020 20:55:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200106125506.GB29905@leoy-ThinkPad-X240s>
References: <20200102151326.31342-1-leo.yan@linaro.org>
 <20200106113610.GB207350@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106113610.GB207350@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Jan 06, 2020 at 12:36:10PM +0100, Jiri Olsa wrote:
> On Thu, Jan 02, 2020 at 11:13:26PM +0800, Leo Yan wrote:
> > perf with CoreSight fails to record trace data with command:
> > 
> >   perf record -e cs_etm/@tmc_etr0/u --per-thread ls
> >   failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
> >   directory)/perf/
> > 
> > This failure is root caused with the commit 1dc925568f01 ("perf
> > parse: Add a deep delete for parse event terms").
> > 
> > The log shows, cs_etm fails to parse the sink attribution; cs_etm event
> > relies on the event configuration to pass sink name, but the event
> > specific configuration data cannot be passed properly with flow:
> > 
> >   get_config_terms()
> >     ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
> >       __t->val.drv_cfg = term->val.str;
> >         `> __t->val.drv_cfg is assigned to term->val.str;
> > 
> >   parse_events_terms__purge()
> >     parse_events_term__delete()
> >       zfree(&term->val.str);
> >         `> term->val.str is freed and assigned to NULL pointer;
> > 
> >   cs_etm_set_sink_attr()
> >     sink = __t->val.drv_cfg;
> >       `> sink string has been freed.
> 
> so your problem is that the data is freed before you use it?

Yes, exactly.

> > 
> > To fix this issue, in the function get_config_terms(), this patch
> > changes from directly assignment pointer value for the strings to
> > use strdup() for allocation a new duplicate string for the cases:
> > 
> >   perf_evsel_config_term::val.callgraph
> >   perf_evsel_config_term::val.branch
> >   perf_evsel_config_term::val.drv_cfg.
> > 
> > Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/parse-events.c | 49 ++++++++++++++++++++--------------
> >  1 file changed, 29 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index ed7c008b9c8b..5972acdd40d6 100644
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
> > @@ -1229,9 +1228,19 @@ do {								\
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
> >  } while (0)
> 
> the term->val.str is supposed to be already strdup-ed,
> so this seems wrong and leaking mem

Though term->val.str is strdup-ed, after merged the commit 1dc925568f01
("perf parse: Add a deep delete for parse event terms"), term->val.str
is freed in the code [1].

If term->val.str should not be freed, how about to rollback the code as
below:

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5972acdd40d6..f3211cde0d9f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2955,7 +2955,12 @@ void parse_events_terms__purge(struct list_head *terms)
 
        list_for_each_entry_safe(term, h, terms, list) {
                list_del_init(&term->list);
-               parse_events_term__delete(term);
+
+               if (term->array.nr_ranges)
+                       zfree(&term->array.ranges);
+
+               zfree(&term->config);
+               free(term);
        }
 }

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/parse-events.c?h=v5.5-rc5#n2911

> 
> jirka
> 
