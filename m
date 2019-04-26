Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C66BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DC320693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQRO4rM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfDZT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:28:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33023 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfDZT2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:28:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so2595716qkc.0;
        Fri, 26 Apr 2019 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CBdbDtH16bin2p0a8VyDKqz4JIIFpMBjbJoHadjB4x4=;
        b=SQRO4rM4LcQF8TvaH4I//D1kTetpIOx9o9IYzAAaTWZNkR56kYW3dSWX11aMJFcXeb
         D8h2zQAHpW2H69XANE0IC5M1nAtqqaDH6KueZMX384eRiXzpPPYSZDTcI1FF+MRyzy0m
         mUvqjKSzXd+N4GA4+5JKmJZzjXLTJY7XOurQgr3lLZ0cj5CqqMsCL/aGmrhsku/lDUdV
         pNEHPWmBiooNF5Pr+w66q/CZgEaSoi+GMQRCittH7bi/fPPPNbxAFU/x6GPA0qditCSK
         MLLcM6HZhS+QIlmwXLYEH/Keb3FDIODYy0a8IWTOEu1yL4x5G95oz2ixN9plq3vfDyGY
         Rs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CBdbDtH16bin2p0a8VyDKqz4JIIFpMBjbJoHadjB4x4=;
        b=qn1oaudPNxZZNghq/njUZIGir6cyvxK49q62RSAJLK1QHiTSaYag/fe9EdtiQQKZp9
         ltv4x7V0E4ppL5g6txcFJ1DwuqV6Xm0L1IOP3GlAOto8fuQsTAzYj1F/+rhkOGanaFL1
         r+LCB08PPv6S8aWor0R+1gOOOIAyPId5Aw73Eu1MBsKhb1BGzHMTHaQ+ElKiNCd7YDjH
         z4Ar5yYZ1rW5REqMMxq/P/T9rBmcgOJC/sszDFXT3LwAZE3PoImE3u6s2OJLkzccQkjI
         JjaO8NG2rTIyfvE2E3zKMrclnY7VNFDLi4D+uP2dlMNS3QOVPJPA843CCOs9ysUrwRp2
         So+g==
X-Gm-Message-State: APjAAAV3kZEaWDJ19fDdbFEPQYo1yijj3cauNm2TL30sC2QX+jhtAdDH
        XPJum4mHZAnFBTCySDgmOOI=
X-Google-Smtp-Source: APXvYqy5bomka4p2fhRKc7cMczJ/5v6m4xsvHPcOYCvzmZtLmWLok3BcX4In+iEf5DnZXqyWJtGJDA==
X-Received: by 2002:a37:80c6:: with SMTP id b189mr28983890qkd.144.1556306918742;
        Fri, 26 Apr 2019 12:28:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id i62sm5911322qkc.78.2019.04.26.12.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:28:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD1694111F; Fri, 26 Apr 2019 16:28:34 -0300 (-03)
Date:   Fri, 26 Apr 2019 16:28:34 -0300
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190426192834.GB28586@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <20190425214800.GC21829@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190425214800.GC21829@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 25, 2019 at 06:48:00PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Apr 22, 2019 at 12:20:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:
> > > When building perf for ARC (v5.1-rc2) I get the following
> >  
> > > | In file included from bench/futex-hash.c:26:
> > > | bench/futex.h: In function 'futex_wait':
> > > | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this function);
> >  
> > > git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools headers uapi:
> > > Sync copy of asm-generic/unistd.h with the kernel sources")
> > 
> > Humm, I have to check why this:
> > 
> > [perfbuilder@quaco ~]$ podman images | grep ARC
> > docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-uClibc          4c259582a8e6   5 weeks ago      846 MB
> > [perfbuilder@quaco ~]$
> > 
> > isn't catching this... :-\
> > 
> > FROM docker.io/fedora:24
> > MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
> > ENV TOOLCHAIN=arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install
> > ENV CROSS=arc-linux-
> > ENV SOURCEFILE=${TOOLCHAIN}.tar.gz
> > RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc findutils xz
> > RUN wget https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-2017.09-rc2/${SOURCEFILE}
> > <SNIP>
> > COPY rx_and_build.sh /
> > ENV EXTRA_MAKE_ARGS=NO_LIBBPF=1
> > ENV ARCH=arc
> > ENV CROSS_COMPILE=/${TOOLCHAIN}/bin/${CROSS}
> > ENV EXTRA_CFLAGS=-matomic
> 
> So, now I have a libnuma crossbuilt in this container that allows me to
> build a ARC perf binary linked with zlib and numactl-devel, but only
> after I applied the fix below.
> 
> Can you please provide the feature detection header in the build? I.e.
> what I have with my ARC cross build container right now, after applying
> the patch below is:

