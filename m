Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4F1C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E4B216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIHF/Ync"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfGIAtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:49:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45254 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGIAtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:49:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so14763948qkj.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zlQpR9ktKWBZQ8/f/kNBJvJxSiKsk8UCyHR29xOrEqU=;
        b=mIHF/YncNEDg9srHZGFF71sVCPQVo8MiLf5jEOriCPFtPzCDege9eKcU9xM4b6x+sF
         Czsg881Dds04etsCCpGBGQ8TWM3UTqbbiKraF6nnZNst1pihWN6DQk7dNFHfhs7hU+8I
         Pgl3k0VNXEb2tob8ffBh8/icmCaJgXCaC0HEOE6M7nylXsQ1TIx7KY7bZ7ep1UmVZ59D
         5ntWR8xf6GAsUKThRnSkeiWsoViePWQHcIN1Jroi8wx8GaQ7gw3xh9bjwlFWm7PulOSY
         WTPWqdciVmJLfngKhw9iDlXTKC68OOgG7SXvIM/yGF+U01TPEUfyBNdIWOsGE+VqlBRK
         ty8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zlQpR9ktKWBZQ8/f/kNBJvJxSiKsk8UCyHR29xOrEqU=;
        b=oi+TcRIXLTmEPtzyX/ju/dmy2TWTrZhTFLHgZYF26Oya0R9++yp/T9HnRCv8kp+Ouy
         MN0yvCLnzZrZ4yTvkvEJ1t64/OtK2a9kO7Y2KWOM2nn5v7AVpOTCG5ZzL7PoguexcpAs
         C2ucAMJ3jqI+J0J1Lj/BqL0YgrKvFjUEXWa/VXd6Oq0jm/DFQ1bDjj5AqZb1fuB0L8Cj
         ovBgnWlxdh94q7XSW/Q/x/qx1X22KLejY0MhiSyIQv2wYVY3TQ7u7vSkonGTtqV+u6dQ
         QG71uQSNMGDwoMLewvojWifUqPDDJQNOSm0dVs7EW6a+glT3sIhO0DxBaKk/5H2ojeS1
         24vw==
X-Gm-Message-State: APjAAAVfDmi2y/G7eK/8E0KaHfGZB7ixAUcyOJR+n0P7fhdVkL+2rUkZ
        LpxKxBVeBUWmq4GJt1qeQE4=
X-Google-Smtp-Source: APXvYqx4feh2FymJl9r9giyJJCkbphlyw0VyhpRmHBNIZAuJTyKmggl7w87an6+bh3UV0G9eh1wyEA==
X-Received: by 2002:a37:4c92:: with SMTP id z140mr16297606qka.245.1562633387771;
        Mon, 08 Jul 2019 17:49:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id a21sm5060643qka.113.2019.07.08.17.49.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 17:49:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D02140340; Mon,  8 Jul 2019 21:49:43 -0300 (-03)
Date:   Mon, 8 Jul 2019 21:49:43 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH] Fix perf-hooks test for sanitizers
Message-ID: <20190709004943.GA25880@kernel.org>
References: <20190708215928.167905-1-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708215928.167905-1-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 08, 2019 at 02:59:28PM -0700, Numfor Mbiziwo-Tiapo escreveu:
> The perf-hooks test fails with Address Sanitizer and Memory
> Sanitizer builds because it purposefully generates a segfault.
> Checking if these sanitizers are active when running this test
> will allow the perf-hooks test to pass.
> 
> This can be replicated by running (from the tip directory):
> 
> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=address \
> -DADDRESS_SANITIZER=1"
> 
> then running tools/perf/perf test 55
> 
> Fix past to pass:
> The raised signal was changed from SIGSEGV to SIGILL to get the test 
> to pass on our local machines which use clang 4.

We still need a little bit more info, because I couldn't find libasan in
the clang that ships with fedora:30 and not on the selection used to
build from the clang repo in my machine:

[acme@quaco perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
[acme@quaco perf]$ make -C tools/perf CC=clang EXTRA_CFLAGS="-fsanitize=address -DADDRESS_SANITIZER=1" O=/tmp/build/perf
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep

Auto-detecting system features:
...                         dwarf: [ OFF ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ OFF ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ OFF ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ OFF ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ OFF ]
...                        libaio: [ OFF ]
...                       libzstd: [ OFF ]
...        disassembler-four-args: [ OFF ]

Makefile.config:368: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.
make[1]: *** [Makefile.perf:219: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'
[acme@quaco perf]$ cat /tmp/build/perf/feature/test-glibc.make.output
/usr/bin/ld: cannot find /opt/llvm/lib/clang/9.0.0/lib/linux/libclang_rt.asan-x86_64.a: No such file or directory
clang-8: error: linker command failed with exit code 1 (use -v to see invocation)
[acme@quaco perf]$

So I'll check and select that to get to the set of instructions needed
to use this.

- Arnaldo
 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/tests/perf-hooks.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
> index a693bcf017ea..3f5f4b28cf01 100644
> --- a/tools/perf/tests/perf-hooks.c
> +++ b/tools/perf/tests/perf-hooks.c
> @@ -7,7 +7,14 @@
>  #include "util.h"
>  #include "perf-hooks.h"
>  
> -static void sigsegv_handler(int sig __maybe_unused)
> +#if defined(ADDRESS_SANITIZER) || defined(MEMORY_SANITIZER) || \
> +defined(THREAD_SANITIZER) || defined(SAFESTACK_SANITIZER)
> +#define USE_SIGNAL 1
> +#else
> +#define USE_SIGNAL 0
> +#endif
> +
> +static void signal_handler(int sig __maybe_unused)
>  {
>  	pr_debug("SIGSEGV is observed as expected, try to recover.\n");
>  	perf_hooks__recover();
> @@ -25,6 +32,9 @@ static void the_hook(void *_hook_flags)
>  	*hook_flags = 1234;
>  
>  	/* Generate a segfault, test perf_hooks__recover */
> +#if USE_SIGNAL
> +	raise(SIGILL);
> +#endif
>  	*p = 0;
>  }
>  
> @@ -32,7 +42,7 @@ int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unuse
>  {
>  	int hook_flags = 0;
>  
> -	signal(SIGSEGV, sigsegv_handler);
> +	signal(USE_SIGNAL ? SIGILL : SIGSEGV, signal_handler);
>  	perf_hooks__set_hook("test", the_hook, &hook_flags);
>  	perf_hooks__invoke_test();
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 

- Arnaldo
