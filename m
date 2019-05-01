Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C2EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8E021743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfEAOKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:10:11 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:6556 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfEAOKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:10:10 -0400
Subject: Re: perf build broken in 5.1-rc7
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Song Liu <liu.song.a23@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
 <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
 <CAPhsuW7dS9TXOAW--U2q9-zmsgS4_K+uZYLnbPra+r+2LjJKDQ@mail.gmail.com>
 <b773df70-58e6-69f8-d566-282b0f7ae579@mageia.org>
 <20190501130751.GB21436@kernel.org>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <932c4e06-c4db-7bb8-769d-75651d092450@mageia.org>
Date:   Wed, 1 May 2019 17:09:59 +0300
MIME-Version: 1.0
In-Reply-To: <20190501130751.GB21436@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C020A.5CC9A8BA.003E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 01-05-2019 kl. 16:07, skrev Arnaldo Carvalho de Melo:
> Em Tue, Apr 30, 2019 at 04:31:14PM +0300, Thomas Backlund escreveu:
>> Den 30-04-2019 kl. 16:06, skrev Song Liu:
>>> On Tue, Apr 30, 2019 at 12:55 AM Thomas Backlund <tmb@mageia.org> wrote:
>>>> Den 30-04-2019 kl. 10:26, skrev Thomas Backlund:
>>>>> Building perf in 5.1-rc5/6/7 fails:
>>>>> Build start:
>>>>>     make -s -C tools/perf NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1
>>>>> WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_STRLCPY=1
>>>>> NO_BIONIC=1 NO_JVMTI=1 prefix=/usr lib=lib64 all
>>>>>      BUILD:   Doing 'make -j32' parallel build
>>>>>      HOSTCC   fixdep.o
>>>>>      HOSTLD   fixdep-in.o
>>>>>      LINK     fixdep
>>>>> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h'
>>>>> differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
>>>>> diff -u tools/arch/x86/include/uapi/asm/vmx.h
>>>>> arch/x86/include/uapi/asm/vmx.h
>>>>>
>>>>> Auto-detecting system features:
>>>>> ...                         dwarf: [ on  ]
>>>>> ...            dwarf_getlocations: [ on  ]
>>>>> ...                         glibc: [ on  ]
>>>>> ...                          gtk2: [ on  ]
>>>>> ...                      libaudit: [ on  ]
>>>>> ...                        libbfd: [ on  ]
>>>>> ...                        libelf: [ on  ]
>>>>> ...                       libnuma: [ on  ]
>>>>> ...        numa_num_possible_cpus: [ on  ]
>>>>> ...                       libperl: [ on  ]
>>>>> ...                     libpython: [ on  ]
>>>>> ...                      libslang: [ on  ]
>>>>> ...                     libcrypto: [ on  ]
>>>>> ...                     libunwind: [ on  ]
>>>>> ...            libdw-dwarf-unwind: [ on  ]
>>>>> ...                          zlib: [ on  ]
>>>>> ...                          lzma: [ on  ]
>>>>> ...                     get_cpuid: [ on  ]
>>>>> ...                           bpf: [ on  ]
>>>>> ...                        libaio: [ on  ]
>>>>> ...        disassembler-four-args: [ OFF ]
>>>>>
>>>>> Makefile.config:473: No sys/sdt.h found, no SDT events are defined,
>>>>> please install systemtap-sdt-devel or systemtap-sdt-dev
>>>>> Makefile.config:853: No libbabeltrace found, disables 'perf data' CTF
>>>>> format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
>>>>>
>>>>>
>>>>> And breaks with:
>>>>>
>>>>>
>>>>> CC       ui/setup.o
>>>>> util/annotate.c: In function 'symbol__disassemble_bpf':
>>>>> util/annotate.c:1767:29: error: incompatible type for argument 1 of
>>>>> 'disassembler'
>>>>>      disassemble = disassembler(bfdf);
>>>>>                                 ^~~~
>>>>> In file included from util/annotate.c:1689:
>>>>> /usr/include/dis-asm.h:325:63: note: expected 'enum bfd_architecture'
>>>>> but argument is of type 'bfd *' {aka 'struct bfd *'}
>>>>>     extern disassembler_ftype disassembler (enum bfd_architecture arc,
>>>>>                                             ~~~~~~~~~~~~~~~~~~~~~~^~~
>>>>> util/annotate.c:1767:16: error: too few arguments to function
>>>>> 'disassembler'
>>>>>      disassemble = disassembler(bfdf);
>>>>>                    ^~~~~~~~~~~~
>>>>> In file included from util/annotate.c:1689:
>>>>> /usr/include/dis-asm.h:325:27: note: declared here
>>>>>     extern disassembler_ftype disassembler (enum bfd_architecture arc,
>>>>>                               ^~~~~~~~~~~~
>>>>>      CC       arch/x86/util/header.o
>>>>>      CC       arch/x86/util/tsc.o
>>>>>      CC       arch/x86/util/pmu.o
>>>>> mv: cannot stat 'util/.annotate.o.tmp': No such file or directory
>>>>>      CC       bench/futex-requeue.o
>>>>>      CC       arch/x86/util/kvm-stat.o
>>>>> make[4]: ***
>>>>> [/work/rpmbuild/BUILD/kernel-x86_64/linux-5.0/tools/build/Makefile.build:97:
>>>>> util/annotate.o] Error 1
>>>>> make[4]: *** Waiting for unfinished jobs....
>>>>>      CC       util/build-id.o
>>>>>
>>>>>
>>>>>
>>>> And I forgot...
>>>>
>>>> Reverting:
>>>>    From 6987561c9e86eace45f2dbb0c564964a63f4150a Mon Sep 17 00:00:00 2001
>>>> From: Song Liu <songliubraving@fb.com>
>>>> Date: Mon, 11 Mar 2019 22:30:48 -0700
>>>> Subject: perf annotate: Enable annotation of BPF programs
>>>>
>>>> Makes it build again.
>>>>
>>>> --
>>>> Thomas
>>>>
>>> Hi Thomas,
>>>
>>> Which system are you running this test on? I would like to repro it in a VM.
>>>
>>> Thanks,
>>> Song
>>
>> Mageia Cauldron currently stabilizing to become Mageia 7 in ~1 month.
>>
>>
>> Basesystem is:
>>
>> binutils-2.32-5.mga7
>> (includes all fixes from upstream binutils-2_32-branch)
>>
>> gcc-8.3.1-0.20190419.2.mga7
>>
>> glibc-2.29-7.mga7
>> (includes all fixes from upstream glibc release/2.29/master branch up to
>> 2019-04-15 for now)
>>
>>
>> kernel-desktop-5.1.0-0.rc7.1.mga7
>> kernel-userspace-headers-5.1.0-0.rc7.1.mga7
> Ok, so the steps are:
>
> 1) the feature test, the small C program that we try to build is:
>
> [acme@quaco perf]$ cat tools/build/feature/test-disassembler-four-args.c
> // SPDX-License-Identifier: GPL-2.0
> #include <bfd.h>
> #include <dis-asm.h>
>
> int main(void)
> {
> 	bfd *abfd = bfd_openr(NULL, NULL);
>
> 	disassembler(bfd_get_arch(abfd),
> 		     bfd_big_endian(abfd),
> 		     bfd_get_mach(abfd),
> 		     abfd);
>
> 	return 0;
> }
> [acme@quaco perf]$
>
> And here in my fedora29 system it ends up producing the following file,
> when built with:
>
> $ make O=/tmp/build/perf  -C tools/perf install-bin
>
> [acme@quaco perf]$ cat /tmp/build/perf/feature/test-disassembler-four-args.make.output
> [acme@quaco perf]$
> [acme@quaco perf]$ file /tmp/build/perf/feature/test-disassembler-four-args.bin
> /tmp/build/perf/feature/test-disassembler-four-args.bin: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=c9bd83db766a620c5cb6d756b0cd6991527641ff, not stripped, too many notes (256)
> [acme@quaco perf]$ ldd /tmp/build/perf/feature/test-disassembler-four-args.bin
> 	linux-vdso.so.1 (0x00007ffebc5f9000)
> 	libz.so.1 => /lib64/libz.so.1 (0x00007fed2da04000)
> 	libdl.so.2 => /lib64/libdl.so.2 (0x00007fed2d9fe000)
> 	libc.so.6 => /lib64/libc.so.6 (0x00007fed2d838000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007fed2da3e000)
> [acme@quaco perf]$
>
> Meaning it built properly, so in this sytem the disassembler() function
> has indeed four args, so we end up with:
>
> [acme@quaco perf]$ grep disassembler /tmp/build/perf/FEATURE-DUMP
> feature-disassembler-four-args=1
> [acme@quaco perf]$
>
> Can you check the output for
> /tmp/build/perf/feature/test-disassembler-four-args.make.output in your
> system? And also check what is the prototype for the disassembler()
> routine on mageia7?


I guess this is what fails the test:

cat /tmp/build/perf/feature/test-disassembler-four-args.make.output
/usr/bin/ld: /usr/lib64/libbfd.a(plugin.o): in function `try_load_plugin':
/home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:243: 
undefined reference to `dlopen'
/usr/bin/ld: 
/home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:271: 
undefined reference to `dlsym'
/usr/bin/ld: 
/home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:256: 
undefined reference to `dlclose'
/usr/bin/ld: 
/home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:246: 
undefined reference to `dlerror'


as we allow dynamic linking and loading

And we use linker flags:

rpm --eval %ldflags
  -Wl,--as-needed -Wl,--no-undefined -Wl,-z,relro -Wl,-O1 -Wl,--build-id 
-Wl,--enable-new-dtags

So it reports:

  disassembler-four-args: [ OFF ]

And falls back to one single command.

> Here I have:
>
> [acme@quaco perf]$ rpm -q binutils
> binutils-2.31.1-25.fc29.x86_64
> [acme@quaco perf]$
>
> Perhaps binutils 2.32 changed that prototype again and instead of
> falling back to using just one arg we need to use some other number of
> args, or even a different type for the N args it now maybe have?
>
> - Arnaldo


There is no change in 2.32


disassembler_ftype
disassembler (enum bfd_architecture a,
               bfd_boolean big ATTRIBUTE_UNUSED,
               unsigned long mach ATTRIBUTE_UNUSED,
               bfd *abfd ATTRIBUTE_UNUSED)



Is there a way to force it to "detect" / use 4 args ?

--

Thomas


