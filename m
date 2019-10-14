Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C78BC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A6420854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfJNP35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729905AbfJNP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:29:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22CA9308FB9A;
        Mon, 14 Oct 2019 15:29:56 +0000 (UTC)
Received: from krava (unknown [10.40.205.218])
        by smtp.corp.redhat.com (Postfix) with SMTP id 39238196AE;
        Mon, 14 Oct 2019 15:29:54 +0000 (UTC)
Date:   Mon, 14 Oct 2019 17:29:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf: add support for logging debug messages to
 file
Message-ID: <20191014152953.GD9700@krava>
References: <20191008123554.6796-1-changbin.du@gmail.com>
 <20191008123554.6796-3-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008123554.6796-3-changbin.du@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 14 Oct 2019 15:29:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:35:54PM +0800, Changbin Du wrote:
> When in TUI mode, it is impossible to show all the debug messages to
> console. This make it hard to debug perf issues using debug messages.
> This patch adds support for logging debug messages to file to resolve
> this problem.
> 
> The usage is:
> perf -debug verbose=2,file=~/perf.log COMMAND
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> --
> v4: fix another segfault.
> v3: fix a segfault issue.

hi,
no crash this time ;-) some questions below

> ---
>  tools/perf/Documentation/perf.txt | 15 ++++++-----
>  tools/perf/util/debug.c           | 44 ++++++++++++++++++++++++++++---
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index c05a94b2488e..a6b19661e5c3 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -16,14 +16,17 @@ OPTIONS
>  	Setup debug variable (see list below) in value
>  	range (0, 10). Use like:
>  	  --debug verbose   # sets verbose = 1
> -	  --debug verbose=2 # sets verbose = 2
> +	  --debug verbose=2,file=~/perf.log
> +	                    # sets verbose = 2 and save log to file
>  
>  	List of debug variables allowed to set:
> -	  verbose=level		- general debug messages
> -	  ordered-events=level	- ordered events object debug messages
> -	  data-convert=level	- data convert command debug messages
> -	  stderr		- write debug output (option -v) to stderr
> -				  in browser mode
> +	  verbose=level         - general debug messages
> +	  ordered-events=level  - ordered events object debug messages
> +	  data-convert=level    - data convert command debug messages
> +	  stderr                - write debug output (option -v) to stderr
> +	                          in browser mode
> +	  file=path             - write debug output to log file (stderr and
> +	                          file options are exclusive)
>  
>  --buildid-dir::
>  	Setup buildid cache directory. It has higher priority than
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index df82ad9cd16d..5cc2479d63ea 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -6,6 +6,7 @@
>  #include <stdarg.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <errno.h>
>  #include <sys/wait.h>
>  #include <api/debug.h>
>  #include <linux/kernel.h>
> @@ -26,7 +27,7 @@
>  int verbose;
>  bool dump_trace = false, quiet = false;
>  int debug_ordered_events;
> -static bool redirect_to_stderr;
> +static FILE *log_file;
>  int debug_data_convert;
>  
>  int veprintf(int level, int var, const char *fmt, va_list args)
> @@ -34,8 +35,10 @@ int veprintf(int level, int var, const char *fmt, va_list args)
>  	int ret = 0;
>  
>  	if (var >= level) {
> -		if (use_browser >= 1 && !redirect_to_stderr)
> +		if (use_browser >= 1 && !log_file)
>  			ui_helpline__vshow(fmt, args);
> +		else if (log_file)
> +			ret = vfprintf(log_file, fmt, args);
>  		else
>  			ret = vfprintf(stderr, fmt, args);
>  	}
> @@ -197,6 +200,24 @@ static int str2loglevel(const char *vstr)
>  	return v;
>  }
>  
> +static void flush_log(void)
> +{
> +	if (log_file)
> +		fflush(log_file);
> +}
> +
> +static void set_log_output(FILE *f)
> +{
> +	if (f == log_file)
> +		return;
> +
> +	if (log_file && log_file != stderr)
> +		fclose(log_file);
> +
> +	log_file = f;
> +	atexit(flush_log);
> +}
> +
>  int perf_debug_option(const char *str)
>  {
>  	char *sep, *vstr;
> @@ -218,8 +239,23 @@ int perf_debug_option(const char *str)
>  		else if (!strcmp(opt, "data-convert"))
>  			debug_data_convert = str2loglevel(vstr);
>  		else if (!strcmp(opt, "stderr"))
> -			redirect_to_stderr = true;

do you ned to fflush stderr? I thought it's unbuffered

> -		else {
> +			set_log_output(stderr);
> +		else if (!strcmp(opt, "file")) {
> +			FILE *f;
> +
> +			if (!vstr)
> +				vstr = (char *)"perf.log";

you did not mention in doc that perf.log is default

> +
> +			f = fopen(vstr, "a");
> +			if (!f) {
> +				pr_err("Can not create log file: %s\n",
> +				       strerror(errno));
> +				free(dstr);
> +				return -1;
> +			}
> +			fprintf(f, "\n===========perf log===========\n");

is this necessary?

jirka

> +			set_log_output(f);
> +		} else {
>  			fprintf(stderr, "unkown debug option '%s'\n", opt);
>  			free(dstr);
>  			return -1;
> -- 
> 2.20.1
> 
