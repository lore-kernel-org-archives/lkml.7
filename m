Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF02BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AD6206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp3ShLqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfGYKjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:39:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33161 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGYKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:39:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so44324665qtt.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTj7l7g0gii2rnIGEmaatmmcnfI6es82gD2PUd9QAuI=;
        b=Lp3ShLqUg2gl2nwkaWL16PbNLUrZ3rrewybSLu6JasZsMapUjw9HmMUwA5I9rzy1Rd
         ep5knQoYunl4Bga5EFN8igy7GWrezqaHt01NYKuARrKU3il3C5O5sTZIFjBPMGEVd5KW
         xP+0tAYxgbODg2PMTuq+ts4Wjoy7C9DEIWowhhfYgLd7d5IU5ADM1rOQKNM99ITIAARn
         dxQtoNf68LR7ZejpcktWx0URJXBisSJdDjAfC92WwwFN/UUufVKaCOk1xf10uuxpuRWC
         NedL/oYEpEb/a0Mg08APjuGj1WL5Fe1DzdgWLrds+trWUu0BUdqFt6ZJoIVTEyAzPX1Y
         GmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTj7l7g0gii2rnIGEmaatmmcnfI6es82gD2PUd9QAuI=;
        b=jBMgRkT0gWORjGqRGP4Jo74W5yGGRBfcJnUdRwgMsJuEr9TDkUeQWpnAwNodpKc7Q3
         nl/Y1LZt4PdzQGwG+ieBn8LgiV3kPRcxCsc5CJDCdc8zmSQ0xO9flazNLgoboP5XVx7l
         YLj7E15DBMI22mKE731f9tYXzgMP2TDVVBvbjfqk/FAdPSugkyx2uCJpw+1QWScxmPmg
         eSd3EstctpuhUPVJ+cAdFlYt3+Qare4wYyK5PsHJlruWvawe8wFnXY9hMBuR9PldXUcE
         GZJLzDIW/ijD2+vwOLBpsAq86tRWv5wmbcG+J8kNquZ5b3RWbTPwdWiAcQLu9lJLdhpm
         Dd6A==
X-Gm-Message-State: APjAAAWbUxYuBduJA49Expdrbm2K809AhwaKhIY0A7rt5HSLKlr2TbbR
        TY5o1fbpnlqqF/dE8+a9ERE=
X-Google-Smtp-Source: APXvYqx0jeS7nGgOOOoZ7liIz4nu82G/rBPyEa5k4NlEfwl8XJYKAUtblZdjoaUgR3EzzWVn9Sk+pw==
X-Received: by 2002:a0c:fa8b:: with SMTP id o11mr63020162qvn.6.1564051179551;
        Thu, 25 Jul 2019 03:39:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net (189-92-255-60.3g.claro.net.br. [189.92.255.60])
        by smtp.gmail.com with ESMTPSA id a21sm22974810qka.113.2019.07.25.03.39.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:39:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A195D40340; Thu, 25 Jul 2019 07:39:33 -0300 (-03)
Date:   Thu, 25 Jul 2019 07:39:33 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 73/79] libperf: Add perf_cpu_map test
Message-ID: <20190725103933.GF9306@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-74-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-74-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:25:00PM +0200, Jiri Olsa escreveu:
> Add simple perf_cpu_map tests.

Its not honouring O= and requires that we first build libperf in the
source tree, please fix this in a followup patch:

[acme@quaco perf]$ make -C tools/perf/lib clean
make: Entering directory '/home/acme/git/perf/tools/perf/lib'
  CLEAN    libperf
  CLEAN    tests
make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
[acme@quaco perf]$ ls -la tools/perf/lib/tests/
total 16
drwxrwxr-x. 2 acme acme 4096 Jul 25 07:35 .
drwxrwxr-x. 4 acme acme 4096 Jul 25 07:35 ..
-rw-rw-r--. 1 acme acme  857 Jul 25 07:34 Makefile
-rw-rw-r--. 1 acme acme  328 Jul 25 07:34 test-cpumap.c
[acme@quaco perf]$ make O=/tmp/build/perf -C tools/perf/lib/ tests
make: Entering directory '/home/acme/git/perf/tools/perf/lib'
  LINK     test-cpumap-a
gcc: error: ../libperf.a: No such file or directory
make[1]: *** [Makefile:22: test-cpumap-a] Error 1
make: *** [Makefile:115: tests] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
[acme@quaco perf]$

libperf itself is honouring O=:

[acme@quaco perf]$ make O=/tmp/build/perf -C tools/perf/lib
make: Entering directory '/home/acme/git/perf/tools/perf/lib'
  LINK     /tmp/build/perf/libperf.so.0.0.1
  GEN      /tmp/build/perf/libperf.pc
make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
[acme@quaco perf]$ make O=/tmp/build/perf -C tools/perf/lib  tests
make: Entering directory '/home/acme/git/perf/tools/perf/lib'
  LINK     test-cpumap-a
gcc: error: ../libperf.a: No such file or directory
make[1]: *** [Makefile:22: test-cpumap-a] Error 1
make: *** [Makefile:115: tests] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
[acme@quaco perf]$

Its only when I stop using O= that it works:

[acme@quaco perf]$ make -C tools/perf/lib  
make: Entering directory '/home/acme/git/perf/tools/perf/lib'
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
  CC       core.o
  CC       cpumap.o
  CC       threadmap.o
  CC       evsel.o
  CC       evlist.o
  CC       zalloc.o
  CC       xyarray.o
  CC       lib.o
  LD       libperf-in.o
  AR       libperf.a
  LINK     libperf.so.0.0.1
  GEN      libperf.pc
make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
[acme@quaco perf]$ make O=/tmp/build/perf -C tools/perf/lib  tests
make: Entering directory '/home/acme/git/perf/tools/perf/lib'
  LINK     test-cpumap-a
  LINK     test-cpumap-so
running static:
- running test-cpumap.c...OK
running dynamic:
- running test-cpumap.c...OK
make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
[acme@quaco perf]$

It is already useful albeit this limitation, so I'm applying.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-143x51wped4tlsb06sapbfp0@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/tests/Makefile      |  2 +-
>  tools/perf/lib/tests/test-cpumap.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/lib/tests/test-cpumap.c
> 
> diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
> index de951ae38dea..b72c8c47df61 100644
> --- a/tools/perf/lib/tests/Makefile
> +++ b/tools/perf/lib/tests/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  
> -TESTS =
> +TESTS = test-cpumap
>  
>  TESTS_SO := $(addsuffix -so,$(TESTS))
>  TESTS_A  := $(addsuffix -a,$(TESTS))
> diff --git a/tools/perf/lib/tests/test-cpumap.c b/tools/perf/lib/tests/test-cpumap.c
> new file mode 100644
> index 000000000000..76a43cfb83a1
> --- /dev/null
> +++ b/tools/perf/lib/tests/test-cpumap.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <perf/cpumap.h>
> +#include <internal/tests.h>
> +
> +int main(int argc, char **argv)
> +{
> +	struct perf_cpu_map *cpus;
> +
> +	__T_START;
> +
> +	cpus = perf_cpu_map__dummy_new();
> +	if (!cpus)
> +		return -1;
> +
> +	perf_cpu_map__get(cpus);
> +	perf_cpu_map__put(cpus);
> +	perf_cpu_map__put(cpus);
> +
> +	__T_OK;
> +	return 0;
> +}
> -- 
> 2.21.0

-- 

- Arnaldo
