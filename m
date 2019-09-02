Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5807BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395F3215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfIBITb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:19:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56157 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbfIBIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVi-0007xM-6l; Mon, 02 Sep 2019 10:16:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21C921C0DEC;
        Mon,  2 Sep 2019 10:16:25 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:25 -0000
From:   "tip-bot2 for Kyle Meyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf machine: Replace MAX_NR_CPUS with
 perf_env::nr_cpus_online
Cc:     Kyle Meyer <kyle.meyer@hpe.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190827214352.94272-6-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190827214352.94272-6-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <156741218504.17280.8058375020426111095.tip-bot2@tip-bot2>
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

Commit-ID:     8c7274691f0de5fb56f3b9fe9208ce7e515a2d2c
Gitweb:        https://git.kernel.org/tip/8c7274691f0de5fb56f3b9fe9208ce7e515a2d2c
Author:        Kyle Meyer <meyerk@hpe.com>
AuthorDate:    Tue, 27 Aug 2019 16:43:50 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online

nr_cpus, the number of CPUs online during a record session bound by
MAX_NR_CPUS, can be used as a dynamic alternative for MAX_NR_CPUS in
__machine__synthesize_threads and machine__set_current_tid.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-6-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 93483f1..a1542b4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2619,7 +2619,9 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
-	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
+	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
+
+	if (cpu < 0 || cpu >= nr_cpus || !machine->current_tid)
 		return -1;
 
 	return machine->current_tid[cpu];
@@ -2629,6 +2631,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid)
 {
 	struct thread *thread;
+	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
 
 	if (cpu < 0)
 		return -EINVAL;
@@ -2636,14 +2639,14 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	if (!machine->current_tid) {
 		int i;
 
-		machine->current_tid = calloc(MAX_NR_CPUS, sizeof(pid_t));
+		machine->current_tid = calloc(nr_cpus, sizeof(pid_t));
 		if (!machine->current_tid)
 			return -ENOMEM;
-		for (i = 0; i < MAX_NR_CPUS; i++)
+		for (i = 0; i < nr_cpus; i++)
 			machine->current_tid[i] = -1;
 	}
 
-	if (cpu >= MAX_NR_CPUS) {
+	if (cpu >= nr_cpus) {
 		pr_err("Requested CPU %d too large. ", cpu);
 		pr_err("Consider raising MAX_NR_CPUS\n");
 		return -EINVAL;
