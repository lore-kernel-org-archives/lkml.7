Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE2C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D5C20815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIFnIaMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfI3MXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:23:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33647 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfI3MXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:23:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so16758401qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rn0TQFn5LrUOsBViaqqhucyUnV5jUl9NDAtImCAIm34=;
        b=CIFnIaMJLxogfmv4Ys+yKCPNGepW4QLYg65QSn6EahaV76EJd06lJkoTyeqK3wEvuA
         loVR0bsDC7DXJ2w4Tj3wgkPGUpIPPtJnGU9S/dIBwI2e2BEH2khwKFDSYb84g9vHQMgB
         tFTWYl1KObhRzjfu8P1qRPN0dQRlTNp5KidHEaguDTf+t2f1bs+WZY+6G+BS+gyPAXbh
         x74v71FBIpgOs4nv1wP0ph1+PgVYaEOgbDrda+fozmMDqo+h+9JbFiMSPSFYjJpYMprk
         aLhpEu+CotfHYGHlofpu4kfclK7Ic3ombvdOcNuMf14Dfv4TC+2+cAtQWOVBWyEoCz4W
         w9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rn0TQFn5LrUOsBViaqqhucyUnV5jUl9NDAtImCAIm34=;
        b=mvx2QcJJogIGSCsogUtAu3Cb7MzxvfAIYHkFqE4e0vRrJxPoTJUv+JdypN5Eefb5BP
         /fTQHcj022yZiTi8fRGkzTHvFToGYf7Pf1Zvnuabe8soEYYK4qBS5ltn7otDGm43TdaS
         0tT6i/wzG93aVxFU+ONwFNLvihEZvTV+1xdt/z+3RwC0so3V4q8PtI/LPmtIcrxkaeJj
         XsNfboyfmBTwuMYs3Un3jAYOnuKIBp6XjGAS23W/B3VrvYyqclb8juL8MDv0KGOD8WNZ
         gB91TBskk1GFEan1hPWvauF/6izzJysOz0zcbyj6dv2v0EPx3drsSOQHsaYwNjufA/Tf
         PJdw==
X-Gm-Message-State: APjAAAV/z5Q9eh7oHrKqJffTm2iu0dII/N3oLEqQdiI+TGu1naoHh5zP
        RosotKMibPo2lXNieKZVnCA=
X-Google-Smtp-Source: APXvYqyp54nS01AuEGXqux/VyAaPN0O51pFHoBbeMYhx8b71z2SIAwWRgesVro+A2PY4YG3/LEec5Q==
X-Received: by 2002:ac8:1812:: with SMTP id q18mr24075799qtj.192.1569846220044;
        Mon, 30 Sep 2019 05:23:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o124sm5481909qke.66.2019.09.30.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 05:23:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A264340DA4; Mon, 30 Sep 2019 09:23:35 -0300 (-03)
Date:   Mon, 30 Sep 2019 09:23:35 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf tools: avoid sample_reg_masks being const + weak
Message-ID: <20190930122335.GF9622@kernel.org>
References: <20190927211005.147176-1-irogers@google.com>
 <20190927214341.170683-1-irogers@google.com>
 <20190929210514.GC602@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929210514.GC602@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 29, 2019 at 11:05:14PM +0200, Jiri Olsa escreveu:
