Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C70C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1FC2243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt22LJec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfKTLWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:22:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfKTLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:22:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id y23so27059381ljh.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTkXgjkYRybCH/ZS4RWR8tpgnHj6/1Pw2cuT0ewUYO8=;
        b=Xt22LJecb0aZixz44RtWTZ5wWdFSf2CFyf9ta6FjFahun+oKUHy7c6hGli6dUFoGKY
         OhyZQwNIqUpZVWhdcHe8b8hhhlNM9KZN3/6tNwt7ktLmjqqh6pNxhNWhElx/jj+ZgS0b
         zxzMXq7o/Wa5zT3yxyrdFi0ip1H6bNyE46sC00urjGlxwYV4lx/H/N/PG9zsp6Ayvf6d
         BIGZL6bId0oK4nnJ6HUmqYOgWf3RvxqA4YoPOAMZ8OIdG+Tksv9fu57thSEI5ClsoZne
         MrrN7tufYt5azx/hgZocTofRZp4pC1FMkfPWzYcXhCWAjlVAXD4/fAw1v/vsNb4IHU1I
         hDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTkXgjkYRybCH/ZS4RWR8tpgnHj6/1Pw2cuT0ewUYO8=;
        b=pVD+aT2G4htvBAUZ9ZE3jCnZRyDikcpScyR5aQ14YWnaNuiRWBxVKBVgV8O/kA38E/
         AyvIB8HpeIyIJJDEupZoB8nxcMrMqutRXwVrkOVtM4JEfQUI0TViBrUAkajBNd3hPp8c
         LhLE+6DBNZUDyWjPWYAY3nplAJ9GPMwy3tt9+aKuWwNvioTLwsvxEXB9ZdwocQJZ6pc9
         oZRThufj72zX4DChRYxK6cdH+C/fAArHlE61NYhRZmDt/Rr1JtMndLGA1P7RDGyAEOe3
         R0MzWtduPiCGcK5yREs5Ei/Ta3Mk70A4a0ROOYDNkNDXJ+ccmrDczmLY925vhssrlURa
         xw8g==
X-Gm-Message-State: APjAAAW0qlnVX2+jMM4vvvmzS+2gwevXIAjKfz+lJcUs3s5nHVJU/W4a
        Jhv042ItmmuPUj5kZ2yKro0sWWnFlZFhl5uAKsSQOg==
X-Google-Smtp-Source: APXvYqx8/Ld2bcP/DCH7muH6RTT5RJVfqWwIO9KUyYktuYJLrzxNJzvAwt0iX9ypsOo9I33kzcF59aYo5vjIrcGo7to=
X-Received: by 2002:a2e:b0d3:: with SMTP id g19mr2176648ljl.135.1574248960061;
 Wed, 20 Nov 2019 03:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20191120203434.2a0727b3@canb.auug.org.au>
In-Reply-To: <20191120203434.2a0727b3@canb.auug.org.au>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Nov 2019 16:52:28 +0530
Message-ID: <CA+G9fYufQjPVsDATdyDn+xtxD1FrwnVGKJ+bpVAxvoropJ=7hg@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 20
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf build failed on linux next for i386 and armv7.

On Wed, 20 Nov 2019 at 15:04, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Changes since 20191119:
>
> The net tree gained a conflict against Linus' tree.
>
> Non-merge commits (relative to Linus' tree): 11697
>  10361 files changed, 506041 insertions(+), 224327 deletions(-)

i386 build failed log,
---------------------------
 In file included from libbpf.c:52:0:
 libbpf.c: In function 'bpf_program__collect_reloc':
 libbpf_internal.h:59:22: error: format '%lu' expects argument of type
 'long unsigned int', but argument 3 has type 'Elf64_Addr {aka long
long unsigned int}' [-Werror=format=]
   libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                       ^
 libbpf_internal.h:62:27: note: in expansion of macro '__pr'
  #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                            ^~~~
 libbpf.c:1874:5: note: in expansion of macro 'pr_warn'
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
      ^~~~~~~
 libbpf.c:1874:38: note: format string is defined here
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
                                     ~~^
                                     %llu
 Makefile:652: arch/x86/Makefile: No such file or directory
 cc1: all warnings being treated as errors

 find: unknown predicate `-m32/arch'

 Try 'find --help' for more information.
   CC       perf/1.0-r9/perf-1.0/staticobjs/libbpf_probes.o
 i686-linaro-linux-gcc: warning: '-x c' after last input file has no effect
   CC       perf/1.0-r9/perf-1.0/staticobjs/xsk.o
 i686-linaro-linux-gcc: error: unrecognized command line option
'-m32/include/uapi/asm-generic/errno.h'
 i686-linaro-linux-gcc: fatal error: no input files
 compilation terminated.

arm build log:
------------------
 Makefile:652: arch/arm/Makefile: No such file or directory
 In file included from libbpf.c:52:0:
 libbpf.c: In function 'bpf_program__collect_reloc':
 libbpf_internal.h:59:22: error: format '%lu' expects argument of type
 'long unsigned int', but argument 3 has type 'Elf64_Addr {aka long
long unsigned int}' [-Werror=format=]
   libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                       ^
 libbpf_internal.h:62:27: note: in expansion of macro '__pr'
  #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                            ^~~~
 libbpf.c:1874:5: note: in expansion of macro 'pr_warn'
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
      ^~~~~~~
 libbpf.c:1874:38: note: format string is defined here
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
                                     ~~^
                                     %llu

ref:
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/650/consoleText
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/650/consoleText

- Naresh
