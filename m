Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F9120848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGjCO92S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLBRaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:30:35 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46493 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLBRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:30:34 -0500
Received: by mail-yw1-f65.google.com with SMTP id u139so61729ywf.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2nri4hEgl3FZp2rp79+cDefn58SHk2S/e6ghIhKTcg=;
        b=IGjCO92SUYM15QVy2qjeQOH5BocqjVl5I6dgPxakSVUxjXGCqKXdkbXWZ61tebH3UL
         TV+lSUatJ/f9ELEROnaB65YaWO4wc9HoNZew4xfNguK/6OTYCnYfuyxyyLpIi3CSbtK3
         odsVKYqC1FZV+iwdest/GXrqOfy+0a4FqWFP2ILSMZHIa1OzQ+i7mYWmeT7o2y/MBcOO
         rul9zGMzkEJuSemy7m9sbpOAtWQ1oIj6zkItAnz29PLVr3xg1iZric9Ybh9zebhpjP8k
         YiWZJKQqLXTCjLIwoh98PC0RAWGJWsm9YrPzAKTuHCfJRPd4KCeZT7UlkQTdlZaQgJiu
         +FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2nri4hEgl3FZp2rp79+cDefn58SHk2S/e6ghIhKTcg=;
        b=k2wnULUqW7YiyftiHRP+jsgDNupd46rvSjYRANES8QVv+CKJVzJDfUjDOV46NI+Gok
         YLIUYyfkWqbQMWCdWEnjjY31IHfRNTPoAyf8lKHXXe2IAE0yiGwIq2F6OPd/oICV3C55
         l3FlqavMdNbKUxEm60OMwNTLYFNm5EdDh2pyYPla6BeYjc7WsfHqhDy35I5V8SwW9nf8
         0Md59o224Z26HloKuWCwWtbedxtKnHUCC/CxZYAOmSPqSxvoUL09D+hS4EmFyy5R6HOs
         9kYBbS6fLLW9mmfWGznBky+iX0hP/bJnuVHw3qr4luKT5Er2glEWuSu7HjEiDUsd4lJ8
         M/bg==
X-Gm-Message-State: APjAAAVmvaostD1SVXdbtxlJWdClcloAGaDjpA6opJd3QYplPF69PrLn
        i+YjVV2Ek+ZS1mzSgJgXHBgHID8/E3yrBEiT9rAGmw==
X-Google-Smtp-Source: APXvYqwra4LfS9hrH8cRDHxsyzHdco/m1KPzPjFTYfLGynQpyssoN1qQHsYEe81/tzY16HX4qWjrdD12Cgh/7FKfeKQ=
X-Received: by 2002:a81:55cd:: with SMTP id j196mr15095642ywb.377.1575307830751;
 Mon, 02 Dec 2019 09:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20191126235913.41855-1-irogers@google.com> <20191127152328.GI22719@kernel.org>
 <20191127160558.GM22719@kernel.org> <CAP-5=fVhXvMFtGU18-TMt29BsuZNySZ8sPvj_3r7GGsfZLPvuA@mail.gmail.com>
 <20191128131928.GD4063@kernel.org>
