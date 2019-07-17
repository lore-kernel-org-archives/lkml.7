Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F1CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A745D21783
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTly5ZB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfGQXq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:46:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44333 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfGQXq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:46:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so18935715qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ip9lNfmhhDb5HCtfgW2jjjNOGJYDxsuUzii/0A7QOTM=;
        b=WTly5ZB9tAxV/Y2VbrLJusEAwAG6gtCPLHeCq/Zqqwj5kOiTV1sAfuSvaR3++dbhaB
         YRYAExCw1AmHr2HjHUIFZ1xUYeiHdpEEZ72haPPt3v9jtumDEhVjT3W2h7V19+xPxg0U
         4CFeR1HR9bmNw31FJinnDU6IRCvsYqF6ZWJDQews+fe00ok5BcJcGTl0Q//8dP8S5QMv
         kBDKQxuQOz50HPxU7In3axMpE+E1CQCXwLEJ8nf+1TvLdwweTJeK2wpET39GMvmaCS5e
         9QdC6JBOGK4aZV9k+rfrXlmoGKtV7ktPRFN3ZvcPfzUyWUBP83rmkDDwSZ7TYADwBzX8
         /Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ip9lNfmhhDb5HCtfgW2jjjNOGJYDxsuUzii/0A7QOTM=;
        b=RY4rqKZ8qnc//4XhntyAyct5UvGBJYuCJuJ8WOxKSWp3Y2Qdv6OkKxaS3y1YX/aMIH
         iPh9ZyMA1X6UTqTxuETJdwIi2ZpF6jcYYpR14GErvi4RJqwUT3rb/oyNWnAYoJQc5dbs
         m9Jvc2P4EnQ7Pcq9pVAPfbqGU6XLIMgHk7sgLBWCoXlKyoSqmYa/rBE837DJ3kSk7P++
         FPzbzQG+Nzt2Sy0g57fEOToZQpL8/+/7mnXCJHF4hckHRPHx3ipEjn3DG78PgCiXlCeN
         C/oDbzhkJvSzgeML9S9ErGx6asIyrUf8JGchZRW2ElbWyisr74sR8AYgMp+Ph85DRf7J
         kG+Q==
X-Gm-Message-State: APjAAAX533AX9SePFWLMvIxuIeYbkwsqh2hXByCiIYoKvb+Ml9/nALtm
        6yY4fh/eSZv+xqkcpERW6os=
X-Google-Smtp-Source: APXvYqyNOqYCdBlycnve/p37YNSGimFojx0lmZ650+ep36fxOgmVEr0LvsM7Ftj1UNN8L2EvQGcymg==
X-Received: by 2002:a37:6982:: with SMTP id e124mr27062180qkc.291.1563407217114;
        Wed, 17 Jul 2019 16:46:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 195sm12234485qke.90.2019.07.17.16.46.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 16:46:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8AB9E40340; Wed, 17 Jul 2019 20:46:52 -0300 (-03)
Date:   Wed, 17 Jul 2019 20:46:52 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Igor Lubashev <ilubashe@akamai.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 1/3] perf: Add capability-related utilities
Message-ID: <20190717234652.GJ3624@kernel.org>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-2-git-send-email-ilubashe@akamai.com>
 <20190716084643.GA22317@krava>
 <20190717210551.GI3624@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717210551.GI3624@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 17, 2019 at 06:05:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jul 16, 2019 at 10:46:43AM +0200, Jiri Olsa escreveu:
> > On Tue, Jul 02, 2019 at 08:10:03PM -0400, Igor Lubashev wrote:
> > > Add utilities to help checking capabilities of the running process.
> > > Make perf link with libcap.
> > > 
> > > Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> > > ---
> > >  tools/perf/Makefile.config         |  2 +-
> > >  tools/perf/util/Build              |  1 +
> > >  tools/perf/util/cap.c              | 24 ++++++++++++++++++++++++
> > >  tools/perf/util/cap.h              | 10 ++++++++++
> > >  tools/perf/util/event.h            |  1 +
> > >  tools/perf/util/python-ext-sources |  1 +
> > >  tools/perf/util/util.c             |  9 +++++++++
> > >  7 files changed, 47 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/perf/util/cap.c
> > >  create mode 100644 tools/perf/util/cap.h
> > > 
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 85fbcd265351..21470a50ed39 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -259,7 +259,7 @@ CXXFLAGS += -Wno-strict-aliasing
> > >  # adding assembler files missing the .GNU-stack linker note.
> > >  LDFLAGS += -Wl,-z,noexecstack
> > >  
> > > -EXTLIBS = -lpthread -lrt -lm -ldl
> > > +EXTLIBS = -lpthread -lrt -lm -ldl -lcap
> > 
> > I wonder we should detect libcap or it's everywhere.. Arnaldo's compile test suite might tell
> 
> I'll add this tentatively and try to build it in my test suite.

So, not even in my notebook this worked straight away:

  CC       /tmp/build/perf/util/cap.o
  CC       /tmp/build/perf/util/config.o
In file included from util/cap.c:5:
util/cap.h:6:10: fatal error: sys/capability.h: No such file or directory
    6 | #include <sys/capability.h>
      |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
mv: cannot stat '/tmp/build/perf/util/.cap.o.tmp': No such file or directory


I had to first do:

dnf install libcap-devel

So we need to have a feature test and fail if that is not installed,
i.e. libcap becomes a hard req for building perf, which I think is
reasonable, one more shouldn't hurt, right?

With all the features enabled:

[acme@quaco perf]$ ldd ~/bin/perf
	linux-vdso.so.1 (0x00007ffe7278a000)
	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f7be52f1000)
	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f7be52d7000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f7be52ae000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f7be528d000)
	librt.so.1 => /lib64/librt.so.1 (0x00007f7be5283000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f7be513d000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f7be5135000)
	libcap.so.2 => /lib64/libcap.so.2 (0x00007f7be512e000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007f7be5113000)
	libdw.so.1 => /lib64/libdw.so.1 (0x00007f7be50c0000)
	libslang.so.2 => /lib64/libslang.so.2 (0x00007f7be4de8000)
	libperl.so.5.28 => /lib64/libperl.so.5.28 (0x00007f7be4ac2000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f7be48fa000)
	libpython2.7.so.1.0 => /lib64/libpython2.7.so.1.0 (0x00007f7be4690000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f7be4676000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f7be45d1000)
	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007f7be45c3000)
	libbabeltrace-ctf.so.1 => /lib64/libbabeltrace-ctf.so.1 (0x00007f7be456d000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f7be4551000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f7be5331000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f7be453d000)
	libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f7be4502000)
	libutil.so.1 => /lib64/libutil.so.1 (0x00007f7be44fd000)
	libbabeltrace.so.1 => /lib64/libbabeltrace.so.1 (0x00007f7be44ed000)
	libpopt.so.0 => /lib64/libpopt.so.0 (0x00007f7be44dd000)
	libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f7be44d3000)
	libgmodule-2.0.so.0 => /lib64/libgmodule-2.0.so.0 (0x00007f7be44cd000)
	libglib-2.0.so.0 => /lib64/libglib-2.0.so.0 (0x00007f7be43a9000)
	libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f7be4335000)
[acme@quaco perf]$

;-)

So, please check tools/build/feature/ and check how this is done and add
a test and the warning in tools/perf/Makefile.config so that we get an
error message stating that libcap-dev or libcap-devel should be
installed.

I'll do it if there is any difficulty, just not right now as I'm busy
and want to get a pull req out of the door.

- Arnaldo
