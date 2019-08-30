Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B3AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF2523431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7AgEi0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfH3T7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:59:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39069 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3T7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:59:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so7232263qki.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XbwkQOPlRIHCQ2tWufAsblL/1ZkDgscti8mmmpfdDl0=;
        b=A7AgEi0OimXUtJ+jQebzimbPm3megR3P8h4d8jYhRXWQ08kjRw/H03cwsLBUu+KWIM
         vHkNlm7RYy36hRwqi0Nqq9r3KkW+7I7O/VVWnH4kN1JJaXGDdNuNNDhgnkbzC7B8M2pA
         z69xb0S0rOcQo6Cpwm1hTu/Jr4PHBW0LDEUUQvg+rp1K2qvboe2qdbexIh1jJCFAZ0S2
         bhch2UXElnWqIBkS0mELwxhfsFuzGIolfW+tuxOgGwE94BV/WuHjfraR93uF7+0/4hhI
         UQNc0vEFXGAqXtFL1AslwGTEDYxZsDUDsOLQFlvR+4WW0ZfedXDPYehJyKSlqW02cbuW
         K/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XbwkQOPlRIHCQ2tWufAsblL/1ZkDgscti8mmmpfdDl0=;
        b=c2MOMNwXgeoN+aBRW+BO1EoQD5a/l7ORSzNcpRu49QDCdo9rMT3xkVIElRMeokd3wT
         guPDEjAKyajAjwrh6BubtgnAlWW5XVwkKNp6lJjihsn7aHWYjFM2kfl2Pw4dhbwPZnwr
         dswxvwFfdqc3QhIfmfGii3+g6jgJdiXlV7bBu67Z329ca758R7chsEfIaHfYB2zVa5Bx
         5XBKphJJKKKy6JBlYpxx1O9lWM33zNwl98gny3kHVZRsNAOuQ/GBiUFzGTbVoaKiJIU7
         DnkMdMx7C3bwx+sNEH6rZbIudET9JW8yIxUKnpCsQuf7PTarh9EHJwgbaRjetys4YfVx
         wGHw==
X-Gm-Message-State: APjAAAXc1EgsvR+3wQkhOf+ASftAXzPm8yTEh50wyWr00F3vtIO/2lEo
        z267o+B/GL46VUlZwC/EoYA=
X-Google-Smtp-Source: APXvYqyVFNm0pT6sYrjML4t7p8ll5UOs7YvEpkxUt1AspC2VoaUml6FqcgZaPMOviL1y2q0Xrv2BkQ==
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr16828116qkj.116.1567195184652;
        Fri, 30 Aug 2019 12:59:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-100-20.3g.claro.net.br. [187.26.100.20])
        by smtp.gmail.com with ESMTPSA id n8sm2934992qtr.42.2019.08.30.12.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 12:59:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F1C8A41146; Fri, 30 Aug 2019 16:59:37 -0300 (-03)
Date:   Fri, 30 Aug 2019 16:59:37 -0300
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/4] perf intel-pt: Use shared x86 insn decoder
Message-ID: <20190830195937.GJ28011@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <8a37e615d2880f039505d693d1e068a009358a2b.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a37e615d2880f039505d693d1e068a009358a2b.1567118001.git.jpoimboe@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 29, 2019 at 05:41:21PM -0500, Josh Poimboeuf escreveu:
> +++ b/tools/perf/util/intel-pt-decoder/Build
> @@ -1,7 +1,7 @@
>  perf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
>  
> -inat_tables_script = util/intel-pt-decoder/gen-insn-attr-x86.awk
> -inat_tables_maps = util/intel-pt-decoder/x86-opcode-map.txt
> +inat_tables_script = ../../arch/x86/tools/gen-insn-attr-x86.awk
> +inat_tables_maps = ../../arch/x86/lib/x86-opcode-map.txt

I'm having trouble building it from:

[acme@quaco perf]$ make help | grep perf
  perf-tar-src-pkg    - Build perf-5.3.0-rc6.tar source tarball
  perf-targz-src-pkg  - Build perf-5.3.0-rc6.tar.gz source tarball
  perf-tarbz2-src-pkg - Build perf-5.3.0-rc6.tar.bz2 source tarball
  perf-tarxz-src-pkg  - Build perf-5.3.0-rc6.tar.xz source tarball

I.e. detached tarballs, outside the kernel source tree, also using O=

[acme@quaco perf]$ ls -la perf-5*
ls: cannot access 'perf-5*': No such file or directory
[acme@quaco perf]$ make perf-tarxz-src-pkg ; ls -la perf-5.* 
  TAR
  PERF_VERSION = 5.3.rc6.gc55f04097932
-rw-rw-r--. 1 acme acme 1670016 Aug 30 16:57 perf-5.3.0-rc6.tar.xz
[acme@quaco perf]$ cp perf-5.3.0-rc6.tar.xz /tmp
[acme@quaco perf]$ cd /tmp
[acme@quaco tmp]$ ls -la perf-5*
-rw-rw-r--. 1 acme acme 1670016 Aug 30 16:57 perf-5.3.0-rc6.tar.xz
[acme@quaco tmp]$ tar xf perf-5.3.0-rc6.tar.xz 
[acme@quaco tmp]$ cd perf-5.3.0-rc6/
[acme@quaco perf-5.3.0-rc6]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf 
[acme@quaco perf-5.3.0-rc6]$ make O=/tmp/build/perf -C tools/perf install-bin
make: Entering directory '/tmp/perf-5.3.0-rc6/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]

  GEN      /tmp/build/perf/common-cmds.h
  PERF_VERSION = 5.3.rc6.gc55f04097932
  CC       /tmp/build/perf/exec-cmd.o
  MKDIR    /tmp/build/perf/fd/
  MKDIR    /tmp/build/perf/fs/
<SNIP>
  CC       /tmp/build/perf/util/rwsem.o
  CC       /tmp/build/perf/util/thread-stack.o
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/auxtrace.o
make[5]: *** No rule to make target '../../arch/x86/tools/gen-insn-attr-x86.awk', needed by '/tmp/build/perf/util/intel-pt-decoder/inat-tables.c'.  Stop.
make[5]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/util/intel-pt.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  CC       /tmp/build/perf/util/intel-bts.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
make[4]: *** [/tmp/perf-5.3.0-rc6/tools/build/Makefile.build:139: intel-pt-decoder] Error 2
make[4]: *** Waiting for unfinished jobs....
  CC       /tmp/build/perf/util/arm-spe.o
  LD       /tmp/build/perf/util/scripting-engines/perf-in.o
make[3]: *** [/tmp/perf-5.3.0-rc6/tools/build/Makefile.build:139: util] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile.perf:597: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:221: sub-make] Error 2
make: *** [Makefile:110: install-bin] Error 2
make: Leaving directory '/tmp/perf-5.3.0-rc6/tools/perf'
[acme@quaco perf-5.3.0-rc6]$
