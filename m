Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71630C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADA520722
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBDq6lAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfK0PXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:23:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38484 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:23:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id b8so4889608qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4MMsHlTT4ZK5MAvXGl6fI1+m5fdySQ8gI1Og3Waa20w=;
        b=QBDq6lAlEs8IzkfAACynPZR1R7XcLduYtSgSSHz1xVm1I4wKnD4cQlPlOG+0i5SQmq
         mOndepW1JR+gfu5Ph1mDChlo+HPKA/PHBI9wyhh6zUl8/Hisvw8Sv+zVk22eVHA9PklZ
         Fa7A2q6M0zS9W5W/OnfXx+gONGYRugiaBoXaSc6qY8OD05HOOU9LjM6wzM1sto2LqDGU
         RvfNt/vE+LIzsKt7Wd6Zqc1olwRVauxQ9PXhzKekdpUzKFvLWMc1bEGSb/M5rC8OQFSx
         WpdGSa0PHldPv4U3lcER+PVK4Ihm3vxRJlYsMdou3N0YzGH7jKf29mGDGEasihfzxx3Y
         QwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4MMsHlTT4ZK5MAvXGl6fI1+m5fdySQ8gI1Og3Waa20w=;
        b=gp+PecMU18CFbQXbV8BaB2xzgMGtKg7oHmHI4hG4ssrhN8KRLI4NLT7nf8Osuw+N3L
         J7jRlIYmSyxQFtBt4MzmVYJ7Enhb+EAlUMwk032TSmXrVfmdC3V5OTW1zUF03E6L/m8s
         8Yqo4CRj6jwtchDl+CSn7PzYR7/qRMTfVUKMBfrFoSZMh/miFO4nPE41n48JsVkB5x4m
         ft772Iut9aiht0UgEYexXmm85/ykjyNwEMTzLkgUOttcSbLdA2Nq06xtUj1LC5y7vkiO
         pB8g8370s8qUv9lKaUrNZfWrNbWZKmWL4xmHznSYcBdHTvWrcOvaoC45rOpy5clb78Q+
         jI4g==
X-Gm-Message-State: APjAAAWEs7WvsSizhnsaRrptSOhMLsCD6TY4qfM989ZPmicgfYJFJhlx
        RTnbv78ZmrG1stSPhPnQ27s=
X-Google-Smtp-Source: APXvYqzoDw3oQZLqdjl6asz/OcS4NdID/sDr0Q2EsfSa80TcBZYZPWOWc+FjQfXsPpLOZq1MFi/MQQ==
X-Received: by 2002:a37:6f07:: with SMTP id k7mr4636010qkc.118.1574868211139;
        Wed, 27 Nov 2019 07:23:31 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e14sm7395183qto.79.2019.11.27.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:23:30 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0855D40D3E; Wed, 27 Nov 2019 12:23:28 -0300 (-03)
Date:   Wed, 27 Nov 2019 12:23:28 -0300
To:     Ian Rogers <irogers@google.com>
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
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf jit: move test functionality in to a test
Message-ID: <20191127152328.GI22719@kernel.org>
References: <20191126235913.41855-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126235913.41855-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 26, 2019 at 03:59:13PM -0800, Ian Rogers escreveu:
> Adds a test for minimal jit_write_elf functionality.

Thanks, tested and applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/Build          |  1 +
>  tools/perf/tests/builtin-test.c |  4 +++
>  tools/perf/tests/genelf.c       | 53 +++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |  1 +
>  tools/perf/util/genelf.c        | 46 ----------------------------
>  5 files changed, 59 insertions(+), 46 deletions(-)
>  create mode 100644 tools/perf/tests/genelf.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index e72accefd669..a738e4a5b301 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -54,6 +54,7 @@ perf-y += unit_number__scnprintf.o
>  perf-y += mem2node.o
>  perf-y += map_groups.o
>  perf-y += time-utils-test.o
> +perf-y += genelf.o
>  
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>  	$(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 8b286e9b7549..6ab2e2346aab 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -300,6 +300,10 @@ static struct test generic_tests[] = {
>  		.desc = "map_groups__merge_in",
>  		.func = test__map_groups__merge_in,
>  	},
> +	{
> +		.desc = "Test jit_write_elf",
> +		.func = test__jit_write_elf,
> +	},
>  	{
>  		.func = NULL,
>  	},
> diff --git a/tools/perf/tests/genelf.c b/tools/perf/tests/genelf.c
> new file mode 100644
> index 000000000000..d392e9300881
> --- /dev/null
> +++ b/tools/perf/tests/genelf.c
> @@ -0,0 +1,53 @@
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
> +static unsigned char x86_code[] = {
> +	0xBB, 0x2A, 0x00, 0x00, 0x00, /* movl $42, %ebx */
> +	0xB8, 0x01, 0x00, 0x00, 0x00, /* movl $1, %eax */
> +	0xCD, 0x80            /* int $0x80 */
> +};
> +
> +int test__jit_write_elf(struct test *test __maybe_unused,
> +			int subtest __maybe_unused)
> +{
> +#ifdef HAVE_JITDUMP
> +	char path[PATH_MAX];
> +	int fd, ret;
> +
> +	strcpy(path, TEMPL);
> +
> +	fd = mkstemp(path);
> +	if (fd < 0) {
> +		perror("mkstemp failed");
> +		return TEST_FAIL;
> +	}
> +
> +	pr_info("Writing jit code to: %s\n", path);
> +
> +	ret = jit_write_elf(fd, 0, "main", x86_code, sizeof(x86_code),
> +			NULL, 0, NULL, 0, 0);
> +	close(fd);
> +
> +	unlink(path);
> +
> +	return ret ? TEST_FAIL : 0;
> +#else
> +	return TEST_SKIPPED;
> +#endif
> +}
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 9837b6e93023..5a53ab7294e9 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -109,6 +109,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
>  int test__mem2node(struct test *t, int subtest);
>  int test__map_groups__merge_in(struct test *t, int subtest);
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
>  	return retval;
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
> -	int c, fd, ret;
> -
> -	while ((c = getopt(argc, argv, "o:h")) != -1) {
> -		switch (c) {
> -		case 'o':
> -			options.output = optarg;
> -			break;
> -		case 'h':
> -			printf("Usage: genelf -o output_file [-h]\n");
> -			return 0;
> -		default:
> -			errx(1, "unknown option");
> -		}
> -	}
> -
> -	fd = open(options.output, O_CREAT|O_TRUNC|O_RDWR, 0666);
> -	if (fd == -1)
> -		err(1, "cannot create file %s", options.output);
> -
> -	ret = jit_write_elf(fd, "main", x86_code, sizeof(x86_code));
> -	close(fd);
> -
> -	if (ret != 0)
> -		unlink(options.output);
> -
> -	return ret;
> -}
> -#endif
> -- 
> 2.24.0.432.g9d3f5f5b63-goog

-- 

- Arnaldo
