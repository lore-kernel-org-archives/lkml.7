Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98A72147A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKvGaf5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfGYKbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:31:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34150 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfGYKbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:31:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so48598657qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aByDz0a8lfqoPlUqwo8aK5yencHd7JUxupyX+f75ZqM=;
        b=JKvGaf5gtI9Hgsz/+Nbngn7ED6CBQAvDstY5e4Ha83nm96m3mZdACGbItyr+OF7kRY
         RfjN5XuIdINnpmDwkvKKbvXX035nrUv8oTa2v8eV9xBoaEFVcmfn3HNcEin83/9XuqvZ
         nLTN9b0FISMpi3zwpuyvHJ/bzRSnifDoCOvZxnBdtmq6a/kuEqxbrVAdXPoDD6aJzW0g
         p1ssOLv4u/VUb837D+S2IxuLy0104cyhh4nGKNb+iljkan3t4zg5YjQSMyUq5i+GjNFE
         5tG3EM+HTAFktAhjzJU3o5cHCqyenE+hc16hTPVGixmDjgDOxw4UKian/dvm04MJCagr
         RI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aByDz0a8lfqoPlUqwo8aK5yencHd7JUxupyX+f75ZqM=;
        b=e8+oUWK/Jk/OPogLAEscviIwc8EcZFKHT6d3rmVwlicsOSLTFgXrzYFwmeoxp6OTEn
         i7Mz9F0/sLq6vMbk3BB30ZlYBKS6UhO9yLGW/dtXyuQv+okfwZNMv8Eehc9defoS0hD4
         2yAf5AVoV+5U29LkPDyFJ9K0ramjGrQyYi3KkPoH5D/Eeq757YxxGYCMo+TRpSZHhzIj
         fvvmzoT195K5vxmfi/giIftKsc/WOR+rorxWjwW2j3j9itsP/Grzhqko2occ0ZF7n92A
         b/wtkjEpJNSLTnQ90rFVwiAJ1jl2KhF7DzuM1FknrkBXnHr4aa409oeZhhCsakLjXFQD
         gNWw==
X-Gm-Message-State: APjAAAWfDsBWYX2vbQ0sCw4tYJISQjBC3LAy4Apwo1qDr50kGAwUvLOC
        iMXmU6DmQLlBT3+oskMe9+sVcage
X-Google-Smtp-Source: APXvYqx8nNgWfOy3YsEuI035ZJtJxrcmW/OEtDiaCfFfuXtz48FdNq3RN4AauktdYmIR3D4RdTeniQ==
X-Received: by 2002:ac8:525a:: with SMTP id y26mr61149593qtn.378.1564050679577;
        Thu, 25 Jul 2019 03:31:19 -0700 (PDT)
Received: from quaco.ghostprotocols.net (189-92-255-60.3g.claro.net.br. [189.92.255.60])
        by smtp.gmail.com with ESMTPSA id n5sm27736115qta.29.2019.07.25.03.31.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:31:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 56D1A40340; Thu, 25 Jul 2019 07:31:14 -0300 (-03)
Date:   Thu, 25 Jul 2019 07:31:14 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 71/79] libperf: Add install targets
Message-ID: <20190725103114.GE9306@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-72-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-72-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:24:58PM +0200, Jiri Olsa escreveu:
> Add install targets (mostly copied from lib/bpf),
> it's now possible to install libperf with:
> 
>   $ make DESTDIR=/tmp/krava  install
>     INSTALL  libperf.a
>     INSTALL  libperf.so
>     INSTALL  libperf.so.0
>     INSTALL  libperf.so.0.0.1
>     INSTALL  headers
>     INSTALL  libperf.pc

'make install' shouldn't install the development parts, just what is
needed by an application dynamicly linking with libperf, right?

And I also noticed that it installs directl in /, i.e. one would have to
include '/usr' in the DESTDIR, which is different from libbpf:

[acme@quaco perf]$ rm -rf /tmp/C
[acme@quaco perf]$ make -C tools/lib/bpf DESTDIR=/tmp/C install
make: Entering directory '/home/acme/git/perf/tools/lib/bpf'
  INSTALL  libbpf.a
  INSTALL  libbpf.so.0.0.4
  INSTALL  libbpf.pc
make: Leaving directory '/home/acme/git/perf/tools/lib/bpf'
[acme@quaco perf]$
[acme@quaco perf]$ find /tmp/C
/tmp/C
/tmp/C/usr
/tmp/C/usr/local
/tmp/C/usr/local/lib64
/tmp/C/usr/local/lib64/pkgconfig
/tmp/C/usr/local/lib64/pkgconfig/libbpf.pc
/tmp/C/usr/local/lib64/libbpf.so.0.0.4
/tmp/C/usr/local/lib64/libbpf.so.0
/tmp/C/usr/local/lib64/libbpf.so
/tmp/C/usr/local/lib64/libbpf.a
[acme@quaco perf]$

I'm applying the patch as we can fix this later, but I think .a, .pc
files do not need to be installed for the main 'install' target, not
even libbpf should do it, do you see any reason why it should?

