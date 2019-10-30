Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A9CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8789420874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoLtUF/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfJ3PNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:13:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44969 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfJ3PNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:13:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id b10so1885854qto.11;
        Wed, 30 Oct 2019 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5OZSYFVQQCN9jPq40PFQ0tbJN0l/5n2kSdVxcNbhMyc=;
        b=hoLtUF/FRgVISM8STLXR0q+/Sx5TqkfUrzPES8j2pD9CC6WP+zr6GtPf3Sj5JvGMnv
         TB9B6uyuVbpoWDXnIsZZRarLuLBM0u7hVL9x1U5nrKXpfHY7wHcossl4iEWVdMP4kVoQ
         n3QZTM+Rg7lgcluVJE956us/iF0euvAvGjGE/Cm+vR5YUwIK6cjN2ChQJanmIHYcBhj0
         N3MGJwPcTIiwOL7et4V/nsA/D41j1nF6AvR4saKq5zNmvo84y5qQyC1sAcxm0PmI/DZB
         cSqf0MbfIVk6YjkzP0FGL2dq5oPv7b2y/eGIyMNk6QJ8MHEdUvTqir0oUBUIi4QxhQ2T
         Ud6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5OZSYFVQQCN9jPq40PFQ0tbJN0l/5n2kSdVxcNbhMyc=;
        b=S+K2kIAxSRJpCSoLq5m9CROxGYwOMZzk2WWWkPCGknCPhyuqR1oyl7iLMTvwgkjbXj
         5okowyAAh95J0XNJPtHQUWKDAFgtEQscrTUaRvx4KkIOa1q/SKKvLodKANzRRxkwN+Iq
         zI9IenwL+JX8T9kLRtw6OIsuFIoKsH/d0yOqGGw6SvD/6UdotPi+Dk05BxdXm2qZHrYo
         TbyjUVpanRpiMlVfA9LtAqgRpfj1VCLggAt5F6Xp96H5gGPmJXARFp3ep84YV8o7JH6J
         l373MHxKtkkP5GnIQx7CXefdlKFYRa//9Txif97G9kn5Y0NopiHdDntRhwLmu0rbhos5
         wOEg==
X-Gm-Message-State: APjAAAVFDJozBjQF2booeTvl54Sfl4J7D4AC5pH97WJaO0FJTbHEw06m
        fy67m7Cp3YqXkYE4S1WefvA=
X-Google-Smtp-Source: APXvYqw0YNpPRjx9wexXpeihN29/pFYVjrKSeDEQLWPSiC1j1xnXsd8pptCmTl9iNnhGFZCJybh+Zw==
X-Received: by 2002:ac8:3376:: with SMTP id u51mr561126qta.248.1572448420273;
        Wed, 30 Oct 2019 08:13:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c23sm257784qte.66.2019.10.30.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:13:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93764410D7; Wed, 30 Oct 2019 12:13:36 -0300 (-03)
Date:   Wed, 30 Oct 2019 12:13:36 -0300
To:     James Clark <James.Clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Message-ID: <20191030151336.GD27327@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
 <20191029140052.GB4922@kernel.org>
 <20191029141852.GC4922@kernel.org>
 <20191029142647.GD4922@kernel.org>
 <578c3a3a-2972-2b95-b98c-aee78950f5bb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578c3a3a-2972-2b95-b98c-aee78950f5bb@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2019 at 11:03:43AM +0000, James Clark escreveu:
> Hi Arnaldo,
> 
> Thanks for that, yes separating them looks better.
> I will try to break down commits in the future.
> 
> > The patch came mangled, so I'm applying by hand, and separating it into
> > two patches, the first for the first paragraph and the other for the
> > second, ok?
> 
> By mangled do you mean the quoted printables "=3D" and "=20"?
> 
> It seems like git send-email falls back to this behavior by default:
> 
>          
>      --transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)
> 
>        Specify the transfer encoding to be used to send the message over SMTP.
>        7bit will fail upon encountering a non-ASCII message. quoted-printable can be
>        useful when the repository contains files that contain carriage returns, but
>        makes the raw patch email file (as saved from a MUA) much harder to inspect
>        manually. base64 is even more fool proof, but also even more opaque. auto will
>        use 8bit when possible, and quoted-printable otherwise.
> 
> 
> I copied my raw patch and was able to successfully apply it with git am, even with this escaping. Although I
> did upgrade to a newer version of git (2.23.0).
> 
> If I view the patch that you created, then it doesn't have quoted printable escaping. So there does
> seem to be a difference somewhere.
> Do you think I should use "git send-email --transfer-encoding=7bit"?

Well, I'm using mutt defaults, I'd say take a look at:

~/git/linux/Documentation/process/email-clients.rst

There is a sesion for your mail agent, maybe it helps.

- Arnaldo
 
> 
> Thanks
> James
> 
> On 29/10/2019 14:26, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 29, 2019 at 11:18:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> And here is the first patch out of your larger one, I changed the
> >> subject line to reflect that this is not tools/perf specific, as
> >> tools/objtool/ also uses libsubcmd, added Josh, objtool's maintainer so
> >> that he is made aware.
> > 
> > And the second patch:
> > 
> > 
> > commit d0381449fd9ab733ec2daf527263da9f73f1e94e
> > Author: James Clark <James.Clark@arm.com>
> > Date:   Mon Oct 28 11:34:01 2019 +0000
> > 
> >     libsubcmd: Use -O0 with DEBUG=1
> >     
> >     When a 'make DEBUG=1' build is done, the command parser is still built
> >     with -O6 and is hard to step through, fix it making it use -O0 in that
> >     case.
> >     
> >     Signed-off-by: James Clark <james.clark@arm.com>
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: nd <nd@arm.com>
> >     Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
> >     [ split from a larger patch ]
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> > index 352c6062deba..1c777a72bb39 100644
> > --- a/tools/lib/subcmd/Makefile
> > +++ b/tools/lib/subcmd/Makefile
> > @@ -27,7 +27,9 @@ ifeq ($(DEBUG),0)
> >    endif
> >  endif
> >  
> > -ifeq ($(CC_NO_CLANG), 0)
> > +ifeq ($(DEBUG),1)
> > +  CFLAGS += -O0
> > +else ifeq ($(CC_NO_CLANG), 0)
> >    CFLAGS += -O3
> >  else
> >    CFLAGS += -O6
> > 

-- 

- Arnaldo