So, switched from the uCLibc build system to the glibc based one, so
that I could get elfutils building (it needs argp that isn't available
with uCLibc) I have it reproduced, see below, now I'm testing with the
fix, which is to grab the unistd.h files you noticed missing for the
arches that are present in tools/arch/, will post results soon

[perfbuilder@f1798ef8e433 perf]$ make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C /git/perf/tools/perf O=/tmp/build/perf
make: Entering directory '/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep
sh: line 0: command: -c: invalid option
command: usage: command [-pVv] command [arg ...]

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...        disassembler-four-args: [ OFF ]

Makefile.config:441: DWARF register mappings have not been defined for architecture arc, DWARF support disabled
Makefile.config:473: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:548: Disabling post unwind, no support found.
Makefile.config:601: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
Makefile.config:613: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
Makefile.config:628: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:642: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
Makefile.config:669: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:696: No python interpreter was found: disables Python support - please install python-devel/python-dev
Makefile.config:754: No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling
Makefile.config:785: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:853: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:897: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
  GEN      /tmp/build/perf/common-cmds.h
  CC       /tmp/build/perf/exec-cmd.o
  CC       /tmp/build/perf/help.o
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/fd/array.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/pager.o
  LD       /tmp/build/perf/fd/libapi-in.o
  CC       /tmp/build/perf/cpu.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/fs.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/parse-options.o
  CC       /tmp/build/perf/str_error_r.o
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/run-command.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/parse-filter.o
  LD       /tmp/build/perf/libapi-in.o
  AR       /tmp/build/perf/libapi.a
  CC       /tmp/build/perf/sigchain.o
  CC       /tmp/build/perf/parse-utils.o
  CC       /tmp/build/perf/kbuffer-parse.o
  CC       /tmp/build/perf/tep_strerror.o
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/event-parse-api.o
  MKDIR    /tmp/build/perf/pmu-events/
  MKDIR    /tmp/build/perf/pmu-events/
  LD       /tmp/build/perf/libsubcmd-in.o
  HOSTCC   /tmp/build/perf/pmu-events/json.o
  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
  LD       /tmp/build/perf/libtraceevent-in.o
  LINK     /tmp/build/perf/libtraceevent.a
  AR       /tmp/build/perf/libsubcmd.a
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
  CC       /tmp/build/perf/plugin_kvm.o
  CC       /tmp/build/perf/plugin_kmem.o
  CC       /tmp/build/perf/plugin_jbd2.o
  CC       /tmp/build/perf/plugin_hrtimer.o
  CC       /tmp/build/perf/plugin_mac80211.o
  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  LD       /tmp/build/perf/plugin_kmem-in.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  LINK     /tmp/build/perf/pmu-events/jevents
  LD       /tmp/build/perf/plugin_kvm-in.o
  CC       /tmp/build/perf/plugin_xen.o
  CC       /tmp/build/perf/plugin_function.o
  CC       /tmp/build/perf/plugin_scsi.o
  PERF_VERSION = 5.1.0-rc6
  CC       /tmp/build/perf/plugin_cfg80211.o
  GEN      perf-archive
  GEN      perf-with-kcore
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  LINK     /tmp/build/perf/plugin_jbd2.so
  LINK     /tmp/build/perf/plugin_hrtimer.so
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  LD       /tmp/build/perf/plugin_xen-in.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LD       /tmp/build/perf/plugin_function-in.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  LINK     /tmp/build/perf/plugin_kmem.so
  LINK     /tmp/build/perf/plugin_kvm.so
  LINK     /tmp/build/perf/plugin_mac80211.so
  LINK     /tmp/build/perf/plugin_sched_switch.so
  LINK     /tmp/build/perf/plugin_function.so
  LINK     /tmp/build/perf/plugin_xen.so
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
  LINK     /tmp/build/perf/plugin_scsi.so
  LINK     /tmp/build/perf/plugin_cfg80211.so
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  LD       /tmp/build/perf/libperf-in.o
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/builtin-bench.o
  CC       /tmp/build/perf/builtin-annotate.o
  CC       /tmp/build/perf/builtin-diff.o
  CC       /tmp/build/perf/builtin-ftrace.o
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/builtin-help.o
  CC       /tmp/build/perf/builtin-sched.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  CC       /tmp/build/perf/builtin-kallsyms.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/builtin-report.o
  CC       /tmp/build/perf/builtin-stat.o
  CC       /tmp/build/perf/builtin-timechart.o
  CC       /tmp/build/perf/builtin-top.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-version.o
  CC       /tmp/build/perf/builtin-probe.o
  CC       /tmp/build/perf/builtin-c2c.o
  MKDIR    /tmp/build/perf/bench/
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/bench/sched-messaging.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/tests/builtin-test.o
  CC       /tmp/build/perf/bench/sched-pipe.o
  CC       /tmp/build/perf/bench/mem-functions.o
  CC       /tmp/build/perf/bench/futex-hash.o
  CC       /tmp/build/perf/bench/futex-wake.o
