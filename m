Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F8AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B614221707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKbCWZaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfD3BSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:18:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33800 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfD3BSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:18:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id u14so4734576ywe.1;
        Mon, 29 Apr 2019 18:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+WIm5hmSN2OmSuQJOts8t0F9/3FnmKAv+vIoX+0L1nY=;
        b=vKbCWZaqDdiUDwCF2w/QZx7zr85DmDYqwSMT5r3GhSK2RTouX2BnfZoaQpoJ9XOQEs
         8ryw7GxbpwfscspO206/iC6c/d3kFXnEE9F1hRdu8xJc/3R0cKIURcvEg6ifiotKAH33
         wLcQu8FZwq2lkeiPS0F4e+VBM/AqyiCChIKWEvTcVo4ngvNxD8AgJ/n7mqKsDC6BbFKV
         VMvpeZQpFSYGwCi4cpL7aoTiMEYyke8ZfFjxRSsZ2xLzN5+R80Z1dbwm6T9uFWq0YKJJ
         8wGk6CxlOuPZRxJRA/LAXRDwtpRiTNs/mYlDcxzdbsGRaIe0rR6R+suv5Kgc0NcpwSpE
         vI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+WIm5hmSN2OmSuQJOts8t0F9/3FnmKAv+vIoX+0L1nY=;
        b=CWMVxGhx0ohTif25nt9kejP1JMFpPsELVW1XbmiPPhrcl89irz6ur2omqlE2WDqKdF
         7Jnopz9pXYZJxL6ACPeRavqtdhKWl0C8NT5v3olPSN2FW4wIuRMxbelHVEW0PiV0d56h
         7bRrVRaaQO91GdNhOW5jf7xD8/Gu6AY329qxuTMncQsTMOzuhx0FJp7wrxrU36CLVhaO
         17AZfsHBRuWGCkkwhor8TMGkoB9Kc+5yl1Ds7zGVovwnihANzJ0qQFdrr4otMd8aszCy
         FRj7m+sTGLxsmA0D7CcNduPTFGbef/S4mee5fj6KqcKE8RvsDpJ2uckxiNUiVYkOqnSt
         2a7w==
X-Gm-Message-State: APjAAAXRP5XfLiZUfAAFEDXxBU2XmYENE448PLE9Z07C3fzbQ94hl8nk
        NhTadWED3EGv3ud31UZrt0DiLA+Q
X-Google-Smtp-Source: APXvYqyUk1/sS5cJIMAOwt8HA/QHDr6iPh3ipJYdAuwTQ/ezBphEz65aik1SJWQnNoGlN5hCqrSpSg==
X-Received: by 2002:a81:9845:: with SMTP id p66mr19305979ywg.497.1556587101308;
        Mon, 29 Apr 2019 18:18:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id i206sm16087163ywi.99.2019.04.29.18.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 18:18:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F32DF4111F; Mon, 29 Apr 2019 21:18:18 -0400 (EDT)
