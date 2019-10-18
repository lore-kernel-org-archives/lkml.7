Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1440320640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJme9gtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439678AbfJRSOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:14:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41369 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfJRSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:14:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so6133242qkg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hJL3W28tsNJSycsf4FFWxvi2b25HysnBbI9G2GYJqtM=;
        b=ZJme9gtMXLi63+oalJklVHrSJpffanpC5g/2Sh9fTuAyGInfpt6F1Q2qQbCsLjsRxZ
         t5WVOYzJTQaY31eCG1syRSg9nhLI4fTOdpnB8WlzCqwPa22pKWWe3fsz4tUWvM0z0h1Y
         wnQNgT4Nm/cznjCNip/u6r1yblEFyj95YyToJtu5DDv9sGOsAzpTIXpBfj0KSm5z5uJr
         nmA0PVhWoMFJxWsEu7VHDeU3gxkZsQfA6zCMqJ3fQMdCchYEmOCVTXpCamce56HMO1Xd
         CUTAIJ6Il0DRIMD0jm4Ya25bzD4ssboWISTdN2YcsHcgdkHFq+YW9reAvzi7ISoaG7T+
         f1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hJL3W28tsNJSycsf4FFWxvi2b25HysnBbI9G2GYJqtM=;
        b=O0u63yk4MaJz5GNo1Szs2ULuzew9Wo+z91EygthpcReg4m74ybNSktrEc+in/3H0g2
         bwePOMUa9ULhBuX87nrTalkYlJ3FwZfcw3k3M1M49Y+MznFq1fsV7PNujatieCTmlQIX
         15BGha0wEQgLIWM3XROvSqqmbR2/sOyx6FJSFCFkj5GRdSkwSvXH40MfnKrIYgOzAaal
         IOuBgLn5sN/BRXh/Z/RucjWbHzf3xOSAMtD3SDXW2Gnvin7BF+RSfawxvFGksRpAyjK0
         QCku3tCzUmWoVR03uO2PEdzIWHdRazbM73zExyKe6QNkVGrEkMIv2fap0VrYMoTCMRMM
         J35A==
X-Gm-Message-State: APjAAAUU33QVhKwCo382QFW2pi6cLexLQWehMR+5i+PmexzmRfwm6QI9
        ObNl4RoLMBES57ZLE3QoeOhiI79H
X-Google-Smtp-Source: APXvYqxqKDmbchFAi1pcx5Co5J0cd4sJuZAO++pWANLJ2Mo8ggm/Pg33UAGpMyFFWsVYAq3YpM1r0Q==
X-Received: by 2002:a37:93c4:: with SMTP id v187mr10228122qkd.490.1571422475663;
        Fri, 18 Oct 2019 11:14:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-170-47.3g.claro.net.br. [179.240.170.47])
        by smtp.gmail.com with ESMTPSA id a190sm3609897qkf.118.2019.10.18.11.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:14:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42A224DD66; Fri, 18 Oct 2019 15:14:29 -0300 (-03)
Date:   Fri, 18 Oct 2019 15:14:29 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 07/10] libperf: Add tests_mmap_cpus test
Message-ID: <20191018181429.GE1797@kernel.org>
References: <20191017105918.20873-1-jolsa@kernel.org>
 <20191017105918.20873-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017105918.20873-8-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 17, 2019 at 12:59:15PM +0200, Jiri Olsa escreveu:
> Adding mmaping tests that generates prctl call on
> every cpu validates it gets all the related events
> in ring buffer.

So _here_ we need _GNU_SOURCE, for this specific test:

  LINK     test-evlist-a
test-evlist.c: In function ‘test_mmap_cpus’:
test-evlist.c:352:8: warning: implicit declaration of function ‘sched_getaffinity’ [-Wimplicit-function-declaration]
  352 |  err = sched_getaffinity(0, sizeof(saved_mask), &saved_mask);
      |        ^~~~~~~~~~~~~~~~~
test-evlist.c:358:3: warning: implicit declaration of function ‘CPU_ZERO’ [-Wimplicit-function-declaration]
  358 |   CPU_ZERO(&mask);
      |   ^~~~~~~~
test-evlist.c:359:3: warning: implicit declaration of function ‘CPU_SET’ [-Wimplicit-function-declaration]
  359 |   CPU_SET(cpu, &mask);
      |   ^~~~~~~
test-evlist.c:361:9: warning: implicit declaration of function ‘sched_setaffinity’ [-Wimplicit-function-declaration]
  361 |   err = sched_setaffinity(0, sizeof(mask), &mask);
      |         ^~~~~~~~~~~~~~~~~
