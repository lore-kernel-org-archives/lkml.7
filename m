Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F06ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AC42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfJOFct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42261 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfJOFcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRQ-0000XY-VY; Tue, 15 Oct 2019 07:32:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D33171C0714;
        Tue, 15 Oct 2019 07:31:52 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf top: Initialize perf_env->cpuid, needed by the
 per arch annotation init routine
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-4t4n3o8l8s0tc2b1pq53hyr4@git.kernel.org>
References: <tip-4t4n3o8l8s0tc2b1pq53hyr4@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111751270.12254.3384760503527806608.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     608127f73779bfc199158b61efdbdb690720e542
Gitweb:        https://git.kernel.org/tip/608127f73779bfc199158b61efdbdb690720e542
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Sep 2019 11:53:00 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine

Just read it so that later on the per arch init routine can use it,
e.g. x86__annotate_init().

When using a perf.data file this is obtained from a header that was put
there by 'perf record', and then it may be for another machine, another
arch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4t4n3o8l8s0tc2b1pq53hyr4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1f60124..611d030 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1560,6 +1560,17 @@ int cmd_top(int argc, const char **argv)
 	status = perf_config(perf_top_config, &top);
 	if (status)
 		return status;
+	/*
+	 * Since the per arch annotation init routine may need the cpuid, read
+	 * it here, since we are not getting this from the perf.data header.
+	 */
+	status = perf_env__read_cpuid(&perf_env);
+	if (status) {
+		pr_err("Couldn't read the cpuid for this machine: %s\n",
+		       str_error_r(errno, errbuf, sizeof(errbuf)));
+		goto out_delete_evlist;
+	}
+	top.evlist->env = &perf_env;
 
 	argc = parse_options(argc, argv, options, top_usage, 0);
 	if (argc)
