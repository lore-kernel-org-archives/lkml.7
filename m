Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D97C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF412070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfIVKwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:52:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55548 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfIVKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:52:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBzTd-0000v2-0z; Sun, 22 Sep 2019 12:52:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8A46D1C0DF1;
        Sun, 22 Sep 2019 12:52:24 +0200 (CEST)
Date:   Sun, 22 Sep 2019 10:52:24 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf probe: Skip same probe address for a given line
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <156886447061.10772.4261569305869149178.stgit@devnote2>
References: <156886447061.10772.4261569305869149178.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <156914954448.24167.7115189929260088693.tip-bot2@tip-bot2>
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

Commit-ID:     1a375ae7659ab740d4c885ea98c1659b8a6e2071
Gitweb:        https://git.kernel.org/tip/1a375ae7659ab740d4c885ea98c1659b8a6e2071
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 19 Sep 2019 12:41:10 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 15:22:00 -03:00

perf probe: Skip same probe address for a given line

Fix to skip making a same probe address on given line.

Since a DWARF line info contains several entries for one line with
different column, perf probe will make a different probe on same address
if user specifies a probe point by "function:line" or "file:line".

e.g.
 $ perf probe -D kernel_read:8
 p:probe/kernel_read_L8 kernel_read+39
 p:probe/kernel_read_L8_1 kernel_read+39

This skips such duplicated probe addresses.

Committer testing:

  # uname -a
  Linux quaco 5.3.0+ #2 SMP Thu Sep 19 16:13:22 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  #

Before:

  # perf probe -D kernel_read:8
  p:probe/kernel_read _text+3115191
  p:probe/kernel_read_1 _text+3115191
  #

After:

  # perf probe -D kernel_read:8
  p:probe/kernel_read _text+3115191
  #

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lore.kernel.org/lkml/156886447061.10772.4261569305869149178.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 505905f..cd9f95e 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1245,6 +1245,17 @@ static int expand_probe_args(Dwarf_Die *sc_die, struct probe_finder *pf,
 	return n;
 }
 
+static bool trace_event_finder_overlap(struct trace_event_finder *tf)
+{
+	int i;
+
+	for (i = 0; i < tf->ntevs; i++) {
+		if (tf->pf.addr == tf->tevs[i].point.address)
+			return true;
+	}
+	return false;
+}
+
 /* Add a found probe point into trace event list */
 static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 {
@@ -1255,6 +1266,14 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	struct perf_probe_arg *args = NULL;
 	int ret, i;
 
+	/*
+	 * For some reason (e.g. different column assigned to same address)
+	 * This callback can be called with the address which already passed.
+	 * Ignore it first.
+	 */
+	if (trace_event_finder_overlap(tf))
+		return 0;
+
 	/* Check number of tevs */
 	if (tf->ntevs == tf->max_tevs) {
 		pr_warning("Too many( > %d) probe point found.\n",
