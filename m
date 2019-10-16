Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665ECECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF142067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teSCk0fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbfJPANo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:13:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32933 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfJPANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:13:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so3433340wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UuDMUddzEnik9Lf7ZPAO3s0i6j7aIKnSuu0LT3ObG9U=;
        b=teSCk0fxsgO807bxG7AS6jc+9sm2K8O0tTsJIu2OOPss3o8vXBIzK+bxAAE3Nwd2gj
         mFA26ALZYiyF85VAwDMJfmfh4/qO3eem9dGD9451C9HOQLxOgzesfmaDWeCJD3HTHiEx
         5fivKMGlp5jyru1ZkJNTu6ThJzHVzGbkh+Cb7x9ycD87UdcOObmngvSImIXSu+jXo5qU
         ITwqWIZuL0N8NMYxYQc42z+bfDaCU3IGF2+dtNVhTb7If0vNRM5dTOyx3VXXOG1exwo2
         q0RtE2PhnGtle/pqZE/X/FTDT5qexIyYaPr2mATaAk0oNym452Jot9IL4Rv0ubmp2cIe
         ZXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UuDMUddzEnik9Lf7ZPAO3s0i6j7aIKnSuu0LT3ObG9U=;
        b=nI0ZjQIAUmJ3axmTPzAfjHEURcUU05FZoGRXIeEGeO9EOfnZgbdW9TK4tDRnwa/Pyd
         43WYspQCTIxG9fDEl884m/sLA09oJb+OijsRlVRaHvZyQFv6HQPX6DPz87wUrFOCPMWp
         85OrHlSVl1Jw1PskUa3Th01v6XXQ5ZtW1dfrHbuYTZoh63W5NMAAgWFcyfp5YRiuGbe0
         eWqWLJyZTqFCtZgGG82jVn/Z1zxQUhcA2/CSmP4ArKJxNjGQU/PVKGg4sO0eiiqqMf+Z
         GKxt+gD4BdugFR92HeRR98YzPdBycjnc+S6xOEilXdiOn2s0KbGLtDYdxVFbwTtR+mJf
         VvXQ==
X-Gm-Message-State: APjAAAUb4wMOqKwBiZ1qsCZzenDg+hl5JnPM2jiOVlI0huKcXrwrgt/z
        wfrpKVm/ZNCOZtUsPZGqHtJUPHpZc3s=
X-Google-Smtp-Source: APXvYqwvo79KTHbxKsmJBzgqMTrAFlAf9+nCbtKAF+VGfn7NbaaUr4BoluH4tC8L8W3Q57WBE4souQ==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr869410wms.168.1571184821553;
        Tue, 15 Oct 2019 17:13:41 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id g4sm27605234wrw.9.2019.10.15.17.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 17:13:40 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:13:33 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf: add support for logging debug messages to
 file
Message-ID: <20191016001331.cmwrr5iew5twe7fe@mail.google.com>
References: <20191008123554.6796-1-changbin.du@gmail.com>
 <20191008123554.6796-3-changbin.du@gmail.com>
 <20191014152953.GD9700@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014152953.GD9700@krava>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 05:29:53PM +0200, Jiri Olsa wrote:
