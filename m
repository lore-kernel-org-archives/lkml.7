Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C348A2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfCEOsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:48:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:59763 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfCEOsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:48:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 06:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="149437948"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 05 Mar 2019 06:48:14 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 57E70301BC7; Tue,  5 Mar 2019 06:48:14 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 03/15] perf tools script: Filter COMM/FORK/.. events by CPU
Date:   Tue,  5 Mar 2019 06:47:46 -0800
Message-Id: <20190305144758.12397-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305144758.12397-1-andi@firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The --cpu option only filtered samples. Filter other perf events,
such as COMM, FORK, SWITCH by the CPU too.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fbc440bdf880..3813f60d1dc0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2038,6 +2038,9 @@ static int process_comm_event(struct perf_tool *tool,
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
 	if (thread == NULL) {
 		pr_debug("problem processing COMM event, skipping it.\n");
@@ -2073,6 +2076,9 @@ static int process_namespaces_event(struct perf_tool *tool,
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	thread = machine__findnew_thread(machine, event->namespaces.pid,
 					 event->namespaces.tid);
 	if (thread == NULL) {
@@ -2108,6 +2114,9 @@ static int process_fork_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	if (perf_event__process_fork(tool, event, sample, machine) < 0)
 		return -1;
 
@@ -2141,6 +2150,9 @@ static int process_exit_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
 	if (thread == NULL) {
 		pr_debug("problem processing EXIT event, skipping it.\n");
@@ -2174,6 +2186,9 @@ static int process_mmap_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
 		return -1;
 
@@ -2206,6 +2221,9 @@ static int process_mmap2_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
 		return -1;
 
@@ -2238,6 +2256,9 @@ static int process_switch_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
@@ -2266,6 +2287,9 @@ process_lost_event(struct perf_tool *tool,
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	struct thread *thread;
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return 0;
+
 	thread = machine__findnew_thread(machine, sample->pid,
 					 sample->tid);
 	if (thread == NULL)
-- 
2.20.1