In-Reply-To: <20191128131928.GD4063@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 2 Dec 2019 09:30:19 -0800
Message-ID: <CAP-5=fWYUF7fnvVX1pDeTFg1u7Mfe9=1+E5zBiUX3QGTp2wDHw@mail.gmail.com>
Subject: Re: [PATCH] perf jit: move test functionality in to a test
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 5:19 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Nov 27, 2019 at 10:49:29AM -0800, Ian Rogers escreveu:
> > On Wed, Nov 27, 2019 at 8:06 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Wed, Nov 27, 2019 at 12:23:28PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Nov 26, 2019 at 03:59:13PM -0800, Ian Rogers escreveu:
> > > > > Adds a test for minimal jit_write_elf functionality.
> > > >
> > > > Thanks, tested and applied.
> > >
> > > Had to apply this to have it built in systems where HAVE_JITDUMP isn't
> > > defined:
> >
> > Thanks for fixing this!
> > Ian
>
> This needs some more work, as it is failing in some of the cross build
> containers, for arches not supported by that genelf.h header, where it
> should just detect that this feature shouldn't be used, warn the user
> and build what is possible to build, e.g.:
>
>   CC       /tmp/build/perf/util/evswitch.o
> In file included from tests/genelf.c:15:
> tests/../util/genelf.h:42:2: error: #error "unsupported architecture"
>    42 | #error "unsupported architecture"
>       |  ^~~~~
> tests/../util/genelf.h:51:5: error: "GEN_ELF_CLASS" is not defined, evaluates to 0 [-Werror=undef]
>    51 | #if GEN_ELF_CLASS == ELFCLASS64
>       |     ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> mv: cannot stat '/tmp/build/perf/tests/.genelf.o.tmp': No such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/tests/genelf.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   CC       /tmp/build/perf/util/find_bit.o
>   CC       /tmp/build/perf/util/get_current_dir_name.o
>
>
> There is some wiring up to do here, related to:
> [acme@quaco perf]$ vim tools/perf/Makefile.config
> [acme@quaco perf]$ find . -type f| xargs grep PERF_HAVE_JITDUMP
> grep: ./et: No such file or directory
> grep: vi: No such file or directory
> ^Xgrep: ./perf.data: Permission denied
> ./tools/perf/arch/x86/Makefile:PERF_HAVE_JITDUMP := 1
> ./tools/perf/arch/sparc/Makefile:PERF_HAVE_JITDUMP := 1
> ./tools/perf/arch/arm/Makefile:PERF_HAVE_JITDUMP := 1
> ./tools/perf/arch/arm64/Makefile:PERF_HAVE_JITDUMP := 1
> ./tools/perf/arch/powerpc/Makefile:PERF_HAVE_JITDUMP := 1
> ./tools/perf/arch/s390/Makefile:PERF_HAVE_JITDUMP := 1
> ./tools/perf/Makefile.config:ifdef PERF_HAVE_JITDUMP
> ^C
> [acme@quaco perf]$
>
> But I'll defer this for later, not to hold what I have too much, after
> my next pull req I'll revisit this, if you haven't found a fix by then
> :-)
>
> The current patch is below, with my fixes, and looking at it again it
> seems its just to replace that HAVE_LIBELF_SUPPORT with HAVE_JITDUMP,
> will confirm that later, after sending the pull req to Ingo.
>
> - Arnaldo

Your fix sounds correct, I should work on getting a build test setup.
It sounds like you have it covered but if you need me to do anything
let me know.

Thanks,
Ian

