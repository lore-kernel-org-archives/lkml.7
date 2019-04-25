Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E3C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD08206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg3BQ9Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfDYVsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:48:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46144 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:48:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id w73so692480qkb.13;
        Thu, 25 Apr 2019 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q1UpAOGNswqr3kYSiN13ewFvLBQm8M5rhSdV/SDeygY=;
        b=dg3BQ9Lr3YoqH156Ic4NQaKXEOj3/enSHApawne7TKih6Z3aa0++m2vJ0sv3gwpQIv
         rW1WF77W737/Vb2UhebotaIjQCnx7mUk/NlHrnyjbUQjod/qAizZlqneqCp9VxsbqytN
         0epgn/arYDIHD2kIWkO/EqZpFpYeUCMAUSFAZjI7bKRndZAKyqhIBtOPw5L8r1dg1klD
         o95+AFvDa4Bd/qtX2JsXxP9ELyVGnXn5BaEGiI3Q/rUtGHgaaleXXwDrWfsw4jCQfjZq
         iCQ5FDfNKcz/ukoIABIBZDPo1bcR7CZ5ssYXohRjzUyY1kDUdyMabKgNjep6NHqBChPW
         sEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q1UpAOGNswqr3kYSiN13ewFvLBQm8M5rhSdV/SDeygY=;
        b=Uo6t16M4hH4NqGiLXp59tEdiTro+DVhuJ2KFHZ0zaNHNds9sfhYgkTWiWEBSGfqy1e
         FkXYm49NIArpywzfZ3FqZbvTB64xHRisNdK6C3k2Tl1wWs2Is27B+RPpd3lT+PXfBj/l
         4Qj9b0jfLRDG1sEFf/L43B0VXnoOZzi7n07v83bKjXe4o6GGqc83MzcbLP779ucYFWXt
         d0NUk1sh8Q2udESCOCozMYfHvhLtguQ6U10PVVa6EEY6QZl/CackI9H293i2ZbTD3c7+
         7oScjsdIumqGCNB470mQtVDrxDW5MENBZw88XKFlSobmDT48/3CXFEamYMUvrTRnalSo
         E6pw==
X-Gm-Message-State: APjAAAU+r3v/ghfNArPIzJVZyJUp8QANKFEHadKVRwdB59uTIh6U7MVX
        cdcY729R6ZHkXJst2u1amhk=
X-Google-Smtp-Source: APXvYqzyzjF+oygzJf/rBgrEc9nqHfqxCv4Vt6Oe9LTR52cALcSTsM17cRE2AnZ0F5wD9xKreZx+OQ==
X-Received: by 2002:a37:8544:: with SMTP id h65mr18615045qkd.84.1556228883914;
        Thu, 25 Apr 2019 14:48:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id b7sm236685qtt.43.2019.04.25.14.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 14:48:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E9114111F; Thu, 25 Apr 2019 18:48:00 -0300 (-03)
Date:   Thu, 25 Apr 2019 18:48:00 -0300
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190425214800.GC21829@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190422152027.GB11750@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 22, 2019 at 12:20:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:
> > When building perf for ARC (v5.1-rc2) I get the following
>  
> > | In file included from bench/futex-hash.c:26:
> > | bench/futex.h: In function 'futex_wait':
> > | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this function);
>  
> > git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools headers uapi:
> > Sync copy of asm-generic/unistd.h with the kernel sources")
> 
> Humm, I have to check why this:
> 
> [perfbuilder@quaco ~]$ podman images | grep ARC
> docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-uClibc          4c259582a8e6   5 weeks ago      846 MB
> [perfbuilder@quaco ~]$
> 
> isn't catching this... :-\
> 
> FROM docker.io/fedora:24
> MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
> ENV TOOLCHAIN=arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install
> ENV CROSS=arc-linux-
> ENV SOURCEFILE=${TOOLCHAIN}.tar.gz
> RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc findutils xz
> RUN wget https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-2017.09-rc2/${SOURCEFILE}
> <SNIP>
> COPY rx_and_build.sh /
> ENV EXTRA_MAKE_ARGS=NO_LIBBPF=1
> ENV ARCH=arc
> ENV CROSS_COMPILE=/${TOOLCHAIN}/bin/${CROSS}
> ENV EXTRA_CFLAGS=-matomic