> On Fri, Sep 27, 2019 at 02:43:41PM -0700, Ian Rogers wrote:
> > Being const + weak breaks with some compilers that constant-propagate
> > from the weak symbol. This behavior is outside of the specification, but
> > in LLVM is chosen to match GCC's behavior.
> > 
> > LLVM's implementation was set in this patch:
> > https://github.com/llvm/llvm-project/commit/f49573d1eedcf1e44893d5a062ac1b72c8419646
> > A const + weak symbol is set to be weak_odr:
> > https://llvm.org/docs/LangRef.html
> > ODR is one definition rule, and given there is one constant definition
> > constant-propagation is possible. It is possible to get this code to
> > miscompile with LLVM when applying link time optimization. As compilers
> > become more aggressive, this is likely to break in more instances.
> > 
> > Move the definition of sample_reg_masks to the conditional part of
> > perf_regs.h and guard usage with HAVE_PERF_REGS_SUPPORT. This avoids the
> > weak symbol.
> > 
> > Fix an issue when HAVE_PERF_REGS_SUPPORT isn't defined from patch v1.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Breaks the build on arm64, I'm removing it from perf/urgent till this gets settled.

  LINK     /tmp/build/perf/perf
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `__parse_regs':
/git/linux/tools/perf/util/parse-regs-options.c:39: undefined reference to `sample_reg_masks'
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:47: undefined reference to `sample_reg_masks'
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:60: undefined reference to `sample_reg_masks'
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:50: undefined reference to `sample_reg_masks'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:609: /tmp/build/perf/perf] Error 1
make[1]: *** [Makefile.perf:221: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/linux/tools/perf'
+ exit 1
[root@quaco ~]# 

Complete output:

[root@quaco ~]# cat dm.log/debian\:experimental-x-arm64 
debian:experimental-x-arm64
Downloading http://192.168.124.1/perf/perf-5.3.0.tar.xz...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1646k  100 1646k    0     0   803M      0 --:--:-- --:--:-- --:--:--  803M
d6bf2b2334abdabfe14cbc7cb161ba72b515e11d
Using built-in specs.
COLLECT_GCC=aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/aarch64-linux-gnu/8/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian 8.3.0-19' --with-bugurl=file:///usr/share/doc/gcc-8/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr --with-gcc-major-version-only --program-suffix=-8 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-libquadmath --disable-libquadmath-support --enable-plugin --enable-default-pie --with-system-zlib --disable-libphobos --enable-multiarch --enable-fix-cortex-a53-843419 --disable-werror --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=aarch64-linux-gnu --program-prefix=aarch64-linux-gnu- --includedir=/usr/aarch64-linux-gnu/include --with-build-config=bootstrap-lto --enable-link-mutex
Thread model: posix
gcc version 8.3.0 (Debian 8.3.0-19) 
+ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- EXTRA_CFLAGS= -C /git/linux/tools/perf O=/tmp/build/perf
make: Entering directory '/git/linux/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep
sh: 1: command: Illegal option -c

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ on  ]
...                        libbfd: [ OFF ]
...                        libcap: [ OFF ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ OFF ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ OFF ]
...        disassembler-four-args: [ OFF ]

Makefile.config:670: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
Makefile.config:724: No python interpreter was found: disables Python support - please install python-devel/python-dev
Makefile.config:782: No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling
Makefile.config:826: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:837: No libcap found, disables capability support, please install libcap-devel/libcap-dev
Makefile.config:905: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:931: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
  GEN      /tmp/build/perf/common-cmds.h
  PERF_VERSION = 5.3.gd6bf2b2334ab
  CC       /tmp/build/perf/exec-cmd.o
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/fd/array.o
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/core.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/libbpf.o
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/cpumap.o
  CC       /tmp/build/perf/threadmap.o
  LD       /tmp/build/perf/fd/libapi-in.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/fs.o
  CC       /tmp/build/perf/evsel.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/bpf.o
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/evlist.o
  CC       /tmp/build/perf/help.o
  CC       /tmp/build/perf/zalloc.o
  CC       /tmp/build/perf/xyarray.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/lib.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/nlattr.o
  CC       /tmp/build/perf/btf.o
  LD       /tmp/build/perf/libperf-in.o
  AR       /tmp/build/perf/libperf.a
  CC       /tmp/build/perf/str_error_r.o
  CC       /tmp/build/perf/libbpf_errno.o
  CC       /tmp/build/perf/str_error.o
  CC       /tmp/build/perf/netlink.o
  LD       /tmp/build/perf/libapi-in.o
  CC       /tmp/build/perf/bpf_prog_linfo.o
  AR       /tmp/build/perf/libapi.a
  CC       /tmp/build/perf/libbpf_probes.o
  CC       /tmp/build/perf/pager.o
  CC       /tmp/build/perf/parse-options.o
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/run-command.o
  CC       /tmp/build/perf/xsk.o
  CC       /tmp/build/perf/sigchain.o
  CC       /tmp/build/perf/hashmap.o
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/btf_dump.o
  CC       /tmp/build/perf/parse-utils.o
  CC       /tmp/build/perf/kbuffer-parse.o
  CC       /tmp/build/perf/tep_strerror.o
  CC       /tmp/build/perf/event-parse-api.o
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/json.o
  GEN      perf-archive
  GEN      perf-with-kcore
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
  DESCEND  plugins
  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
  LD       /tmp/build/perf/libtraceevent-in.o
  LINK     /tmp/build/perf/libtraceevent.a
  CC       /tmp/build/perf/plugins/plugin_jbd2.o
  CC       /tmp/build/perf/plugins/plugin_hrtimer.o
  CC       /tmp/build/perf/plugins/plugin_kmem.o
  CC       /tmp/build/perf/plugins/plugin_kvm.o
  LD       /tmp/build/perf/libbpf-in.o
  LINK     /tmp/build/perf/libbpf.a
  CC       /tmp/build/perf/plugins/plugin_mac80211.o
  LD       /tmp/build/perf/plugins/plugin_jbd2-in.o
  LD       /tmp/build/perf/plugins/plugin_hrtimer-in.o
  CC       /tmp/build/perf/plugins/plugin_sched_switch.o
  CC       /tmp/build/perf/plugins/plugin_function.o
  LD       /tmp/build/perf/plugins/plugin_kmem-in.o
  CC       /tmp/build/perf/plugins/plugin_xen.o
  LD       /tmp/build/perf/plugins/plugin_kvm-in.o
  LD       /tmp/build/perf/plugins/plugin_mac80211-in.o
  CC       /tmp/build/perf/plugins/plugin_scsi.o
  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
  CC       /tmp/build/perf/plugins/plugin_cfg80211.o
  LINK     /tmp/build/perf/pmu-events/jevents
  LD       /tmp/build/perf/plugins/plugin_sched_switch-in.o
  LD       /tmp/build/perf/plugins/plugin_function-in.o
  LD       /tmp/build/perf/plugins/plugin_xen-in.o
  LINK     /tmp/build/perf/plugins/plugin_jbd2.so
  LINK     /tmp/build/perf/plugins/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugins/plugin_kmem.so
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  LINK     /tmp/build/perf/plugins/plugin_kvm.so
  LINK     /tmp/build/perf/plugins/plugin_mac80211.so
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  LINK     /tmp/build/perf/plugins/plugin_sched_switch.so
  LD       /tmp/build/perf/plugins/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugins/plugin_function.so
  LINK     /tmp/build/perf/plugins/plugin_xen.so
  LINK     /tmp/build/perf/plugins/plugin_cfg80211.so
  LD       /tmp/build/perf/plugins/plugin_scsi-in.o
  LINK     /tmp/build/perf/plugins/plugin_scsi.so
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
  GEN      /tmp/build/perf/plugins/libtraceevent-dynamic-list
  CC       /tmp/build/perf/builtin-bench.o
  CC       /tmp/build/perf/builtin-annotate.o
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/builtin-diff.o
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/builtin-ftrace.o
make[3]: Nothing to be done for '/tmp/build/perf/plugins/libtraceevent-dynamic-list'.
  CC       /tmp/build/perf/builtin-help.o
  LD       /tmp/build/perf/libsubcmd-in.o
  AR       /tmp/build/perf/libsubcmd.a
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
  CC       /tmp/build/perf/builtin-c2c.o
  CC       /tmp/build/perf/builtin-trace.o
  CC       /tmp/build/perf/builtin-probe.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-messaging.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/builtin-test.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/arch/common.o
  CC       /tmp/build/perf/util/annotate.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-pipe.o
  MKDIR    /tmp/build/perf/arch/arm64/util/
  CC       /tmp/build/perf/arch/arm64/util/header.o
  MKDIR    /tmp/build/perf/arch/arm64/util/
  CC       /tmp/build/perf/arch/arm64/util/sym-handling.o
  CC       /tmp/build/perf/bench/mem-functions.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/parse-events.o
  MKDIR    /tmp/build/perf/arch/arm64/tests/
  CC       /tmp/build/perf/arch/arm64/tests/regs_load.o
  MKDIR    /tmp/build/perf/arch/arm64/tests/
  CC       /tmp/build/perf/arch/arm64/tests/dwarf-unwind.o
  CC       /tmp/build/perf/arch/arm64/util/dwarf-regs.o
  CC       /tmp/build/perf/arch/arm64/util/unwind-libunwind.o
  CC       /tmp/build/perf/arch/arm64/tests/arch-tests.o
  MKDIR    /tmp/build/perf/arch/arm64/util/../../arm/util/
  CC       /tmp/build/perf/arch/arm64/util/../../arm/util/pmu.o
  LD       /tmp/build/perf/arch/arm64/tests/perf-in.o
  MKDIR    /tmp/build/perf/arch/arm64/util/../../arm/util/
  CC       /tmp/build/perf/arch/arm64/util/../../arm/util/auxtrace.o
  CC       /tmp/build/perf/bench/futex-hash.o
  CC       /tmp/build/perf/arch/arm64/util/../../arm/util/cs-etm.o
  CC       /tmp/build/perf/arch/arm64/util/arm-spe.o
  CC       /tmp/build/perf/bench/futex-wake.o
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  CC       /tmp/build/perf/bench/futex-requeue.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/setup.o
  LD       /tmp/build/perf/arch/arm64/util/perf-in.o
  LD       /tmp/build/perf/arch/arm64/perf-in.o
  LD       /tmp/build/perf/arch/perf-in.o
  MKDIR    /tmp/build/perf/scripts/perl/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/helpline.o
  CC       /tmp/build/perf/bench/epoll-wait.o
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/bench/epoll-ctl.o
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/trace/beauty/fcntl.o
  CC       /tmp/build/perf/trace/beauty/flock.o
  CC       /tmp/build/perf/trace/beauty/fsmount.o
  CC       /tmp/build/perf/trace/beauty/fspick.o
  CC       /tmp/build/perf/bench/numa.o
  CC       /tmp/build/perf/trace/beauty/kcmp.o
  CC       /tmp/build/perf/trace/beauty/mount_flags.o
  LD       /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
  LD       /tmp/build/perf/scripts/perf-in.o
  CC       /tmp/build/perf/perf.o
  CC       /tmp/build/perf/trace/beauty/move_mount.o
  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/trace/beauty/arch_prctl.o
  CC       /tmp/build/perf/trace/beauty/prctl.o
  CC       /tmp/build/perf/trace/beauty/renameat.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/trace/beauty/sockaddr.o
  CC       /tmp/build/perf/util/block-range.o
  CC       /tmp/build/perf/trace/beauty/socket.o
  CC       /tmp/build/perf/trace/beauty/statx.o
  CC       /tmp/build/perf/trace/beauty/sync_file_range.o
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/util/cacheline.o
  CC       /tmp/build/perf/tests/dso-data.o
  CC       /tmp/build/perf/util/config.o
  CC       /tmp/build/perf/util/copyfile.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  CC       /tmp/build/perf/util/ctype.o
  CC       /tmp/build/perf/util/db-export.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/util/event.o
  CC       /tmp/build/perf/util/evlist.o
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/util/evsel.o
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/util/perf_event_attr_fprintf.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/util/evswitch.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/util/find_bit.o
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/util/get_current_dir_name.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  CC       /tmp/build/perf/util/llvm-utils.o
  CC       /tmp/build/perf/util/mmap.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/util/memswap.o
  BISON    /tmp/build/perf/util/parse-events-bison.c
util/parse-events.y:1.1-12: warning: deprecated directive, use '%define api.pure' [-Wdeprecated]
    1 | %pure-parser
      | ^~~~~~~~~~~~
  CC       /tmp/build/perf/util/perf_regs.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
  CC       /tmp/build/perf/util/path.o
  CC       /tmp/build/perf/util/print_binary.o
  CC       /tmp/build/perf/util/rlimit.o
  CC       /tmp/build/perf/util/argv_split.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  CC       /tmp/build/perf/util/rbtree.o
  CC       /tmp/build/perf/util/libstring.o
  CC       /tmp/build/perf/util/bitmap.o
  CC       /tmp/build/perf/util/hweight.o
  CC       /tmp/build/perf/util/smt.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/util/strbuf.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/util/string.o
  CC       /tmp/build/perf/util/strlist.o
  CC       /tmp/build/perf/ui/browser.o
  CC       /tmp/build/perf/util/strfilter.o
  CC       /tmp/build/perf/util/top.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  CC       /tmp/build/perf/tests/fdarray.o
  CC       /tmp/build/perf/util/usage.o
  CC       /tmp/build/perf/tests/pmu.o
  CC       /tmp/build/perf/tests/hists_common.o
  CC       /tmp/build/perf/util/dso.o
  CC       /tmp/build/perf/tests/hists_link.o
  CC       /tmp/build/perf/util/dsos.o
  CC       /tmp/build/perf/util/symbol.o
  CC       /tmp/build/perf/tests/hists_filter.o
  CC       /tmp/build/perf/tests/hists_output.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/annotate.o
  CC       /tmp/build/perf/util/symbol_fprintf.o
  CC       /tmp/build/perf/tests/hists_cumulate.o
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/tests/bp_signal.o
  CC       /tmp/build/perf/util/color.o
  CC       /tmp/build/perf/util/color_config.o
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  CC       /tmp/build/perf/util/metricgroup.o
  CC       /tmp/build/perf/util/header.o
  CC       /tmp/build/perf/util/callchain.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/hists.o
  CC       /tmp/build/perf/tests/bp_account.o
  CC       /tmp/build/perf/ui/browsers/map.o
  CC       /tmp/build/perf/tests/wp.o
  CC       /tmp/build/perf/ui/browsers/scripts.o
  CC       /tmp/build/perf/tests/task-exit.o
  CC       /tmp/build/perf/util/values.o
  CC       /tmp/build/perf/tests/sw-clock.o
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  CC       /tmp/build/perf/util/debug.o
  CC       /tmp/build/perf/ui/browsers/header.o
  CC       /tmp/build/perf/tests/thread-mg-share.o
  CC       /tmp/build/perf/util/machine.o
  CC       /tmp/build/perf/ui/browsers/res_sample.o
  CC       /tmp/build/perf/tests/switch-tracking.o
  CC       /tmp/build/perf/tests/keep-tracking.o
  CC       /tmp/build/perf/util/map.o
  CC       /tmp/build/perf/util/pstack.o
  CC       /tmp/build/perf/util/session.o
  CC       /tmp/build/perf/tests/code-reading.o
  CC       /tmp/build/perf/util/sample-raw.o
  CC       /tmp/build/perf/tests/sample-parsing.o
  CC       /tmp/build/perf/util/s390-sample-raw.o
  CC       /tmp/build/perf/util/syscalltbl.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  CC       /tmp/build/perf/util/ordered-events.o
  CC       /tmp/build/perf/tests/kmod-path.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/util/namespaces.o
  CC       /tmp/build/perf/util/comm.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/util/thread.o
  CC       /tmp/build/perf/util/thread_map.o
  CC       /tmp/build/perf/util/trace-event-parse.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/util/parse-events-bison.o
  BISON    /tmp/build/perf/util/pmu-bison.c
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/util/trace-event.o
  CC       /tmp/build/perf/util/svghelper.o
  CC       /tmp/build/perf/tests/mem.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/util/hist.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/util/util.o
  CC       /tmp/build/perf/util/cpumap.o
  CC       /tmp/build/perf/tests/stat.o
  CC       /tmp/build/perf/util/cputopo.o
  CC       /tmp/build/perf/tests/event_update.o
  CC       /tmp/build/perf/util/cgroup.o
  CC       /tmp/build/perf/util/target.o
  CC       /tmp/build/perf/util/rblist.o
  CC       /tmp/build/perf/tests/event-times.o
  CC       /tmp/build/perf/util/intlist.o
  CC       /tmp/build/perf/util/vdso.o
  CC       /tmp/build/perf/util/counts.o
  CC       /tmp/build/perf/util/stat.o
  CC       /tmp/build/perf/util/stat-shadow.o
  CC       /tmp/build/perf/util/stat-display.o
  CC       /tmp/build/perf/tests/expr.o
  CC       /tmp/build/perf/util/record.o
  LD       /tmp/build/perf/ui/browsers/perf-in.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/setup.o
  CC       /tmp/build/perf/tests/backward-ring-buffer.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/util.o
  CC       /tmp/build/perf/ui/tui/helpline.o
  CC       /tmp/build/perf/tests/sdt.o
  CC       /tmp/build/perf/util/srcline.o
  CC       /tmp/build/perf/ui/tui/progress.o
  CC       /tmp/build/perf/util/srccode.o
  CC       /tmp/build/perf/tests/is_printable_array.o
  LD       /tmp/build/perf/ui/tui/perf-in.o
  LD       /tmp/build/perf/ui/perf-in.o
  CC       /tmp/build/perf/tests/bitmap.o
  CC       /tmp/build/perf/tests/perf-hooks.o
  CC       /tmp/build/perf/tests/clang.o
  CC       /tmp/build/perf/util/synthetic-events.o
  CC       /tmp/build/perf/tests/unit_number__scnprintf.o
  CC       /tmp/build/perf/tests/mem2node.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/tests/map_groups.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/tests/time-utils-test.o
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/tests/dwarf-unwind.o
  CC       /tmp/build/perf/util/call-path.o
  CC       /tmp/build/perf/util/rwsem.o
  CC       /tmp/build/perf/util/thread-stack.o
  CC       /tmp/build/perf/util/auxtrace.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC       /tmp/build/perf/util/intel-pt.o
  CC       /tmp/build/perf/tests/llvm-src-base.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  CC       /tmp/build/perf/util/intel-bts.o
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/arm-spe.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  GEN      /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
  CC       /tmp/build/perf/util/arm-spe-pkt-decoder.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/dump-insn.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
  CC       /tmp/build/perf/util/vsprintf.o
  CC       /tmp/build/perf/util/units.o
  CC       /tmp/build/perf/util/time-utils.o
  BISON    /tmp/build/perf/util/expr-bison.c
util/expr.y:15.1-12: warning: deprecated directive, use '%define api.pure' [-Wdeprecated]
   15 | %pure-parser
      | ^~~~~~~~~~~~
util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother  LD       /tmp/build/perf/util/scripting-engines/perf-in.o
]
  CC       /tmp/build/perf/util/branch.o
  CC       /tmp/build/perf/util/mem2node.o
  CC       /tmp/build/perf/util/bpf-loader.o
  CC       /tmp/build/perf/util/bpf_map.o
  CC       /tmp/build/perf/util/bpf-prologue.o
  CC       /tmp/build/perf/util/symbol-elf.o
  CC       /tmp/build/perf/util/probe-file.o
  CC       /tmp/build/perf/util/probe-event.o
  CC       /tmp/build/perf/util/probe-finder.o
  CC       /tmp/build/perf/util/dwarf-aux.o
  CC       /tmp/build/perf/util/dwarf-regs.o
  CC       /tmp/build/perf/util/unwind-libunwind-local.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       /tmp/build/perf/util/unwind-libunwind.o
  MKDIR    /tmp/build/perf/util/libunwind/
  CC       /tmp/build/perf/util/libunwind/arm64.o
  CC       /tmp/build/perf/util/zlib.o
  CC       /tmp/build/perf/util/lzma.o
  CC       /tmp/build/perf/util/demangle-java.o
  CC       /tmp/build/perf/util/demangle-rust.o
  CC       /tmp/build/perf/util/jitdump.o
  CC       /tmp/build/perf/util/genelf.o
  CC       /tmp/build/perf/util/genelf_debug.o
  CC       /tmp/build/perf/util/perf-hooks.o
  CC       /tmp/build/perf/util/bpf-event.o
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
  LD       /tmp/build/perf/util/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `__parse_regs':
/git/linux/tools/perf/util/parse-regs-options.c:39: undefined reference to `sample_reg_masks'
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:47: undefined reference to `sample_reg_masks'
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:60: undefined reference to `sample_reg_masks'
/usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:50: undefined reference to `sample_reg_masks'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:609: /tmp/build/perf/perf] Error 1
make[1]: *** [Makefile.perf:221: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/linux/tools/perf'
+ exit 1
[root@quaco ~]# 