Date:   Mon, 29 Apr 2019 21:18:18 -0400
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190430011818.GE7857@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <20190425214800.GC21829@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 29, 2019 at 05:14:54PM +0000, Vineet Gupta escreveu:
> On 4/25/19 2:48 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Apr 22, 2019 at 12:20:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:
> >>> When building perf for ARC (v5.1-rc2) I get the following
> >>  
> >>> | In file included from bench/futex-hash.c:26:
> >>> | bench/futex.h: In function 'futex_wait':
> >>> | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this function);
> >>  
> >>> git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools headers uapi:
> >>> Sync copy of asm-generic/unistd.h with the kernel sources")
> >> Humm, I have to check why this:
> >>
> >> [perfbuilder@quaco ~]$ podman images | grep ARC
> >> docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-uClibc          4c259582a8e6   5 weeks ago      846 MB
> >> [perfbuilder@quaco ~]$
> >>
> >> isn't catching this... :-\
> >>
> >> FROM docker.io/fedora:24
> >> MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
> >> ENV TOOLCHAIN=arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install
> >> ENV CROSS=arc-linux-
> >> ENV SOURCEFILE=${TOOLCHAIN}.tar.gz
> >> RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc findutils xz
> >> RUN wget https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_foss-2Dfor-2Dsynopsys-2Ddwc-2Darc-2Dprocessors_toolchain_releases_download_arc-2D2017.09-2Drc2_-24-257BSOURCEFILE-257D&d=DwIDaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=7FgpX6o3vAhwMrMhLh-4ZJey5kjdNUwOL2CWsFwR4T8&m=HjtufCLozrW47pS5C2YH3safLHQE7eEtmHFZsSWrz1M&s=29g4oKvGuYcLgheCUvZh3wojhhljivpLd8aj7Ur4sKQ&e=
> >> <SNIP>
> >> COPY rx_and_build.sh /
> >> ENV EXTRA_MAKE_ARGS=NO_LIBBPF=1
> >> ENV ARCH=arc
> >> ENV CROSS_COMPILE=/${TOOLCHAIN}/bin/${CROSS}
> >> ENV EXTRA_CFLAGS=-matomic
> > So, now I have a libnuma crossbuilt in this container that allows me to
> > build a ARC perf binary linked with zlib and numactl-devel, but only
> > after I applied the fix below.
> >
> > Can you please provide the feature detection header in the build? I.e.
> > what I have with my ARC cross build container right now, after applying
> > the patch below is:
> >
> > [perfbuilder@60d5802468f6 perf]$ make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C /git/perf/tools/perf O=/tmp/build/perf
> > make: Entering directory '/git/perf/tools/perf'
> >   BUILD:   Doing 'make -j8' parallel build
> > sh: line 0: command: -c: invalid option
> > command: usage: command [-pVv] command [arg ...]
> >
> > Auto-detecting system features:
> > ...                         dwarf: [ OFF ]
> > ...            dwarf_getlocations: [ OFF ]
> > ...                         glibc: [ on  ]
> 
> Not related to current issue, this run uses a uClibc toolchain and yet it is
> detecting glibc - doesn't seem right to me.

Ok, I'll improve that, I think it just tries to detect a libc, yeah,
see:

[acme@quaco linux]$ cat tools/build/feature/test-glibc.c
// SPDX-License-Identifier: GPL-2.0
#include <stdlib.h>

#if !defined(__UCLIBC__)
#include <gnu/libc-version.h>
#else
#define XSTR(s) STR(s)
#define STR(s) #s
#endif

int main(void)
{
#if !defined(__UCLIBC__)
	const char *version = gnu_get_libc_version();
#else
	const char *version = XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);
#endif

	return (long)version;
}
[acme@quaco linux]$

[perfbuilder@59ca4b424ded /]$ grep __GLIBC__ /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/*.h
/arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:   The macros `__GNU_LIBRARY__', `__GLIBC__', and `__GLIBC_MINOR__' are
/arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:#define	__GLIBC__	2
/arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:	((__GLIBC__ << 16) + __GLIBC_MINOR__ >= ((maj) << 16) + (min))
[perfbuilder@59ca4b424ded /]$

Isn't that part of uClibc?
 
> > ...                          gtk2: [ OFF ]
> > ...                      libaudit: [ OFF ]
> > ...                        libbfd: [ OFF ]
> > ...                        libelf: [ OFF ]
> > ...                       libnuma: [ on  ]
> 
> Wondering why that is - for me numa is off - even when using a glibc toolchain.
> 
> > ...        numa_num_possible_cpus: [ on  ]
> > ...                       libperl: [ OFF ]
> > ...                     libpython: [ OFF ]
> > ...                      libslang: [ OFF ]
> > ...                     libcrypto: [ OFF ]
> > ...                     libunwind: [ OFF ]
> > ...            libdw-dwarf-unwind: [ OFF ]
> > ...                          zlib: [ OFF ]
> > ...                          lzma: [ OFF ]
> > ...                     get_cpuid: [ OFF ]
> > ...                           bpf: [ on  ]
> > ...                        libaio: [ OFF ]
> > ...        disassembler-four-args: [ OFF ]
> >
> >
> 
> For my glibc toolchain, here's the feature detection output
> 
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ OFF ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ OFF ]
> ...                      libaudit: [ OFF ]
> ...                        libbfd: [ OFF ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ OFF ]
> ...        numa_num_possible_cpus: [ OFF ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                      libslang: [ OFF ]
> ...                     libcrypto: [ OFF ]
> ...                     libunwind: [ OFF ]
> ...            libdw-dwarf-unwind: [ OFF ]
> ...                          zlib: [ OFF ]
> ...                          lzma: [ OFF ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...        disassembler-four-args: [ OFF ]
> 
> 

-- 

- Arnaldo
