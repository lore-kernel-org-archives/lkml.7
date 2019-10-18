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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E23DCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EF420820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs1ldh9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394203AbfJRSQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:16:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38629 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390705AbfJRSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:16:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so10400024qta.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pjI/VRMA4GwKa+oqoITr46wRcG9xFLi4SsEed7cYFg0=;
        b=Hs1ldh9zw6HlfTNA5GN8fiM1JARuNkqkCrN6fsRcytJuggQDUHmMtk2rz9VPxd2B3g
         FjUtnjPmamJAKZe9OTtpJToKwJSSScxocUvefbKLYjzDZb1vX+CqIqq4JxaZzPGYwlUy
         B/i3oZZIso46oEHNIcw20TUwGJdoFuDMkaa9f+aOyQDuCgY442IShuqCaC2Pn4dqX73s
         0rXTgY4cUUAgB9VzzNJqvOFD0C9vPmrTM4f++4W69zH2pxT7VkK0qsx80QFZXU6xnOBS
         h48+CIItmSdd6kCVTGwSEuiAkwJChngbHT/HD8FtZ88wjYlNLH7vBvGOGETXP53zzEJn
         x4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pjI/VRMA4GwKa+oqoITr46wRcG9xFLi4SsEed7cYFg0=;
        b=hOAhKQHw4TjOam9nqJp+/LS70PBKe84pUD2sq/XIWlXnlinZt/96N1Sy1catX8/LZG
         N5YvN97oVI7bHMfifYxJZF/ASxkUVroH6yBfHWIIx78zYcc4bo0CvcfOGd53ECF1UiHr
         /8AI2v8v+CU9WYYU4kPQ9Q6oLBloKB5H1Qz0uohVAypyjDxfxh0ikqLuiZRK7ujrTih5
         bH87LjlFG4LGD8KGPBAKMis6qsxETJClfwZdS0+j/Q80xs456jqV4KzMhJyV6A8xXpw2
         Oc/i7QUYHwsTrSCh7OyxGgL1cKgIgyTycXOf6BWWpXmzGnhIEEtNGyfdvsOfdJL1I3tR
         TqAw==
X-Gm-Message-State: APjAAAWCOwiLP4E3x+WKv9AZK52U0pm+5OtL0RSN5HwkQ7tpDpKkrcKD
        mGQDOR1I0dlegOl0uSp+VKw=
X-Google-Smtp-Source: APXvYqwSQ0GSW4iD2qTstjsXHgbCgFFcX80ctWtNSeMrorzODUlao7X6FIf3s73NOCA+LkJX0CKlqQ==
X-Received: by 2002:ac8:53cb:: with SMTP id c11mr7902123qtq.162.1571422605015;
        Fri, 18 Oct 2019 11:16:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-170-47.3g.claro.net.br. [179.240.170.47])
        by smtp.gmail.com with ESMTPSA id z12sm3722958qkg.97.2019.10.18.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:16:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C84994DD66; Fri, 18 Oct 2019 15:16:31 -0300 (-03)
Date:   Fri, 18 Oct 2019 15:16:31 -0300
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
Message-ID: <20191018181631.GF1797@kernel.org>
References: <20191017105918.20873-1-jolsa@kernel.org>
 <20191017105918.20873-8-jolsa@kernel.org>
 <20191018181429.GE1797@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018181429.GE1797@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 18, 2019 at 03:14:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Oct 17, 2019 at 12:59:15PM +0200, Jiri Olsa escreveu:
> > Adding mmaping tests that generates prctl call on
> > every cpu validates it gets all the related events
> > in ring buffer.
> 
> So _here_ we need _GNU_SOURCE, for this specific test:

Added, to this test:

[acme@quaco perf]$ git diff
diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index d8c52ebfa53a..741bc1bb4524 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
+#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
 #include <sched.h>
+#include <stdio.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <stdlib.h>
[acme@quaco perf]$

We can go the big hammer way if this is more generally needed, but first
lets try to use it only when needed, ok?

- Arnaldo
 
