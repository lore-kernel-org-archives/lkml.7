Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31984C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F02218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568864477;
	bh=Sw7HQ06M3joYnCa+TwfGZi9hJaesB+c0vGVxA6MpB/c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ffmOVtZJJi+fUzOUTg+C0F/4amJIGt8JEhhJfl244f8pPegQrXTnFbZrw/0neagcf
	 iHVXNbdbCNI7gDkyXeEj0AfBGEfsXLmc5P1sk+gFXnzLBNw2GCpo20O33NHGOmuCpu
	 +AyFfgaQnqDaGFN5YVfGeipT6kk/luVAsz7t9jbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfISDlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfISDlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:41:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76026214AF;
        Thu, 19 Sep 2019 03:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568864475;
        bh=Sw7HQ06M3joYnCa+TwfGZi9hJaesB+c0vGVxA6MpB/c=;
        h=From:To:Cc:Subject:Date:From;
        b=LAprfa4hs2PVhz1q6cumyAYutEJQoJ3hJqH/WCw1j9/ms2s1p75d1DUA/CCWzXot7
         +lWCFfCUZo/uv7UgmOoyTXYUUH5GM+7FY4rPDe4ju9Lisl+JmG98zn4Y7kcU9HpjTp
         ixt+cnBfENzYmL/Z7XJ8z86oOWQBVe9yM9HY63gA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/probe: Skip same probe address
Date:   Thu, 19 Sep 2019 12:41:10 +0900
Message-Id: <156886447061.10772.4261569305869149178.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to skip making a same probe address on given line.

Since dwarf line info contains several entries for one line
with different column, perf probe will make a different
probe on same address if user specifies a probe point by
"function:line" or "file:line".

e.g.
 $ perf probe -D kernel_read:8
 p:probe/kernel_read_L8 kernel_read+39
 p:probe/kernel_read_L8_1 kernel_read+39

This skips such duplicated probe address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 025fc4491993..02ca95deaf2c 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1244,6 +1244,17 @@ static int expand_probe_args(Dwarf_Die *sc_die, struct probe_finder *pf,
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
@@ -1254,6 +1265,14 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
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

