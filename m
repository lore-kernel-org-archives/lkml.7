Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA6CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6552721670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev4b3NcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfD3NGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:06:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46053 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfD3NGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:06:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id d5so8026237qko.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xu0LbkXWbh0BXLoqCriBqfNKRC7SgaoGIdiOs9kTAIo=;
        b=ev4b3NcIoN2LtjZoczNWMJkObSXi5rJhv1tREV7FIHhWII/JH7EGK4uRr1pK0U9/e7
         YHxtZa02o0T/Y4UbH9x6lMlIYwIhCmu0g1HhicTIxPlw0Cip/edX1KilUNZxQnPb61t5
         NI+/EF/qCRvJc6ONyf5+EjfBZYNlCqUnmQjVJ+0BP5qzMrTW9ncWyC4Qiwmr/37we1NG
         WMIwW7gRL5U+oOQULoFL4dZ2YatA80ngCq/4sVaDCUrfFrToGkM1xtJrB1ilCvb0TaC/
         pD3lOncUjvkRHwsKqoNf0OGRimEPiC0fv6YwnXR9hr9MrHcPJ8SCyY5G6Jr0Iu2kP2xi
         N7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xu0LbkXWbh0BXLoqCriBqfNKRC7SgaoGIdiOs9kTAIo=;
        b=OWZKGhi0PrjTGEj/40AdIdqM7pfMTzyKuig42KAO2WTWNhlC95SJJKElP72AKUbMNv
         TTHZinPf62fyg/JE+zcgCwuC9oVCtbIApJC+vhLfYtVnMQxa7UuVu/+kd9RYtToFOLka
         yiWBVOVijrQA/dtJqFONUByHPQCrc4BqrbdLMGbviPGOL9LDIWDTDT3W4JrlxwYcn9Fc
         dBIhnKY9UPFgzfOKg+9rlmU0OeGG+FZE28R/FZEsFd8HuJcN0NZ53/2XZ2NYllhmreEt
         CE9ROJ+5pxmh+cj2I8h9csaCnt3TLj8SIcze8ugCjqCPG5k8mkrH/DyvF91biejzlLmA
         th2g==
X-Gm-Message-State: APjAAAXfBwlbkz97Ff+7FOMA7kAj+WXrJskyM6p0BD8Hn5BDclnX7+sn
        /vu3xfy+6mPcZK9ctR0ANFdpsvlSRQ5Ut0W3bcI=
X-Google-Smtp-Source: APXvYqw50i+EEJTKCYk/63q9X6/A1x4vxEa299K+pSOX3Ai9Z0fZPQoCSnH4o4lLDcLLXqsDxi3BJmxrTMrYj9jnfas=
X-Received: by 2002:a37:a514:: with SMTP id o20mr19369286qke.41.1556629598835;
 Tue, 30 Apr 2019 06:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org> <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
In-Reply-To: <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 30 Apr 2019 06:06:26 -0700
Message-ID: <CAPhsuW7dS9TXOAW--U2q9-zmsgS4_K+uZYLnbPra+r+2LjJKDQ@mail.gmail.com>
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

On Tue, Apr 30, 2019 at 12:55 AM Thomas Backlund <tmb@mageia.org> wrote:
>
> Den 30-04-2019 kl. 10:26, skrev Thomas Backlund:
> >
> > Building perf in 5.1-rc5/6/7 fails:
> >
> >
> > Build start:
> >
> >
> >   make -s -C tools/perf NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1
> > WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_STRLCPY=1
> > NO_BIONIC=1 NO_JVMTI=1 prefix=/usr lib=lib64 all
> >    BUILD:   Doing 'make -j32' parallel build
> >    HOSTCC   fixdep.o
> >    HOSTLD   fixdep-in.o
> >    LINK     fixdep
> > Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h'
> > differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
> > diff -u tools/arch/x86/include/uapi/asm/vmx.h
> > arch/x86/include/uapi/asm/vmx.h
> >
> > Auto-detecting system features:
> > ...                         dwarf: [ on  ]
> > ...            dwarf_getlocations: [ on  ]
> > ...                         glibc: [ on  ]
> > ...                          gtk2: [ on  ]
> > ...                      libaudit: [ on  ]
> > ...                        libbfd: [ on  ]
> > ...                        libelf: [ on  ]
> > ...                       libnuma: [ on  ]
> > ...        numa_num_possible_cpus: [ on  ]
> > ...                       libperl: [ on  ]
> > ...                     libpython: [ on  ]
> > ...                      libslang: [ on  ]
> > ...                     libcrypto: [ on  ]
> > ...                     libunwind: [ on  ]
> > ...            libdw-dwarf-unwind: [ on  ]
> > ...                          zlib: [ on  ]
> > ...                          lzma: [ on  ]
> > ...                     get_cpuid: [ on  ]
> > ...                           bpf: [ on  ]
> > ...                        libaio: [ on  ]
> > ...        disassembler-four-args: [ OFF ]
> >
> > Makefile.config:473: No sys/sdt.h found, no SDT events are defined,
> > please install systemtap-sdt-devel or systemtap-sdt-dev
> > Makefile.config:853: No libbabeltrace found, disables 'perf data' CTF
> > format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> >
> >
> > And breaks with:
> >
> >
> > CC       ui/setup.o
> > util/annotate.c: In function 'symbol__disassemble_bpf':
> > util/annotate.c:1767:29: error: incompatible type for argument 1 of
> > 'disassembler'
> >    disassemble = disassembler(bfdf);
> >                               ^~~~
> > In file included from util/annotate.c:1689:
> > /usr/include/dis-asm.h:325:63: note: expected 'enum bfd_architecture'
> > but argument is of type 'bfd *' {aka 'struct bfd *'}
> >   extern disassembler_ftype disassembler (enum bfd_architecture arc,
> >                                           ~~~~~~~~~~~~~~~~~~~~~~^~~
> > util/annotate.c:1767:16: error: too few arguments to function
> > 'disassembler'
> >    disassemble = disassembler(bfdf);
> >                  ^~~~~~~~~~~~
> > In file included from util/annotate.c:1689:
> > /usr/include/dis-asm.h:325:27: note: declared here
> >   extern disassembler_ftype disassembler (enum bfd_architecture arc,
> >                             ^~~~~~~~~~~~
> >    CC       arch/x86/util/header.o
> >    CC       arch/x86/util/tsc.o
> >    CC       arch/x86/util/pmu.o
> > mv: cannot stat 'util/.annotate.o.tmp': No such file or directory
> >    CC       bench/futex-requeue.o
> >    CC       arch/x86/util/kvm-stat.o
> > make[4]: ***
> > [/work/rpmbuild/BUILD/kernel-x86_64/linux-5.0/tools/build/Makefile.build:97:
> > util/annotate.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >    CC       util/build-id.o
> >
> >
> >
>
>
> And I forgot...
>
> Reverting:
>  From 6987561c9e86eace45f2dbb0c564964a63f4150a Mon Sep 17 00:00:00 2001
> From: Song Liu <songliubraving@fb.com>
> Date: Mon, 11 Mar 2019 22:30:48 -0700
> Subject: perf annotate: Enable annotation of BPF programs
>
> Makes it build again.
>
> --
> Thomas
>

Hi Thomas,

Which system are you running this test on? I would like to repro it in a VM.

Thanks,
Song