> On Tue, Oct 08, 2019 at 08:35:54PM +0800, Changbin Du wrote:
> > When in TUI mode, it is impossible to show all the debug messages to
> > console. This make it hard to debug perf issues using debug messages.
> > This patch adds support for logging debug messages to file to resolve
> > this problem.
> > 
> > The usage is:
> > perf -debug verbose=2,file=~/perf.log COMMAND
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > 
> > --
> > v4: fix another segfault.
> > v3: fix a segfault issue.
> 
> hi,
> no crash this time ;-) some questions below
> 
> > ---
> >  tools/perf/Documentation/perf.txt | 15 ++++++-----
> >  tools/perf/util/debug.c           | 44 ++++++++++++++++++++++++++++---
> >  2 files changed, 49 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> > index c05a94b2488e..a6b19661e5c3 100644
> > --- a/tools/perf/Documentation/perf.txt
> > +++ b/tools/perf/Documentation/perf.txt
> > @@ -16,14 +16,17 @@ OPTIONS
> >  	Setup debug variable (see list below) in value
> >  	range (0, 10). Use like:
> >  	  --debug verbose   # sets verbose = 1
> > -	  --debug verbose=2 # sets verbose = 2
> > +	  --debug verbose=2,file=~/perf.log
> > +	                    # sets verbose = 2 and save log to file
> >  
> >  	List of debug variables allowed to set:
> > -	  verbose=level		- general debug messages
> > -	  ordered-events=level	- ordered events object debug messages
> > -	  data-convert=level	- data convert command debug messages
> > -	  stderr		- write debug output (option -v) to stderr
> > -				  in browser mode
> > +	  verbose=level         - general debug messages
> > +	  ordered-events=level  - ordered events object debug messages
> > +	  data-convert=level    - data convert command debug messages
> > +	  stderr                - write debug output (option -v) to stderr
> > +	                          in browser mode
> > +	  file=path             - write debug output to log file (stderr and
> > +	                          file options are exclusive)
> >  
> >  --buildid-dir::
> >  	Setup buildid cache directory. It has higher priority than
> > diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> > index df82ad9cd16d..5cc2479d63ea 100644
> > --- a/tools/perf/util/debug.c
> > +++ b/tools/perf/util/debug.c
> > @@ -6,6 +6,7 @@
> >  #include <stdarg.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <errno.h>
> >  #include <sys/wait.h>
> >  #include <api/debug.h>
> >  #include <linux/kernel.h>
> > @@ -26,7 +27,7 @@
> >  int verbose;
> >  bool dump_trace = false, quiet = false;
> >  int debug_ordered_events;
> > -static bool redirect_to_stderr;
> > +static FILE *log_file;
> >  int debug_data_convert;
> >  
> >  int veprintf(int level, int var, const char *fmt, va_list args)
> > @@ -34,8 +35,10 @@ int veprintf(int level, int var, const char *fmt, va_list args)
> >  	int ret = 0;
> >  
> >  	if (var >= level) {
> > -		if (use_browser >= 1 && !redirect_to_stderr)
> > +		if (use_browser >= 1 && !log_file)
> >  			ui_helpline__vshow(fmt, args);
> > +		else if (log_file)
> > +			ret = vfprintf(log_file, fmt, args);
> >  		else
> >  			ret = vfprintf(stderr, fmt, args);
> >  	}
> > @@ -197,6 +200,24 @@ static int str2loglevel(const char *vstr)
> >  	return v;
> >  }
> >  
> > +static void flush_log(void)
> > +{
> > +	if (log_file)
> > +		fflush(log_file);
> > +}
> > +
> > +static void set_log_output(FILE *f)
> > +{
> > +	if (f == log_file)
> > +		return;
> > +
> > +	if (log_file && log_file != stderr)
> > +		fclose(log_file);
> > +
> > +	log_file = f;
> > +	atexit(flush_log);
> > +}
> > +
> >  int perf_debug_option(const char *str)
> >  {
> >  	char *sep, *vstr;
> > @@ -218,8 +239,23 @@ int perf_debug_option(const char *str)
> >  		else if (!strcmp(opt, "data-convert"))
> >  			debug_data_convert = str2loglevel(vstr);
> >  		else if (!strcmp(opt, "stderr"))
> > -			redirect_to_stderr = true;
> 
> do you ned to fflush stderr? I thought it's unbuffered
>
Acorrding to my test, some messages are lost after ctrl-c without flusing. So
I think it is buffered by libc?

> > -		else {
> > +			set_log_output(stderr);
> > +		else if (!strcmp(opt, "file")) {
> > +			FILE *f;
> > +
> > +			if (!vstr)
> > +				vstr = (char *)"perf.log";
> 
> you did not mention in doc that perf.log is default
> 
yes, it should be mentioned.

> > +
> > +			f = fopen(vstr, "a");
> > +			if (!f) {
> > +				pr_err("Can not create log file: %s\n",
> > +				       strerror(errno));
> > +				free(dstr);
> > +				return -1;
> > +			}
> > +			fprintf(f, "\n===========perf log===========\n");
> 
> is this necessary?
> 
Yes, because we will append new log to existing one. So we'd beeter put a margin
there.

> jirka
> 
> > +			set_log_output(f);
> > +		} else {
> >  			fprintf(stderr, "unkown debug option '%s'\n", opt);
> >  			free(dstr);
> >  			return -1;
> > -- 
> > 2.20.1
> > 

-- 
Cheers,
Changbin Du
