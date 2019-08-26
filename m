Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D4C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906FF20674
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvpjdKuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfHZQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:06:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42493 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfHZQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:06:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so18382843qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rB+z6OAatx0Ht4xX6FLjDLnp3FaZunZW6qVW6fjDq5A=;
        b=ZvpjdKuRQDuLbbtmZL4VmO60FAx3o6tJGowy+FxHLxcNZ/tQbaUtNZKBpMjMgPl+/8
         7QW2MQL5U8J0uUcRU79iPhPeKBGdwuD2EFHqrBn80Yyjo40WJ2dFfbPNbXryWtNRCHNJ
         2sQGyi1e4VDSdedYrZXldXONfG4ISO6X7ZXKjE0gAtszupG7aRMO9BYlBpIWAqjd5sXW
         Z635F21T9zvIWSq2GflzkKAcBFmA028AxijXI8mGg4lXfBOiSY6wATzs8cnQIbJWUF//
         JJDEhbWIAmeTmLL1avGV9XkDN1R3a+wwz8aVqXyhsGwk8uVu0G/7F6MmIyVdcUEXdB/d
         QceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rB+z6OAatx0Ht4xX6FLjDLnp3FaZunZW6qVW6fjDq5A=;
        b=YZIvBL5pg5fXrqHvwW8cQVUCgU4sKHjUaT6oKPvsjP9j0IfcMbSW6SORChiVOhAxwG
         DH+05II7S4h9914Xd7Rs5A18lNtTDMrNflUHeOAh4pvtoH0t9PPgHcHTH8UQ9SZ+PiOk
         uADJ96zvDrnUv9MREjByiafQMqo2zvNWNFEvHxxeDX+Whm620GA3bTDydcw5MCmMAOa5
         tMgj9x1EyLCrxwNyOdOqMLBCqzyue1cebHXfz9DC+MefBqXw17qIOBpiKf+ArSmMGhb1
         Qxi7lWAPoEv3ojtkuunUe73pBSDgI0whagsCVQ2BGVr944xbhWRqtmJaXdt9aIvDVdvD
         bD+Q==
X-Gm-Message-State: APjAAAXzj/VSFT2HoM5q14nEGpTJifZj1xuYwrS13QnI/8aKJX+LG11M
        jyoJAGtYUyHYZ3Xn6uVb7a4=
X-Google-Smtp-Source: APXvYqzjajQZnkPnD7hlgIgS00/03QDJoBBWieGYibG5C9mQROWmL3wlJFd2Cdna2GXvWFybXFAsQA==
X-Received: by 2002:ac8:4612:: with SMTP id p18mr15471821qtn.49.1566835591013;
        Mon, 26 Aug 2019 09:06:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b5sm6042524qkk.78.2019.08.26.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 09:06:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02EA640916; Mon, 26 Aug 2019 13:06:27 -0300 (-03)
Date:   Mon, 26 Aug 2019 13:06:27 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826160627.GE24801@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190825181752.722-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 25, 2019 at 08:17:40PM +0200, Jiri Olsa escreveu:
> hi,
> as a preparation for sampling libperf interface, moving event
> definitions into the library header. Moving just the kernel=20
> non-AUX events now.
>=20
> In order to keep libperf simple, we switch 'u64/u32/u16/u8'
> types used events to their generic '__u*' versions.
>=20
> Perf added 'u*' types mainly to ease up printing __u64 values
> as stated in the linux/types.h comment:
>=20
>   /*
>    * We define u64 as uint64_t for every architecture
>    * so that we can print it with "%"PRIx64 without getting warnings.
>    *
>    * typedef __u64 u64;
>    * typedef __s64 s64;
>    */
>=20
> Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
> that.  Using extra '_' to ease up the reading and differentiate
> them from standard PRI*64 macros.

So, this is not building on android env:

builtin-sched.c: In function 'process_lost':
builtin-sched.c:2646:2: error: unknown conversion type character 'l' in for=
mat [-Werror=3Dformat=3D]
  printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample-=
>cpu);
  ^
builtin-sched.c:2646:2: error: format '%d' expects argument of type 'int', =
but argument 2 has type '__u64' [-Werror=3Dformat=3D]
builtin-sched.c:2646:2: error: too many arguments for format [-Werror=3Dfor=
mat-extra-args]
  MKDIR    /tmp/build/perf/util/


