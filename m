Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FCEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289CE2339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+3tIlNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfIAPOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:14:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47006 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfIAPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:14:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so902831qkd.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CzWizBmKHYjeRy8xI8+2ULlvyi2RPkZmYCE6Y3FLHUA=;
        b=S+3tIlNodNSVaijZRv57CKtqlOvoxbnz+K6vawptldoBeScaQEZRQikg2TWPa/gald
         cEHYeYTOK1qjgbTg2pDaIHqhnYI67zKQfh6bRLRmA2lBupBh0Mt64R29EJLIpTfQU41N
         glCgrLoLk1Ls/R1O34GwTUvVTICY3AqoC/qjZhWtT5313tZs8zOZM8QvQordB6RmNszV
         t5Ltn5RX9V3PFs+jU1dTAihJpyZnZqsDAyAO4HfqeUMPD6lmXErChFWiue0HcQseWQIZ
         2CGfo9IfsvAi4Bx9YktNrjQo82895de2C5mAQAqJ9WFPsZxSxaRCPWkXyFntGoAzUo4U
         3BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CzWizBmKHYjeRy8xI8+2ULlvyi2RPkZmYCE6Y3FLHUA=;
        b=rm0X6UvheXfwvMoAycar0PHeyygSZMJ1UtmzRxkxOOqgnDpdb/wRA/jSHBqJkkx0Q/
         FfmvXc6WhkgWHLvdYe18txZvrWmGPTRm/EsM3Dxx7Z9yG3gGxI5jeLDGDOpmnURCvC0V
         VK+ppN+Q0ROBGogsJ8BaHU2W31rIc3CiSnJ4zLTktm2xJBb54nptuveC3CzuBVGBWjvD
         RjuTVntBDZ6D9NDQkpbqwYzrD8wOONFvvR3vZcBDRyMD9WPQCt3lv+j5fnwpb3LO4TUf
         zMkyDth1x4qrYC2tfkh2bwm/y9ZCIKGXdc1Eu+J7wX2i9XLknQWbrsuVfHaozJwa+he1
         Xu/A==
X-Gm-Message-State: APjAAAXXXj5+6pWo0JX5iYYynHLx4Y0fO/CE5oYrgU+teWt+wu2R804s
        7qVwVjp/q61b1uojd8UclQA=
X-Google-Smtp-Source: APXvYqzakMkOeBF5LZKRlGnSX1P69FwwB1yHWPYDg/QS6tkSu2yYg9gopC5XlH4j/PO7IImXWqJ4Jg==
X-Received: by 2002:a37:c206:: with SMTP id i6mr6582769qkm.114.1567350874770;
        Sun, 01 Sep 2019 08:14:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id u28sm6623436qtu.22.2019.09.01.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 08:14:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F0ABC41146; Sun,  1 Sep 2019 12:14:31 -0300 (-03)
Date:   Sun, 1 Sep 2019 12:14:31 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/4] perf tools: Fix python/perf.so compilation
Message-ID: <20190901151431.GL28011@kernel.org>
References: <20190901124822.10132-1-jolsa@kernel.org>
 <20190901124822.10132-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901124822.10132-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 01, 2019 at 02:48:19PM +0200, Jiri Olsa escreveu:
> The python/perf.so compilation needs libperf ready,
> otherwise it fails:
> 
>   $ make python/perf.so JOBS=1
>     BUILD:   Doing 'make -j1' parallel build
>     GEN      python/perf.so
>   gcc: error: /home/jolsa/kernel/linux-perf/tools/perf/lib/libperf.a: No such file or directory
> 
> Fixing this with by adding libperf dependency.

Thanks, tested, applied.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-0aaa6frvqnybjc2rjn7xrvjh@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f9807d8c005b..2ccc12f3730b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -567,7 +567,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
>  # Create python binding output directory if not already present
>  _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
>  
> -$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
> +$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST) $(LIBPERF)
>  	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
>          CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS)' \
>  	  $(PYTHON_WORD) util/setup.py \
> -- 
> 2.21.0

-- 

- Arnaldo
