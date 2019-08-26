Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AFEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FE3217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZdZrch9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfHZQSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:18:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38175 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbfHZQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:18:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id q64so6752480qtd.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z5gvMbbRMA03QD8dKnrTiIPKqCiNs7aRT27yoUz84tA=;
        b=qZdZrch9lgOa88HyQXDJ1OYHyc9nl9MHADIMTv2NOVz01JeJL57nacgvMMzg52L/pr
         lBAQUpmgJYc3pqT9CR4MG9JX+So95kZEAC0P+IZGayf6y8sx3c4q1Ad1Yr18+bnYA0eE
         5Zj5azaV6KaUWcA4mDJNUf9YPoevr7sqTVtf/ogOGGRlH0u2JuIeznzIgjDc9SATgjE/
         oz4+kPI7MGwLKqLTnoWppuBqhyD9gDiI20SGVl91+UkiBylUkZgbC/qPe7/lDK5UKe5L
         SNsUd0WqTDqDw88ng1rK7kK5JaIukd2RYwgxxXMSPD7r1uKjlgEkn+ElHBrJP0dZYnJD
         T4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z5gvMbbRMA03QD8dKnrTiIPKqCiNs7aRT27yoUz84tA=;
        b=NhOpPi+/LQhUUowdq0xcwMrn64kxAInmhGbSmsr75ELX9f1ZyTH09QvTCwFiZ4KCGP
         d7Vm4GUawMs2zvEC4ENJ6EbFdg1bqZ9uZAQnERQ6qhoyEVoszw6004ErWi50zAJsDAD/
         ld8LDOIu0e1DoQGrV/P4/VHxqIPWXH2I00Z6pl/+VM2PTKxbw9t/k1gYSI0c+LsOSLMe
         MfWcE+ha8O3e7Sog/awo4ZxEKHIvRbP/57oensul32SP2sjuckfcC3/rAKTkGWXIqmcL
         BrtlORoNUvs7t0AHspmZhafzrEM4B5NL3F2fx93ai3CEBMKj1HHloiNxu7sLHTTS/Ntc
         H+Sw==
X-Gm-Message-State: APjAAAW+TI4vsdtP3BKq4ax9lU/nEvPbFAGlyN8mQ+piI8oZN8gLpH4G
        n7goXdwSIA3HxsfME1ZXAyU=
X-Google-Smtp-Source: APXvYqwaNlEyZYpblg/CRm4Lyd7wt0MMi9ADmpffKbXyy5zUO9hxzGQEAbiLa2ZZlXlKwM3qpFczkw==
X-Received: by 2002:ac8:3130:: with SMTP id g45mr17919338qtb.270.1566836333529;
        Mon, 26 Aug 2019 09:18:53 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v4sm7444665qtj.77.2019.08.26.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 09:18:52 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E2D440916; Mon, 26 Aug 2019 13:18:49 -0300 (-03)
Date:   Mon, 26 Aug 2019 13:18:49 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826161849.GF24801@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
 <20190826160627.GE24801@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826160627.GE24801@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 26, 2019 at 01:06:28PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Aug 25, 2019 at 08:17:40PM +0200, Jiri Olsa escreveu:
