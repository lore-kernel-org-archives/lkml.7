Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDC3C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2892D216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuKuwffW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404806AbfGHVvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:51:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33616 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbfGHVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:51:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id h24so19665398qto.0;
        Mon, 08 Jul 2019 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rO1gDqz4IgP8gTvRzo33LTHvaQcxnK9ffI5uPHdQA4=;
        b=TuKuwffWhPmd9VaOwLlxWAJBjiLeYWz9yJPpq1/LHbj0B+OI3d2NVROO58MO8cRDxn
         WfQneRMxt/NVHDF5rOxM8foryOh2lnzVwDHACU8UPVRfyY+QG00x0kZrtz02qNSi9FMZ
         zXVkl9+mQl9bqLaTE79nNyKYT+USqa6XCoAIlQq/u7YLHxXqgPMNWTypzyUik47koilS
         N3L76wmbPSiddr4pMPRusVZ7ISkJMPHCGhpNB+zmkJMdlnWZ0cuS2sSVbNPsnVxMwZqe
         uqNUawVKIE6H9gwH1deczQYhcLKngMWqZs5U0EMDmQE4kjxVYYaf+Qr6FU6ajF6HnrTI
         W3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rO1gDqz4IgP8gTvRzo33LTHvaQcxnK9ffI5uPHdQA4=;
        b=TflupnP1vcwvDJYIyEwugWaqT4trtgFKGRDD/gGaTqDZNzbh6jiedvHgVV20FceYmY
         PgIJniGfwCBEb6FD9Ihyi9lbb53IMx8Q1/qCMvBuZ2Y2N2Dr48Ht1lvnWxBX/6QBfE+Z
         g+tdd9Ryo/hFEw0UVEIcrJ736E0HJmceF1tZFFefS9uM4W9fRztMT0eFnkRv9trdBhBE
         T/urFp5zaTcwnLhDEe9Gsjm8JeMq7uZ4o+l3GF58zCYnR9Zvr4KhYO1AXtRKp6dm0pIx
         NaruGVgTf0WrQkxeRwLCIfeO+bMBiII0Mpq8UhLAmuMxWn5OQkbJuwn8A6qnhBDAGftS
         HwVw==
X-Gm-Message-State: APjAAAXGijq40AgLVoDbLGxR9QZEbl5wrACsxjBDMPqd6eBeteDzJBN0
        uNdTCJQ4KaeQQF1tPm6g8fg=
X-Google-Smtp-Source: APXvYqyPzRPWjZJZckU6a2s0A5Cn8+Vy1mN1ZIwKg8VcMAAFNPPD2K4dbBB5Z9Z0LyUc08HOykHtNQ==
X-Received: by 2002:ac8:3794:: with SMTP id d20mr15740176qtc.392.1562622662281;
        Mon, 08 Jul 2019 14:51:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id b4sm4194283qtp.77.2019.07.08.14.51.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:51:01 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B2F740340; Mon,  8 Jul 2019 18:50:58 -0300 (-03)
Date:   Mon, 8 Jul 2019 18:50:57 -0300
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        David Carrillo Cisneros <davidca@fb.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>, Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
Message-ID: <20190708215057.GA7455@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708154207.11403-1-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 08, 2019 at 12:41:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Ingo,
> 
> 	Please consider pulling, I did a git merge with torvalds/master
> late last week to fixup some kernel headers ABI sync warnings, but I had
> to cherry pick some csets from my perf/core branch to get the container
> builds to all work, so ended up slipping past v5.2, oh well, but here it
> is, all containers building ok, I'll now test perf/core to then push
> that too.

Hi Ingo,

	As requested I merged tip/perf/core with this branch and now its
available as the perf-urgent-for-mingo-5.3-20190708-2 signed tag, that
has only one extra cset:

  commit 686cbe9e5d88ad639bbe26d963e7d5dafa1c1c28 (HEAD -> perf/urgent, tag: perf-urgent-for-mingo-5.3-20190708-2, acme/perf/urgent, acme.korg/perf/urgent)
  Author: Arnaldo Carvalho de Melo <acme@redhat.com>
  Date:   Mon Jul 8 13:47:14 2019 -0300
  
      tools arch x86: Sync asm/cpufeatures.h with the with the kernel

Best regards,

- Arnaldo
 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> - Arnaldo