So, now I have a libnuma crossbuilt in this container that allows me to
build a ARC perf binary linked with zlib and numactl-devel, but only
after I applied the fix below.

Can you please provide the feature detection header in the build? I.e.
what I have with my ARC cross build container right now, after applying
the patch below is:

[perfbuilder@60d5802468f6 perf]$ make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C /git/perf/tools/perf O=/tmp/build/perf
make: Entering directory '/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
sh: line 0: command: -c: invalid option
command: usage: command [-pVv] command [arg ...]

Auto-detecting system features:
...                         dwarf: [ OFF ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ OFF ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ OFF ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]
...                        libaio: [ OFF ]
...        disassembler-four-args: [ OFF ]

Makefile.config:339: No libelf found. Disables 'probe' tool, jvmti and BPF support in 'perf record'. Please install libelf-dev, libelf-devel or elfutils-libelf-devel
Makefile.config:473: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:548: Disabling post unwind, no support found.
Makefile.config:601: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
Makefile.config:613: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
Makefile.config:628: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:642: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
Makefile.config:669: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:696: No python interpreter was found: disables Python support - please install python-devel/python-dev
Makefile.config:785: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:853: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
make: Leaving directory '/git/perf/tools/perf'
[perfbuilder@60d5802468f6 perf]$ export
declare -x ARCH="arc"
declare -x CROSS="arc-linux-"
declare -x CROSS_COMPILE="/arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install/bin/arc-linux-"
declare -x DISTTAG="f30container"
declare -x EXTRA_CFLAGS="-matomic"
declare -x EXTRA_MAKE_ARGS="NO_LIBBPF=1"
declare -x FBR="f30"
declare -x FGC="f30"
declare -x NUMACTL_SOURCEFILE="github.com-numactl-numactl-archive-master-2019-04-25.zip"
declare -x PATH="/home/perfbuilder/.local/bin:/home/perfbuilder/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
declare -x SOURCEFILE="arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install.tar.gz"
declare -x TOOLCHAIN="arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install"
declare -x container="podman"
[perfbuilder@60d5802468f6 perf]$ 

commit dd617baf28925cf72fce309232ad9178452e75ab
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Apr 25 18:36:51 2019 -0300

    perf bench numa: Add define for RUSAGE_THREAD if not present
    
    While cross building perf to the ARC architecture on a fedora 30 host,
    we were failing with:
    
          CC       /tmp/build/perf/bench/numa.o
      bench/numa.c: In function ‘worker_thread’:
      bench/numa.c:1261:12: error: ‘RUSAGE_THREAD’ undeclared (first use in this function); did you mean ‘SIGEV_THREAD’?
        getrusage(RUSAGE_THREAD, &rusage);
                  ^~~~~~~~~~~~~
                  SIGEV_THREAD
      bench/numa.c:1261:12: note: each undeclared identifier is reported only once for each function it appears in
    
    [perfbuilder@60d5802468f6 perf]$ /arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install/bin/arc-linux-gcc --version | head -1
    arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
    [perfbuilder@60d5802468f6 perf]$
    
    Trying to reproduce a report by Vineet, I noticed that, with just
    cross-built zlib and numactl libraries, I ended up with the above
    failure.
    
    So, since RUSAGE_THREAD is available as a define, check for that and
    numactl libraries, I ended up with the above failure.
    
    So, since RUSAGE_THREAD is available as a define in the system headers,
    check if it is defined in the 'perf bench numa' sources and define it if
    not.
    
    Now it builds and I have to figure out if the problem reported by Vineet
    only takes place if we have libelf or some other library available.
    
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: linux-snps-arc@lists.infradead.org
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
    Link: https://lkml.kernel.org/n/tip-2wb4r1gir9xrevbpq7qp0amk@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 98ad783efc69..a7784554a80d 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -39,6 +39,10 @@
 #include <numa.h>
 #include <numaif.h>
 
+#ifndef RUSAGE_THREAD
+# define RUSAGE_THREAD 1
+#endif
+
 /*
  * Regular printout to the terminal, supressed if -q is specified:
  */
