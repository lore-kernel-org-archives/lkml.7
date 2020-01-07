Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62936C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321AA2072E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 00:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFDK3Yuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgAGA5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:57:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33635 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgAGA5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:57:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13so22502391pls.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 16:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KXZVzkgAmBeNBoD0youM63rm0kvw0AcVHzhcDhyN5ug=;
        b=tFDK3Yuzl1ZnMFsAfICZjFhnOTWEee51fYZ1v103NJknaKzP4Ej8jZf1xQ7mnzrVwN
         +wXujRCCoUaNdLEraxwjLb2icDOU0kwLu0X8XJAuceBI4HVtQNhOqUBGhnSzmaDXJih4
         /fOs5pB8XMgn5l3iKeDWA/28Lw55C2hVtSxxe+5m003WVX2rMb/VNVUSMHdgXnoH1y8n
         f1uvnJGYkRBFwO0J6GS9dwa04Z330mK5TS+52jTBVVxO+FpJMxjePpNKuB6O+RLNdzbT
         cJPg45AQvtn45SsJrH8CTCjx3YdX4zlUFQAET2iHDp/efUeT+Psx7Uw9DOLz4hPFkorg
         jqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXZVzkgAmBeNBoD0youM63rm0kvw0AcVHzhcDhyN5ug=;
        b=iNhIhbYlo7j/kOo0fnXac97z6JAVlUpM5aPvey06fGc0RNb1AeqmEDKQZDsUccI8Ce
         N73fwn/WYjurmsYlZK8pYI38wuLNWLGOU2Gho+PofPBkXhmj/fSscCkapYvii/84kSOq
         m5raGpugey0swg6/Wgd2xOIsdH1DgJzBC36E8UEHM3O3t7b6zF/fNC2IqmYnAvX4ZDGe
         xe5meRFU8yZ0+4hNP2p2Bnc9wUzPoLlz9RoHgO+DdBe36NlRB4Utz9hhbAFo1w0k+g54
         oUj9AX6zsQvTOYNW8m5qS328TtR9RxJAYqQZ3l1QExpQLn2rOLM2ZLLn3LGu+QMWOGL/
         DCmQ==
X-Gm-Message-State: APjAAAWVRjq0n211RaH98/UOp+tBllEaFFeok47MkdFzioBKjUzLwdB4
        RVqdcVPUV1kHFKQ2MtM84yI7qA==
X-Google-Smtp-Source: APXvYqyVCTfOG3gjhXVhapmKbaXSUQztl3zUuSquVZ1znCmK7M/5aeCSWk9AWORDaFwxuAReibIfTQ==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21mr14609584pls.49.1578358671310;
        Mon, 06 Jan 2020 16:57:51 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id d129sm57999335pfd.115.2020.01.06.16.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 16:57:50 -0800 (PST)
Date:   Tue, 7 Jan 2020 08:57:45 +0800
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
Message-ID: <20200107005745.GB5320@leoy-ThinkPad-X240s>
References: <20200102151326.31342-1-leo.yan@linaro.org>
 <20200106151241.GA236146@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106151241.GA236146@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Jan 06, 2020 at 04:12:41PM +0100, Jiri Olsa wrote:

[...]

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
> 
> ok, I understand now.. we move the pointer to the perf_evsel_config_term,
> but release it after in parse_events_terms__purge
> 
> the change seems ok, but please check on the strdup return value
> and cleanup and return -ENOMEM if it fails in here

Thanks for suggestion.  Will do it.

Thanks,
Leo
