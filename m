Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 02:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC8B20882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 02:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4zN/DrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437632AbfIUCEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 22:04:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45502 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437587AbfIUCEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 22:04:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so4023924pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 19:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4HorIcxvAeYR90hn18suy/4zO4DegTzvuyZdzOASANM=;
        b=r4zN/DrZc8ATtRCTZ92cWaGhlPyXK2A8r2K59trA4kT/Fjfwbda3rsFDb885kkj0hu
         JUHiKmg3Uhgif2wsoPG0mFobB3MnUH8HH0jqc/zvdmhOWPb7lfmi0JJgPSrb1EzRNXCs
         +dwKgyWaECDAbIEitn2szBynKUz+kPpa5ZKkJ/kHd73PTO6VElNeyKn7xQ9fCPjK+QeO
         GQ4FtDH4hnacidh9hwM7bXZueI5BRusFW2OyTo8KTnc7vCWXB60B4heybW/oo/ZN/Vuz
         QYrPvCo/R1LaAptvrX7cggHW9fEZ9f4zDEGcr7EBO9f9uTuhPNyhbO/xl/g61I3+QTLa
         y1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4HorIcxvAeYR90hn18suy/4zO4DegTzvuyZdzOASANM=;
        b=EuThMphlBkZXNYxL9XyNUEu9p9jDdeEKDjo/lD2OG5Io2VUZM7+CAn4NSPbENJxWsD
         t1i0ozHeat2JJtbnb9AHsDcwxg1m7Lt/RrjdhIToEvRSKKPYPRNl/Cx4wWLF0uiEseVE
         CmpkZrtbaJNk+U07zWXDq/715HpOQ86tB+axLIK0GPLSFFEqdoNXRup3vzzcCjajeqJ5
         QZhq8QWYSKn5dacx0mjMdqnGyoGJ0lInKpC79+jv5iQjSbJaJUQPo5AIEtnzSkKgwldf
         QrN7YCuxBzKWJDdm1hiddI6tsu6YPd3IUpdDigca2Oke/P4S+NGNOOxVOGs60t3u+gmI
         5xZg==
X-Gm-Message-State: APjAAAV5dY5Bl6dU6Hl3jth4QZ2n6QM4IWHQmVVTwnlG11DBPrHypCwC
        wmWvikl/5hzELD5HiZZnJME=
X-Google-Smtp-Source: APXvYqxXA13/PaF8bmDkXEXSSTmcx55EixwcSBcjJ3sbggQn1nKRthE5pdjpTQ5S4VtpZR2XzRo+zQ==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr19531274plo.71.1569031489622;
        Fri, 20 Sep 2019 19:04:49 -0700 (PDT)
Received: from mail.google.com ([207.148.65.56])
        by smtp.gmail.com with ESMTPSA id d24sm3825652pfn.86.2019.09.20.19.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 19:04:49 -0700 (PDT)
Date:   Sat, 21 Sep 2019 02:04:45 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: add support for logging debug messages to file
Message-ID: <20190921020444.qtrsqxweuyoeomzq@mail.google.com>
References: <20190915102740.24209-1-changbin.du@gmail.com>
 <20190920205356.GA1041@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920205356.GA1041@krava>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:53:56PM +0200, Jiri Olsa wrote:
> On Sun, Sep 15, 2019 at 06:27:40PM +0800, Changbin Du wrote:
> > When in TUI mode, it is impossible to show all the debug messages to
> > console. This make it hard to debug perf issues using debug messages.
> > This patch adds support for logging debug messages to file to resolve
> > this problem.
> > 
> > The usage is:
> > perf -debug verbose=2 --debug file=1 COMMAND
> > 
> > And the path of log file is '~/perf.log'.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/perf.txt |  4 +++-
> >  tools/perf/util/debug.c           | 20 ++++++++++++++++++++
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> > index 401f0ed67439..45db7b22d1a5 100644
> > --- a/tools/perf/Documentation/perf.txt
> > +++ b/tools/perf/Documentation/perf.txt
> > @@ -16,7 +16,8 @@ OPTIONS
> >  	Setup debug variable (see list below) in value
> >  	range (0, 10). Use like:
> >  	  --debug verbose   # sets verbose = 1
> > -	  --debug verbose=2 # sets verbose = 2
> > +	  --debug verbose=2 --debug file=1
> > +	                    # sets verbose = 2 and save log to file
> 
> it's variable already, why not allow to pass the path directly like:
> 
>   --debug file=~/perf.log
> 
> would be great if we won't need to use --debug twice and allow:
> 
>   --debug verbose=2,file=perf.log
>
This could be done, but first we need to change the option parsing code
first. will do it later.

> jirka

-- 
Cheers,
Changbin Du