>   LINK     test-evlist-a
> test-evlist.c: In function ‘test_mmap_cpus’:
> test-evlist.c:352:8: warning: implicit declaration of function ‘sched_getaffinity’ [-Wimplicit-function-declaration]
>   352 |  err = sched_getaffinity(0, sizeof(saved_mask), &saved_mask);
>       |        ^~~~~~~~~~~~~~~~~
> test-evlist.c:358:3: warning: implicit declaration of function ‘CPU_ZERO’ [-Wimplicit-function-declaration]
>   358 |   CPU_ZERO(&mask);
>       |   ^~~~~~~~
> test-evlist.c:359:3: warning: implicit declaration of function ‘CPU_SET’ [-Wimplicit-function-declaration]
>   359 |   CPU_SET(cpu, &mask);
>       |   ^~~~~~~
> test-evlist.c:361:9: warning: implicit declaration of function ‘sched_setaffinity’ [-Wimplicit-function-declaration]
>   361 |   err = sched_setaffinity(0, sizeof(mask), &mask);
>       |         ^~~~~~~~~~~~~~~~~
> /usr/bin/ld: /tmp/ccOhNrLC.o: in function `test_mmap_cpus':
> /home/acme/git/perf/tools/perf/lib/tests/test-evlist.c:358: undefined reference to `CPU_ZERO'
> /usr/bin/ld: /home/acme/git/perf/tools/perf/lib/tests/test-evlist.c:359: undefined reference to `CPU_SET'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:22: test-evlist-a] Error 1
> make: *** [Makefile:143: tests] Error 2
> make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
> [root@quaco perf]#
>  
> > Link: http://lkml.kernel.org/n/tip-9qdckblmgjm42ofd7haflso0@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/lib/tests/test-evlist.c | 97 ++++++++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> > 
> > diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
> > index 90a1869ba4b1..d8c52ebfa53a 100644
> > --- a/tools/perf/lib/tests/test-evlist.c
> > +++ b/tools/perf/lib/tests/test-evlist.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <stdio.h>
> > +#include <sched.h>
> >  #include <stdarg.h>
> >  #include <unistd.h>
> >  #include <stdlib.h>
> > @@ -299,6 +300,101 @@ static int test_mmap_thread(void)
> >  	return 0;
> >  }
> >  
> > +static int test_mmap_cpus(void)
> > +{
> > +	struct perf_evlist *evlist;
> > +	struct perf_evsel *evsel;
> > +	struct perf_mmap *map;
> > +	struct perf_cpu_map *cpus;
> > +	struct perf_event_attr attr = {
> > +		.type             = PERF_TYPE_TRACEPOINT,
> > +		.sample_period    = 1,
> > +		.wakeup_watermark = 1,
> > +		.disabled         = 1,
> > +	};
> > +	cpu_set_t saved_mask;
> > +	char path[PATH_MAX];
> > +	int id, err, cpu, tmp;
> > +	union perf_event *event;
> > +	int count = 0;
> > +
> > +	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
> > +		 sysfs__mountpoint());
> > +
> > +	if (filename__read_int(path, &id)) {
> > +		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
> > +		return -1;
> > +	}
> > +
> > +	attr.config = id;
> > +
> > +	cpus = perf_cpu_map__new(NULL);
> > +	__T("failed to create cpus", cpus);
> > +
> > +	evlist = perf_evlist__new();
> > +	__T("failed to create evlist", evlist);
> > +
> > +	evsel = perf_evsel__new(&attr);
> > +	__T("failed to create evsel1", evsel);
> > +
> > +	perf_evlist__add(evlist, evsel);
> > +
> > +	perf_evlist__set_maps(evlist, cpus, NULL);
> > +
> > +	err = perf_evlist__open(evlist);
> > +	__T("failed to open evlist", err == 0);
> > +
> > +	err = perf_evlist__mmap(evlist, 4);
> > +	__T("failed to mmap evlist", err == 0);
> > +
> > +	perf_evlist__enable(evlist);
> > +
> > +	err = sched_getaffinity(0, sizeof(saved_mask), &saved_mask);
> > +	__T("sched_getaffinity failed", err == 0);
> > +
> > +	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
> > +		cpu_set_t mask;
> > +
> > +		CPU_ZERO(&mask);
> > +		CPU_SET(cpu, &mask);
> > +
> > +		err = sched_setaffinity(0, sizeof(mask), &mask);
> > +		__T("sched_setaffinity failed", err == 0);
> > +
> > +		prctl(0, 0, 0, 0, 0);
> > +	}
> > +
> > +	err = sched_setaffinity(0, sizeof(saved_mask), &saved_mask);
> > +	__T("sched_setaffinity failed", err == 0);
> > +
> > +	perf_evlist__disable(evlist);
> > +
> > +	perf_evlist__for_each_mmap(evlist, map, false) {
> > +		if (perf_mmap__read_init(map) < 0)
> > +			continue;
> > +
> > +		while ((event = perf_mmap__read_event(map)) != NULL) {
> > +			count++;
> > +			perf_mmap__consume(map);
> > +		}
> > +
> > +		perf_mmap__read_done(map);
> > +	}
> > +
> > +	/* calls perf_evlist__munmap/perf_evlist__close */
> > +	perf_evlist__delete(evlist);
> > +
> > +	/*
> > +	 * The generated prctl events should match the
> > +	 * number of cpus or be bigger (we are system-wide).
> > +	 */
> > +	__T("failed count", count >= perf_cpu_map__nr(cpus));
> > +
> > +	perf_cpu_map__put(cpus);
> > +
> > +	return 0;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >  	__T_START;
> > @@ -309,6 +405,7 @@ int main(int argc, char **argv)
> >  	test_stat_thread();
> >  	test_stat_thread_enable();
> >  	test_mmap_thread();
> > +	test_mmap_cpus();
> >  
> >  	__T_OK;
> >  	return 0;
> > -- 
> > 2.21.0
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
