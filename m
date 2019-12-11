Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9018C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786C5214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goKy+bF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfLKNdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:33:24 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33537 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLKNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:33:24 -0500
Received: by mail-vk1-f194.google.com with SMTP id i78so6816735vke.0;
        Wed, 11 Dec 2019 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHMPt5qitZdN52gsvm9KvCbw43rL0xEEQ7DP0ggn9w0=;
        b=goKy+bF0jWzrn8bwmsVTGVuqUGDJWDQ9K/qoo4sinDBcAmPsx6u33dajVTIGr7IwG8
         a2h0Dyd8C3BG1NDgqGqFn1bu2YiJYytJhvCmWv0q9Mfpsac102Qw9qHvbrW2EbBIggDK
         qZbXC1YM1aTt9QV9qpCw9TF80adckQlwyacgNCh/BJCqPyuA4RDF0NuC0Q/Wu7SAsvFX
         cg8pve+eMpw9LS7gqTtDD5uy6z/1fhOkdUJWap44J4qeJggXIU9Q8v4uzNaItoprnw6e
         JqYU0ydUiOyBqlwhiAG4ZMrrjX9wTKBsyTqJ7tQP98SfCN0nw3wlJH8HpQ9itSSVaJse
         LmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHMPt5qitZdN52gsvm9KvCbw43rL0xEEQ7DP0ggn9w0=;
        b=Ci8E0dsXDIETsba6IHHNkjJnPpoeLjkbLIU6/C02m7lD4NaRNSuJKcam+/GRhda9PW
         6TbjdOPytCaPRQbctSR0lGBpUa5LdZcddsMh2c1VFPzwczEO93wegItf4wKfE/AHYPsy
         UbUlrkEIZX9do+gRigsYuhCuG2uAWHzLc7Y2D9Jj7wavGOEJ+ceFbtCUofmpTT1F2z+F
         1XGXlRdSOZwDiG8cx94WrssisjcwOSFClEOIMoDJ75MHEXAMmPkZGoC+VvUtJokECQlh
         yjpeYvdvEbnu43ULM6FzOLahtsyjqC9qz27F1wtoYur2Q9N+Q23y6iki782FUogqCXpq
         NMtg==
X-Gm-Message-State: APjAAAVP34ycnIdzjx356y+dJhAbhcy947lwZMcYtnfGAfQa+QBs5jQ3
        povx4gw9nAolPHH3dTV4Lvc=
X-Google-Smtp-Source: APXvYqz8T7B4eu5yS7e9alzom4sjSbmSq81n1PeDpEM8py7rel8vT+zVTNansN1Fl/F1kORIKojZpQ==
X-Received: by 2002:a1f:d5c5:: with SMTP id m188mr3413119vkg.7.1576071202658;
        Wed, 11 Dec 2019 05:33:22 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id x132sm1455338vkx.9.2019.12.11.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:33:22 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 697A640352; Wed, 11 Dec 2019 10:33:19 -0300 (-03)
Date:   Wed, 11 Dec 2019 10:33:19 -0300
To:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>, linux-perf-users@vger.kernel.org
Subject: [PATCHES] Fix 'perf top' breakage on architectures not providing
 get_cpuid() Re: perf top for arm64?
Message-ID: <20191211133319.GA15181@kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
 <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
 <20191210195113.GD13965@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210195113.GD13965@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 10, 2019 at 04:51:13PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 10, 2019 at 05:17:56PM +0000, John Garry escreveu:
> > On 10/12/2019 17:08, Jiri Olsa wrote:
> > > On Tue, Dec 10, 2019 at 04:52:52PM +0000, John Garry wrote:
> > > > On 10/12/2019 16:36, Jiri Olsa wrote:
> > > > > On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
> > > > > > I find to my surprise that "perf top" does not work for arm64:

> > > > > > root@ubuntu:/home/john/linux# tools/perf/perf top
> > > > > > Couldn't read the cpuid for this machine: No such file or directory

> > > > > there was recent change that check on cpuid and quits:
> > > > >     608127f73779 perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine

> > > > ok, this is new code. I obviously didn't check the git history...

> > > > But, apart from this, there are many other places where get_cpuid() is
> > > > called. I wonder what else we're missing out on, and whether we should still
> > > > add it.

