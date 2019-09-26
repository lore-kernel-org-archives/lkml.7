Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F909C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734C9222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569457999;
	bh=RgsAanqTifp71PLJSM6G+W1ujaztqtJpBUszycOkJS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f49mgyhYRPirbfGO6lUpkz3b42moBqK6jGWvAvm7u/O9NOBzE2IRr+gWChWytSQxF
	 nXv5YJF3HvDpy3FA5+JMX53TJKgY2P7vvH2ygjWdOd9NM/h8cZt3g7saLqM9TI/r//
	 8ms4CllMltMs71m3udhay3BrdABtok5psOgMsJ5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfIZAdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZAdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:05 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC3D21D7B;
        Thu, 26 Sep 2019 00:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569457984;
        bh=RgsAanqTifp71PLJSM6G+W1ujaztqtJpBUszycOkJS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZoDjmkVz/+hDt/OY7il9w1vGPwia3yekvCrkD0hPXXwk5Se67JoqpYwEGv7N8oU0
         dfMTNsD1SLoL0tPVExLs6B4sA2NvjG0mq0tI+CtoFNzYwXlE/XXGHw/Z3d3YN+h42o
         rTbejam7cBhenHyjdzpvGrUR/x/aopZ0GhCK+hgU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 02/66] perf record: Move restricted maps check to after a possible fallback to not collect kernel samples
Date:   Wed, 25 Sep 2019 21:31:40 -0300
Message-Id: <20190926003244.13962-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  [acme@quaco ~]$ perf record -b -e cycles date
  WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
  check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.

  Samples in kernel functions may not be resolved if a suitable vmlinux
  file is not found in the buildid cache or in the vmlinux path.

  Samples in kernel modules won't be resolved at all.

  If some relocation was applied (e.g. kexec) symbols may be misresolved
  even with a suitable vmlinux or kallsyms file.

  Mon 23 Sep 2019 11:00:59 AM -03
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.005 MB perf.data (14 samples) ]
  [acme@quaco ~]$

But we did a fallback and exclude_kernel was set, so no need for
resolving kernel symbols:

  $ perf evlist -v
  cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
  $

After:

  [acme@quaco ~]$ perf record -b -e cycles date
  Mon 23 Sep 2019 11:07:18 AM -03
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.007 MB perf.data (16 samples) ]
  [acme@quaco ~]$ perf evlist -v
  cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
  [acme@quaco ~]$

No needless warning is emitted.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-5yqnr8xcqwhr15xktj2097ac@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3f66a49a997f..1e1f97139f16 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -788,6 +788,17 @@ static int record__open(struct record *rec)
 		pos->supported = true;
 	}
 
+	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(evlist)) {
+		pr_warning(
+"WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
+"check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
+"Samples in kernel functions may not be resolved if a suitable vmlinux\n"
+"file is not found in the buildid cache or in the vmlinux path.\n\n"
+"Samples in kernel modules won't be resolved at all.\n\n"
+"If some relocation was applied (e.g. kexec) symbols may be misresolved\n"
+"even with a suitable vmlinux or kallsyms file.\n\n");
+	}
+
 	if (perf_evlist__apply_filters(evlist, &pos)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
 			pos->filter, perf_evsel__name(pos), errno,
@@ -2364,16 +2375,6 @@ int cmd_record(int argc, const char **argv)
 
 	err = -ENOMEM;
 
-	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(rec->evlist))
-		pr_warning(
-"WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-"check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
-"Samples in kernel functions may not be resolved if a suitable vmlinux\n"
-"file is not found in the buildid cache or in the vmlinux path.\n\n"
-"Samples in kernel modules won't be resolved at all.\n\n"
-"If some relocation was applied (e.g. kexec) symbols may be misresolved\n"
-"even with a suitable vmlinux or kallsyms file.\n\n");
-
 	if (rec->no_buildid_cache || rec->no_buildid) {
 		disable_buildid_cache();
 	} else if (rec->switch_output.enabled) {
-- 
2.21.0

