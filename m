Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD93C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DA021744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326854;
	bh=xBs1bXw8eZRDqJb4F37NRLkVcQW6RUzdL6mWevt75ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rlaQogkohpPjiUTEsmNRnZ6IC9u5eW1iBZXUv2tcELQw8CV1Yb4syPOZM18DaRfyO
	 EOteHkQU5Zv+CfWg3IN3EYCFPvNWBLniRB4FFIx2Hoj+DaIQqNTEBFeS43k49awiYa
	 SbQC+fwslBunu/CeHKnEExy2ERlCNLq/FWZ1d8aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgAFQHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgAFQHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:31 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A4D207FF;
        Mon,  6 Jan 2020 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326850;
        bh=xBs1bXw8eZRDqJb4F37NRLkVcQW6RUzdL6mWevt75ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTiDnIry/NnpBssASCctSfzBPvIQxRDVwF/ToGp0Fz/3uHe+xfVauJuVbuu+7r+Dh
         4EaqnJ6JrYK582E+8NqVu8HwbCVBVBd8t9/wzC2rbwaoDyN2aDwVKt8Enw/IC8/lqm
         3z2xjQWNHdjpEblJLK8AixtB/FDagtZXNY6LOhfk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        David Ahern <dsahern@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/20] perf sched timehist: Add support for filtering on CPU
Date:   Mon,  6 Jan 2020 13:06:49 -0300
Message-Id: <20200106160705.10899-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Allow user to limit output to one or more CPUs. Really helpful on
systems with a large number of cpus.

Committer testing:

  # perf sched record -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.765 MB perf.data (1412 samples) ]
  [root@quaco ~]# perf sched timehist | head
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     66307.802686 [0000]  perf[13086]                         0.000      0.000      0.000
     66307.802700 [0000]  migration/0[12]                     0.000      0.001      0.014
     66307.802766 [0001]  perf[13086]                         0.000      0.000      0.000
     66307.802774 [0001]  migration/1[15]                     0.000      0.001      0.007
     66307.802841 [0002]  perf[13086]                         0.000      0.000      0.000
     66307.802849 [0002]  migration/2[20]                     0.000      0.001      0.008
     66307.802913 [0003]  perf[13086]                         0.000      0.000      0.000
  #
  # perf sched timehist --cpu 2 | head
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     66307.802841 [0002]  perf[13086]                         0.000      0.000      0.000
     66307.802849 [0002]  migration/2[20]                     0.000      0.001      0.008
     66307.964485 [0002]  <idle>                              0.000      0.000    161.635
     66307.964811 [0002]  CPU 0/KVM[3589/3561]                0.000      0.056      0.325
     66307.965477 [0002]  <idle>                              0.325      0.000      0.666
     66307.965553 [0002]  CPU 0/KVM[3589/3561]                0.666      0.024      0.076
     66307.966456 [0002]  <idle>                              0.076      0.000      0.903
  #

Signed-off-by: David Ahern <dsahern@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191204173925.66976-1-dsahern@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-sched.txt |  4 ++++
 tools/perf/builtin-sched.c              | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 63f938b887dd..5fbe42bd599b 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -110,6 +110,10 @@ OPTIONS for 'perf sched timehist'
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
 
+-C=::
+--cpu=::
+	Only show events for the given CPU(s) (comma separated list).
+
 -p=::
 --pid=::
 	Only show events for given process ID (comma separated list).
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8a12d71364c3..82fcc2c15fe4 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -51,6 +51,9 @@
 #define SYM_LEN			129
 #define MAX_PID			1024000
 
+static const char *cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
 struct sched_atom;
 
 struct task_desc {
@@ -2008,6 +2011,9 @@ static void timehist_print_sample(struct perf_sched *sched,
 	char nstr[30];
 	u64 wait_time;
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return;
+
 	timestamp__scnprintf_usec(t, tstr, sizeof(tstr));
 	printf("%15s [%04d] ", tstr, sample->cpu);
 
@@ -2994,6 +3000,12 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	if (cpu_list) {
+		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
+		if (err < 0)
+			goto out;
+	}
+
 	evlist = session->evlist;
 
 	symbol__init(&session->header.env);
@@ -3429,6 +3441,7 @@ int cmd_sched(int argc, const char **argv)
 		   "analyze events only for given process id(s)"),
 	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "analyze events only for given thread id(s)"),
+	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.21.1

