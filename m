Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6E5C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BB72173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558579330;
	bh=kzrXIJesvbEc8PheR98SRazIjZUjAUEPbbtwF3OPPz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aV/0hv/rYdSbqHdEo18mexeg+Oj7TIjZ3NsoVO8iXzezfJoInpcsF2V85wQTtJRMw
	 v+sJVkkj91Y03ZQo9uyXOqQF4WMnjz1m3XP9Lr1TEfwERFMStXYtXY3mYI9gRLrWwX
	 /kxF2RR6JkkE7NMSDHo1hnkfgj+C0i49XIQ6BZGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfEWCmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:42:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46110 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:42:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id r18so1986515pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zXRl8xYw8irI5iOjDnZrPwf9D6nvpcG/SowB4qdokqM=;
        b=WR4BsB0UuqhlH3a7015JvPFWjici1vUa66ZSC9MGJDCkkHaGl6pPFocpYIK3ZP4onl
         0X+7+/AfZIPy2vuifVlgCdlap2+nEjPmbAiKzv2tWq5xXlOXtYc4Q8LIX5vHfKSroWzF
         5hMSwtYuZ5h5gA/oilE62qWY0RXassLaKCT9cfvSHSrV+i3ZEawrP7EujQm2RutV0kMB
         ceJmdx15O4UYYhihZIbCaB4BTsfamttwcIP3QwM0zk8wRuj8NPqfEolf9ffGTuI5+fMP
         eBsfJ+aN0RvGewK4n7CzCCPebwQuRqVxgogr5/uiU25nz+IRHaI8LX1B/O2xzqrrUJbF
         CNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXRl8xYw8irI5iOjDnZrPwf9D6nvpcG/SowB4qdokqM=;
        b=SZ0TXRAeJ/5M6rCzUGbyisIgpIe2GKMytK2989q3iMzFHUru+wDAlgH3qooO1ECBzA
         50qGaTmzkrKgr0q6t/8xm5g1JtHcDkM//WjN9oMY1eZ+b14cBV2gEm3iOG8WW9No6of8
         3WjoeuRTnpzhran9eouAvZBwoUMxJAxob8onQSBy3/VfcWNj1bL5v2lZkMmIGq6owaA6
         khURYLULyS3loZPsgxCC3ji8ok02SCnoHbkeDV4qRChd4lnP2udN7GqXS/K0pEvxQBpI
         vPThE/weoQGFUU7w2HxWXc0TLL56QQ5PVJsfq8yG+RatumFhV4b5TuBBE/mwRhZ1fmbm
         ylhw==
X-Gm-Message-State: APjAAAXIpHuv6OKaFcx+Fvf6eYBxTG//gTfrpXCgVF+NOTGY3SfSjHXS
        ufhGyGAeuaXzQTkQecvhs5YEWgGG
X-Google-Smtp-Source: APXvYqxn4VcyjpdJXLmxqUGYiVR5xNNfAbSfmctJpFhsBkDIyjzVaPTdYduW4ocb8ULmYJFhM/eRTw==
X-Received: by 2002:a17:902:7883:: with SMTP id q3mr20228176pll.89.1558579329169;
        Wed, 22 May 2019 19:42:09 -0700 (PDT)
Received: from google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id f10sm280532pgq.73.2019.05.22.19.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 19:42:08 -0700 (PDT)
Date:   Thu, 23 May 2019 11:42:04 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] perf top: Enable --namespaces option
Message-ID: <20190523024202.GB196218@google.com>
References: <20190522053250.207156-1-namhyung@kernel.org>
 <20190522053250.207156-4-namhyung@kernel.org>
 <20190522132424.GD30271@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522132424.GD30271@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:24:24AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 22, 2019 at 02:32:50PM +0900, Namhyung Kim escreveu:
> > Since perf record already have the option, let's have it for perf top
> > as well.
> 
> I'm applying, but I wonder if this shouldn't be the default...

Not sure, it'll only add a bit of overhead to task and/or namespace
creation.

Thanks,
Namhyung


> 
> - Arnaldo
>  
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-top.txt | 5 +++++
> >  tools/perf/builtin-top.c              | 5 +++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > index 44d89fb9c788..cfea87c6f38e 100644
> > --- a/tools/perf/Documentation/perf-top.txt
> > +++ b/tools/perf/Documentation/perf-top.txt
> > @@ -262,6 +262,11 @@ Default is to monitor all CPUS.
> >  	The number of threads to run when synthesizing events for existing processes.
> >  	By default, the number of threads equals to the number of online CPUs.
> >  
> > +--namespaces::
> > +	Record events of type PERF_RECORD_NAMESPACES and display it with the
> > +	'cgroup_id' sort key.
> > +
> > +
> >  INTERACTIVE PROMPTING KEYS
> >  --------------------------
> >  
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 3648ef576996..6651377fd762 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1208,6 +1208,9 @@ static int __cmd_top(struct perf_top *top)
> >  
> >  	init_process_thread(top);
> >  
> > +	if (opts->record_namespaces)
> > +		top->tool.namespace_events = true;
> > +
> >  	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
> >  						&top->session->machines.host,
> >  						&top->record_opts);
> > @@ -1500,6 +1503,8 @@ int cmd_top(int argc, const char **argv)
> >  	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
> >  	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
> >  			"number of thread to run event synthesize"),
> > +	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
> > +		    "Record namespaces events"),
> >  	OPT_END()
> >  	};
> >  	struct perf_evlist *sb_evlist = NULL;
> > -- 
> > 2.21.0.1020.gf2820cf01a-goog
> 
> -- 
> 
> - Arnaldo
