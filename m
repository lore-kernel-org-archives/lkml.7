Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF36C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFD22190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1iftIqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKKOZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:25:15 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35679 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:25:15 -0500
Received: by mail-qv1-f66.google.com with SMTP id y18so4936855qve.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pd0jyk5Hmsa8VRUVMIT7ZCVSUG/JVaQlXwpiOsD9XiM=;
        b=O1iftIqOql2rWcdlade68KTF0CpGdCZI3nsRvDmJsmTUBfr3VehEITs63XxFler/42
         zlJtkAf78fTrB3ladUZZHJriEVhlVQIsNhAnZQTcX95RNDGnVxqdFEhXqdIq0pkCSvM/
         F/0jHnZA38u8pxRYeNDPqLB7QsFcXA9OwOWFpNESHEvVUrfhDR1GE5IeBJNrtCtaIgZd
         6Y+rYKfBYpZbpb7TgpxbWVhY8yxE+1qZxhJ9M0+C7BivmtZyjvbS4RezN8wbE92sQU2l
         NibpVA76cr+tFmmOr1Ucmk5Ergg7rCtCn6F6evhvbJcvxug/SuXElahje9MTn8UziWs4
         xMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pd0jyk5Hmsa8VRUVMIT7ZCVSUG/JVaQlXwpiOsD9XiM=;
        b=dpoF4txqlr7MeHeaSuGIFGorIm2bZOjq6fZiVACw0Zcvg1ZP4gUFyZTUtCwHsR/BhL
         4tyjMPUmB2oL/DESEqA2JhyhB8Q4IZpFNrhmgiCARVWXQpMOIPpSu69eEBiDzIIAtMNo
         /uDYYtJ0qgMIWE9j9WeV4Y4RYq7BPFh6qpRePB3nwEbNqZ6jWxBE48lUXJBGCN84SCwC
         rGk/QDqezCiiEnkLc5zvg4q2BFQVcHFz1qhJdC41QcF+eM1+reb80m9Mcq3PkfRyuYHp
         MLxLzUGhic2yeKtIfqvp62Jz1BYsIg4hZzqp+sx+QOxe5p9RGA+IQRGKZGrjht2/YaiN
         JAhw==
X-Gm-Message-State: APjAAAWHQgJoHx8gHCwJxMhOLJzAGPFrzFOYOJtTI7OE42G6yJ5YocOR
        MXb/1L4tjekPEfKrDoriRxI=
X-Google-Smtp-Source: APXvYqwdViP7HkiM4opx0BxrBBRraIYawh2Gn4x0C8bgaeOf+rkbg6Al5pD5O8GNGdaQefcW36lYzg==
X-Received: by 2002:a05:6214:1323:: with SMTP id c3mr23573062qvv.243.1573482314083;
        Mon, 11 Nov 2019 06:25:14 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c128sm1022371qkg.124.2019.11.11.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:25:13 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A5AE411B3; Mon, 11 Nov 2019 11:25:11 -0300 (-03)
Date:   Mon, 11 Nov 2019 11:25:11 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, He Kuang <hekuang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: avoid reading out of scope array
Message-ID: <20191111142511.GF9365@kernel.org>
References: <20191017170531.171244-1-irogers@google.com>
 <20191023082912.GB22919@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023082912.GB22919@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 23, 2019 at 10:29:12AM +0200, Jiri Olsa escreveu:
> On Thu, Oct 17, 2019 at 10:05:31AM -0700, Ian Rogers wrote:
> > Modify tracepoint name into 2 sys components and assemble at use. This
> > avoids the sys_name array being out of scope at the point of use.
> > Bug caught with LLVM's address sanitizer with fuzz generated input of
> > ":cs\1" to parse_events.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.y | 36 +++++++++++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 48126ae4cd13..28be39a703c9 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -104,7 +104,8 @@ static void inc_group_count(struct list_head *list,
> >  	struct list_head *head;
> >  	struct parse_events_term *term;
> >  	struct tracepoint_name {
> > -		char *sys;
> > +		char *sys1;
> > +		char *sys2;
> >  		char *event;
> >  	} tracepoint_name;
> >  	struct parse_events_array array;
> > @@ -425,9 +426,19 @@ tracepoint_name opt_event_config
> >  	if (error)
> >  		error->idx = @1.first_column;
> >  
> > -	if (parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
> > -					error, $2))
> > -		return -1;
> > +        if ($1.sys2) {
> > +		char sys_name[128];
> > +		snprintf(&sys_name, sizeof(sys_name), "%s-%s",
> > +			$1.sys1, $1.sys2);
> > +		if (parse_events_add_tracepoint(list, &parse_state->idx,
> > +						sys_name, $1.event,
> > +						error, $2))
> > +			return -1;
> > +        } else
> > +		if (parse_events_add_tracepoint(list, &parse_state->idx,
> > +						$1.sys1, $1.event,
> > +						error, $2))
> > +			return -1;
> 
> nice catch, please enclose all multiline condition legs with {}
> 
> other than that
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Ian, this one isn't applying to my perf/core branch, can you please
address Jiri's comment and resubmit?

- arnaldo
