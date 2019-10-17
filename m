Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC23AECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0F2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrtkfAXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440689AbfJQTtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:49:14 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:35300 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfJQTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:49:14 -0400
Received: by mail-qt1-f175.google.com with SMTP id m15so5430643qtq.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ld3QzIh9Kjp1LuhDbcRleycPavRHyknoLj8FLlpV0Qk=;
        b=MrtkfAXWDyFPrQeJGyQMnrzfGNn9ZzfQoSr7ab8+6Vn3/I1WewjPpluIQ0oEnHzU6x
         RbbFLfuxUp8AdQTshlcQW0ke8X9Ly8qU96mQKLy2jeWJVZ2k2b7ObKmvhjtqNlAUu7L8
         O9D0/gCKw/bXO0nk70ak/lIwLDeaKrbakyzDLjw/fRZavwu4zKFfllHMEZ/GHoQqq1uq
         n5SN7BhRmIFSN2UmXVOhblbx4f3qn88ugfpNB8LmFjR/Jq+hzjdrQjtjJEc381dRtcfk
         d4Pz4ZvgIFQo8IBNP9JWPq71s50X7ZTYJVLIwKM9AEfw60dM2BBrWwPwcLwuvVXporns
         aqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ld3QzIh9Kjp1LuhDbcRleycPavRHyknoLj8FLlpV0Qk=;
        b=nOj4hCOCTgwKZ3hCjEulqfTP/yiM1uPrjPf56hTYzCjh6hD+GBRu8sDz5vJzSjxngp
         wKmZd2IKSTuOBzZz+iS7jhhMbot33Dxg+f5vx49TvoNSyUctsfSfjETS6RqECrsZRQk/
         HMrDN2r0UA9fKPZYBRgfvmhDOzZL/BvsMiyWqZdBrOH8RH30PZXQ9UjM0rxEnGztGA1S
         MRY2DDxKMkMYgM8cRg0oiT0olSU/dJqa5JhtQMET+BCObLokcvC4fNJ/Lo+aRAnqe4Ft
         7grTwm4jYi37eR5LlPhy/U/y+YK9n6wR17FDf5mqGLXZGZHgicd1qPY5Rd7sBps45wx2
         Hvsg==
X-Gm-Message-State: APjAAAVNB0T8HnfMX92EkLC+XzVutD6O2IqrKk3HAB4ynF+yyFJk1w8n
        7aVBihMW+eHyyH/e2EgvLto=
X-Google-Smtp-Source: APXvYqw7W1nN2VgpB3pKUsKoIuG8iuxcpVkxsajuI3J8hIyY/qE0SoaWx1jSMrNcx1l7V4u1lMcm/w==
X-Received: by 2002:a0c:91bd:: with SMTP id n58mr5833422qvn.62.1571341752745;
        Thu, 17 Oct 2019 12:49:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.211.77])
        by smtp.gmail.com with ESMTPSA id v139sm1751962qkb.53.2019.10.17.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:49:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0250A4DD66; Thu, 17 Oct 2019 16:49:07 -0300 (-03)
Date:   Thu, 17 Oct 2019 16:49:07 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] libtraceevent: perf script -g python segfaults
Message-ID: <20191017194907.GC3600@kernel.org>
References: <20191017154205.GC8974@kernel.org>
 <20191017143841.317b26b5@gandalf.local.home>
 <20191017144114.48e25298@gandalf.local.home>
 <20191017192832.GB3600@kernel.org>
 <20191017153733.630cd5eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017153733.630cd5eb@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 17, 2019 at 03:37:33PM -0400, Steven Rostedt escreveu:
> On Thu, 17 Oct 2019 16:28:32 -0300
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> 
> > Em Thu, Oct 17, 2019 at 02:41:14PM -0400, Steven Rostedt escreveu:
> > > On Thu, 17 Oct 2019 14:38:41 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >   
> > > >  struct tep_event *trace_find_next_event(struct tep_handle *pevent,
> > > >  					struct tep_event *event)
> > > >  {
> > > > +	static struct tep_event **all_events;
> > > >  	static int idx;
> > > >  	int events_count;
> > > > -	struct tep_event *all_events;  
> > > 
> > > If we are going to use static variables, let's make them all static and
> > > optimize it a little more...  
> > 
> > I'll test it, but can't you have this somewhere else, i.e. at
> > tep_handle perhaps?
> > 
> >
> 
> Or we can nuke the function entirely, it's a rather silly helper
> anyway. Just do this:

I like it, that is a good nuke use, nice button to press! :-)

Testing it now...

- Arnaldo
 
> -- Steve
> 
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index b93f36b887b5..f1d5f564aa46 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -537,10 +537,11 @@ static int perl_stop_script(void)
>  
>  static int perl_generate_script(struct tep_handle *pevent, const char *outfile)
>  {
> +	int i, not_first, count, nr_events;
> +	struct tep_event **all_events;
>  	struct tep_event *event = NULL;
>  	struct tep_format_field *f;
>  	char fname[PATH_MAX];
> -	int not_first, count;
>  	FILE *ofp;
>  
>  	sprintf(fname, "%s.pl", outfile);
> @@ -601,8 +602,11 @@ sub print_backtrace\n\
>  }\n\n\
>  ");
>  
> +	nr_events = tep_get_events_count(pevent);
> +	all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
>  
> -	while ((event = trace_find_next_event(pevent, event))) {
> +	for (i = 0; all_events && i < nr_events; i++) {
> +		event = all_events[i];
>  		fprintf(ofp, "sub %s::%s\n{\n", event->system, event->name);
>  		fprintf(ofp, "\tmy (");
>  
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 87ef16a1b17e..2a148a10d0de 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1590,10 +1590,11 @@ static int python_stop_script(void)
>  
>  static int python_generate_script(struct tep_handle *pevent, const char *outfile)
>  {
> +	int i, not_first, count, nr_events;
> +	struct tep_event **all_events;
>  	struct tep_event *event = NULL;
>  	struct tep_format_field *f;
>  	char fname[PATH_MAX];
> -	int not_first, count;
>  	FILE *ofp;
>  
>  	sprintf(fname, "%s.py", outfile);
> @@ -1638,7 +1639,11 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
>  	fprintf(ofp, "def trace_end():\n");
>  	fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
>  
> -	while ((event = trace_find_next_event(pevent, event))) {
> +	nr_events = tep_get_events_count(pevent);
> +	all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
> +
> +	for (i = 0; all_events && i < nr_events; i++) {
> +		event = all_events[i];
>  		fprintf(ofp, "def %s__%s(", event->system, event->name);
>  		fprintf(ofp, "event_name, ");
>  		fprintf(ofp, "context, ");
> 

-- 

- Arnaldo
