Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244F5C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3D022311
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163217;
	bh=A9yGFhble/iE9ZQhQTbsGZrc8aOY64f8eRqo6Ffg/Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wbiy7fIGNbn7wU0X8OSAs1RjW3NnHlRgGVopTat4FSJoIMDO8qwdqKrQNoOQno/2K
	 gqyeCCfIRgJSYBc0VKINCOOei+//FiZe6SoRkSdfsV5aU+UO43CL+RsFLmmXGpFHdu
	 1NtYpmyQQVY8pgNXcd8lMAqoTHuoNddwBBX4vUl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfKSLdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfKSLde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:34 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E21BA2230C;
        Tue, 19 Nov 2019 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163213;
        bh=A9yGFhble/iE9ZQhQTbsGZrc8aOY64f8eRqo6Ffg/Bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fe8DYeZh7Kqoqxn7HTDNCA5Q1RbjSVhdKmfKE1fh1TlcnZbkkYnwycYB3BbzipIwA
         kgD/DcvQPn6lJoty0KUi1uDgI1QkYmN+cqx97LEGBqASz+6t4iq5bUGjG+Lqz5hy+C
         h0r8JLZGdkiuLe5raBYAUwwhDrXqO2lZP3SCHzMo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 09/25] perf record: No need to process the synthesized MMAP events twice
Date:   Tue, 19 Nov 2019 08:32:29 -0300
Message-Id: <20191119113245.19593-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At the end of a 'perf record' session, by default, we'll process all
samples and populate the threads, maps, etc so as to find out which of
the DSOs got samples, to reduce the size of the build-id table we'll
add to the perf.data headers.

But we don't need to process the PERF_RECORD_MMAP events synthesized
for the kernel modules, as we have those already via
perf_session__create_kernel_maps(), so add mmap/mmap2 handlers that
first look at event->header.misc to see if the event is for a user map,
bailing out if not.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mofoxvcx2dryppcw3o689jdd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b95c000c1ed9..7ab3110b4035 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2148,6 +2148,31 @@ static const char * const __record_usage[] = {
 };
 const char * const *record_usage = __record_usage;
 
+static int build_id__process_mmap(struct perf_tool *tool, union perf_event *event,
+				  struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+	return perf_event__process_mmap(tool, event, sample, machine);
+}
+
+static int build_id__process_mmap2(struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+
+	return perf_event__process_mmap2(tool, event, sample, machine);
+}
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -2177,8 +2202,8 @@ static struct record record = {
 		.exit		= perf_event__process_exit,
 		.comm		= perf_event__process_comm,
 		.namespaces	= perf_event__process_namespaces,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
+		.mmap		= build_id__process_mmap,
+		.mmap2		= build_id__process_mmap2,
 		.ordered_events	= true,
 	},
 };
-- 
2.21.0

