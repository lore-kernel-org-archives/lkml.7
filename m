Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5705720708
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjvLZw7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUOru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:47:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42418 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:47:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id i3so3221645qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vdcmn1+3xWMnRDagEegM970Sjr+dGziiJdK5fsuiiM=;
        b=mjvLZw7a0yL6AlXcd6Zxt6dr83OQeu+0WNTEixGYwfmow+04mNk6KAmpgC0S7My6JD
         f9f5wVMCTb4MIZSDYn03rwP+r3wJPMA+oEoG2BwVPrIDbpF+SUOT5//KtGW2L7hMdUfJ
         d7ZtZW5vYO854MT8xfN3gwbZcHZePNCUSfb1hQNksod98RaYFRfZ8K8eX7TX6EE3FFf6
         JAlY2g9SnHygGABIYHUl7WRMy1G5XCw2FYuZGa4Iad/XbxiZiInvPj2UIHi9hbieiZXJ
         s/OraAsj12QVNyqlxqO7G1F3Z5FNWD9iovATkSHS7A3pdcuV3zaQwF9FBHLE6tkjWWfK
         8C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vdcmn1+3xWMnRDagEegM970Sjr+dGziiJdK5fsuiiM=;
        b=UHum64GtXtBR+Mi/4BNX7g7HQT0QTwuRYwdtYXmPGKFkZmq+CxT7Vloj0nQK9q1H7D
         p0DGpFx2TzVBgAX8btkLQWhJAnw1hqDQ5/DpdDp7BW91HdU/ARk4F2e7r08bj3AsmaUf
         QpUC05gnADoE9tZEJzfHmoXCnq3GNkbmm4Q1x9t9rCrMZjID2LcDouHm4QQaDF7qxjlW
         /IaMVjeLCg4FxLAPzuYuQZvbF7vFRNqqIPo0Yx/1ujsYPLFqy6BRLebmepFDssnaT9Ug
         fYjOSs/3YyYDQvQzX7rUcbU5o2CKoNVln5ZveAuMJF5+Vx3NvbPSSiWx44Zg4esyILcJ
         RqRQ==
X-Gm-Message-State: APjAAAXXE2rGktLcS5TBjsZdQyXUzc6aEGekFmKfLRrzUFEHGrWsD1cT
        rFii916hlrdbrOUJ1zf1PeY=
X-Google-Smtp-Source: APXvYqy8O0Z1bmM6bi5OawpJm2ccCS3stk00YQDa/rHqatx0z0pmMJ8k1ko+8QekQ49rGm3eYy6+hA==
X-Received: by 2002:a37:f915:: with SMTP id l21mr716881qkj.209.1574347667475;
        Thu, 21 Nov 2019 06:47:47 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z6sm1012802qkz.101.2019.11.21.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:47:46 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6937840D3E; Thu, 21 Nov 2019 11:47:44 -0300 (-03)
Date:   Thu, 21 Nov 2019 11:47:44 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: fix potential memory leak
Message-ID: <20191121144744.GI5078@kernel.org>
References: <20191120180925.21787-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120180925.21787-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 20, 2019 at 10:09:25AM -0800, Ian Rogers escreveu:
> An error may be in place when tracepoint_error is called, use
> parse_events__handle_error to avoid a memory leak and to capture the
> first and last error. Error detected by LLVM's libFuzzer using the
> following event:
> 
> $ perf stat -e 'msr/event/,f:e'
> event syntax error: 'msr/event/,f:e'
>                      \___ can't access trace events
> 
> Error:  No permissions to read /sys/kernel/debug/tracing/events/f/e
> Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing/'
> 
> Initial error:
> event syntax error: 'msr/event/,f:e'
>                                 \___ no value assigned for term
> Run 'perf list' for a list of valid events
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list available events

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 6bae9d6edc12..ecef5b8037b4 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -511,6 +511,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>  static void tracepoint_error(struct parse_events_error *e, int err,
>  			     const char *sys, const char *name)
>  {
> +	const char *str;
>  	char help[BUFSIZ];
>  
>  	if (!e)
> @@ -524,18 +525,18 @@ static void tracepoint_error(struct parse_events_error *e, int err,
>  
>  	switch (err) {
>  	case EACCES:
> -		e->str = strdup("can't access trace events");
> +		str = "can't access trace events";
>  		break;
>  	case ENOENT:
> -		e->str = strdup("unknown tracepoint");
> +		str = "unknown tracepoint";
>  		break;
>  	default:
> -		e->str = strdup("failed to add tracepoint");
> +		str = "failed to add tracepoint";
>  		break;
>  	}
>  
>  	tracing_path__strerror_open_tp(err, help, sizeof(help), sys, name);
> -	e->help = strdup(help);
> +	parse_events__handle_error(e, 0, strdup(str), strdup(help));
>  }
>  
>  static int add_tracepoint(struct list_head *list, int *idx,
> -- 
> 2.24.0.432.g9d3f5f5b63-goog

-- 

- Arnaldo
