Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE0C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B186424659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgpnVv9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLFPfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:35:15 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35396 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLFPfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:35:14 -0500
Received: by mail-ua1-f66.google.com with SMTP id y23so3005012ual.2;
        Fri, 06 Dec 2019 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z3vTy7H/7lOXWPNaODhyF3/E/KgHLJ7DB3lysc2zBWE=;
        b=jgpnVv9zC5Dx0ZQl4zFQG42kE4SgF6sWasBjphggAmpGJeL8N+ZMZI7o8laneng5sF
         40xVd+iS4PMzAt96UJWrKqIzwwKHWjkD2NGLvDl8Bq+SgfKOKjkXRPKTjtgSpIxmXkPo
         /ZAIjpw0wfr1gLm9obKJaO6G3Tpo/REGgCiFXl+5+6NuktaLP01grdFjP19xajxafxXT
         n+rCE54tn32CF+0y6Z7FeLeInYzsHpPOogo10ESD0l6/GMGtd7o6qMyfelfwZSIWvQG7
         43VFx5u17uhGhGgrmCUBwy01LA+XxsW/gThta+WbpEeX2UyxikSGBkmYPTH27wxWv/e3
         bJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z3vTy7H/7lOXWPNaODhyF3/E/KgHLJ7DB3lysc2zBWE=;
        b=dXVdOBJvW31w5uXz3dg1hFc7sLexo22tKYiHP9v7bDQXsrju7hucAkgBrtfpiQXAq3
         xLcC6svpSpyEceGHdVsdxpc3Iuz58wMYZXpc0f1AghIPRsKaR9EAgt6skr9y7G61F+Vp
         hR+Euv0+gPNUcqnw3ryySajtLWAVniq4Aeokakaxdgwrp+m1VnM7CHptI3/01Bqn2uT5
         XurCJCKxQySOzAuBsntrXy8Cl0+6L2m8QWhXep17383IVioVjmiuLZQ331p03RGxDcvw
         dzcNbNvTQunxQgp5g71jSnI8MgpLlZg9xWOs4uyCM1KI7V4B6VfrHCX2fYPTsJmuyzq5
         7Gzg==
X-Gm-Message-State: APjAAAXeRAbVaAi9ZOOqw+oMdD8TCJ+22YyT9FDDLAgK0wqnv/IXdOS4
        S8/2DSk7HhS0N5u7my1yhIE=
X-Google-Smtp-Source: APXvYqzZelqxHkcUVQ1yxAiJuLc77p0etLU/znKr78zJ13wtkDs+bFmDpmoxPyZd3xEGW3NR2ssuSw==
X-Received: by 2002:ab0:42c1:: with SMTP id j59mr12994602uaj.101.1575646513773;
        Fri, 06 Dec 2019 07:35:13 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y129sm6093449vky.43.2019.12.06.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:35:12 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A99EE40352; Fri,  6 Dec 2019 12:35:09 -0300 (-03)
Date:   Fri, 6 Dec 2019 12:35:09 -0300
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
Message-ID: <20191206153509.GB13965@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
 <20191206075701.GA25384@gmail.com>
 <20191206142516.GA31721@krava>
 <20191206144354.GD30698@kernel.org>
 <20191206150455.GC31721@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191206150455.GC31721@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 06, 2019 at 04:04:55PM +0100, Jiri Olsa escreveu:
> On Fri, Dec 06, 2019 at 11:43:54AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 06, 2019 at 03:25:16PM +0100, Jiri Olsa escreveu:
> > > On Fri, Dec 06, 2019 at 08:57:01AM +0100, Ingo Molnar wrote:
> > > 
> > > SNIP
> > > 
> > > > >  tools/include/uapi/drm/drm.h      |   3 +-
> > > > >  tools/include/uapi/drm/i915_drm.h | 128 +++++++++++++++++++++++++++++++++++++-
> > > > >  tools/perf/builtin-inject.c       |  13 +---
> > > > >  tools/perf/builtin-report.c       |   8 +++
> > > > >  tools/perf/util/sort.c            |  16 +++--
> > > > >  5 files changed, 147 insertions(+), 21 deletions(-)
> > > > 
> > > > Pulled, thanks a lot Arnaldo!
> > > > 
> > > > JFYI, on my system the default perf/urgent build still has this noise 
> > > > generated by util/parse-events.y and util/expr.y:
> > > > 
> > > >   util/parse-events.y:1.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
> > > >       1 | %pure-parser
> > > >       | ^~~~~~~~~~~~
> > > >   util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> > > >   util/expr.y:15.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
> > > >      15 | %pure-parser
> > > >       | ^~~~~~~~~~~~
> > > >   util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> > > 
> > > just saw it in fedora 31 with new bison, change below
> > > should fix it, I'll post it with other fixes later
> > 
> > As I explained to Ingo, this will make it fail with older systems, for
> > now this is just a warning, thus I've not been eager to get this merged,
> > Andi alredy submitted this, for instance.
> > 
> > Is there some way to have some sort of ifdef based on bison's version so
> > that we can have both?
> 
> I see, I guess we could use one or another based on
> bison version with macro

If you could do that, that would be great, the attempt may well
enlighten us if that is possible and if not, then, oh well, I can just
update bison on these older systems and keep a note in my container
definition files :-)

- Arnaldo
 
> jirka
> 
> > 
> > At some point I'll just bite the bullet and stop testing on such older
> > systems, but while this is not strictly needed...
> > 
> > - Arnaldo
> >  
> > > jirka
> > > 
> > > ---
> > > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > > index f9a20a39b64a..4ef801334b9d 100644
> > > --- a/tools/perf/util/expr.y
> > > +++ b/tools/perf/util/expr.y
> > > @@ -12,7 +12,7 @@
> > >  #define MAXIDLEN 256
> > >  %}
> > >  
> > > -%pure-parser
> > > +%define api.pure
> > >  %parse-param { double *final_val }
> > >  %parse-param { struct parse_ctx *ctx }
> > >  %parse-param { const char **pp }
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > > index e2eea4e601b4..87a0d11676f0 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -1,4 +1,4 @@
> > > -%pure-parser
> > > +%define api.pure
> > >  %parse-param {void *_parse_state}
> > >  %parse-param {void *scanner}
> > >  %lex-param {void* scanner}
> > 
> > -- 
> > 
> > - Arnaldo
> > 

-- 

- Arnaldo
