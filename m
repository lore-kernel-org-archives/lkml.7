Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EDBC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C01920449
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225254;
	bh=V2AOtZAj5hgsl5MN+QbfZVB9JIFthfWkj8+jM/g6tMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NTLdLPi/RfhU588XC/ggcKR5FuLunv8JBftjRAJeMVGDfqyB7EQiEdviLjFJYKZzt
	 3BEIWGqdx8QNTXqHbto9PyDpDGw7PCUwc78QbvM3Qfi64TJflV6sMkvKWWB6pvrW1F
	 Kn5qd3c9g8QiXqczD1Jr3OHvIcDaa5FM9FCaKPco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfGOVOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfGOVOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:14:11 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847922171F;
        Mon, 15 Jul 2019 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225249;
        bh=V2AOtZAj5hgsl5MN+QbfZVB9JIFthfWkj8+jM/g6tMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZN/4Y6rQGi4ASN4yAhjaWjXP9xYN/3fHt39BT2HJPQJfW4jjs2c1MVyYWNCftz67
         +UYhzp+MZ0IT3ophHPCw0u31ppmixW38W/L/cJJGP3mDCeuimLx5dzN14gzuwa4YxK
         DqSJgCMG5WkzEGt4+4EPVQvruc18/nFyWtjooooc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 23/28] perf scripts python: export-to-sqlite.py: Export switch events
Date:   Mon, 15 Jul 2019 18:11:55 -0300
Message-Id: <20190715211200.10984-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Export switch events to a new table 'context_switches' and create a view
'context_switches_view'. The table and view will show automatically in
the exported-sql-viewer.py script.

If the table ends up empty, then it and the view are dropped.

Committer testing:

Use the exported-sql-viewer.py and look at "Tables" ->
"context_switches":

  id  machine_id  time             cpu  thread_out_id  comm_out_id  thread_in_id  comm_in_id  flags
  1   1           187836111885918  7    1              1            2             2           3
  2   1           187836111889369  7    1              1            2             2           0
  3   1           187836112464618  7    2              3            1             1           1
  4   1           187836112465511  7    2              3            1             1           0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-21-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 9156f6a1e5f0..8043a7272a56 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -306,6 +306,17 @@ do_query(query, 'CREATE TABLE pwrx ('
 		'last_cstate	integer,'
 		'wake_reason	integer)')
 
+do_query(query, 'CREATE TABLE context_switches ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'machine_id	bigint,'
+		'time		bigint,'
+		'cpu		integer,'
+		'thread_out_id	bigint,'
+		'comm_out_id	bigint,'
+		'thread_in_id	bigint,'
+		'comm_in_id	bigint,'
+		'flags		integer)')
+
 # printf was added to sqlite in version 3.8.3
 sqlite_has_printf = False
 try:
@@ -530,6 +541,29 @@ do_query(query, 'CREATE VIEW power_events_view AS '
 	' INNER JOIN selected_events ON selected_events.id = evsel_id'
 	' WHERE selected_events.name IN (\'cbr\',\'mwait\',\'exstop\',\'pwre\',\'pwrx\')')
 
+do_query(query, 'CREATE VIEW context_switches_view AS '
+	'SELECT '
+		'context_switches.id,'
+		'context_switches.machine_id,'
+		'context_switches.time,'
+		'context_switches.cpu,'
+		'th_out.pid AS pid_out,'
+		'th_out.tid AS tid_out,'
+		'comm_out.comm AS comm_out,'
+		'th_in.pid AS pid_in,'
+		'th_in.tid AS tid_in,'
+		'comm_in.comm AS comm_in,'
+		'CASE	  WHEN context_switches.flags = 0 THEN \'in\''
+			' WHEN context_switches.flags = 1 THEN \'out\''
+			' WHEN context_switches.flags = 3 THEN \'out preempt\''
+			' ELSE context_switches.flags '
+		'END AS flags'
+	' FROM context_switches'
+	' INNER JOIN threads AS th_out ON th_out.id   = context_switches.thread_out_id'
+	' INNER JOIN threads AS th_in  ON th_in.id    = context_switches.thread_in_id'
+	' INNER JOIN comms AS comm_out ON comm_out.id = context_switches.comm_out_id'
+	' INNER JOIN comms AS comm_in  ON comm_in.id  = context_switches.comm_in_id')
+
 do_query(query, 'END TRANSACTION')
 
 evsel_query = QSqlQuery(db)
@@ -571,6 +605,8 @@ exstop_query = QSqlQuery(db)
 exstop_query.prepare("INSERT INTO exstop VALUES (?, ?)")
 pwrx_query = QSqlQuery(db)
 pwrx_query.prepare("INSERT INTO pwrx VALUES (?, ?, ?, ?)")
+context_switch_query = QSqlQuery(db)
+context_switch_query.prepare("INSERT INTO context_switches VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
 	printdate("Writing records...")
@@ -620,6 +656,8 @@ def trace_end():
 		drop("pwrx")
 		if is_table_empty("cbr"):
 			drop("cbr")
+	if is_table_empty("context_switches"):
+		drop("context_switches")
 
 	if (unhandled_count):
 		printdate("Warning: ", unhandled_count, " unhandled events")
@@ -753,3 +791,6 @@ def synth_data(id, config, raw_buf, *x):
 		pwrx(id, raw_buf)
 	elif config == 5:
 		cbr(id, raw_buf)
+
+def context_switch_table(*x):
+	bind_exec(context_switch_query, 9, x)
-- 
2.21.0

