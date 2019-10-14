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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA09BECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3A12067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLlkrh08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfJNOY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:24:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37334 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbfJNOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:24:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so16063415qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cOYG38CUdckNFnwHJHo++ePElnN1zXnfHM/vkk4ZyI0=;
        b=NLlkrh08FD4VxE8DtpADBnNtLaleWwQtAljnhV1Nl6T/2mlaNCxPCx9JLjzWMMa9gH
         qQPGrEh7e8b6DYLbPLKFH9h9NsR8Jvr9ndSYQqf27jSzRgsXueuGlzVye5PsYuQDf2Ea
         6/H9UuFRp5bE5DGsKtUiTV2eTW1t0KWqU+Yy0unCh8Ra0yWfJtkl5IcEW+z8RDnfaQmY
         YWWaNZHgBHxdyqQgBTkplBzq0Kb7Zul/JS+C7l1v1+l0s6hpo01aK99EBANG4kf21q3m
         z8LnkDQsijqOxRWZWPMQg0eOdfscglCWwuG+rPD8oCIMhMjxFAr2/RG7Kemz7bVe2ypN
         KdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cOYG38CUdckNFnwHJHo++ePElnN1zXnfHM/vkk4ZyI0=;
        b=A2q2yUO7Jav8AplSnDlTHtLkJpk59+68Klnn4gd/GsZzuQilRZsfPSRgvfgU6n3Ds9
         yO2duMVCFOcw8QPb4c3IpDP9+4Ow59hp/RRY5ZdY7S3GxPBVeE82vviqKzyZou1He41y
         jDDrNWcVC1DN4jqeIw5vjnJy2FY0B6G12+aYVdQ+DN28AIdGEdgvSIzua03SKZ7fSTpj
         9ehaecExarz1u36ar5KjZMB/nj3A3RyodvqjQw5bGJJEcAgmriO+534tauJvkcv1RPzs
         2Gr9oXvLXr6WSFM8PzCOXnV4Qz6tZSeUlKRzrzwQZEZcS7cwCPJjLE+fAoBWUsagyV+V
         yW9A==
X-Gm-Message-State: APjAAAUY6nB6HPkjJqPLqmPW7fOpO7zCnX6fJO+NYYlZG5dzJRW4u7NE
        Mm2AoIm86rdMvEFQ6MFBZ9M/Qhae
X-Google-Smtp-Source: APXvYqzVLTnLCPqAKdINnZududp/9OKljwOsJkzhvrR7Jd5TP1BsKUGro8G0w9wRKDvZQx75ksWz/w==
X-Received: by 2002:a05:620a:2193:: with SMTP id g19mr30845981qka.184.1571063067173;
        Mon, 14 Oct 2019 07:24:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v85sm6725977qkb.25.2019.10.14.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:24:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6145F4DD66; Mon, 14 Oct 2019 11:24:24 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:24:24 -0300
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
Subject: Re: [PATCH 5/5] perf annotate: fix objdump --no-show-raw-insn flag
Message-ID: <20191014142424.GI19627@kernel.org>
References: <20191010183649.23768-1-irogers@google.com>
 <20191010183649.23768-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010183649.23768-6-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 10, 2019 at 11:36:49AM -0700, Ian Rogers escreveu:
> Remove redirection of objdump's stderr to /dev/null to help diagnose
> failures.
> Fix the '--no-show-raw' flag to be '--no-show-raw-insn' which binutils
> is permissive and allows, but fails with LLVM objdump.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 3d5b9236576a..2a71c90a4921 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1944,13 +1944,13 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	err = asprintf(&command,
>  		 "%s %s%s --start-address=0x%016" PRIx64
>  		 " --stop-address=0x%016" PRIx64
> -		 " -l -d %s %s -C \"$1\" 2>/dev/null",
> +		 " -l -d %s %s -C \"$1\"",
>  		 opts->objdump_path ?: "objdump",
>  		 opts->disassembler_style ? "-M " : "",
>  		 opts->disassembler_style ?: "",
>  		 map__rip_2objdump(map, sym->start),
>  		 map__rip_2objdump(map, sym->end),
> -		 opts->show_asm_raw ? "" : "--no-show-raw",
> +		 opts->show_asm_raw ? "" : "--no-show-raw-insn",
>  		 opts->annotate_src ? "-S" : "");
>  
>  	if (err < 0) {
> -- 
> 2.23.0.581.g78d2f28ef7-goog

-- 

- Arnaldo
