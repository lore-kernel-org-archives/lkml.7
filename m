Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9DC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFDD21734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlE+eA0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEADhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 23:37:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34680 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfEADhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:37:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id j6so18926012qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 20:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYZexU7V2KNF36ssonVwNZ+lNLpgylp+Umw+N00clyw=;
        b=SlE+eA0FnI3+R8iEpSSd+k3neEErSHwrVleU85J/7ykp9HYypo2y6mXI8H8OvSd/g+
         lbGPNg1zBGwZGwcrG/xKts4/sFDCagn3fWY9nHDZSxq+oCqssUBSpiG6r6VAHElvWWiV
         Lqp8XGuJkCVQ2izoIi/yjps2xnk2Gb6rJlIMOEk7YFE7CfJqCkpCKkH45WirNTD/Ldlg
         YmxVsfLIAmiPHHD9gvl6P+9TlPHN/9dmyfgw5z6NKTsTDjT6Rg+K7K6bD4+eRagYjYKH
         5g7kryJ/Il3gVk9PTuxTBhSDxmC/vJGe53KmHgufS3M9nQf8tTMb2XyCAsU+KfDRJjS2
         9H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYZexU7V2KNF36ssonVwNZ+lNLpgylp+Umw+N00clyw=;
        b=RlrTp/SqjMX6i4NVfpQ0MtiXihbfqHu5ITpOTqW/Dv6vueUnftDLq8OrKoHXoCxMjd
         4vDih+WxUrvG1UdZjZk8P3HS4a6rxKZqvpArVR1gVonR8IcHSDeLc7vUtvP/wUUOiCdV
         fnreOU9I8Y+5uwLL3AINebMTBmQc9k6zIMRdQcoRim2mQKg1+hd51rdTWUmRIMbOyJOj
         W54Jw69uNKnHEXEz3LQnZkXMC+1JecSGAiT8JFGA1RxWVjygoc/BKCdBKBrw4Jscg9If
         LTIFpl7aTC4fieLGRHbHrlh88bdexwv7IPSPvfrzZuSMpdvogDxvrO40rYu3PY0XHjYw
         vwDA==
X-Gm-Message-State: APjAAAUsKmwp6X7ssHK2gBFce6pKCx6lk9asvEft6r4oJ3GIUKdF3du1
        A+wEYjsV+aHeer2ZO0fzXnonOzNRqPs1LSbJVtn8OOe5
X-Google-Smtp-Source: APXvYqx+O0Yfh4pUIaxx5/NFjoS2z9X58XTvZsenhLc+XFBxlJFq4XZfdJp77pSfb1N3KRzV52XNNg9eVnFQssTbYj8=
X-Received: by 2002:ac8:195c:: with SMTP id g28mr15402575qtk.138.1556681870707;
 Tue, 30 Apr 2019 20:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
 <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org> <CAPhsuW7dS9TXOAW--U2q9-zmsgS4_K+uZYLnbPra+r+2LjJKDQ@mail.gmail.com>
 <b773df70-58e6-69f8-d566-282b0f7ae579@mageia.org>