> commit d006842faa9a26feb51b818e02c681f064b83b0a
> Author: Ian Rogers <irogers@google.com>
> Date:   Tue Nov 26 15:59:13 2019 -0800
>
>     perf jit: Move test functionality in to a test
>
>     Adds a test for minimal jit_write_elf functionality.
>
>     Committer testing:
>
>       # perf test jit
>       61: Test jit_write_elf                                    : Ok
>       #
>
>       # perf test -v jit
>       61: Test jit_write_elf                                    :
>       --- start ---
>       test child forked, pid 10460
>       Writing jit code to: /tmp/perf-test-KqxURR
>       test child finished with 0
>       ---- end ----
>       Test jit_write_elf: Ok
>       #
>
>     Committer notes:
>
>     Fix up the case where HAVE_JITDUMP is no defined.
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Alexios Zavras <alexios.zavras@intel.com>
>     Cc: Allison Randal <allison@lohutok.net>
>     Cc: Florian Fainelli <f.fainelli@gmail.com>
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: Kate Stewart <kstewart@linuxfoundation.org>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Michael Petlan <mpetlan@redhat.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Song Liu <songliubraving@fb.com>
>     Cc: Stephane Eranian <eranian@google.com>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Link: http://lore.kernel.org/lkml/20191126235913.41855-1-irogers@google.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index a3c595fba943..1692529639b0 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -54,6 +54,7 @@ perf-y += unit_number__scnprintf.o
>  perf-y += mem2node.o
>  perf-y += maps.o
>  perf-y += time-utils-test.o
> +perf-y += genelf.o
>
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>         $(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 7115aa32a51e..970e2ecfb39f 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -296,6 +296,10 @@ static struct test generic_tests[] = {
>                 .desc = "time utils",
>                 .func = test__time_utils,
>         },
> +       {
> +               .desc = "Test jit_write_elf",
> +               .func = test__jit_write_elf,
> +       },
>         {
>                 .desc = "maps__merge_in",
>                 .func = test__maps__merge_in,
> diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
> new file mode 100644
> index 000000000000..28dfd17a6b9f
> --- /dev/null
> +++ b/tools/perf/tests/genelf.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +
> +#include "debug.h"
> +#include "tests.h"
> +
> +
> +#ifdef HAVE_LIBELF_SUPPORT
> +#include <libelf.h>
> +#include "../util/genelf.h"
> +#endif
> +
> +#define TEMPL "/tmp/perf-test-XXXXXX"
> +
> +int test__jit_write_elf(struct test *test __maybe_unused,
> +                       int subtest __maybe_unused)
> +{
> +#ifdef HAVE_JITDUMP
> +       static unsigned char x86_code[] = {
> +               0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
> +               0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
> +               0xCD, 0x80            /* int $0x80 */
> +       };
> +       char path[PATH_MAX];
> +       int fd, ret;
> +
> +       strcpy(path, TEMPL);
> +
> +       fd = mkstemp(path);
> +       if (fd < 0) {
> +               perror("mkstemp failed");
> +               return TEST_FAIL;
> +       }
> +
> +       pr_info("Writing jit code to: %s\n", path);
> +
> +       ret = jit_write_elf(fd, 0, "main", x86_code, sizeof(x86_code),
> +                       NULL, 0, NULL, 0, 0);
> +       close(fd);
> +
> +       unlink(path);
> +
> +       return ret ? TEST_FAIL : 0;
> +#else
> +       return TEST_SKIP;
> +#endif
> +}
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 25aea387e2bf..0e6d67910b0a 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -109,6 +109,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
>  int test__mem2node(struct test *t, int subtest);
>  int test__maps__merge_in(struct test *t, int subtest);
>  int test__time_utils(struct test *t, int subtest);
> +int test__jit_write_elf(struct test *test, int subtest);
>
>  bool test__bp_signal_is_supported(void);
>  bool test__bp_account_is_supported(void);
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index f9f18b8b1df9..aed49806a09b 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -8,15 +8,12 @@
>   */
>
>  #include <sys/types.h>
> -#include <stdio.h>
> -#include <getopt.h>
>  #include <stddef.h>
>  #include <libelf.h>
>  #include <string.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> -#include <limits.h>
>  #include <fcntl.h>
>  #include <err.h>
>  #ifdef HAVE_DWARF_SUPPORT
> @@ -31,8 +28,6 @@
>  #define NT_GNU_BUILD_ID 3
>  #endif
>
> -#define JVMTI
> -
>  #define BUILD_ID_URANDOM /* different uuid for each run */
>
>  #ifdef HAVE_LIBCRYPTO
> @@ -511,44 +506,3 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
>
>         return retval;
>  }
> -
> -#ifndef JVMTI
> -
> -static unsigned char x86_code[] = {
> -    0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
> -    0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
> -    0xCD, 0x80            /* int $0x80 */
> -};
> -
> -static struct options options;
> -
> -int main(int argc, char **argv)
> -{
> -       int c, fd, ret;
> -
> -       while ((c = getopt(argc, argv, "o:h")) != -1) {
> -               switch (c) {
> -               case 'o':
> -                       options.output = optarg;
> -                       break;
> -               case 'h':
> -                       printf("Usage: genelf -o output_file [-h]\n");
> -                       return 0;
> -               default:
> -                       errx(1, "unknown option");
> -               }
> -       }
> -
> -       fd = open(options.output, O_CREAT|O_TRUNC|O_RDWR, 0666);
> -       if (fd == -1)
> -               err(1, "cannot create file %s", options.output);
> -
> -       ret = jit_write_elf(fd, "main", x86_code, sizeof(x86_code));
> -       close(fd);
> -
> -       if (ret != 0)
> -               unlink(options.output);
> -
> -       return ret;
> -}
> -#endif