> > hi,
> > as a preparation for sampling libperf interface, moving event
> > definitions into the library header. Moving just the kernel=20
> > non-AUX events now.
> >=20
> > In order to keep libperf simple, we switch 'u64/u32/u16/u8'
> > types used events to their generic '__u*' versions.
> >=20
> > Perf added 'u*' types mainly to ease up printing __u64 values
> > as stated in the linux/types.h comment:
> >=20
> >   /*
> >    * We define u64 as uint64_t for every architecture
> >    * so that we can print it with "%"PRIx64 without getting warnings.
> >    *
> >    * typedef __u64 u64;
> >    * typedef __s64 s64;
> >    */
> >=20
> > Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
> > that.  Using extra '_' to ease up the reading and differentiate
> > them from standard PRI*64 macros.
>=20
> So, this is not building on android env:
>=20
> builtin-sched.c: In function 'process_lost':
> builtin-sched.c:2646:2: error: unknown conversion type character 'l' in f=
ormat [-Werror=3Dformat=3D]
>   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sampl=
e->cpu);
>   ^
> builtin-sched.c:2646:2: error: format '%d' expects argument of type 'int'=
, but argument 2 has type '__u64' [-Werror=3Dformat=3D]
> builtin-sched.c:2646:2: error: too many arguments for format [-Werror=3Df=
ormat-extra-args]
>   MKDIR    /tmp/build/perf/util/
>=20
>=20
> [perfbuilder@490c2c7bdaab ~]$ /opt/android-ndk-r12b//toolchains/arm-linux=
-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc -v
> Using built-in specs.
> COLLECT_GCC=3D/opt/android-ndk-r12b//toolchains/arm-linux-androideabi-4.9=
/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc
> COLLECT_LTO_WRAPPER=3D/opt/android-ndk-r12b/toolchains/arm-linux-androide=
abi-4.9/prebuilt/linux-x86_64/bin/../libexec/gcc/arm-linux-androideabi/4.9.=
x/lto-wrapper
> Target: arm-linux-androideabi
> Configured with: /usr/local/google/buildbot/src/android/gcc/toolchain/bui=
ld/../gcc/gcc-4.9/configure --prefix=3D/tmp/59719db9ae19ff43aef46bbcb79596b=
6 --target=3Darm-linux-androideabi --host=3Dx86_64-linux-gnu --build=3Dx86_=
64-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=3Dc,c++ --with-=
gmp=3D/buildbot/tmp/build/toolchain/temp-install --with-mpfr=3D/buildbot/tm=
p/build/toolchain/temp-install --with-mpc=3D/buildbot/tmp/build/toolchain/t=
emp-install --with-cloog=3D/buildbot/tmp/build/toolchain/temp-install --wit=
h-isl=3D/buildbot/tmp/build/toolchain/temp-install --with-ppl=3D/buildbot/t=
mp/build/toolchain/temp-install --disable-ppl-version-check --disable-cloog=
-version-check --disable-isl-version-check --enable-cloog-backend=3Disl --w=
ith-host-libstdcxx=3D'-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' -=
-disable-libssp --enable-threads --disable-nls --disable-libmudflap --disab=
le-libgomp --disable-libstdc__-v3 --disable-sjlj-exceptions --disable-share=
d --disable-tls --disable-libitm --with-float=3Dsoft --with-fpu=3Dvfp --wit=
h-arch=3Darmv5te --enable-target-optspace --enable-bionic-libs --enable-lib=
atomic-ifuncs=3Dno --enable-initfini-array --disable-nls --prefix=3D/tmp/59=
719db9ae19ff43aef46bbcb79596b6 --with-sysroot=3D/tmp/59719db9ae19ff43aef46b=
bcb79596b6/sysroot --with-binutils-version=3D2.25 --with-mpfr-version=3D3.1=
=2E1 --with-mpc-version=3D1.0.1 --with-gmp-version=3D5.0.5 --with-gcc-versi=
on=3D4.9 --with-gdb-version=3Dnone --with-gxx-include-dir=3D/tmp/59719db9ae=
19ff43aef46bbcb79596b6/include/c++/4.9.x --with-bugurl=3Dhttp://source.andr=
oid.com/source/report-bugs.html --enable-languages=3Dc,c++ --disable-bootst=
rap --enable-plugins --enable-libgomp --enable-gnu-indirect-function --disa=
ble-libsanitizer --enable-gold --enable-threads --enable-eh-frame-hdr-for-s=
tatic --enable-graphite=3Dyes --with-isl-version=3D0.11.1 --with-cloog-vers=
ion=3D0.18.0 --with-arch=3Darmv5te --program-transform-name=3D's&^&arm-linu=
x-androideabi-&' --enable-gold=3Ddefault
> Thread model: posix
> gcc version 4.9.x 20150123 (prerelease) (GCC)
> [perfbuilder@490c2c7bdaab ~]$
>=20
> It doesn't build on the r15b as well.
>=20
> I'll investigate after lunch.

$ make $EXTRA_MAKE_ARGS ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE EXTRA_C=
FLAGS=3D"$EXTRA_CFLAGS" -C /git/perf/tools/perf O=3D/tmp/build/perf /tmp/bu=
ild/perf/builtin-sched.i

We end up with one 'l' too many?

[perfbuilder@490c2c7bdaab ~]$ grep 'printf("lost' /tmp/build/perf/builtin-s=
ched.i
 printf("lost %" "l" "ll""u" " events on cpu %d\n", event->lost.lost, sampl=
e->cpu);
[perfbuilder@490c2c7bdaab ~]$

And if we do this on a fedora:30 x86_64:

$ make -C tools/perf O=3D/tmp/build/perf /tmp/build/perf/builtin-sched.i
[acme@quaco perf]$ grep -A4 'printf("lost' /tmp/build/perf/builtin-sched.i
 printf("lost %" "l"=20
# 2646 "builtin-sched.c" 3 4
                "l" "u"=20
# 2646 "builtin-sched.c"
                         " events on cpu %d\n", event->lost.lost, sample->c=
pu);
[acme@quaco perf]$

I.e. on 32-bit arches we shouldn't add that extra "l", right?

I bet the build for the mips/mipsel will fail too, lemme see... Yeah,
both failed:


[root@quaco ~]# grep -m1 -A6 -- -Werror=3Dformat=3D  dm.log/debian\:experim=
ental-x-mips
builtin-sched.c:2646:9: error: unknown conversion type character 'l' in for=
mat [-Werror=3Dformat=3D]
  printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample-=
>cpu);
         ^~~~~~~~
In file included from builtin-sched.c:31:
/usr/mips-linux-gnu/include/inttypes.h:47:28: note: format string is define=
d here
 #  define __PRI64_PREFIX "ll"
                            ^
[root@quaco ~]#

[root@quaco ~]# grep -m1 -A6 -- -Werror=3Dformat=3D  dm.log/debian\:experim=
ental-x-mipsel
builtin-sched.c:2646:9: error: unknown conversion type character 'l' in for=
mat [-Werror=3Dformat=3D]
  printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample-=
>cpu);
         ^~~~~~~~
In file included from builtin-sched.c:31:
/usr/mipsel-linux-gnu/include/inttypes.h:47:28: note: format string is defi=
ned here
 #  define __PRI64_PREFIX "ll"
                            ^
[root@quaco ~]#

And also on a uclibc ARC arch container:

[root@quaco ~]# grep -m1 -A6 -- -Werror=3Dformat=3D  dm.log/fedora\:24-x-AR=
C-uClibc
builtin-sched.c:2646:9: error: unknown conversion type character 'l' in for=
mat [-Werror=3Dformat=3D]
  printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample-=
>cpu);
         ^~~~~~~~
In file included from builtin-sched.c:31:0:
/arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux=
-uclibc/sysroot/usr/include/inttypes.h:47:28: note: format string is define=
d here
 #  define __PRI64_PREFIX "ll"
                            ^
[root@quaco ~]#

The _fix_ will come after lunch :)

- Arnaldo