> 
> The following changes since commit 69bf4b6b54fb7f52b7ea9ce28d4a360cd5ec956d:
> 
>   Revert "mm: page cache: store only head pages in i_pages" (2019-07-05 19:55:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.3-20190708
> 
> for you to fetch changes up to 05c78468a60f2fd961cd0a0c01c27f288bf81204:
> 
>   tools build: Check if gettid() is available before providing helper (2019-07-07 17:53:09 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> core:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Allow references to thread objects after__machine_exit(), fixing a bug with
>     'perf sched lat' where that happens, i.e. after perf_session__delete() we
>     still have references to threads that were in a linked list whose head was
>     freed in perf_session__delete(), causing a segfault, fix it.
> 
>   Jiri Olsa:
> 
>   - Do not rely on errno values for precise_ip fallback, fixing the default
>     use case for 'perf record' on some AMD servers, when no events are specified
>     and we try to use "cycles:P", i.e. with the maximum precision level.
> 
> BPF:
> 
>   Song Liu:
> 
>   - Assign proper ff->ph in perf_event__synthesize_features(), fixing a bug
>     when using pipe mode, i.e.  'perf record -o -'.
> 
> tools headers:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync kvm headers with the kernel sources
> 
> perf tests:
> 
>   Seeteena Thoufeek:
> 
>   - Fix record+probe_libc_inet_pton.sh for powerpc64, where without the
>     debuginfo package for the 'ping' utility we can't resolve its symbols,
>     so admit getting "[unknown]" for that backtrace line.
> 
> perf python:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove -fstack-protector-strong if clang doesn't have it, fixing the build
>     with clang on fedora:30, oracleline:7, centos:7.
> 
> perf jvmti:
> 
>   Jiri Olsa:
> 
>   - Address gcc string overflow warning for strncpy()
> 
> build:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Check if gettid() is available before providing helper, as recent
>     versions of glibc started to provide gettid().
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools arch kvm: Sync kvm headers with the kernel sources
>       perf thread: Allow references to thread objects after machine__exit()
>       perf annotate TUI browser: Do not use member from variable within its own initialization
>       perf python: Remove -fstack-protector-strong if clang doesn't have it
>       tools build: Check if gettid() is available before providing helper
> 
> Jiri Olsa (2):
>       perf evsel: Do not rely on errno values for precise_ip fallback
>       perf jvmti: Address gcc string overflow warning for strncpy()
> 
> Seeteena Thoufeek (1):
>       perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64
> 
> Song Liu (1):
>       perf header: Assign proper ff->ph in perf_event__synthesize_features()
> 
>  tools/arch/arm64/include/uapi/asm/kvm.h            |  7 +++++
>  tools/arch/x86/include/uapi/asm/kvm.h              | 31 +++++++++++++++-------
>  tools/build/Makefile.feature                       |  1 +
>  tools/build/feature/Makefile                       |  4 +++
>  tools/build/feature/test-all.c                     |  5 ++++
>  tools/build/feature/test-gettid.c                  | 11 ++++++++
>  tools/perf/Makefile.config                         |  4 +++
>  tools/perf/jvmti/jvmti_agent.c                     |  2 ++
>  tools/perf/jvmti/libjvmti.c                        |  4 +--
>  .../tests/shell/record+probe_libc_inet_pton.sh     |  2 +-
>  tools/perf/ui/browsers/annotate.c                  |  5 ++--
>  tools/perf/util/evsel.c                            | 10 ++-----
>  tools/perf/util/header.c                           |  1 +
>  tools/perf/util/machine.c                          | 25 +++++++++++++++--
>  tools/perf/util/setup.py                           |  2 ++
>  tools/perf/util/thread.c                           | 23 +++++++++++++---
>  16 files changed, 109 insertions(+), 28 deletions(-)
>  create mode 100644 tools/build/feature/test-gettid.c
> 
> Test results:
> 
> The first ones are container based builds of tools/perf with and without libelf
> support.  Where clang is available, it is also used to build perf with/without
> libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
> when clang and its devel libraries are installed.
> 
> The objtool and samples/bpf/ builds are disabled now that I'm switching from
> using the sources in a local volume to fetching them from a http server to
> build it inside the container, to make it easier to build in a container cluster.
> Those will come back later.
> 
> Several are cross builds, the ones with -x-ARCH and the android one, and those
> may not have all the features built, due to lack of multi-arch devel packages,
> available and being used so far on just a few, like
> debian:experimental-x-{arm64,mipsel}.
> 
> The 'perf test' one will perform a variety of tests exercising
> tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
> with a variety of command line event specifications to then intercept the
> sys_perf_event syscall to check that the perf_event_attr fields are set up as
> expected, among a variety of other unit tests.
> 
> Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
> with a variety of feature sets, exercising the build with an incomplete set of
> features as well as with a complete one. It is planned to have it run on each
> of the containers mentioned above, using some container orchestration
> infrastructure. Get in contact if interested in helping having this in place.
> 
> The '41: BPF filter' 'perf test' entry is being investigated, it
> shouldn't be with "Skip" status, some problem with BPF maps.
> 
>   $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.2.0-rc7.tar.xz
>   $ dm
>    1  alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
>    2  alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
>    3  alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
>    4  alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    5  alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    6  alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    7  alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>    8  alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 7.0.1 (tags/RELEASE_701/final) (based on LLVM 7.0.1)
>    9  amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
>   10  amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
>   11  android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   12  android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   13  centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>   14  centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>   15  centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
>   16  clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.1.1 20190628 gcc-9-branch@272773, clang version 8.0.0 (tags/RELEASE_800/final)
>   17  debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
>   18  debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
>   19  debian:experimental           : Ok   gcc (Debian 8.3.0-7) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
>   20  debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
>   21  debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
>   22  debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
>   23  debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
>   24  fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
>   25  fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
>   26  fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
>   27  fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
>   28  fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
>   29  fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
>   30  fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
>   31  fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
>   32  fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
>   33  fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
>   34  fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
>   35  fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
>   36  fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
>   37  fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
>   38  fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
>   39  gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
>   40  mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
>   41  mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
>   42  mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
>   43  manjaro:latest                : Ok   gcc (GCC) 9.1.0, clang version 8.0.0 (tags/RELEASE_800/final)
>   44  openmandriva:cooker           : Ok   gcc (GCC) 9.1.1 20190622 (OpenMandriva)
>   45  opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
>   46  opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
>   47  opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
>   48  opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190611 [gcc-9-branch revision 272147], clang version 8.0.0 (tags/RELEASE_800/final 356365)
>   49  oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
>   50  oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
>   51  ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
>   52  ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
>   53  ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
>   54  ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   55  ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   56  ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   57  ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   58  ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   59  ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   60  ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>   61  ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   62  ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   63  ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   64  ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   65  ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   66  ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   67  ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   68  ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   69  ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   70  ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>   71  ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
>   72  ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
>   73  ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
>   74  ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
>   75  ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
>   76  ubuntu:19.10                  : Ok   gcc (Ubuntu 8.3.0-14ubuntu1) 8.3.0, clang version 8.0.1-+rc1-1~exp1 (tags/RELEASE_801/rc1)
>   $
> 
>   # uname -a
>   Linux quaco 5.2.0-rc7+ #4 SMP Sat Jul 6 14:43:41 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
>   # git log --oneline -1
>   05c78468a60f tools build: Check if gettid() is available before providing helper
>   # perf version --build-options
>   perf version 5.2.rc7.g05c784
>                    dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>       dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                    glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>                     gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
>            syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                   libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                   libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                  libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>   numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                  libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>                libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>                 libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>                libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>                libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>       libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                     zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                     lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>                get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                      bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                      aio: [ on  ]  # HAVE_AIO_SUPPORT
>                     zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>   # perf test
>    1: vmlinux symtab matches kallsyms                       : Ok
>    2: Detect openat syscall event                           : Ok
>    3: Detect openat syscall event on all cpus               : Ok
>    4: Read samples using the mmap interface                 : Ok
>    5: Test data source output                               : Ok
>    6: Parse event definition strings                        : Ok
>    7: Simple expression parser                              : Ok
>    8: PERF_RECORD_* events & perf_sample fields             : Ok
>    9: Parse perf pmu format                                 : Ok
>   10: DSO data read                                         : Ok
>   11: DSO data cache                                        : Ok
>   12: DSO data reopen                                       : Ok
>   13: Roundtrip evsel->name                                 : Ok
>   14: Parse sched tracepoints fields                        : Ok
>   15: syscalls:sys_enter_openat event fields                : Ok
>   16: Setup struct perf_event_attr                          : Ok
>   17: Match and link multiple hists                         : Ok
>   18: 'import perf' in python                               : Ok
>   19: Breakpoint overflow signal handler                    : Ok
>   20: Breakpoint overflow sampling                          : Ok
>   21: Breakpoint accounting                                 : Ok
>   22: Watchpoint                                            :
>   22.1: Read Only Watchpoint                                : Skip
>   22.2: Write Only Watchpoint                               : Ok
>   22.3: Read / Write Watchpoint                             : Ok
>   22.4: Modify Watchpoint                                   : Ok
>   23: Number of exit events of a simple workload            : Ok
>   24: Software clock events period values                   : Ok
>   25: Object code reading                                   : Ok
>   26: Sample parsing                                        : Ok
>   27: Use a dummy software event to keep tracking           : Ok
>   28: Parse with no sample_id_all bit set                   : Ok
>   29: Filter hist entries                                   : Ok
>   30: Lookup mmap thread                                    : Ok
>   31: Share thread mg                                       : Ok
>   32: Sort output of hist entries                           : Ok
>   33: Cumulate child hist entries                           : Ok
>   34: Track with sched_switch                               : Ok
>   35: Filter fds with revents mask in a fdarray             : Ok
>   36: Add fd to a fdarray, making it autogrow               : Ok
>   37: kmod_path__parse                                      : Ok
>   38: Thread map                                            : Ok
>   39: LLVM search and compile                               :
>   39.1: Basic BPF llvm compile                              : Ok
>   39.2: kbuild searching                                    : Ok
>   39.3: Compile source for BPF prologue generation          : Ok
>   39.4: Compile source for BPF relocation                   : Ok
>   40: Session topology                                      : Ok
>   41: BPF filter                                            :
>   41.1: Basic BPF filtering                                 : Skip
>   41.2: BPF pinning                                         : Skip
>   41.3: BPF prologue generation                             : Skip
>   41.4: BPF relocation checker                              : Skip
>   42: Synthesize thread map                                 : Ok
>   43: Remove thread map                                     : Ok
>   44: Synthesize cpu map                                    : Ok
>   45: Synthesize stat config                                : Ok
>   46: Synthesize stat                                       : Ok
>   47: Synthesize stat round                                 : Ok
>   48: Synthesize attr update                                : Ok
>   49: Event times                                           : Ok
>   50: Read backward ring buffer                             : Ok
>   51: Print cpu map                                         : Ok
>   52: Probe SDT events                                      : Ok
>   53: is_printable_array                                    : Ok
>   54: Print bitmap                                          : Ok
>   55: perf hooks                                            : Ok
>   56: builtin clang support                                 : Skip (not compiled in)
>   57: unit_number__scnprintf                                : Ok
>   58: mem2node                                              : Ok
>   59: x86 rdpmc                                             : Ok
>   60: Convert perf time to TSC                              : Ok
>   61: DWARF unwind                                          : Ok
>   62: x86 instruction decoder - new instructions            : Ok
>   63: x86 bp modify                                         : Ok
>   64: probe libc's inet_pton & backtrace it with ping       : Ok
>   65: Use vfs_getname probe to get syscall args filenames   : Ok
>   66: Add vfs_getname probe to get syscall args filenames   : Ok
>   67: Check open filename arg using perf trace + vfs_getname: Ok
>   68: Zstd perf.data compression/decompression              : Ok
> 
>   $ make -C tools/perf build-test
>   make: Entering directory '/home/acme/git/perf/tools/perf'
>   - tarpkg: ./tests/perf-targz-src-pkg .
>                    make_help_O: make help
>                  make_perf_o_O: make perf.o
>                    make_pure_O: make
>                make_no_slang_O: make NO_SLANG=1
>               make_no_libelf_O: make NO_LIBELF=1
>                   make_debug_O: make DEBUG=1
>          make_with_clangllvm_O: make LIBCLANGLLVM=1
>             make_no_libaudit_O: make NO_LIBAUDIT=1
>                 make_install_O: make install
>              make_util_map_o_O: make util/map.o
>                 make_no_gtk2_O: make NO_GTK2=1
>        make_util_pmu_bison_o_O: make util/pmu-bison.o
>    make_install_prefix_slash_O: make install prefix=/tmp/krava/
>              make_no_libnuma_O: make NO_LIBNUMA=1
>            make_no_libunwind_O: make NO_LIBUNWIND=1
>            make_no_libbionic_O: make NO_LIBBIONIC=1
>               make_clean_all_O: make clean all
>             make_no_auxtrace_O: make NO_AUXTRACE=1
>              make_no_libperl_O: make NO_LIBPERL=1
>            make_no_libpython_O: make NO_LIBPYTHON=1
>             make_no_demangle_O: make NO_DEMANGLE=1
>   make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
>            make_no_backtrace_O: make NO_BACKTRACE=1
>                  make_cscope_O: make cscope
>                    make_tags_O: make tags
>              make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
>               make_no_libbpf_O: make NO_LIBBPF=1
>                  make_static_O: make LDFLAGS=-static
>                   make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
>                 make_no_newt_O: make NO_NEWT=1
>         make_with_babeltrace_O: make LIBBABELTRACE=1
>                     make_doc_O: make doc
>          make_install_prefix_O: make install prefix=/tmp/krava
>                 make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
>             make_install_bin_O: make install-bin
>   OK
>   make: Leaving directory '/home/acme/git/perf/tools/perf'
>   

-- 

- Arnaldo