In-Reply-To: <b773df70-58e6-69f8-d566-282b0f7ae579@mageia.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 30 Apr 2019 20:37:39 -0700
Message-ID: <CAPhsuW5O7sBdxorngkROCVRPGgRGV2se8mjT-q=O_guxC6Z7SA@mail.gmail.com>
Subject: Re: perf build broken in 5.1-rc7
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 6:31 AM Thomas Backlund <tmb@mageia.org> wrote:
>
>
> Den 30-04-2019 kl. 16:06, skrev Song Liu:
> > On Tue, Apr 30, 2019 at 12:55 AM Thomas Backlund <tmb@mageia.org> wrote:
> >> Den 30-04-2019 kl. 10:26, skrev Thomas Backlund:
> >>> Building perf in 5.1-rc5/6/7 fails:
> >>>
> >>>
> >>> Build start:
> >>>
> >>>
> >>>    make -s -C tools/perf NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1
> >>> WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_STRLCPY=1
> >>> NO_BIONIC=1 NO_JVMTI=1 prefix=/usr lib=lib64 all
> >>>     BUILD:   Doing 'make -j32' parallel build
> >>>     HOSTCC   fixdep.o
> >>>     HOSTLD   fixdep-in.o
> >>>     LINK     fixdep
> >>> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h'
> >>> differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
> >>> diff -u tools/arch/x86/include/uapi/asm/vmx.h
> >>> arch/x86/include/uapi/asm/vmx.h
> >>>
> >>> Auto-detecting system features:
> >>> ...                         dwarf: [ on  ]
> >>> ...            dwarf_getlocations: [ on  ]
> >>> ...                         glibc: [ on  ]
> >>> ...                          gtk2: [ on  ]
> >>> ...                      libaudit: [ on  ]
> >>> ...                        libbfd: [ on  ]
> >>> ...                        libelf: [ on  ]
> >>> ...                       libnuma: [ on  ]
> >>> ...        numa_num_possible_cpus: [ on  ]
> >>> ...                       libperl: [ on  ]
> >>> ...                     libpython: [ on  ]
> >>> ...                      libslang: [ on  ]
> >>> ...                     libcrypto: [ on  ]
> >>> ...                     libunwind: [ on  ]
> >>> ...            libdw-dwarf-unwind: [ on  ]
> >>> ...                          zlib: [ on  ]
> >>> ...                          lzma: [ on  ]
> >>> ...                     get_cpuid: [ on  ]
> >>> ...                           bpf: [ on  ]
> >>> ...                        libaio: [ on  ]
> >>> ...        disassembler-four-args: [ OFF ]
> >>>
> >>> Makefile.config:473: No sys/sdt.h found, no SDT events are defined,
> >>> please install systemtap-sdt-devel or systemtap-sdt-dev
> >>> Makefile.config:853: No libbabeltrace found, disables 'perf data' CTF
> >>> format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> >>>
> >>>
> >>> And breaks with:
> >>>
> >>>
> >>> CC       ui/setup.o
> >>> util/annotate.c: In function 'symbol__disassemble_bpf':
> >>> util/annotate.c:1767:29: error: incompatible type for argument 1 of
> >>> 'disassembler'
> >>>     disassemble = disassembler(bfdf);
> >>>                                ^~~~
> >>> In file included from util/annotate.c:1689:
> >>> /usr/include/dis-asm.h:325:63: note: expected 'enum bfd_architecture'
> >>> but argument is of type 'bfd *' {aka 'struct bfd *'}
> >>>    extern disassembler_ftype disassembler (enum bfd_architecture arc,
> >>>                                            ~~~~~~~~~~~~~~~~~~~~~~^~~
> >>> util/annotate.c:1767:16: error: too few arguments to function
> >>> 'disassembler'
> >>>     disassemble = disassembler(bfdf);
> >>>                   ^~~~~~~~~~~~
> >>> In file included from util/annotate.c:1689:
> >>> /usr/include/dis-asm.h:325:27: note: declared here
> >>>    extern disassembler_ftype disassembler (enum bfd_architecture arc,
> >>>                              ^~~~~~~~~~~~
> >>>     CC       arch/x86/util/header.o
> >>>     CC       arch/x86/util/tsc.o
> >>>     CC       arch/x86/util/pmu.o
> >>> mv: cannot stat 'util/.annotate.o.tmp': No such file or directory
> >>>     CC       bench/futex-requeue.o
> >>>     CC       arch/x86/util/kvm-stat.o
> >>> make[4]: ***
> >>> [/work/rpmbuild/BUILD/kernel-x86_64/linux-5.0/tools/build/Makefile.build:97:
> >>> util/annotate.o] Error 1
> >>> make[4]: *** Waiting for unfinished jobs....
> >>>     CC       util/build-id.o
> >>>
> >>>
> >>>
> >>
> >> And I forgot...
> >>
> >> Reverting:
> >>   From 6987561c9e86eace45f2dbb0c564964a63f4150a Mon Sep 17 00:00:00 2001
> >> From: Song Liu <songliubraving@fb.com>
> >> Date: Mon, 11 Mar 2019 22:30:48 -0700
> >> Subject: perf annotate: Enable annotation of BPF programs
> >>
> >> Makes it build again.
> >>
> >> --
> >> Thomas
> >>
> > Hi Thomas,
> >
> > Which system are you running this test on? I would like to repro it in a VM.
> >
> > Thanks,
> > Song
>
>
> Mageia Cauldron currently stabilizing to become Mageia 7 in ~1 month.
>
>
> Basesystem is:
>
> binutils-2.32-5.mga7
> (includes all fixes from upstream binutils-2_32-branch)
>
> gcc-8.3.1-0.20190419.2.mga7
>
> glibc-2.29-7.mga7
> (includes all fixes from upstream glibc release/2.29/master branch up to
> 2019-04-15 for now)
>
>
> kernel-desktop-5.1.0-0.rc7.1.mga7
> kernel-userspace-headers-5.1.0-0.rc7.1.mga7
>
>
> --
>
> Thomas
>
>

I am trying to install Mageia 7 beta 3, but hit some issue. While I try fix it,
could you please try clean everything under tools/ and retry:

  make -C tools/ clean
  make -C tools/perf -j

If it still fails, how about building bpftool?

  make -C tools/bpf -j

Thanks,
Song
