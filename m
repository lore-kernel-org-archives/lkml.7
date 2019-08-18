Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D35EC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D352186A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuCrWAng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfHRV2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 17:28:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35140 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfHRV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 17:28:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so5725641pgv.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3tGJUKa/eeejPUiZWA78bv3PmeepiSAvExlCPFnXMD0=;
        b=PuCrWAngKmljCRsJJW4bWsn3RTG2jDhRERKe9p/bZDSgMMNnVrc5YDX3GBzIYmDA0+
         KFBYB3hcoqN0MTbwb0coQQXwCznIBSn6ExUlqa5ndrdJGKP1a6HQpuropy2okeoKsv8L
         8hBXa89KvEkddO0Nn7lc/bks578ZUCowdnh5mcjhJuK4klV5Kb/Lu0/KiEtcmO1/sHms
         eKZU4b/EbK8MbZvxLiE6FG7oS0JYJar1QXba2HNwpTLWPuSD3L6prkVy9HobcSKZnwRG
         vB0sIQKvSFbnxLzdl0Tu5+Wj2DROULDxZVHC0wwOAh9+EB2BKsdOQyxCtQv4xjtpVPnF
         CWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3tGJUKa/eeejPUiZWA78bv3PmeepiSAvExlCPFnXMD0=;
        b=XtlV7D8Suo8ES0ndIH5BkPdVcMWHPhXUz6g07hRNSDUDEJXYOetVme2MKmQ7CIKK5G
         k5js3YMHuQ7DyM3jZlciBoy/1jLmuDbUd1d1mkTrw1xR9UWRs4Byfs9ZfxiFp46hwXbq
         KNPXjmJMov/xg9IOIsJ44aDw9OfVVQgv8BHL1IimPQS7Mf7tVQ1ZOhs/f8a5Tg90Q4Aj
         vX1zXjgmLyRQ29ubtF5zZ1B3ch4xveUesRMt1U0+NUJIbIuZZnaC1/+xEPjkOdC+QZJJ
         SI2MSEBmSmWGP7mgg+1LzKkRGFH/UMaiHO1qO2sK9cOw2inMq026t9SI44DPT7SDpkzn
         4WQg==
X-Gm-Message-State: APjAAAV7ZXrjsNx3ah/x+DMK36Mz47/kkLu6Vmv2ZziU2wv9DTIJiPfH
        G+bs8S3E924OzbZ+oma5yHGi4JWP
X-Google-Smtp-Source: APXvYqyg84pHFGVIH8ZHRUWvof86iZsAJOE/DewvVLlnMHFDOCSecLWqtTi+40HsL/Y6Djy/8fBo8Q==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr21156957pfd.19.1566163699252;
        Sun, 18 Aug 2019 14:28:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k8sm12208158pgm.14.2019.08.18.14.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 14:28:18 -0700 (PDT)
Date:   Sun, 18 Aug 2019 14:28:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 28/79] libperf: Add perf_cpu_map struct
Message-ID: <20190818212816.GA23921@roeck-us.net>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-29-jolsa@kernel.org>
 <20190818140436.GA21854@roeck-us.net>
 <20190818194032.GA10666@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190818194032.GA10666@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 09:40:32PM +0200, Jiri Olsa wrote:
> On Sun, Aug 18, 2019 at 07:04:36AM -0700, Guenter Roeck wrote:
> > On Sun, Jul 21, 2019 at 01:24:15PM +0200, Jiri Olsa wrote:
> > > Adding perf_cpu_map struct into libperf.
> > >=20
> > > It's added as a declaration into into:
> > >   include/perf/cpumap.h
> > > which will be included by users.
> > >=20
> > > The perf_cpu_map struct definition is added into:
> > >   include/internal/cpumap.h
> > >=20
> > > which is not to be included by users, but shared
> > > within perf and libperf.
> > >=20
> > > We tried the total separation of the perf_cpu_map struct
> > > in libperf, but it lead to complications and much bigger
> > > changes in perf code, so we decided to share the declaration.
> > >=20
> > > Link: http://lkml.kernel.org/n/tip-vhtr6a8apr7vkh2tou0r8896@git.kerne=
l.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >=20
> > Hi,
> >=20
> > this patch causes out-of-tree builds (make O=3D<destdir>) to fail.
> >=20
> > In file included from tools/include/asm/atomic.h:6:0,
> >                  from include/linux/atomic.h:5,
> > 		 from tools/include/linux/refcount.h:41,
> > 		 from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic=
=2Eh:11:10:
> > fatal error: asm/cmpxchg.h: No such file or directory
> >=20
> > Bisect log attached.
>=20
> hi,
> I dont see any problem with v5.3-rc4, could you please send
> the full compilation log (after make clean) from:
>=20
>   $ make V=3D1 <your options>
>=20
> also I can't make sense of that bisect, because I can't find
> some of those commits.. what tree are you in?
>=20
This is with -next, not with mainline. More specifically, with
next-20190816, though the problem has been seen since at least
next-20190801. Mainline builds fine.

Here is the script I used to bisect the problem:

make mrproper
rm -rf /tmp/linux
mkdir /tmp/linux
make ARCH=3Dx86_64 O=3D/tmp/linux defconfig
make -j40 ARCH=3Dx86_64 O=3D/tmp/linux tools/perf

It looks like the problem is related to "ARCH=3Dx86_64". In mainline,
x86_64 is replaced in the build command with x86. This is no longer
the case, and make now tries to include from tools/arch/x86_64/include/,
which doesn't exist. As it turns out, O=3D<destdir> is not needed to
reproduce the problem, only ARCH=3Dx86_64 (or ARCH=3Di386).

Output from build with V=3D1 below.

Guenter

---
make[1]: Entering directory '/tmp/linux'
  HOSTCC  scripts/basic/fixdep
  GEN     Makefile
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
make[1]: Leaving directory '/tmp/linux'
make -C /tmp/linux -f /home/groeck/src/linux-next/Makefile tools/perf
make[1]: Entering directory '/tmp/linux'
mkdir -p ./tools
make LDFLAGS=3D MAKEFLAGS=3D" -j --jobserver-fds=3D3,4" O=3D/tmp/linux subd=
ir=3Dtools -C /home/groeck/src/linux-next/tools/ perf
mkdir -p /tmp/linux/tools/perf .
make --no-print-directory -C perf O=3D/tmp/linux/tools/perf subdir=3D
  BUILD:   Doing 'make =1B[33m-j24=1B[m' parallel build
make -C /home/groeck/src/linux-next/tools/build CFLAGS=3D LDFLAGS=3D /tmp/l=
inux/tools/perf/fixdep
make -f /home/groeck/src/linux-next/tools/build/Makefile.build dir=3D. obj=
=3Dfixdep
  gcc -Wp,-MD,/tmp/linux/tools/perf/.fixdep.o.d -Wp,-MT,/tmp/linux/tools/pe=
rf/fixdep.o -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame=
-pointer -std=3Dgnu89   -D"BUILD_STR(s)=3D#s"   -c -o /tmp/linux/tools/perf=
/fixdep.o fixdep.c
   ld -r -o /tmp/linux/tools/perf/fixdep-in.o  /tmp/linux/tools/perf/fixdep=