[perfbuilder@490c2c7bdaab ~]$ /opt/android-ndk-r12b//toolchains/arm-linux-a=
ndroideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc -v
Using built-in specs.
COLLECT_GCC=3D/opt/android-ndk-r12b//toolchains/arm-linux-androideabi-4.9/p=
rebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc
COLLECT_LTO_WRAPPER=3D/opt/android-ndk-r12b/toolchains/arm-linux-androideab=
i-4.9/prebuilt/linux-x86_64/bin/../libexec/gcc/arm-linux-androideabi/4.9.x/=
lto-wrapper
Target: arm-linux-androideabi
Configured with: /usr/local/google/buildbot/src/android/gcc/toolchain/build=
/../gcc/gcc-4.9/configure --prefix=3D/tmp/59719db9ae19ff43aef46bbcb79596b6 =
--target=3Darm-linux-androideabi --host=3Dx86_64-linux-gnu --build=3Dx86_64=
-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=3Dc,c++ --with-gm=
p=3D/buildbot/tmp/build/toolchain/temp-install --with-mpfr=3D/buildbot/tmp/=
build/toolchain/temp-install --with-mpc=3D/buildbot/tmp/build/toolchain/tem=
p-install --with-cloog=3D/buildbot/tmp/build/toolchain/temp-install --with-=
isl=3D/buildbot/tmp/build/toolchain/temp-install --with-ppl=3D/buildbot/tmp=
/build/toolchain/temp-install --disable-ppl-version-check --disable-cloog-v=
ersion-check --disable-isl-version-check --enable-cloog-backend=3Disl --wit=
h-host-libstdcxx=3D'-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' --d=
isable-libssp --enable-threads --disable-nls --disable-libmudflap --disable=
-libgomp --disable-libstdc__-v3 --disable-sjlj-exceptions --disable-shared =
--disable-tls --disable-libitm --with-float=3Dsoft --with-fpu=3Dvfp --with-=
arch=3Darmv5te --enable-target-optspace --enable-bionic-libs --enable-libat=
omic-ifuncs=3Dno --enable-initfini-array --disable-nls --prefix=3D/tmp/5971=
9db9ae19ff43aef46bbcb79596b6 --with-sysroot=3D/tmp/59719db9ae19ff43aef46bbc=
b79596b6/sysroot --with-binutils-version=3D2.25 --with-mpfr-version=3D3.1.1=
 --with-mpc-version=3D1.0.1 --with-gmp-version=3D5.0.5 --with-gcc-version=
=3D4.9 --with-gdb-version=3Dnone --with-gxx-include-dir=3D/tmp/59719db9ae19=
ff43aef46bbcb79596b6/include/c++/4.9.x --with-bugurl=3Dhttp://source.androi=
d.com/source/report-bugs.html --enable-languages=3Dc,c++ --disable-bootstra=
p --enable-plugins --enable-libgomp --enable-gnu-indirect-function --disabl=
e-libsanitizer --enable-gold --enable-threads --enable-eh-frame-hdr-for-sta=
tic --enable-graphite=3Dyes --with-isl-version=3D0.11.1 --with-cloog-versio=
n=3D0.18.0 --with-arch=3Darmv5te --program-transform-name=3D's&^&arm-linux-=
androideabi-&' --enable-gold=3Ddefault
Thread model: posix
gcc version 4.9.x 20150123 (prerelease) (GCC)
[perfbuilder@490c2c7bdaab ~]$

It doesn't build on the r15b as well.

I'll investigate after lunch.

- Arnaldo
=20
> It's also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes
>=20
> thanks,
> jirka
>=20
>=20
> ---
> Jiri Olsa (12):
>       libperf: Add mmap_event to perf/event.h
>       libperf: Add mmap2_event to perf/event.h
>       libperf: Add comm_event to perf/event.h
>       libperf: Add namespaces_event to perf/event.h
>       libperf: Add fork_event to perf/event.h
>       libperf: Add lost_event to perf/event.h
>       libperf: Add lost_samples_event to perf/event.h
>       libperf: Add read_event to perf/event.h
>       libperf: Add throttle_event to perf/event.h
>       libperf: Add ksymbol_event to perf/event.h
>       libperf: Add bpf_event to perf/event.h
>       libperf: Add sample_event to perf/event.h
>=20
>  tools/perf/builtin-sched.c          |   2 +-
>  tools/perf/lib/include/perf/event.h | 112 ++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  tools/perf/util/event.c             |  12 ++++++------
>  tools/perf/util/event.h             | 104 +++---------------------------=
--------------------------------------------------------------------------
>  tools/perf/util/evlist.c            |   2 +-
>  tools/perf/util/evsel.c             |   8 ++++----
>  tools/perf/util/machine.c           |   4 ++--
>  tools/perf/util/python.c            |  14 +++++++-------
>  tools/perf/util/session.c           |   8 ++++----
>  9 files changed, 140 insertions(+), 126 deletions(-)
>  create mode 100644 tools/perf/lib/include/perf/event.h

--=20

- Arnaldo
