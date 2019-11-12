Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED86AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD48A222D2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKLLSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33457 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfKLLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBI-0000IF-Vu; Tue, 12 Nov 2019 12:17:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7059E1C0483;
        Tue, 12 Nov 2019 12:17:55 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:55 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf machine: Add kernel_dso() method
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-9s1bgoxxhlnu037e1nqx0tw3@git.kernel.org>
References: <tip-9s1bgoxxhlnu037e1nqx0tw3@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157355747511.29376.6682944329164352135.tip-bot2@tip-bot2>
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

Commit-ID:     93730f85eb37d9cf592c18dad7e488abed09b461
Gitweb:        https://git.kernel.org/tip/93730f85eb37d9cf592c18dad7e488abed09b461
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 31 Oct 2019 15:22:24 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 08:30:18 -03:00

perf machine: Add kernel_dso() method

To reduce boilerplate in some places.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9s1bgoxxhlnu037e1nqx0tw3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 24d9e28..e768ef2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -42,6 +42,11 @@
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
 
+static struct dso *machine__kernel_dso(struct machine *machine)
+{
+	return machine->vmlinux_map->dso;
+}
+
 static void dsos__init(struct dsos *dsos)
 {
 	INIT_LIST_HEAD(&dsos->head);
@@ -861,7 +866,7 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 {
 	int i;
 	size_t printed = 0;
-	struct dso *kdso = machine__kernel_map(machine)->dso;
+	struct dso *kdso = machine__kernel_dso(machine);
 
 	if (kdso->has_build_id) {
 		char filename[PATH_MAX];
@@ -1543,8 +1548,7 @@ static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
 static int machine__process_extra_kernel_map(struct machine *machine,
 					     union perf_event *event)
 {
-	struct map *kernel_map = machine__kernel_map(machine);
-	struct dso *kernel = kernel_map ? kernel_map->dso : NULL;
+	struct dso *kernel = machine__kernel_dso(machine);
 	struct extra_kernel_map xm = {
 		.start = event->mmap.start,
 		.end   = event->mmap.start + event->mmap.len,