=2Eo
gcc   -o /tmp/linux/tools/perf/fixdep /tmp/linux/tools/perf/fixdep-in.o
Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs f=
rom latest version at 'include/uapi/drm/i915_drm.h'
diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from =
latest version at 'include/uapi/linux/fs.h'
diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs fr=
om latest version at 'include/uapi/linux/prctl.h'
diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs fr=
om latest version at 'include/uapi/linux/sched.h'
diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/usbdevice_fs.h' dif=
fers from latest version at 'include/uapi/linux/usbdevice_fs.h'
diff -u tools/include/uapi/linux/usbdevice_fs.h include/uapi/linux/usbdevic=
e_fs.h
Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from lat=
est version at 'include/linux/bits.h'
diff -u tools/include/linux/bits.h include/linux/bits.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' di=
ffers from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufe=
atures.h
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/unistd.h' di=
ffers from latest version at 'arch/x86/include/uapi/asm/unistd.h'
diff -u tools/arch/x86/include/uapi/asm/unistd.h arch/x86/include/uapi/asm/=
unistd.h
Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h=
' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-gener=
ic/mman-common.h
make FIXDEP=3D1 -f Makefile.perf=20

Auto-detecting system features:
=2E..                         dwarf: [ =1B[32mon=1B[m  ]
=2E..            dwarf_getlocations: [ =1B[32mon=1B[m  ]
=2E..                         glibc: [ =1B[32mon=1B[m  ]
=2E..                          gtk2: [ =1B[32mon=1B[m  ]
=2E..                      libaudit: [ =1B[32mon=1B[m  ]
=2E..                        libbfd: [ =1B[32mon=1B[m  ]
=2E..                        libelf: [ =1B[32mon=1B[m  ]
=2E..                       libnuma: [ =1B[32mon=1B[m  ]
=2E..        numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
=2E..                       libperl: [ =1B[32mon=1B[m  ]
=2E..                     libpython: [ =1B[32mon=1B[m  ]
=2E..                     libcrypto: [ =1B[32mon=1B[m  ]
=2E..                     libunwind: [ =1B[32mon=1B[m  ]
=2E..            libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
=2E..                          zlib: [ =1B[32mon=1B[m  ]
=2E..                          lzma: [ =1B[32mon=1B[m  ]
=2E..                     get_cpuid: [ =1B[32mon=1B[m  ]
=2E..                           bpf: [ =1B[32mon=1B[m  ]
=2E..                        libaio: [ =1B[32mon=1B[m  ]
=2E..                       libzstd: [ =1B[31mOFF=1B[m ]
=2E..        disassembler-four-args: [ =1B[31mOFF=1B[m ]

Makefile.config:822: No libzstd found, disables trace compression, please i=
nstall libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:890: No libbabeltrace found, disables 'perf data' CTF forma=
t support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
$(:)
make -C /home/groeck/src/linux-next/tools/lib/api/ O=3D/tmp/linux/tools/per=
f/ /tmp/linux/tools/perf/libapi.a
make -C /home/groeck/src/linux-next/tools/lib/traceevent/ plugin_dir=3D 'EX=
TRA_CFLAGS=3D' 'LDFLAGS=3D -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -ll=
zma  -Wl,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-lin=
ux-gnu/perl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/l=
ib -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions' O=3D/tmp/linu=
x/tools/perf/ /tmp/linux/tools/perf/libtraceevent.a
make -C /home/groeck/src/linux-next/tools/lib/subcmd/ O=3D/tmp/linux/tools/=
perf/ /tmp/linux/tools/perf/libsubcmd.a
make -C /home/groeck/src/linux-next/tools/perf/lib/ O=3D/tmp/linux/tools/pe=
rf/ /tmp/linux/tools/perf/libperf.a
make -C /home/groeck/src/linux-next/tools/lib/bpf/ O=3D/tmp/linux/tools/per=
f/ /tmp/linux/tools/perf/libbpf.a FEATURES_DUMP=3D/tmp/linux/tools/perf/FEA=
TURE-DUMP
/bin/sh util/PERF-VERSION-GEN /tmp/linux/tools/perf/
=2E util/generate-cmdlist.sh > /tmp/linux/tools/perf/common-cmds.h+ && mv /=
tmp/linux/tools/perf/common-cmds.h+ /tmp/linux/tools/perf/common-cmds.h
/bin/sh '/home/groeck/src/linux-next/tools/perf/arch/x86/entry/syscalls/sys=
calltbl.sh' /home/groeck/src/linux-next/tools/perf/arch/x86/entry/syscalls/=
syscall_64.tbl 'x86_64' > /tmp/linux/tools/perf/arch/x86/include/generated/=
asm/syscalls_64.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/drm_ioctl.sh' =
/home/groeck/src/linux-next/tools/include/uapi/drm > /tmp/linux/tools/perf/=
trace/beauty/generated/ioctl/drm_ioctl_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/fadvise.sh' /h=
ome/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/perf/=
trace/beauty/generated/fadvise_advice_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/fsconfig.sh' /=
home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/perf=
/trace/beauty/generated/fsconfig_arrays.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/fsmount.sh' /h=
ome/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/perf/=
trace/beauty/generated/fsmount_arrays.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/fspick.sh' /ho=
me/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/perf/t=
race/beauty/generated/fspick_arrays.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/pkey_alloc_acc=
ess_rights.sh' /home/groeck/src/linux-next/tools/include/uapi/asm-generic/ =
> /tmp/linux/tools/perf/trace/beauty/generated/pkey_alloc_access_rights_arr=
ay.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/sndrv_pcm_ioct=
l.sh' /home/groeck/src/linux-next/tools/include/uapi/sound > /tmp/linux/too=
ls/perf/trace/beauty/generated/ioctl/sndrv_pcm_ioctl_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/sndrv_ctl_ioct=
l.sh' /home/groeck/src/linux-next/tools/include/uapi/sound > /tmp/linux/too=
ls/perf/trace/beauty/generated/ioctl/sndrv_ctl_ioctl_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/kcmp_type.sh' =
/home/groeck/src/linux-next/tools/include/uapi/linux/ > /tmp/linux/tools/pe=
rf/trace/beauty/generated/kcmp_type_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/kvm_ioctl.sh' =
/home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/per=
f/trace/beauty/generated/ioctl/kvm_ioctl_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/socket_ipproto=
=2Esh' /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/to=
ols/perf/trace/beauty/generated/socket_ipproto_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/vhost_virtio_i=
octl.sh' /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/=
tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/madvise_behavi=
or.sh' /home/groeck/src/linux-next/tools/include/uapi/asm-generic/ > /tmp/l=
inux/tools/perf/trace/beauty/generated/madvise_behavior_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/mmap_flags.sh'=
 /home/groeck/src/linux-next/tools/include/uapi/linux /home/groeck/src/linu=
x-next/tools/include/uapi/asm-generic /home/groeck/src/linux-next/tools/arc=
h/x86/include/uapi/asm/ > /tmp/linux/tools/perf/trace/beauty/generated/mmap=
_flags_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/mount_flags.sh=
' /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/p=
erf/trace/beauty/generated/mount_flags_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/move_mount_fla=
gs.sh' /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/to=
ols/perf/trace/beauty/generated/move_mount_flags_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/perf_ioctl.sh'=
 /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/pe=
rf/trace/beauty/generated/ioctl/perf_ioctl_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/prctl_option.s=
h' /home/groeck/src/linux-next/tools/include/uapi/linux/ > /tmp/linux/tools=
/perf/trace/beauty/generated/prctl_option_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/usbdevfs_ioctl=
=2Esh' /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/to=
ols/perf/trace/beauty/generated/ioctl/usbdevfs_ioctl_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/x86_arch_prctl=
=2Esh' /home/groeck/src/linux-next/tools/arch/x86/include/uapi/asm/ > /tmp/=
linux/tools/perf/trace/beauty/generated/x86_arch_prctl_code_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/rename_flags.s=
h' /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/tools/=
perf/trace/beauty/generated/rename_flags_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/arch_errno_nam=
es.sh' gcc /home/groeck/src/linux-next/tools > /tmp/linux/tools/perf/trace/=
beauty/generated/arch_errno_name_array.c
/bin/sh '/home/groeck/src/linux-next/tools/perf/trace/beauty/sync_file_rang=
e.sh' /home/groeck/src/linux-next/tools/include/uapi/linux > /tmp/linux/too=
ls/perf/trace/beauty/generated/sync_file_range_arrays.c
make -f /home/groeck/src/linux-next/tools/build/Makefile.build dir=3Dpmu-ev=
ents obj=3Djevents
make -C /home/groeck/src/linux-next/tools/lib/traceevent/ plugin_dir=3D 'EX=
TRA_CFLAGS=3D' 'LDFLAGS=3D -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -ll=
zma  -Wl,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-lin=
ux-gnu/perl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/l=
ib -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions' O=3D/tmp/linu=
x/tools/perf/ plugins
make -f /home/groeck/src/linux-next/tools/build/Makefile.build dir=3Djvmti =
obj=3Djvmti
make -f /home/groeck/src/linux-next/tools/build/Makefile.build dir=3D. obj=
=3Dgtk
make -f /home/groeck/src/linux-next/tools/build/Makefile.build dir=3D./fd o=
bj=3Dlibapi
make -f /home/groeck/src/linux-next/tools/build/Makefile.build dir=3D./fs o=
bj=3Dlibapi
make -f /home/groeck/src/linux-next/tools/build/Makefile.build dir=3D./ui/g=
tk obj=3Dgtk
  mkdir -p /tmp/linux/tools/perf/jvmti/
  mkdir -p /tmp/linux/tools/perf/fd/
  mkdir -p /tmp/linux/tools/perf/jvmti/
  mkdir -p /tmp/linux/tools/perf/pmu-events/
  mkdir -p /tmp/linux/tools/perf/fs/
  mkdir -p /tmp/linux/tools/perf/pmu-events/
  mkdir -p /tmp/linux/tools/perf/pmu-events/
  mkdir -p /tmp/linux/tools/perf/ui/gtk/
  gcc -Wp,-MD,/tmp/linux/tools/perf/.exec-cmd.o.d -Wp,-MT,/tmp/linux/tools/=
perf/exec-cmd.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-=
security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototyp=
es -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wr=
edundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -=
Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra=
 -std=3Dgnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -fPIC -O6 -Werror -D_=
LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/home/groeck/sr=
c/linux-next/tools/include/ -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/pe=
rf/exec-cmd.o exec-cmd.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.cpu.o.d -Wp,-MT,/tmp/linux/tools/perf/=
cpu.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -=
Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wneste=
d-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-d=
ecls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-str=
ings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra -std=3Dgn=
u99 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BI=
TS=3D64 -I/home/groeck/src/linux-next/tools/lib/api -I/home/groeck/src/linu=
x-next/tools/include -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/cpu.=
o cpu.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/fd/.array.o.d -Wp,-MT,/tmp/linux/tools/=
perf/fd/array.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-=
security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototyp=
es -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wr=
edundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -=
Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra=
 -std=3Dgnu99 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_SOURCE -D_FILE=
_OFFSET_BITS=3D64 -I/home/groeck/src/linux-next/tools/lib/api -I/home/groec=
k/src/linux-next/tools/include -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools=
/perf/fd/array.o fd/array.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/pmu-events/.json.o.d -Wp,-MT,/tmp/linux=
/tools/perf/pmu-events/json.o -Wall -Wmissing-prototypes -Wstrict-prototype=
s -O2 -fomit-frame-pointer -std=3Dgnu89   -D"BUILD_STR(s)=3D#s"   -c -o /tm=
p/linux/tools/perf/pmu-events/json.o pmu-events/json.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.debug.o.d -Wp,-MT,/tmp/linux/tools/per=
f/debug.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wn=
ested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredunda=
nt-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite=
-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra -std=
=3Dgnu99 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFS=
ET_BITS=3D64 -I/home/groeck/src/linux-next/tools/lib/api -I/home/groeck/src=
/linux-next/tools/include -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf=
/debug.o debug.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/pmu-events/.jsmn.o.d -Wp,-MT,/tmp/linux=
/tools/perf/pmu-events/jsmn.o -Wall -Wmissing-prototypes -Wstrict-prototype=
s -O2 -fomit-frame-pointer -std=3Dgnu89   -D"BUILD_STR(s)=3D#s"   -c -o /tm=
p/linux/tools/perf/pmu-events/jsmn.o pmu-events/jsmn.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/jvmti/.libjvmti.o.d -Wp,-MT,/tmp/linux/=
tools/perf/jvmti/libjvmti.o -Wbad-function-cast -Wdeclaration-after-stateme=
nt -Wformat-security -Wformat-y2k -Winit-self -Wmissing-prototypes -Wnested=
-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-de=
cls -Wswitch-default -Wswitch-enum -Wundef -Wformat -Wstrict-aliasing=3D3 -=
Wshadow -DHAVE_ARCH_X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include=
/generated -DHAVE_SYSCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARC=
H_REGS_QUERY_REGISTER_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -fu=
nwind-tables -Wall -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2=
 -I/home/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/li=
nux-next/tools/perf/util/include -I/home/groeck/src/linux-next/tools/perf/a=
rch/x86/include -I/home/groeck/src/linux-next/tools/include/uapi -I/home/gr=
oeck/src/linux-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch=
/x86/include/uapi -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/=
home/groeck/src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I=
/tmp/linux/tools/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/hom=
e/groeck/src/linux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/=
 -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_C=
OMPARE_AND_SWAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_B=
ARRIER -DHAVE_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS=
_SUPPORT -DHAVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPOR=
T -DHAVE_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DH=
AVE_ELF_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRST=
RNDX_SUPPORT -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE=
 -DHAVE_SDT_EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND=
_DEBUG_FRAME -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG=
_SUPPORT -DHAVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT =
-DHAVE_LIBPYTHON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPOR=
T -DHAVE_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_L=
IBNUMA_SUPPORT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI=
_CMLR -I/tmp/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DPIC -I/usr/lib=
/jvm/java-1.8.0-openjdk-amd64/include -I/usr/lib/jvm/java-1.8.0-openjdk-amd=
64/include/linux -c -o /tmp/linux/tools/perf/jvmti/libjvmti.o jvmti/libjvmt=
i.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/pmu-events/.jevents.o.d -Wp,-MT,/tmp/li=
nux/tools/perf/pmu-events/jevents.o -Wall -Wmissing-prototypes -Wstrict-pro=
totypes -O2 -fomit-frame-pointer -std=3Dgnu89   -D"BUILD_STR(s)=3D#s" -I/ho=
me/groeck/src/linux-next/tools/include  -c -o /tmp/linux/tools/perf/pmu-eve=
nts/jevents.o pmu-events/jevents.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/fs/.fs.o.d -Wp,-MT,/tmp/linux/tools/per=
f/fs/fs.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wn=
ested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredunda=
nt-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite=
-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra -std=
=3Dgnu99 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFS=
ET_BITS=3D64 -I/home/groeck/src/linux-next/tools/lib/api -I/home/groeck/src=
/linux-next/tools/include -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf=
/fs/fs.o fs/fs.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/jvmti/.jvmti_agent.o.d -Wp,-MT,/tmp/lin=
ux/tools/perf/jvmti/jvmti_agent.o -Wbad-function-cast -Wdeclaration-after-s=
tatement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-prototypes -W=
nested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredund=
ant-decls -Wswitch-default -Wswitch-enum -Wundef -Wformat -Wstrict-aliasing=
=3D3 -Wshadow -DHAVE_ARCH_X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/i=
nclude/generated -DHAVE_SYSCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHA=
VE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggd=
b3 -funwind-tables -Wall -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOUR=
CE=3D2 -I/home/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/=
src/linux-next/tools/perf/util/include -I/home/groeck/src/linux-next/tools/=
perf/arch/x86/include -I/home/groeck/src/linux-next/tools/include/uapi -I/h=
ome/groeck/src/linux-next/tools/include/ -I/home/groeck/src/linux-next/tool=
s/arch/x86/include/uapi -I/home/groeck/src/linux-next/tools/arch/x86/includ=
e/ -I/home/groeck/src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//u=
til -I/tmp/linux/tools/perf/ -I/home/groeck/src/linux-next/tools/perf/util =
-I/home/groeck/src/linux-next/tools/perf -I/home/groeck/src/linux-next/tool=
s/lib/ -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_=
SYNC_COMPARE_AND_SWAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTH=
READ_BARRIER -DHAVE_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOC=
ATIONS_SUPPORT -DHAVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_=
SUPPORT -DHAVE_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPO=
RT -DHAVE_ELF_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GET=
SHDRSTRNDX_SUPPORT -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PR=
OLOGUE -DHAVE_SDT_EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIB=
UNWIND_DEBUG_FRAME -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE=
_SLANG_SUPPORT -DHAVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SU=
PPORT -DHAVE_LIBPYTHON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_=
SUPPORT -DHAVE_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -D=
HAVE_LIBNUMA_SUPPORT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE=
_JVMTI_CMLR -I/tmp/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DPIC -I/u=
sr/lib/jvm/java-1.8.0-openjdk-amd64/include -I/usr/lib/jvm/java-1.8.0-openj=
dk-amd64/include/linux -c -o /tmp/linux/tools/perf/jvmti/jvmti_agent.o jvmt=
i/jvmti_agent.c
  mkdir -p /tmp/linux/tools/perf/ui/gtk/
  gcc -Wp,-MD,/tmp/linux/tools/perf/ui/gtk/.browser.o.d -Wp,-MT,/tmp/linux/=
tools/perf/ui/gtk/browser.o -Wbad-function-cast -Wdeclaration-after-stateme=
nt -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmiss=
ing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition =
-Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-en=
um -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -DHAVE_A=
RCH_X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include/generated -DHAV=
E_SYSCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REG=
ISTER_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wa=
ll -Wextra -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2 -I/home=
/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/linux-next=
/tools/perf/util/include -I/home/groeck/src/linux-next/tools/perf/arch/x86/=
include -I/home/groeck/src/linux-next/tools/include/uapi -I/home/groeck/src=
/linux-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch/x86/inc=
lude/uapi -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/home/gro=
eck/src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I/tmp/lin=
ux/tools/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/home/groeck=
/src/linux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/ -D_LARG=
EFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_COMPARE_A=
ND_SWAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER -=
DHAVE_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS_SUPPORT=
 -DHAVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE=
_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DHAVE_ELF_=
GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_SUP=
PORT -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAVE_=
SDT_EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_F=
RAME -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT=
 -DHAVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT -DHAVE_L=
IBPYTHON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHAVE=
_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_S=
UPPORT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI_CMLR -I=
/tmp/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DHAVE_GTK_INFO_BAR_SUPP=
ORT -pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/inc=
lude -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango=
-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I=
/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12=
 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 =
-I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr=
/include/freetype2 -c -o /tmp/linux/tools/perf/ui/gtk/browser.o ui/gtk/brow=
ser.c
  mkdir -p /tmp/linux/tools/perf/fs/
  gcc -Wp,-MD,/tmp/linux/tools/perf/.event-parse.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/event-parse.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/too=
ls/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/=
event-parse.o event-parse.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/ui/gtk/.setup.o.d -Wp,-MT,/tmp/linux/to=
ols/perf/ui/gtk/setup.o -Wbad-function-cast -Wdeclaration-after-statement -=
Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-=
prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpa=
cked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -=
Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -DHAVE_ARCH_=
X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include/generated -DHAVE_SY=
SCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REGISTE=
R_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -=
Wextra -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2 -I/home/gro=
eck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/linux-next/too=
ls/perf/util/include -I/home/groeck/src/linux-next/tools/perf/arch/x86/incl=
ude -I/home/groeck/src/linux-next/tools/include/uapi -I/home/groeck/src/lin=
ux-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch/x86/include=
/uapi -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/home/groeck/=
src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I/tmp/linux/t=
ools/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/home/groeck/src=
/linux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/ -D_LARGEFIL=
E64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_COMPARE_AND_S=
WAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER -DHAV=
E_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS_SUPPORT -DH=
AVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SET=
NS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DHAVE_ELF_GETP=
HDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT=
 -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAVE_SDT_=
EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAME=
 -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT -DH=
AVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT -DHAVE_LIBPY=
THON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHAVE_ZLI=
B_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPO=
RT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI_CMLR -I/tmp=
/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DHAVE_GTK_INFO_BAR_SUPPORT =
-pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include=
 -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0=
 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr=
/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/=
usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/u=
sr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/inc=
lude/freetype2 -c -o /tmp/linux/tools/perf/ui/gtk/setup.o ui/gtk/setup.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/fs/.tracing_path.o.d -Wp,-MT,/tmp/linux=
/tools/perf/fs/tracing_path.o -Wbad-function-cast -Wdeclaration-after-state=
ment -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmi=
ssing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definitio=
n -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-=
enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3=
 -Wall -Wextra -std=3Dgnu99 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_=
SOURCE -D_FILE_OFFSET_BITS=3D64 -I/home/groeck/src/linux-next/tools/lib/api=
 -I/home/groeck/src/linux-next/tools/include -D"BUILD_STR(s)=3D#s" -c -o /t=
mp/linux/tools/perf/fs/tracing_path.o fs/tracing_path.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/ui/gtk/.util.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/ui/gtk/util.o -Wbad-function-cast -Wdeclaration-after-statement -Wf=
ormat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-pr=
ototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpack=
ed -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wu=
ndef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -DHAVE_ARCH_X8=
6_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include/generated -DHAVE_SYSC=
ALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REGISTER_=
OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -We=
xtra -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2 -I/home/groec=
k/src/linux-next/tools/perf/lib/include -I/home/groeck/src/linux-next/tools=
/perf/util/include -I/home/groeck/src/linux-next/tools/perf/arch/x86/includ=
e -I/home/groeck/src/linux-next/tools/include/uapi -I/home/groeck/src/linux=
-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch/x86/include/u=
api -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/home/groeck/sr=
c/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I/tmp/linux/too=
ls/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/home/groeck/src/l=
inux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/ -D_LARGEFILE6=
4_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_COMPARE_AND_SWA=
P_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER -DHAVE_=
EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS_SUPPORT -DHAV=
E_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS=
_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DHAVE_ELF_GETPHD=
RNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT -=
DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAVE_SDT_EV=
ENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAME -=
DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT -DHAV=
E_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT -DHAVE_LIBPYTH=
ON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHAVE_ZLIB_=
SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT=
 -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI_CMLR -I/tmp/l=
inux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DHAVE_GTK_INFO_BAR_SUPPORT -p=
thread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include -=
I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0 -=
I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/i=
nclude/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/us=
r/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr=
/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/inclu=
de/freetype2 -c -o /tmp/linux/tools/perf/ui/gtk/util.o ui/gtk/util.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.core.o.d -Wp,-MT,/tmp/linux/tools/perf=
/core.o -g -Wall -Wbad-function-cast -Wdeclaration-after-statement -Wformat=
-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototy=
pes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -W=
redundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef =
-Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC=
 -I/home/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/li=
nux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/x86_64/incl=
ude/ -I/home/groeck/src/linux-next/tools/arch/x86_64/include/uapi -I/home/g=
roeck/src/linux-next/tools/include/uapi -fvisibility=3Dhidden -D"BUILD_STR(=
s)=3D#s" -c -o /tmp/linux/tools/perf/core.o core.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/ui/gtk/.hists.o.d -Wp,-MT,/tmp/linux/to=
ols/perf/ui/gtk/hists.o -Wbad-function-cast -Wdeclaration-after-statement -=
Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-=
prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpa=
cked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -=
Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -DHAVE_ARCH_=
X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include/generated -DHAVE_SY=
SCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REGISTE=
R_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -=
Wextra -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2 -I/home/gro=
eck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/linux-next/too=
ls/perf/util/include -I/home/groeck/src/linux-next/tools/perf/arch/x86/incl=
ude -I/home/groeck/src/linux-next/tools/include/uapi -I/home/groeck/src/lin=
ux-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch/x86/include=
/uapi -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/home/groeck/=
src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I/tmp/linux/t=
ools/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/home/groeck/src=
/linux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/ -D_LARGEFIL=
E64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_COMPARE_AND_S=
WAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER -DHAV=
E_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS_SUPPORT -DH=
AVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SET=
NS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DHAVE_ELF_GETP=
HDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT=
 -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAVE_SDT_=
EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAME=
 -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPORT -DH=
AVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT -DHAVE_LIBPY=
THON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHAVE_ZLI=
B_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPO=
RT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI_CMLR -I/tmp=
/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DHAVE_GTK_INFO_BAR_SUPPORT =
-pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include=
 -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0=
 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr=
/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/=
usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/u=
sr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/inc=
lude/freetype2 -c -o /tmp/linux/tools/perf/ui/gtk/hists.o ui/gtk/hists.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/ui/gtk/.helpline.o.d -Wp,-MT,/tmp/linux=
/tools/perf/ui/gtk/helpline.o -Wbad-function-cast -Wdeclaration-after-state=
ment -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmi=
ssing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definitio=
n -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-=
enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -DHAVE=
_ARCH_X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include/generated -DH=
AVE_SYSCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_R=
EGISTER_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -=
Wall -Wextra -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2 -I/ho=
me/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/linux-ne=
xt/tools/perf/util/include -I/home/groeck/src/linux-next/tools/perf/arch/x8=
6/include -I/home/groeck/src/linux-next/tools/include/uapi -I/home/groeck/s=
rc/linux-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch/x86/i=
nclude/uapi -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/home/g=
roeck/src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I/tmp/l=
inux/tools/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/home/groe=
ck/src/linux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/ -D_LA=
RGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_COMPARE=
_AND_SWAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER=
 -DHAVE_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS_SUPPO=
RT -DHAVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHA=
VE_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DHAVE_EL=
F_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_S=
UPPORT -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAV=
E_SDT_EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG=
_FRAME -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPO=
RT -DHAVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT -DHAVE=
_LIBPYTHON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHA=
VE_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA=
_SUPPORT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI_CMLR =
-I/tmp/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DHAVE_GTK_INFO_BAR_SU=
PPORT -pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/i=
nclude -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pan=
go-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 =
-I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng=
12 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.=
0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/u=
sr/include/freetype2 -c -o /tmp/linux/tools/perf/ui/gtk/helpline.o ui/gtk/h=
elpline.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_jbd2.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/plugin_jbd2.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/too=
ls/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/=
plugin_jbd2.o plugin_jbd2.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.str_error_r.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/str_error_r.o -Wbad-function-cast -Wdeclaration-after-statement -Wf=
ormat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-pr=
ototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpack=
ed -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wu=
ndef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -=
Wextra -std=3Dgnu99 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_SOURCE -=
D_FILE_OFFSET_BITS=3D64 -I/home/groeck/src/linux-next/tools/lib/api -I/home=
/groeck/src/linux-next/tools/include -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux=
/tools/perf/str_error_r.o ../str_error_r.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/ui/gtk/.progress.o.d -Wp,-MT,/tmp/linux=
/tools/perf/ui/gtk/progress.o -Wbad-function-cast -Wdeclaration-after-state=
ment -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmi=
ssing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definitio=
n -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-=
enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -DHAVE=
_ARCH_X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include/generated -DH=
AVE_SYSCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_R=
EGISTER_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -=
Wall -Wextra -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2 -I/ho=
me/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/linux-ne=
xt/tools/perf/util/include -I/home/groeck/src/linux-next/tools/perf/arch/x8=
6/include -I/home/groeck/src/linux-next/tools/include/uapi -I/home/groeck/s=
rc/linux-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch/x86/i=
nclude/uapi -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/home/g=
roeck/src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I/tmp/l=
inux/tools/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/home/groe=
ck/src/linux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/ -D_LA=
RGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_COMPARE=
_AND_SWAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER=
 -DHAVE_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS_SUPPO=
RT -DHAVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHA=
VE_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DHAVE_EL=
F_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_S=
UPPORT -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAV=
E_SDT_EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG=
_FRAME -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPO=
RT -DHAVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT -DHAVE=
_LIBPYTHON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHA=
VE_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA=
_SUPPORT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI_CMLR =
-I/tmp/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DHAVE_GTK_INFO_BAR_SU=
PPORT -pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/i=
nclude -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pan=
go-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 =
-I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng=
12 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.=
0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/u=
sr/include/freetype2 -c -o /tmp/linux/tools/perf/ui/gtk/progress.o ui/gtk/p=
rogress.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.event-plugin.o.d -Wp,-MT,/tmp/linux/to=
ols/perf/event-plugin.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/t=
ools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/per=
f/event-plugin.o event-plugin.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.cpumap.o.d -Wp,-MT,/tmp/linux/tools/pe=
rf/cpumap.o -g -Wall -Wbad-function-cast -Wdeclaration-after-statement -Wfo=
rmat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-pro=
totypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacke=
d -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wun=
def -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -=
fPIC -I/home/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/sr=
c/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/x86_64/=
include/ -I/home/groeck/src/linux-next/tools/arch/x86_64/include/uapi -I/ho=
me/groeck/src/linux-next/tools/include/uapi -fvisibility=3Dhidden -D"BUILD_=
STR(s)=3D#s" -c -o /tmp/linux/tools/perf/cpumap.o cpumap.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.libbpf.o.d -Wp,-MT,/tmp/linux/tools/pe=
rf/libbpf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY =
-Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wforma=
t-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-exte=
rns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -=
Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -=
Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/groe=
ck/src/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/x8=
6_64/include/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvisibi=
lity=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/libbpf.o li=
bbpf.c
   ld   -r -o /tmp/linux/tools/perf/fd/libapi-in.o  /tmp/linux/tools/perf/f=
d/array.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/ui/gtk/.annotate.o.d -Wp,-MT,/tmp/linux=
/tools/perf/ui/gtk/annotate.o -Wbad-function-cast -Wdeclaration-after-state=
ment -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmi=
ssing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definitio=
n -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-=
enum -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -DHAVE=
_ARCH_X86_64_SUPPORT -I/tmp/linux/tools/perf/arch/x86/include/generated -DH=
AVE_SYSCALL_TABLE_SUPPORT -DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_R=
EGISTER_OFFSET -Werror -O6 -fno-omit-frame-pointer -ggdb3 -funwind-tables -=
Wall -Wextra -std=3Dgnu99 -fstack-protector-all -D_FORTIFY_SOURCE=3D2 -I/ho=
me/groeck/src/linux-next/tools/perf/lib/include -I/home/groeck/src/linux-ne=
xt/tools/perf/util/include -I/home/groeck/src/linux-next/tools/perf/arch/x8=
6/include -I/home/groeck/src/linux-next/tools/include/uapi -I/home/groeck/s=
rc/linux-next/tools/include/ -I/home/groeck/src/linux-next/tools/arch/x86/i=
nclude/uapi -I/home/groeck/src/linux-next/tools/arch/x86/include/ -I/home/g=
roeck/src/linux-next/tools/arch/x86/ -I/tmp/linux/tools/perf//util -I/tmp/l=
inux/tools/perf/ -I/home/groeck/src/linux-next/tools/perf/util -I/home/groe=
ck/src/linux-next/tools/perf -I/home/groeck/src/linux-next/tools/lib/ -D_LA=
RGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -DHAVE_SYNC_COMPARE=
_AND_SWAP_SUPPORT -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER=
 -DHAVE_EVENTFD -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_DWARF_GETLOCATIONS_SUPPO=
RT -DHAVE_GLIBC_SUPPORT -DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHA=
VE_SETNS_SUPPORT -DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT -DHAVE_EL=
F_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_S=
UPPORT -DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAV=
E_SDT_EVENT -DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG=
_FRAME -DHAVE_LIBUNWIND_SUPPORT -DHAVE_LIBCRYPTO_SUPPORT -DHAVE_SLANG_SUPPO=
RT -DHAVE_GTK2_SUPPORT -DHAVE_LIBPERL_SUPPORT -DHAVE_TIMERFD_SUPPORT -DHAVE=
_LIBPYTHON_SUPPORT -DHAVE_CPLUS_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHA=
VE_ZLIB_SUPPORT -DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA=
_SUPPORT -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -DHAVE_JVMTI_CMLR =
-I/tmp/linux/tools/perf/ -D"BUILD_STR(s)=3D#s" -fPIC -DHAVE_GTK_INFO_BAR_SU=
PPORT -pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/i=
nclude -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pan=
go-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 =
-I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng=
12 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.=
0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/u=
sr/include/freetype2 -c -o /tmp/linux/tools/perf/ui/gtk/annotate.o ui/gtk/a=
nnotate.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.trace-seq.o.d -Wp,-MT,/tmp/linux/tools=
/perf/trace-seq.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/tools/i=
nclude -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/trac=
e-seq.o trace-seq.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.bpf.o.d -Wp,-MT,/tmp/linux/tools/perf/=
bpf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY -Wbad-=
function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k =
-Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -W=
no-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstric=
t-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wforma=
t -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/groeck/src=
/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/x86_64/i=
nclude/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvisibility=
=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/bpf.o bpf.c
   ld   -r -o /tmp/linux/tools/perf/plugin_jbd2-in.o  /tmp/linux/tools/perf=
/plugin_jbd2.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.nlattr.o.d -Wp,-MT,/tmp/linux/tools/pe=
rf/nlattr.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY =
-Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wforma=
t-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-exte=
rns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -=
Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -=
Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/groe=
ck/src/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/x8=
6_64/include/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvisibi=
lity=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/nlattr.o nl=
attr.c
In file included from /home/groeck/src/linux-next/tools/include/asm/atomic.=
h:6:0,
                 from /home/groeck/src/linux-next/tools/include/linux/atomi=
c.h:5,
                 from /home/groeck/src/linux-next/tools/include/linux/refco=
unt.h:41,
                 from cpumap.c:4:
/home/groeck/src/linux-next/tools/include/asm/../../arch/x86/include/asm/at=
omic.h:11:10: fatal error: asm/cmpxchg.h: No such file or directory
 #include <asm/cmpxchg.h>
          ^~~~~~~~~~~~~~~
compilation terminated.
  gcc -Wp,-MD,/tmp/linux/tools/perf/.btf.o.d -Wp,-MT,/tmp/linux/tools/perf/=
btf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY -Wbad-=
function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k =
-Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -W=
no-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstric=
t-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wforma=
t -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/groeck/src=
/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/x86_64/i=
nclude/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvisibility=
=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/btf.o btf.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.parse-filter.o.d -Wp,-MT,/tmp/linux/to=
ols/perf/parse-filter.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/t=
ools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/per=
f/parse-filter.o parse-filter.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_hrtimer.o.d -Wp,-MT,/tmp/linux/=
tools/perf/plugin_hrtimer.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-ne=
xt/tools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools=
/perf/plugin_hrtimer.o plugin_hrtimer.c
mv: cannot stat '/tmp/linux/tools/perf/.cpumap.o.tmp': No such file or dire=
ctory
/home/groeck/src/linux-next/tools/build/Makefile.build:96: recipe for targe=
t '/tmp/linux/tools/perf/cpumap.o' failed
make[7]: *** [/tmp/linux/tools/perf/cpumap.o] Error 1
Makefile:92: recipe for target '/tmp/linux/tools/perf/libperf-in.o' failed
make[6]: *** [/tmp/linux/tools/perf/libperf-in.o] Error 2
Makefile.perf:762: recipe for target '/tmp/linux/tools/perf/libperf.a' fail=
ed
make[5]: *** [/tmp/linux/tools/perf/libperf.a] Error 2
make[5]: *** Waiting for unfinished jobs....
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_kmem.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/plugin_kmem.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/too=
ls/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/=
plugin_kmem.o plugin_kmem.c
   ld   -r -o /tmp/linux/tools/perf/fs/libapi-in.o  /tmp/linux/tools/perf/f=
s/fs.o /tmp/linux/tools/perf/fs/tracing_path.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_kvm.o.d -Wp,-MT,/tmp/linux/tool=
s/perf/plugin_kvm.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/tools=
/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/pl=
ugin_kvm.o plugin_kvm.c
   ld   -r -o /tmp/linux/tools/perf/libapi-in.o  /tmp/linux/tools/perf/fd/l=
ibapi-in.o /tmp/linux/tools/perf/fs/libapi-in.o /tmp/linux/tools/perf/cpu.o=
 /tmp/linux/tools/perf/debug.o /tmp/linux/tools/perf/str_error_r.o
rm -f /tmp/linux/tools/perf/libapi.a && ar rcs /tmp/linux/tools/perf/libapi=
=2Ea /tmp/linux/tools/perf/libapi-in.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.help.o.d -Wp,-MT,/tmp/linux/tools/perf=
/help.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security=
 -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnes=
ted-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant=
-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-s=
trings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra -std=3D=
gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -fPIC -O6 -Werror -D_LARGEFIL=
E64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/home/groeck/src/linux-=
next/tools/include/ -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/help.=
o help.c
   ld   -r -o /tmp/linux/tools/perf/plugin_hrtimer-in.o  /tmp/linux/tools/p=
erf/plugin_hrtimer.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.parse-utils.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/parse-utils.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/too=
ls/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/=
parse-utils.o parse-utils.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.libbpf_errno.o.d -Wp,-MT,/tmp/linux/to=
ols/perf/libbpf_errno.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_R=
EALLOCARRAY -Wbad-function-cast -Wdeclaration-after-statement -Wformat-secu=
rity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -=
Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredun=
dant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwri=
te-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. =
-I/home/groeck/src/linux-next/tools/include -I/home/groeck/src/linux-next/t=
ools/arch/x86_64/include/uapi -I/home/groeck/src/linux-next/tools/include/u=
api -fvisibility=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf=
/libbpf_errno.o libbpf_errno.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.kbuffer-parse.o.d -Wp,-MT,/tmp/linux/t=
ools/perf/kbuffer-parse.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next=
/tools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/p=
erf/kbuffer-parse.o kbuffer-parse.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_mac80211.o.d -Wp,-MT,/tmp/linux=
/tools/perf/plugin_mac80211.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-=
next/tools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/too=
ls/perf/plugin_mac80211.o plugin_mac80211.c
   ld   -r -o /tmp/linux/tools/perf/plugin_kmem-in.o  /tmp/linux/tools/perf=
/plugin_kmem.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.tep_strerror.o.d -Wp,-MT,/tmp/linux/to=
ols/perf/tep_strerror.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/t=
ools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/per=
f/tep_strerror.o tep_strerror.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.str_error.o.d -Wp,-MT,/tmp/linux/tools=
/perf/str_error.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOC=
ARRAY -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -=
Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wneste=
d-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-d=
ecls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-str=
ings -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/hom=
e/groeck/src/linux-next/tools/include -I/home/groeck/src/linux-next/tools/a=
rch/x86_64/include/uapi -I/home/groeck/src/linux-next/tools/include/uapi -f=
visibility=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/str_e=
rror.o str_error.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.pager.o.d -Wp,-MT,/tmp/linux/tools/per=
f/pager.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wn=
ested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredunda=
nt-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite=
-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra -std=
=3Dgnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -fPIC -O6 -Werror -D_LARGE=
FILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/home/groeck/src/lin=
ux-next/tools/include/ -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/pa=
ger.o pager.c
   ld   -r -o /tmp/linux/tools/perf/plugin_kvm-in.o  /tmp/linux/tools/perf/=
plugin_kvm.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.parse-options.o.d -Wp,-MT,/tmp/linux/t=
ools/perf/parse-options.o -Wbad-function-cast -Wdeclaration-after-statement=
 -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissin=
g-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -W=
packed -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum=
 -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wa=
ll -Wextra -std=3Dgnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -fPIC -O6 -=
Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/home=
/groeck/src/linux-next/tools/include/ -D"BUILD_STR(s)=3D#s" -c -o /tmp/linu=
x/tools/perf/parse-options.o parse-options.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.run-command.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/run-command.o -Wbad-function-cast -Wdeclaration-after-statement -Wf=
ormat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-pr=
ototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpack=
ed -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wu=
ndef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -=
Wextra -std=3Dgnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -fPIC -O6 -Werr=
or -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/home/gro=
eck/src/linux-next/tools/include/ -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/to=
ols/perf/run-command.o run-command.c
   ld   -r -o /tmp/linux/tools/perf/plugin_mac80211-in.o  /tmp/linux/tools/=
perf/plugin_mac80211.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.sigchain.o.d -Wp,-MT,/tmp/linux/tools/=
perf/sigchain.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-=
security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototyp=
es -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wr=
edundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -=
Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra=
 -std=3Dgnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -fPIC -O6 -Werror -D_=
LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/home/groeck/sr=
c/linux-next/tools/include/ -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/pe=
rf/sigchain.o sigchain.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_sched_switch.o.d -Wp,-MT,/tmp/l=
inux/tools/perf/plugin_sched_switch.o -g -Wall -fPIC -I. -I /home/groeck/sr=
c/linux-next/tools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/l=
inux/tools/perf/plugin_sched_switch.o plugin_sched_switch.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.event-parse-api.o.d -Wp,-MT,/tmp/linux=
/tools/perf/event-parse-api.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-=
next/tools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/too=
ls/perf/event-parse-api.o event-parse-api.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_function.o.d -Wp,-MT,/tmp/linux=
/tools/perf/plugin_function.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-=
next/tools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/too=
ls/perf/plugin_function.o plugin_function.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.netlink.o.d -Wp,-MT,/tmp/linux/tools/p=
erf/netlink.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRA=
Y -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wfor=
mat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-ex=
terns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls=
 -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings=
 -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/gr=
oeck/src/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/=
x86_64/include/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvisi=
bility=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/netlink.o=
 netlink.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_xen.o.d -Wp,-MT,/tmp/linux/tool=
s/perf/plugin_xen.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/tools=
/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/pl=
ugin_xen.o plugin_xen.c
   ld   -r -o /tmp/linux/tools/perf/plugin_sched_switch-in.o  /tmp/linux/to=
ols/perf/plugin_sched_switch.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_scsi.o.d -Wp,-MT,/tmp/linux/too=
ls/perf/plugin_scsi.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-next/too=
ls/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/=
plugin_scsi.o plugin_scsi.c
   ld   -r -o /tmp/linux/tools/perf/plugin_function-in.o  /tmp/linux/tools/=
perf/plugin_function.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.bpf_prog_linfo.o.d -Wp,-MT,/tmp/linux/=
tools/perf/bpf_prog_linfo.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NE=
ED_REALLOCARRAY -Wbad-function-cast -Wdeclaration-after-statement -Wformat-=
security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototyp=
es -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wr=
edundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -=
Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC =
-I. -I/home/groeck/src/linux-next/tools/include -I/home/groeck/src/linux-ne=
xt/tools/arch/x86_64/include/uapi -I/home/groeck/src/linux-next/tools/inclu=
de/uapi -fvisibility=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/=
perf/bpf_prog_linfo.o bpf_prog_linfo.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.subcmd-config.o.d -Wp,-MT,/tmp/linux/t=
ools/perf/subcmd-config.o -Wbad-function-cast -Wdeclaration-after-statement=
 -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissin=
g-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -W=
packed -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum=
 -Wundef -Wwrite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wa=
ll -Wextra -std=3Dgnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -fPIC -O6 -=
Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I/home=
/groeck/src/linux-next/tools/include/ -D"BUILD_STR(s)=3D#s" -c -o /tmp/linu=
x/tools/perf/subcmd-config.o subcmd-config.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.libbpf_probes.o.d -Wp,-MT,/tmp/linux/t=
ools/perf/libbpf_probes.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED=
_REALLOCARRAY -Wbad-function-cast -Wdeclaration-after-statement -Wformat-se=
curity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes=
 -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wred=
undant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Ww=
rite-strings -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I=
=2E -I/home/groeck/src/linux-next/tools/include -I/home/groeck/src/linux-ne=
xt/tools/arch/x86_64/include/uapi -I/home/groeck/src/linux-next/tools/inclu=
de/uapi -fvisibility=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/=
perf/libbpf_probes.o libbpf_probes.c
   ld   -r -o /tmp/linux/tools/perf/jvmti/jvmti-in.o  /tmp/linux/tools/perf=
/jvmti/libjvmti.o /tmp/linux/tools/perf/jvmti/jvmti_agent.o
   ld   -r -o /tmp/linux/tools/perf/plugin_xen-in.o  /tmp/linux/tools/perf/=
plugin_xen.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.xsk.o.d -Wp,-MT,/tmp/linux/tools/perf/=
xsk.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY -Wbad-=
function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k =
-Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -W=
no-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstric=
t-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wforma=
t -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/groeck/src=
/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/x86_64/i=
nclude/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvisibility=
=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/xsk.o xsk.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.hashmap.o.d -Wp,-MT,/tmp/linux/tools/p=
erf/hashmap.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRA=
Y -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wfor=
mat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-ex=
terns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls=
 -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings=
 -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/gr=
oeck/src/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arch/=
x86_64/include/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvisi=
bility=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/hashmap.o=
 hashmap.c
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_jbd2.so /tmp/linux/tools/perf/plugin_jbd2-in.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_hrtimer.so /tmp/linux/tools/perf/plugin_hrtimer-in.o
  gcc -Wp,-MD,/tmp/linux/tools/perf/.btf_dump.o.d -Wp,-MT,/tmp/linux/tools/=
perf/btf_dump.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCAR=
RAY -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wf=
ormat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-=
externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-dec=
ls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strin=
gs -Wformat -Wstrict-aliasing=3D3 -Wshadow -Werror -Wall -fPIC -I. -I/home/=
groeck/src/linux-next/tools/include -I/home/groeck/src/linux-next/tools/arc=
h/x86_64/include/uapi -I/home/groeck/src/linux-next/tools/include/uapi -fvi=
sibility=3Dhidden -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/tools/perf/btf_dum=
p.o btf_dump.c
  gcc -Wp,-MD,/tmp/linux/tools/perf/.plugin_cfg80211.o.d -Wp,-MT,/tmp/linux=
/tools/perf/plugin_cfg80211.o -g -Wall -fPIC -I. -I /home/groeck/src/linux-=
next/tools/include -D_GNU_SOURCE -D"BUILD_STR(s)=3D#s" -c -o /tmp/linux/too=
ls/perf/plugin_cfg80211.o plugin_cfg80211.c
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_kmem.so /tmp/linux/tools/perf/plugin_kmem-in.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_kvm.so /tmp/linux/tools/perf/plugin_kvm-in.o
   ld   -r -o /tmp/linux/tools/perf/plugin_scsi-in.o  /tmp/linux/tools/perf=
/plugin_scsi.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_mac80211.so /tmp/linux/tools/perf/plugin_mac80211-i=
n.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_sched_switch.so /tmp/linux/tools/perf/plugin_sched_=
switch-in.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_function.so /tmp/linux/tools/perf/plugin_function-i=
n.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_xen.so /tmp/linux/tools/perf/plugin_xen-in.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_scsi.so /tmp/linux/tools/perf/plugin_scsi-in.o
   ld   -r -o /tmp/linux/tools/perf/plugin_cfg80211-in.o  /tmp/linux/tools/=
perf/plugin_cfg80211.o
gcc -g -Wall -fPIC  -I. -I /home/groeck/src/linux-next/tools/include    -D_=
GNU_SOURCE -shared -Wl,-z,noexecstack  -lunwind-x86_64 -lunwind -llzma  -Wl=
,-E -fstack-protector-strong -L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/p=
erl/5.22/CORE -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -Xlin=
ker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -nostartfiles -o /tmp/=
linux/tools/perf/plugin_cfg80211.so /tmp/linux/tools/perf/plugin_cfg80211-i=
n.o
   ld -r -o /tmp/linux/tools/perf/pmu-events/jevents-in.o  /tmp/linux/tools=
/perf/pmu-events/json.o /tmp/linux/tools/perf/pmu-events/jsmn.o /tmp/linux/=
tools/perf/pmu-events/jevents.o
   ld   -r -o /tmp/linux/tools/perf/libtraceevent-in.o  /tmp/linux/tools/pe=
rf/event-parse.o /tmp/linux/tools/perf/event-plugin.o /tmp/linux/tools/perf=
/trace-seq.o /tmp/linux/tools/perf/parse-filter.o /tmp/linux/tools/perf/par=
se-utils.o /tmp/linux/tools/perf/kbuffer-parse.o /tmp/linux/tools/perf/tep_=
strerror.o /tmp/linux/tools/perf/event-parse-api.o
rm -f /tmp/linux/tools/perf/libtraceevent.a; ar rcs /tmp/linux/tools/perf/l=
ibtraceevent.a /tmp/linux/tools/perf/libtraceevent-in.o
   ld   -r -o /tmp/linux/tools/perf/libbpf-in.o  /tmp/linux/tools/perf/libb=
pf.o /tmp/linux/tools/perf/bpf.o /tmp/linux/tools/perf/nlattr.o /tmp/linux/=
tools/perf/btf.o /tmp/linux/tools/perf/libbpf_errno.o /tmp/linux/tools/perf=
/str_error.o /tmp/linux/tools/perf/netlink.o /tmp/linux/tools/perf/bpf_prog=
_linfo.o /tmp/linux/tools/perf/libbpf_probes.o /tmp/linux/tools/perf/xsk.o =
/tmp/linux/tools/perf/hashmap.o /tmp/linux/tools/perf/btf_dump.o
rm -f /tmp/linux/tools/perf/libbpf.a; ar rcs /tmp/linux/tools/perf/libbpf.a=
 /tmp/linux/tools/perf/libbpf-in.o
   ld   -r -o /tmp/linux/tools/perf/libsubcmd-in.o  /tmp/linux/tools/perf/e=
xec-cmd.o /tmp/linux/tools/perf/help.o /tmp/linux/tools/perf/pager.o /tmp/l=
inux/tools/perf/parse-options.o /tmp/linux/tools/perf/run-command.o /tmp/li=
nux/tools/perf/sigchain.o /tmp/linux/tools/perf/subcmd-config.o
rm -f /tmp/linux/tools/perf/libsubcmd.a && ar rcs /tmp/linux/tools/perf/lib=
subcmd.a /tmp/linux/tools/perf/libsubcmd-in.o
   ld   -r -o /tmp/linux/tools/perf/ui/gtk/gtk-in.o  /tmp/linux/tools/perf/=
ui/gtk/browser.o /tmp/linux/tools/perf/ui/gtk/hists.o /tmp/linux/tools/perf=
/ui/gtk/setup.o /tmp/linux/tools/perf/ui/gtk/util.o /tmp/linux/tools/perf/u=
i/gtk/helpline.o /tmp/linux/tools/perf/ui/gtk/progress.o /tmp/linux/tools/p=
erf/ui/gtk/annotate.o
   ld   -r -o /tmp/linux/tools/perf/gtk-in.o  /tmp/linux/tools/perf/ui/gtk/=
gtk-in.o
  PERF_VERSION =3D 5.3.rc4.g0c3d3d648b3e
touch /tmp/linux/tools/perf/PERF-VERSION-FILE
Makefile.perf:218: recipe for target 'sub-make' failed
make[4]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make[3]: *** [all] Error 2
Makefile:80: recipe for target 'perf' failed
make[2]: *** [perf] Error 2
/home/groeck/src/linux-next/Makefile:1756: recipe for target 'tools/perf' f=
ailed
make[1]: *** [tools/perf] Error 2
make[1]: Leaving directory '/tmp/linux'
Makefile:179: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2
