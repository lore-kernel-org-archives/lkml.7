Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242BBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA7621835
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576529279;
	bh=Novv1/GTrMisnvZSypa97JR384Sup4LcSGWylyjxexI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J//kE3bsPcJLQi9YUnv/JOnvton6a69egpOyeYkOKWwBEucWxQs6+yJU+3TkriUzy
	 jCGI/aN+xU5fzxvn7NYYBq1n0OWwNi/7hcsAA3nI/+c0KViVHznj4qtIQiW6mujhhW
	 +w8eyx8pwzzgezvEnAZScvafxrm2WLB4ylI4MGTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLPUr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLPUr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:47:57 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A4422464;
        Mon, 16 Dec 2019 20:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576529276;
        bh=Novv1/GTrMisnvZSypa97JR384Sup4LcSGWylyjxexI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pn/pRiEOmh9GqHcvGe3HmOug3NJH59ZIMLIQ3W+veyKlU70xD71yssfITDeLy21b4
         Iu8VJG+NvRAZQGNlpcGv9PM13O/HaVpS28IhP9iyEPRlq8eDb0sqikGzZMK9wYkaoA
         rm4YtSW2RyCQnBLqE2jCqX1BV96pNjJSJbEhQw24=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/9] perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS
Date:   Mon, 16 Dec 2019 17:47:32 -0300
Message-Id: <20191216204738.12107-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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

Fixes: 608127f73779 ("perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine")
Reported-by: John Garry <john.garry@huawei.com>
Analysed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: John Garry <john.garry@huawei.com> # arm64
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
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

