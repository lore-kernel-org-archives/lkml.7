Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34242C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BE820659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga6I0Lji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLFO2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:28:00 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41108 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfLFO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:27:59 -0500
Received: by mail-ua1-f67.google.com with SMTP id f7so2876421uaa.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 06:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B4JEnSRg87z0x0xPHWA6J8Y8Owk2lF1jg1xYqroy0QY=;
        b=ga6I0LjiKLuM4hlv9oFWS0ZbjsC3E0cCZ62YwgRk9fuTnh3A3QqTsCTqYdNbPc98Fj
         kKIiODy1Uo+AZr3v1nwJ+CUOSpuBE/RpXHeIk4MsIC9wbG46wClNQ8EatOkNYb5sDsKh
         fohaPINQmRs5GUUTOoVbV51/n5+CmQbrsAt4A/vNsRoIAdJlmnlX49nBgJroo7ESgBLB
         t5En7iyBOLXXEAjBWnJaD8m2JERh0gF9xTu8qLoRiNxoEq+JFlNur7v+vSTf0Dcnu9BT
         S0+/lZrkeFn/FT2Npq94IdqmY6aCEEWy3Ae4R/5d6fO82cwx3nJzWNaXDCk+ph7JGe6h
         jLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B4JEnSRg87z0x0xPHWA6J8Y8Owk2lF1jg1xYqroy0QY=;
        b=EesjnWWsXHQ2OER7ibUUNKceuaGXtJRNeQqfmzpQ3tk6ac6LsBE5LMlE6jPrmidYRm
         3nsPDeOoFka1SWcLpkXm9rbngUa91k7sO7uhLJdkTCRh/S3/pGGJVnyb89IHCs1UMF3V
         BNwTBeCaZ9w3Zw7XHQXQh0HouNm42s9Kw2IJPv8SCkzJ/MEF7XibDdnMAZJzS64y9uhl
         Vtealgmr4vdfQ6Wlslc+wiYEk1vajAq55No8+bvdaK51IeqGjxpiocBNIL/1GfavNNnb
         bG9stUT8+RRAOzMTQhLswxIhsMSxyiwe7/zPsom47ugDGewJNhLjyjKSQckk/480mb0w
         NxQA==
X-Gm-Message-State: APjAAAVFdvqrdlcWNPBYiT5o83DSiQwgF/9A38b/TSZq77cIlkLnCwoD
        Og84U/c8PYMUnOgtqXs7lW0=
X-Google-Smtp-Source: APXvYqyRWZGnVGr/78Fczelk9IbN6JfdtoEazno2a5UbJp4H4s+czWgI/6N9OMro+TNnjCfbC7zBzg==
X-Received: by 2002:ab0:7118:: with SMTP id x24mr12192841uan.29.1575642477940;
        Fri, 06 Dec 2019 06:27:57 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id m63sm5952731uam.12.2019.12.06.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:27:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37E4D40352; Fri,  6 Dec 2019 11:27:54 -0300 (-03)
Date:   Fri, 6 Dec 2019 11:27:54 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/3] libperf: Move libperf under tools/lib/perf
Message-ID: <20191206142754.GC30698@kernel.org>
References: <20191206135513.31586-1-jolsa@kernel.org>
 <20191206135513.31586-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206135513.31586-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 06, 2019 at 02:55:11PM +0100, Jiri Olsa escreveu:
> Moving libperf from its current location under perf
> to separate directory under tools/lib.

Breaks the build/bisection:

[acme@quaco perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make O=/tmp/build/perf  -C tools/perf install-bin
make: Entering directory '/home/acme/git/perf/tools/perf'
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
make[3]: *** /home/acme/git/perf/tools/perf/lib/: No such file or directory.  Stop.
make[2]: *** [Makefile.perf:785: /tmp/build/perf/libperf.a] Error 2
make[2]: *** Waiting for unfinished jobs....
  MKDIR    /tmp/build/perf/fd/
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/exec-cmd.o
  CC       /tmp/build/perf/fd/array.o
  CC       /tmp/build/perf/fs/fs.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/help.o
  LD       /tmp/build/perf/fd/libapi-in.o
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/pager.o
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/str_error_r.o
  CC       /tmp/build/perf/trace-seq.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/parse-options.o
  MKDIR    /tmp/build/perf/staticobjs/
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/run-command.o
  CC       /tmp/build/perf/staticobjs/libbpf.o
  CC       /tmp/build/perf/parse-utils.o
  CC       /tmp/build/perf/kbuffer-parse.o
  MKDIR    /tmp/build/perf/staticobjs/
  CC       /tmp/build/perf/sigchain.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/staticobjs/bpf.o
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/staticobjs/nlattr.o
  CC       /tmp/build/perf/tep_strerror.o
  CC       /tmp/build/perf/event-parse-api.o
  CC       /tmp/build/perf/staticobjs/btf.o
  LD       /tmp/build/perf/libapi-in.o
  LD       /tmp/build/perf/libsubcmd-in.o
  CC       /tmp/build/perf/staticobjs/libbpf_errno.o
  CC       /tmp/build/perf/staticobjs/str_error.o
  CC       /tmp/build/perf/staticobjs/netlink.o
  CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
  AR       /tmp/build/perf/libapi.a
  LD       /tmp/build/perf/libtraceevent-in.o
  CC       /tmp/build/perf/staticobjs/libbpf_probes.o
  CC       /tmp/build/perf/staticobjs/xsk.o
  AR       /tmp/build/perf/libsubcmd.a
  CC       /tmp/build/perf/staticobjs/btf_dump.o
  CC       /tmp/build/perf/staticobjs/hashmap.o
  LINK     /tmp/build/perf/libtraceevent.a
  LD       /tmp/build/perf/staticobjs/libbpf-in.o
  LINK     /tmp/build/perf/libbpf.a
  PERF_VERSION = 5.4.ge59599b355da
make[1]: *** [Makefile.perf:225: sub-make] Error 2
make: *** [Makefile:110: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'
[acme@quaco perf]$
