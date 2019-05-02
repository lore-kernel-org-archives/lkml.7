Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1751BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A27206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuaXaSOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBUJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:09:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40419 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:09:17 -0400
Received: by mail-yw1-f66.google.com with SMTP id t79so2552119ywc.7;
        Thu, 02 May 2019 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nVxPvb4gHab89NR3TJEjvHX4WUon0plr7WUy6OMsIgU=;
        b=AuaXaSORJIR/VQ8YbNOB7UUEN16Uh5aj424ONK7VJlOj9mIK8+USuBZc6kw0OyNS9y
         NlN0V9u/XiXU2gMmqV/tkT5vHSXJG8l/q9xBVJkQbgb0T6V4pQsMdWXNlvFUnM/kLTfD
         oJN4njWdOvH/qyKXu21Iz5iepD0mjSFiL10W+juSGjg1TR3wM30mIvF0i3K8kjxonqZ1
         o9wsvTpsmfAIvGOnUefYObvnYzWI9n5HUDWjo1ekUsyRNtO1pQXcH2cNps320cX8dFW0
         6VxqoJwJ6DWEqv7id6c3G86KUM90UZDsoUY+zzpeA74f/TcVPKhcchST7KowfMbvp3HI
         xTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nVxPvb4gHab89NR3TJEjvHX4WUon0plr7WUy6OMsIgU=;
        b=JeyPEr86nsVOvF+AUtHXH/73Az3gtI37wQMTfqbv8njgYXSSTW7pb+f/jhZqE40Zzv
         5U+H26lCo4pyiEmqiwZlqq1XBua9NwZdyose21YkKAsi36z1H1eddg3DmcmZBfu7KeCl
         eI8PD6SSSZi70q6SFksQjU/fqvOKETq5qiob92ACKyZnwsXwgPaz426AkgRNYc8TLK7k
         aFwGhydYLhzhG2AVvtYBtgAEs7hmFFZk+pS5F6DvD92R5EH2xeFUpxHmYCO+fJBq2hle
         FkIwHdqYpt1WFiufQ66PsfzOW0Ldkb4B0DC3DkcgKc4Ag8FtB8MpJQhLCDFGwZhGtUpn
         8D6w==
X-Gm-Message-State: APjAAAVPOkKHdPAkntbPiagJP22DYfneE1mWJTFCEYmsOyNozY4qAnhz
        uz4Cd5uBxF833qY4pYFYWM4=
X-Google-Smtp-Source: APXvYqyk/ZUkoqpJgFzIyVCk9yuQg/uOlm1vHiC2QS+wZDPqjU1oLETxWD8AdJEAmwmTObIGVpHNBw==
X-Received: by 2002:a81:3a11:: with SMTP id h17mr4946712ywa.292.1556827756124;
        Thu, 02 May 2019 13:09:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id m5sm45832ywm.67.2019.05.02.13.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:09:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17969403AD; Thu,  2 May 2019 16:09:14 -0400 (EDT)
Date:   Thu, 2 May 2019 16:09:14 -0400
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Rich Felker <dalias@libc.org>, Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "devel@uclibc-ng.org" <devel@uclibc-ng.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Detecting libc in perf (was Re: perf tools build broken after
 v5.1-rc1)
Message-ID: <20190502200914.GA22982@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <20190425214800.GC21829@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
 <20190430011818.GE7857@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250601B@us01wembx1.internal.synopsys.com>
 <20190430170404.GX23599@brightrain.aerifal.cx>
 <17a86bc7-c1f9-8c3c-8f1d-711e95dac49d@synopsys.com>
 <20190501031215.GZ23599@brightrain.aerifal.cx>
 <596d2166-1952-a392-ef05-d3f59abf9fd0@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596d2166-1952-a392-ef05-d3f59abf9fd0@synopsys.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 02, 2019 at 09:55:26AM -0700, Vineet Gupta escreveu:
> On 4/30/19 8:12 PM, Rich Felker wrote:
> >>> What are you trying to achieve? I was just CC'd and I'm missing the
> >>> context.
> >>
> >> Sorry I added you as a subject matter expert but didn't provide enough context.
> >>
> >> The original issue [1] was perf failing to build on ARC due to perf tools needing
> >> a copy of unistd.h but this thread [2] was a small side issue of auto-detecting
> >> libc variaint in perf tools where despite uClibc tools, glibc is declared to be
> >> detected, due to uClibc's historical hack of defining __GLIBC__. So __GLIBC__ is
> >> not sufficient (and probably not the right interface to begin wtih) to ensure glibc.
> >>
> >> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-April/005676.html
> >> [2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-April/005684.html
> > 
> > I think you misunderstood -- 
> 
> :-)
> 
> > I'm asking what you're trying to achieve
> > by detecting whether the libc is glibc, rather than whether it has
> > some particular interface you want to conditionally use. This is a
> > major smell and is usually something wrong that shouldn't be done.
> 
> Good question indeed. Back in 2015 I initially ran into some quirks due to subtle
> libc differences.  At the time perf has a fwd ref for strlcpy which exactly
> matched glibc but not uClibc.  see commit  a83d869f300bf91 "(perf tools: Elide
> strlcpy warning with uclibc)" or 0215d59b154 "(tools lib: Reinstate strlcpy()
> header guard with __UCLIBC__)"
> 
> But this still used the libc defined symbol __UCLIBC__ or __GLIBC__
> 
> Your question however pertains to perf glibc feature check where perf generates an
> alternate symbol HAVE_GLIBC_SUPPORT.
> 
> This is dubious as first of all it detects glibc even for uClibc builds.

 
> Even of we were to improve it, there seems to be no users of this symbol.
> 
> $git grep HAVE_GLIBC_SUPPORT
> perf/Makefile.config:  CFLAGS += -DHAVE_GLIBC_SUPPORT
> perf/builtin-version.c: STATUS(HAVE_GLIBC_SUPPORT, glibc)
> 
> So I'd propose to remove it !

This is some remnant of the past, I'll check further but will end up
just ditching it altogether as you suggest :-)

[acme@quaco perf]$ find tools/ -type f | xargs grep HAVE_GLIBC_SUPPORT
tools/perf/builtin-version.c:	STATUS(HAVE_GLIBC_SUPPORT, glibc);
tools/perf/Makefile.config:  CFLAGS += -DHAVE_GLIBC_SUPPORT
[acme@quaco perf]$

Its just this case that ends up using that feature detection program,

[acme@quaco perf]$ vim tools/perf/Makefile.config
[acme@quaco perf]$ find tools/ -type f | xargs grep feature-glibc
tools/perf/Makefile.config:    ifeq ($(feature-glibc), 1)
tools/perf/Makefile.config:ifeq ($(feature-glibc), 1)
[acme@quaco perf]$

BTW the function on it doesn't mean anything, what matters is if the
program builds or not :-)

- Arnaldo
