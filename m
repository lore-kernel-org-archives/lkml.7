Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A463C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B7C2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii2SJOq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfJNOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:19:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38163 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732558AbfJNOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:19:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so25652066qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQjbModwl3zkXwdwmKJ4bMoReVeolUFu/id85D1bDew=;
        b=Ii2SJOq4g8+3ItxEvViANup5XgR/0yc6/sPW7zFVzTnm5Yf4aBu8yrzMDWmMIBTqye
         ACXgCh1M+GeMcNMK5HeojE0AdjT0fTt8r5kczhbUHLyB4iHoLM+ex1757WjQLVUkoHP6
         SzWbGDbMhXiAATYeZNQdLOPEGvQdPMll69brLDXsX+Jk9vPQx+17J0KoKnJuMbPAzs3y
         J+XI+aOjW4Wgal4Q5HBiRumVD9UMtFJf2jpvmUsWWphvgYBXkOKn0ym97Tv3l+ZEa9c4
         Zixq6Nch4otwDj1ckRF/Ompj2bhbjaj6TXOfHiOvVx42OFMDlnRJU6MO+MzO1Es9qguJ
         b58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQjbModwl3zkXwdwmKJ4bMoReVeolUFu/id85D1bDew=;
        b=BFwbyqusA1hduNKkpkM/fqiO9/MGohQNYWHrk1iK+HcrSCtIPqevrri0WLWCMzTkNi
         3rTVs2qAtifoxzbrFYd0j1xuo6b5YpOdp6TYSfQhpA9SYQv6T+1aDQJ/qIR3yarmS+5B
         b2dyjG3lIQjvFc3sxOYpF86wHw6DjEilKc789A3ZP+aYRJiYNXkWXapidN/sYRrW1LHC
         nsTaTZ7poPyvONxwajuilWANY7PDcKsnqSElfW6oRTIkO/yBuWRQCV0xHUyAhKpaxK3t
         /PTJWG8q67aQAQVxqNojx3IHQXOdQtTDGen6ewvTMIZ+8Iw+sROZv8GZhbjn1hTnmQKi
         GPNA==
X-Gm-Message-State: APjAAAUJk/m0s7oMx5dZGXWG9ocCHKtyUu1AnLVBXvsr4FH2+FnTuD7U
        7vRGaFdurwgM8SS3wyNi/14=
X-Google-Smtp-Source: APXvYqyapKnGQSN76XGhW4aMSjrEefHInuTDPZzTOJwL5bf01E+J9J5L86smCLjPHq0bUGk5dt9ycg==
X-Received: by 2002:aed:2462:: with SMTP id s31mr33446165qtc.40.1571062790505;
        Mon, 14 Oct 2019 07:19:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id m186sm8541598qkb.88.2019.10.14.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:19:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08CE54DD66; Mon, 14 Oct 2019 11:19:48 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:19:47 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/5] perf annotate: don't pipe objdump output through grep
Message-ID: <20191014141947.GH19627@kernel.org>
References: <20191010183649.23768-1-irogers@google.com>
 <20191010183649.23768-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010183649.23768-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 10, 2019 at 11:36:47AM -0700, Ian Rogers escreveu:
> Simplify the objdump command by not piping the output of objdump through
> grep. Instead, drop lines that match the grep pattern during the reading
> loop.

Thanks, applied and tested.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index fc12c5cfe112..0a7a6f3c55f4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1894,7 +1894,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	err = asprintf(&command,
>  		 "%s %s%s --start-address=0x%016" PRIx64
>  		 " --stop-address=0x%016" PRIx64
> -		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
> +		 " -l -d %s %s -C \"$1\" 2>/dev/null|expand",
>  		 opts->objdump_path ?: "objdump",
>  		 opts->disassembler_style ? "-M " : "",
>  		 opts->disassembler_style ?: "",
> @@ -1940,9 +1940,16 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  
>  	nline = 0;
>  	while (!feof(file)) {
> +		const char *match;
> +
>  		if (getline(&line, &line_len, file) < 0 || !line)
>  			break;
>  
> +		/* Skip lines containing "filename:" */
> +		match = strstr(line, symfs_filename);
> +		if (match && match[strlen(symfs_filename)] == ':')
> +			continue;
> +
>  		/*
>  		 * The source code line number (lineno) needs to be kept in
>  		 * across calls to symbol__parse_objdump_line(), so that it
> -- 
> 2.23.0.581.g78d2f28ef7-goog

-- 

- Arnaldo
