Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E058C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B8D208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qt+NsUYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfFQTFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:05:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfFQTFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:05:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ5Uib3557056
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:05:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ5Uib3557056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798330;
        bh=46l84bLQXCOB4DXvUoEepUM/tpEPS9RmdMoB4PRGo8c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qt+NsUYyp3FY+L7kWyjij3IUIKeHApm7j0UIcQxIW0QwUT4Pqc0+0l2Lt0heWQDkT
         Q9NETyI2dd3ndrZFSXCysXUDCeKUfKrsfLKeioYtGlB/qckQ6wNLcdJCnUTffL1JA1
         /87Uav/APLpf82sDDHgutJk8FiUbLgnu25Yt/mnSF6uZrG8c3uepPJedB//TDgQMVz
         qd8ZLRRz3j2Jt1z5hopQ7PUtv+YxCqeJ+kNe+mRqsOX2P1l3C3Gsg0phXBGb9/mbsz
         ATtuEWruP27jJMK2xvuxhBQLrtDUuKM4H4uVOLYHL5QfS4zUgja+hmnsL9e22mO/6W
         05MW0cLldRXVg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ5Tso3557052;
        Mon, 17 Jun 2019 12:05:29 -0700
Date:   Mon, 17 Jun 2019 12:05:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-003ccdc7165accee073ce261fc670f64cc98d0f7@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
        mingo@kernel.org
Reply-To: jolsa@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
          acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190520113728.14389-14-adrian.hunter@intel.com>
References: <20190520113728.14389-14-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread-stack: Accumulate IPC information
Git-Commit-ID: 003ccdc7165accee073ce261fc670f64cc98d0f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  003ccdc7165accee073ce261fc670f64cc98d0f7
Gitweb:     https://git.kernel.org/tip/003ccdc7165accee073ce261fc670f64cc98d0f7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:19 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:57 -0300

perf thread-stack: Accumulate IPC information

Cycle and instruction counts are added to the stack. The IPC of a
function and all functions it calls, is also recorded.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 14 ++++++++++++++
 tools/perf/util/thread-stack.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 41942c2aaa18..8e390f78486f 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -49,6 +49,8 @@ enum retpoline_state_t {
  * @timestamp: timestamp (if known)
  * @ref: external reference (e.g. db_id of sample)
  * @branch_count: the branch count when the entry was created
+ * @insn_count: the instruction count when the entry was created
+ * @cyc_count the cycle count when the entry was created
  * @db_id: id used for db-export
  * @cp: call path
  * @no_call: a 'call' was not seen
@@ -60,6 +62,8 @@ struct thread_stack_entry {
 	u64 timestamp;
 	u64 ref;
 	u64 branch_count;
+	u64 insn_count;
+	u64 cyc_count;
 	u64 db_id;
 	struct call_path *cp;
 	bool no_call;
@@ -75,6 +79,8 @@ struct thread_stack_entry {
  * @sz: current maximum stack size
  * @trace_nr: current trace number
  * @branch_count: running branch count
+ * @insn_count: running  instruction count
+ * @cyc_count running  cycle count
  * @kernel_start: kernel start address
  * @last_time: last timestamp
  * @crp: call/return processor
@@ -88,6 +94,8 @@ struct thread_stack {
 	size_t sz;
 	u64 trace_nr;
 	u64 branch_count;
+	u64 insn_count;
+	u64 cyc_count;
 	u64 kernel_start;
 	u64 last_time;
 	struct call_return_processor *crp;
@@ -289,6 +297,8 @@ static int thread_stack__call_return(struct thread *thread,
 	cr.call_time = tse->timestamp;
 	cr.return_time = timestamp;
 	cr.branch_count = ts->branch_count - tse->branch_count;
+	cr.insn_count = ts->insn_count - tse->insn_count;
+	cr.cyc_count = ts->cyc_count - tse->cyc_count;
 	cr.db_id = tse->db_id;
 	cr.call_ref = tse->ref;
 	cr.return_ref = ref;
@@ -544,6 +554,8 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	tse->timestamp = timestamp;
 	tse->ref = ref;
 	tse->branch_count = ts->branch_count;
+	tse->insn_count = ts->insn_count;
+	tse->cyc_count = ts->cyc_count;
 	tse->cp = cp;
 	tse->no_call = no_call;
 	tse->trace_end = trace_end;
@@ -874,6 +886,8 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	}
 
 	ts->branch_count += 1;
+	ts->insn_count += sample->insn_cnt;
+	ts->cyc_count += sample->cyc_cnt;
 	ts->last_time = sample->time;
 
 	if (sample->flags & PERF_IP_FLAG_CALL) {
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index 9c45f947f5a9..bddb1daf6453 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -52,6 +52,8 @@ enum {
  * @call_time: timestamp of call (if known)
  * @return_time: timestamp of return (if known)
  * @branch_count: number of branches seen between call and return
+ * @insn_count: approx. number of instructions between call and return
+ * @cyc_count: approx. number of cycles between call and return
  * @call_ref: external reference to 'call' sample (e.g. db_id)
  * @return_ref:  external reference to 'return' sample (e.g. db_id)
  * @db_id: id used for db-export
@@ -65,6 +67,8 @@ struct call_return {
 	u64 call_time;
 	u64 return_time;
 	u64 branch_count;
+	u64 insn_count;
+	u64 cyc_count;
 	u64 call_ref;
 	u64 return_ref;
 	u64 db_id;
