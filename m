Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973ACC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6668820651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfEAGmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 02:42:46 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:31431 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:42:46 -0400
Subject: Re: perf build broken in 5.1-rc7
To:     Song Liu <liu.song.a23@gmail.com>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
 <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
 <CAPhsuW7dS9TXOAW--U2q9-zmsgS4_K+uZYLnbPra+r+2LjJKDQ@mail.gmail.com>
 <b773df70-58e6-69f8-d566-282b0f7ae579@mageia.org>
 <CAPhsuW5O7sBdxorngkROCVRPGgRGV2se8mjT-q=O_guxC6Z7SA@mail.gmail.com>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <2e3b5a9d-b9ad-62ba-b3b0-d455dec8c031@mageia.org>
Date:   Wed, 1 May 2019 09:42:38 +0300
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5O7sBdxorngkROCVRPGgRGV2se8mjT-q=O_guxC6Z7SA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C020B.5CC93FE1.003A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 01-05-2019 kl. 06:37, skrev Song Liu:
> On Tue, Apr 30, 2019 at 6:31 AM Thomas Backlund <tmb@mageia.org> wrote:
>>
>> Den 30-04-2019 kl. 16:06, skrev Song Liu:
>>> On Tue, Apr 30, 2019 at 12:55 AM Thomas Backlund <tmb@mageia.org> wrote:
>>>> Den 30-04-2019 kl. 10:26, skrev Thomas Backlund:
>>>>> Building perf in 5.1-rc5/6/7 fails:
>>>>>
>>>>>
>>>>> Build start:
>>>>>
>>>>>
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
>>
>>
>> --
>>
>> Thomas
>>
>>
> I am trying to install Mageia 7 beta 3, but hit some issue. While I try fix it,
> could you please try clean everything under tools/ and retry:
>
>    make -C tools/ clean
>    make -C tools/perf -j


Still fails:

util/annotate.c: In function 'symbol__disassemble_bpf':
util/annotate.c:1767:29: error: incompatible type for argument 1 of 
'disassembler'
   disassemble = disassembler(bfdf);
                              ^~~~
In file included from util/annotate.c:1689:
/usr/include/dis-asm.h:325:63: note: expected 'enum bfd_architecture' 
but argument is of type 'bfd *' {aka 'struct bfd *'}
  extern disassembler_ftype disassembler (enum bfd_architecture arc,
                                          ~~~~~~~~~~~~~~~~~~~~~~^~~
util/annotate.c:1767:16: error: too few arguments to function 'disassembler'
   disassemble = disassembler(bfdf);
                 ^~~~~~~~~~~~
In file included from util/annotate.c:1689:
/usr/include/dis-asm.h:325:27: note: declared here
  extern disassembler_ftype disassembler (enum bfd_architecture arc,
                            ^~~~~~~~~~~~
   CC       scripts/python/Perf-Trace-Util/Context.o
   CC       bench/mem-memcpy-x86-64-lib.o
   CC       tests/parse-events.o
   CC       util/block-range.o
mv: cannot stat 'util/.annotate.o.tmp': No such file or directory
make[4]: *** 
[/work/5.1/linux-5.1-rc7-mga07/tools/build/Makefile.build:97: 
util/annotate.o] Error 1
make[4]: *** Waiting for unfinished jobs....
   CC       ui/util.o

>
> If it still fails, how about building bpftool?
>
>    make -C tools/bpf -j


Also fails:


Auto-detecting system features:
...                        libbfd: [ on  ]
...        disassembler-four-args: [ OFF ]

   CC       bpf_jit_disasm.o
   CC       bpf_dbg.o
   CC       bpf_asm.o
   BISON    bpf_exp.yacc.c
   DESCEND  bpftool
make[1]: Entering directory 
'/work/5.1/linux-5.1-rc7-mga07/tools/bpf/bpftool'
/work/5.1/linux-5.1-rc7-mga07/tools/bpf/bpf_jit_disasm.c: In function 
'get_asm_insns':
/work/5.1/linux-5.1-rc7-mga07/tools/bpf/bpf_jit_disasm.c:81:29: error: 
incompatible type for argument 1 of 'disassembler'
   disassemble = disassembler(bfdf);
                              ^~~~
In file included from 
/work/5.1/linux-5.1-rc7-mga07/tools/bpf/bpf_jit_disasm.c:24:
/usr/include/dis-asm.h:325:63: note: expected 'enum bfd_architecture' 
but argument is of type 'bfd *' {aka 'struct bfd *'}
  extern disassembler_ftype disassembler (enum bfd_architecture arc,
                                          ~~~~~~~~~~~~~~~~~~~~~~^~~
/work/5.1/linux-5.1-rc7-mga07/tools/bpf/bpf_jit_disasm.c:81:16: error: 
too few arguments to function 'disassembler'
   disassemble = disassembler(bfdf);
                 ^~~~~~~~~~~~
In file included from 
/work/5.1/linux-5.1-rc7-mga07/tools/bpf/bpf_jit_disasm.c:24:
/usr/include/dis-asm.h:325:27: note: declared here
  extern disassembler_ftype disassembler (enum bfd_architecture arc,
                            ^~~~~~~~~~~~
make: *** [Makefile:57: bpf_jit_disasm.o] Error 1
make: *** Waiting for unfinished jobs....



So is this a bug in feature misdetection?


In your commit message you state:

"And making all this dependent on HAVE_LIBBFD_SUPPORT and
HAVE_LIBBPF_SUPPORT:"


Now we obviously have libbfd.

But if the HAVE_LIBBPF_SUPPORT means tools/lib/bpf, then I havent 
packaged that yet, so why is it detecting it as available ?


--

Thomas