In file included from bench/futex-hash.c:26:
bench/futex.h: In function ‘futex_wait’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:46:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
         ^~~~~
bench/futex.h:37:10: note: each undeclared identifier is reported only once for each function it appears in
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:46:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_wake’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:56:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_lock_pi’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:65:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_unlock_pi’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:74:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_cmp_requeue’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:86:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
         ^~~~~
bench/futex.h: In function ‘futex_wait’:
bench/futex.h:47:1: error: control reaches end of non-void function [-Werror=return-type]
 }
 ^
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/bench/.futex-hash.o.tmp': No such file or directory
make[4]: *** [/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/bench/futex-hash.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  MKDIR    /tmp/build/perf/tests/
  MKDIR    /tmp/build/perf/arch/
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/tests/parse-events.o
  CC       /tmp/build/perf/util/annotate.o
  CC       /tmp/build/perf/arch/common.o
In file included from bench/futex-wake.c:24:
bench/futex.h: In function ‘futex_wait’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:46:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
         ^~~~~
bench/futex.h:37:10: note: each undeclared identifier is reported only once for each function it appears in
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:46:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_wake’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:56:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_lock_pi’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:65:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_unlock_pi’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:74:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
         ^~~~~
bench/futex.h: In function ‘futex_cmp_requeue’:
bench/futex.h:37:10: error: ‘SYS_futex’ undeclared (first use in this function); did you mean ‘SYS_tee’?
  syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
          ^~~~~~~~~
bench/futex.h:86:9: note: in expansion of macro ‘futex’
  return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
         ^~~~~
bench/futex.h: In function ‘futex_wait’:
bench/futex.h:47:1: error: control reaches end of non-void function [-Werror=return-type]
 }
 ^
bench/futex.h: In function ‘futex_wake’:
bench/futex.h:57:1: error: control reaches end of non-void function [-Werror=return-type]
 }
 ^
cc1: all warnings being treated as errors
  MKDIR    /tmp/build/perf/util/
mv: cannot stat '/tmp/build/perf/bench/.futex-wake.o.tmp': No such file or directory
make[4]: *** [/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/bench/futex-wake.o] Error 1
make[3]: *** [/git/perf/tools/build/Makefile.build:139: bench] Error 2
make[3]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/util/block-range.o
  CC       /tmp/build/perf/util/build-id.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/util/config.o
  MKDIR    /tmp/build/perf/ui/
  MKDIR    /tmp/build/perf/arch/arc/
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/ui/helpline.o
  LD       /tmp/build/perf/arch/arc/perf-in.o
  LD       /tmp/build/perf/arch/perf-in.o
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/tests/dso-data.o
  CC       /tmp/build/perf/util/ctype.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/util/db-export.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/util/event.o
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  CC       /tmp/build/perf/util/evsel.o
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/util/find_bit.o
  CC       /tmp/build/perf/util/get_current_dir_name.o
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/util/llvm-utils.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  LD       /tmp/build/perf/ui/perf-in.o
  CC       /tmp/build/perf/tests/fdarray.o
  CC       /tmp/build/perf/util/mmap.o

