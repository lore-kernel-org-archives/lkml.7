Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2EFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29292082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfLQLc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:32:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfLQLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:32:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihB50-0007Mk-M3; Tue, 17 Dec 2019 12:31:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 56AEC1C2A34;
        Tue, 17 Dec 2019 12:31:54 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:31:54 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf top: Do not bail out when
 perf_env__read_cpuid() returns ENOSYS
Cc:     John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org>
References: <tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157658231424.30329.14769800099775764092.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     61208e6e1003b3fd8d2d1f2a72ec27be43955c0b
Gitweb:        https://git.kernel.org/tip/61208e6e1003b3fd8d2d1f2a72ec27be43955c0b
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 11 Dec 2019 10:21:59 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Dec 2019 12:26:25 -03:00

perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS

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
index dc80044..795e353 100644
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
 