/usr/bin/ld: /tmp/ccOhNrLC.o: in function `test_mmap_cpus':
/home/acme/git/perf/tools/perf/lib/tests/test-evlist.c:358: undefined reference to `CPU_ZERO'
/usr/bin/ld: /home/acme/git/perf/tools/perf/lib/tests/test-evlist.c:359: undefined reference to `CPU_SET'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:22: test-evlist-a] Error 1
make: *** [Makefile:143: tests] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
[root@quaco perf]#
 
> Link: http://lkml.kernel.org/n/tip-9qdckblmgjm42ofd7haflso0@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/tests/test-evlist.c | 97 ++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
> index 90a1869ba4b1..d8c52ebfa53a 100644
> --- a/tools/perf/lib/tests/test-evlist.c
> +++ b/tools/perf/lib/tests/test-evlist.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
> +#include <sched.h>
>  #include <stdarg.h>
>  #include <unistd.h>
>  #include <stdlib.h>
> @@ -299,6 +300,101 @@ static int test_mmap_thread(void)
>  	return 0;
>  }
>  
> +static int test_mmap_cpus(void)
> +{
> +	struct perf_evlist *evlist;
> +	struct perf_evsel *evsel;
> +	struct perf_mmap *map;
> +	struct perf_cpu_map *cpus;
> +	struct perf_event_attr attr = {
> +		.type             = PERF_TYPE_TRACEPOINT,
> +		.sample_period    = 1,
> +		.wakeup_watermark = 1,
> +		.disabled         = 1,
> +	};
> +	cpu_set_t saved_mask;
> +	char path[PATH_MAX];
> +	int id, err, cpu, tmp;
> +	union perf_event *event;
> +	int count = 0;
> +
> +	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
> +		 sysfs__mountpoint());
> +
> +	if (filename__read_int(path, &id)) {
> +		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
> +		return -1;
> +	}
> +
> +	attr.config = id;
> +
> +	cpus = perf_cpu_map__new(NULL);
> +	__T("failed to create cpus", cpus);
> +
> +	evlist = perf_evlist__new();
> +	__T("failed to create evlist", evlist);
> +
> +	evsel = perf_evsel__new(&attr);
> +	__T("failed to create evsel1", evsel);
> +
> +	perf_evlist__add(evlist, evsel);
> +
> +	perf_evlist__set_maps(evlist, cpus, NULL);
> +
> +	err = perf_evlist__open(evlist);
> +	__T("failed to open evlist", err == 0);
> +
> +	err = perf_evlist__mmap(evlist, 4);
> +	__T("failed to mmap evlist", err == 0);
> +
> +	perf_evlist__enable(evlist);
> +
> +	err = sched_getaffinity(0, sizeof(saved_mask), &saved_mask);
> +	__T("sched_getaffinity failed", err == 0);
> +
> +	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
> +		cpu_set_t mask;
> +
> +		CPU_ZERO(&mask);
> +		CPU_SET(cpu, &mask);
> +
> +		err = sched_setaffinity(0, sizeof(mask), &mask);
> +		__T("sched_setaffinity failed", err == 0);
> +
> +		prctl(0, 0, 0, 0, 0);
> +	}
> +
> +	err = sched_setaffinity(0, sizeof(saved_mask), &saved_mask);
> +	__T("sched_setaffinity failed", err == 0);
> +
> +	perf_evlist__disable(evlist);
> +
> +	perf_evlist__for_each_mmap(evlist, map, false) {
> +		if (perf_mmap__read_init(map) < 0)
> +			continue;
> +
> +		while ((event = perf_mmap__read_event(map)) != NULL) {
> +			count++;
> +			perf_mmap__consume(map);
> +		}
> +
> +		perf_mmap__read_done(map);
> +	}
> +
> +	/* calls perf_evlist__munmap/perf_evlist__close */
> +	perf_evlist__delete(evlist);
> +
> +	/*
> +	 * The generated prctl events should match the
> +	 * number of cpus or be bigger (we are system-wide).
> +	 */
> +	__T("failed count", count >= perf_cpu_map__nr(cpus));
> +
> +	perf_cpu_map__put(cpus);
> +
> +	return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	__T_START;
> @@ -309,6 +405,7 @@ int main(int argc, char **argv)
>  	test_stat_thread();
>  	test_stat_thread_enable();
>  	test_mmap_thread();
> +	test_mmap_cpus();
>  
>  	__T_OK;
>  	return 0;
> -- 
> 2.21.0

-- 

- Arnaldo