> > > right, I was just wondering how come vendor events are working for you,
> > > but realized we have get_cpuid_str being called in there ;-)

> > > I think we should add it as you have it prepared already,
> > > could you post it with bigger changelog that would explain
> > > where it's being used for arm?

> > ok, I can look to do that.

> > But, as you know, we still need to fix perf top for other architectures
> > affected.

> Right, I need to make that just a pr_debug() message and then check in
> the annotation code when that is needed to see if it is set, if not,
> then show a popup error message and refuse to do whatever annotation
> feature requires that.

> Anyway, your patch should make sense and provide info that the ARM64
> annotation may use now or in the future.

So can you take a look at the two patches below and provide me Acked-by
and/or Reviewed-by and/or Tested-by?


From 53c6cde6a71a1a9283763bd2e938b229b50c2cd5 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 11 Dec 2019 10:09:24 -0300
Subject: [PATCH 1/2] perf arch: Make the default get_cpuid() return compatible
 error

Some of the functions calling get_cpuid() propagate back the error it
returns, and all are using errno (positive) values, make the weak
default get_cpuid() function return ENOSYS to be consistent and to allow
checking if this is an arch not providing this function or if a provided
one is having trouble getting the cpuid, to decide if the warning should
be provided to the user or just a debug message should be emitted.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index becc2d109423..4d39a75551a0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
  */
 int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
 {
-	return -1;
+	return ENOSYS; /* Not implemented */
 }
 
 static int write_cpuid(struct feat_fd *ff,
-- 
2.21.0

From c6c6a3e2eb6982e37294abcac389effd298cf730 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 11 Dec 2019 10:21:59 -0300
Subject: [PATCH 2/2] perf top: Do not bail out when perf_env__read_cpuid()
 returns ENOSYS

'perf top' stopped working on hw architectures that do not provide a
get_cpuid() implementation and thus fallback to the weak get_cpuid()
default function.

This is done because at annotation time we may need it in the arch
specific annotation init routine, but that is only being used by arches
that do provide a get_cpuid() implementation:

  $ find tools/  -name "*.[ch]" | xargs grep 'evlist->env'
  tools/perf/builtin-top.c:	top.evlist->env = &perf_env;
  tools/perf/util/evsel.c:		return evsel->evlist->env;
  tools/perf/util/s390-cpumsf.c:	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
  tools/perf/util/header.c:	session->evlist->env = &header->env;
  tools/perf/util/sample-raw.c:	const char *arch_pf = perf_env__arch(evlist->env);
  $

  $ find tools/perf/arch  -name "*.[ch]" | xargs grep -w get_cpuid
  tools/perf/arch/x86/util/auxtrace.c:	ret = get_cpuid(buffer, sizeof(buffer));
  tools/perf/arch/x86/util/header.c:get_cpuid(char *buffer, size_t sz)
  tools/perf/arch/powerpc/util/header.c:get_cpuid(char *buffer, size_t sz)
  tools/perf/arch/s390/util/header.c: * Implementation of get_cpuid().
  tools/perf/arch/s390/util/header.c:int get_cpuid(char *buffer, size_t sz)
  tools/perf/arch/s390/util/header.c:	if (buf && get_cpuid(buf, 128))
  $

For 'report' or 'script', i.e. tools working on perf.data files, that is
setup while reading the header, its just top that needs to explicitely
read it at tool start.

Reported-by: John Garry <john.garry@huawei.com>
Analysed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index dc80044bc46f..795e353de095 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1568,9 +1568,13 @@ int cmd_top(int argc, const char **argv)
 	 */
 	status = perf_env__read_cpuid(&perf_env);
 	if (status) {
-		pr_err("Couldn't read the cpuid for this machine: %s\n",
-		       str_error_r(errno, errbuf, sizeof(errbuf)));
-		goto out_delete_evlist;
+		/*
+		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
+		 * warn the user explicitely.
+		 */
+		eprintf(status == ENOSYS ? 1 : 0, verbose,
+			"Couldn't read the cpuid for this machine: %s\n",
+			str_error_r(errno, errbuf, sizeof(errbuf)));
 	}
 	top.evlist->env = &perf_env;
 
-- 
2.21.0