I.e. we should remove 'install_headers' from the main 'install' target,
I think.

- Arnaldo
 
>   $ find /tmp/krava/
>   /tmp/krava/
>   /tmp/krava/include
>   /tmp/krava/include/perf
>   /tmp/krava/include/perf/evsel.h
>   /tmp/krava/include/perf/evlist.h
>   /tmp/krava/include/perf/threadmap.h
>   /tmp/krava/include/perf/cpumap.h
>   /tmp/krava/include/perf/core.h
>   /tmp/krava/lib64
>   /tmp/krava/lib64/pkgconfig
>   /tmp/krava/lib64/pkgconfig/libperf.pc
>   /tmp/krava/lib64/libperf.so.0.0.1
>   /tmp/krava/lib64/libperf.so.0
>   /tmp/krava/lib64/libperf.so
>   /tmp/krava/lib64/libperf.a
> 
> Link: http://lkml.kernel.org/n/tip-gz16baafdkv6irfkywache2i@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/Makefile            | 69 +++++++++++++++++++++++++++++-
>  tools/perf/lib/libperf.pc.template | 11 +++++
>  2 files changed, 78 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/lib/libperf.pc.template
> 
> diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
> index 25a6476f8b12..e69014a76971 100644
> --- a/tools/perf/lib/Makefile
> +++ b/tools/perf/lib/Makefile
> @@ -14,9 +14,31 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
>  #$(info Determined 'srctree' to be $(srctree))
>  endif
>  
> +INSTALL = install
> +
> +# Use DESTDIR for installing into a different root directory.
> +# This is useful for building a package. The program will be
> +# installed in this directory as if it was the root directory.
> +# Then the build tool can move it later.
> +DESTDIR ?=
> +DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
> +
>  include $(srctree)/tools/scripts/Makefile.include
>  include $(srctree)/tools/scripts/Makefile.arch
>  
> +ifeq ($(LP64), 1)
> +  libdir_relative = lib64
> +else
> +  libdir_relative = lib
> +endif
> +
> +prefix ?=
> +libdir = $(prefix)/$(libdir_relative)
> +
> +# Shell quotes
> +libdir_SQ = $(subst ','\'',$(libdir))
> +libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
> +
>  ifeq ("$(origin V)", "command line")
>    VERBOSE = $(V)
>  endif
> @@ -49,6 +71,8 @@ override CFLAGS += -fvisibility=hidden
>  all:
>  
>  export srctree OUTPUT CC LD CFLAGS V
> +export DESTDIR DESTDIR_SQ
> +
>  include $(srctree)/tools/build/Makefile.include
>  
>  VERSION_SCRIPT := libperf.map
> @@ -60,6 +84,9 @@ VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
>  LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
>  LIBPERF_A  := $(OUTPUT)libperf.a
>  LIBPERF_IN := $(OUTPUT)libperf-in.o
> +LIBPERF_PC := $(OUTPUT)libperf.pc
> +
> +LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
>  
>  $(LIBPERF_IN): FORCE
>  	$(Q)$(MAKE) $(build)=libperf
> @@ -74,14 +101,52 @@ $(LIBPERF_SO): $(LIBPERF_IN)
>  	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
>  
>  
> -libs: $(LIBPERF_A) $(LIBPERF_SO)
> +libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
>  
>  all: fixdep
>  	$(Q)$(MAKE) libs
>  
>  clean:
>  	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
> -                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
> +                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
> +
> +$(LIBPERF_PC):
> +	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
> +		-e "s|@LIBDIR@|$(libdir_SQ)|" \
> +		-e "s|@VERSION@|$(VERSION)|" \
> +		< libperf.pc.template > $@
> +
> +define do_install_mkdir
> +	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
> +	fi
> +endef
> +
> +define do_install
> +	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> +	fi;                                             \
> +	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> +endef
> +
> +install_lib: libs
> +	$(call QUIET_INSTALL, $(LIBPERF_ALL)) \
> +		$(call do_install_mkdir,$(libdir_SQ)); \
> +		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
> +
> +install_headers:
> +	$(call QUIET_INSTALL, headers) \
> +		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
> +		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
> +		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
> +		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
> +		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
> +
> +install_pkgconfig: $(LIBPERF_PC)
> +	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
> +		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
> +
> +install: install_lib install_headers install_pkgconfig
>  
>  FORCE:
>  
> diff --git a/tools/perf/lib/libperf.pc.template b/tools/perf/lib/libperf.pc.template
> new file mode 100644
> index 000000000000..117e4a237b55
> --- /dev/null
> +++ b/tools/perf/lib/libperf.pc.template
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +prefix=@PREFIX@
> +libdir=@LIBDIR@
> +includedir=${prefix}/include
> +
> +Name: libperf
> +Description: perf library
> +Version: @VERSION@
> +Libs: -L${libdir} -lperf
> +Cflags: -I${includedir}
> -- 
> 2.21.0

-- 

- Arnaldo
