Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC82C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5BD21897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340641;
	bh=OF/TsxDEcb3dU9Mj2bZdmKIZsYaInI6BV2UbgQolKis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gd4s/RPg/Ds2tdXEvMnzJVBcqbT4adtZITv4WEgmFU2JNxrC8qHeE58Ac2F1PDvP+
	 PLC5ko4UeVsMm08ciGW5j7mGAp/m/V6ibTXVedBXg/Fns5RHgtWG0wJlZ2x9pPIB9u
	 dNYSEAruhkV411kFG5F8XPYA18ytJW9NQeCAQQRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfIAMX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfIAMX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:23:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6580233A2;
        Sun,  1 Sep 2019 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340635;
        bh=OF/TsxDEcb3dU9Mj2bZdmKIZsYaInI6BV2UbgQolKis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRpyfGt459ximv2TH8EoIo15q0s4cdz8JlPOx1onvoLr4SHw5QqC+8EQDpYGpUQ6+
         1l6uS6lhrWdHiyeyUmIfdJEsG3hE4tkKZ8AjKYdVtAezdjDDZMO7nCCnJAkWsg07JF
         XkNaliqeKdCMLWAHUix84ziCHiG1ayT9vlqs/3xI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/47] perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
Date:   Sun,  1 Sep 2019 09:22:45 -0300
Message-Id: <20190901122326.5793-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

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
index 93483f1764d3..a1542b4c047b 100644
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
-- 
2.21.0

