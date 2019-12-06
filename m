Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B1C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA4120706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSWUDKpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFOn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:43:59 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33180 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLFOn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:43:58 -0500
Received: by mail-vs1-f65.google.com with SMTP id n27so5200881vsa.0;
        Fri, 06 Dec 2019 06:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iCZhI7UCjj/yEM37VY51j7qbEM9KfgImB2HsMcQBupk=;
        b=dSWUDKpxakOJ8MLl4gpyms4s+nsEvE19nwWwaR+u/YIoSCpMHgej34SQA8Cqyn1HKB
         9RTvXIStyOolCHUObsojoo74hT7aF0fofJA7qjixUsdNRgp9CW5o5fhPlQEMFcdg/G7L
         ERbOmJ90mII6Md3b+x0SJelDV9QyI272WVpJTJKdjSv8bdW+RXVvwKDgNRrstYkhDsCK
         Fy6tuu+Vqz0pxnFqTWoeLkapMFvdGBTejUn9jma9W7tAwfsXMSoeTfd08iWXliOfCF6D
         0zjhS7VLIAxSuLHkyoPhU70sYB4jVob73X08lx6+maRs2DiXV29FZCWih4J5OPcDi2DJ
         AIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iCZhI7UCjj/yEM37VY51j7qbEM9KfgImB2HsMcQBupk=;
        b=MUyC14MBX2EgWxZkILvCPxu7gltCjiYHbCDw2iLLK15kL6aBfEB4V0j96tVnq7puJ9
         f6CM/OY3UkegVAYcLofOSvNsiFkDl4xq6cvAbHbGDoX0KMEv1ma4itqE45cUdSeYEpWo
         zJ4HyjQBpZDyHZr9PvkUAuW7XNxFKCTacBRa/6nLtXNK3TAV3Q5j3EYeijQ3Gu4HH0Oq
         JYBw41S3mrLn2ZoaWKHee+oO+kyEzhrY3ZQLhnpa6yRHrLo0NX5H/ZbqX5CnLC9vvj+t
         CVYB99HcYxh7WXIHPZMTfVIn7dsCPeabW+ONGLpiR9U7kD6s4PRAQq9+OR0ZtdyHnRW4
         zxjQ==
X-Gm-Message-State: APjAAAVNPHEyBYMPBUd7sj0ANHrY1XH/UkEGVg8Jk60joBKLXFL37/rd
        scnCLQD4pFdVcVosdopXaYY=
X-Google-Smtp-Source: APXvYqxPlfOehaT4PnKcziWe17SNzL1+RRB++QuJoRxhE6SLEnfn5c0Ciq/NcHiv1bIuAIepAWs0Cw==
X-Received: by 2002:a05:6102:300c:: with SMTP id s12mr10089795vsa.188.1575643437435;
        Fri, 06 Dec 2019 06:43:57 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d8sm6254343uan.13.2019.12.06.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:43:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27B4E40352; Fri,  6 Dec 2019 11:43:54 -0300 (-03)
Date:   Fri, 6 Dec 2019 11:43:54 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Message-ID: <20191206144354.GD30698@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
 <20191206075701.GA25384@gmail.com>
 <20191206142516.GA31721@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191206142516.GA31721@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 06, 2019 at 03:25:16PM +0100, Jiri Olsa escreveu:
> On Fri, Dec 06, 2019 at 08:57:01AM +0100, Ingo Molnar wrote:
> 
> SNIP
> 
> > >  tools/include/uapi/drm/drm.h      |   3 +-
> > >  tools/include/uapi/drm/i915_drm.h | 128 +++++++++++++++++++++++++++++++++++++-
> > >  tools/perf/builtin-inject.c       |  13 +---
> > >  tools/perf/builtin-report.c       |   8 +++
> > >  tools/perf/util/sort.c            |  16 +++--
> > >  5 files changed, 147 insertions(+), 21 deletions(-)
> > 
> > Pulled, thanks a lot Arnaldo!
> > 
> > JFYI, on my system the default perf/urgent build still has this noise 
> > generated by util/parse-events.y and util/expr.y:
> > 
> >   util/parse-events.y:1.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
> >       1 | %pure-parser
> >       | ^~~~~~~~~~~~
> >   util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> >   util/expr.y:15.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
> >      15 | %pure-parser
> >       | ^~~~~~~~~~~~
> >   util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> 
> just saw it in fedora 31 with new bison, change below
> should fix it, I'll post it with other fixes later

As I explained to Ingo, this will make it fail with older systems, for
now this is just a warning, thus I've not been eager to get this merged,
Andi alredy submitted this, for instance.

Is there some way to have some sort of ifdef based on bison's version so
that we can have both?

At some point I'll just bite the bullet and stop testing on such older
systems, but while this is not strictly needed...

- Arnaldo
 
> jirka
> 
> ---
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index f9a20a39b64a..4ef801334b9d 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -12,7 +12,7 @@
>  #define MAXIDLEN 256
>  %}
>  
> -%pure-parser
> +%define api.pure
>  %parse-param { double *final_val }
>  %parse-param { struct parse_ctx *ctx }
>  %parse-param { const char **pp }
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index e2eea4e601b4..87a0d11676f0 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -1,4 +1,4 @@
> -%pure-parser
> +%define api.pure
>  %parse-param {void *_parse_state}
>  %parse-param {void *scanner}
>  %lex-param {void* scanner}

-- 

- Arnaldo
