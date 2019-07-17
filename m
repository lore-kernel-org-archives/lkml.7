Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B307EC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7221783
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qKsrAfK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfGQXE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:04:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46437 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfGQXE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:04:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN4nu31725477
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:04:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN4nu31725477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404690;
        bh=SzndoWfCgEKFRZyDeWCB/Nw6sZ6ea+9Rk+qSp0jAZQc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qKsrAfK1sljKVmYSslmN+UoU/esJwNdE3GVg85CBON90d9xbRohqBBD+1Z0aiJpM8
         uncE1XBfPT1YvH+gKs8vOOEmLLxXwAvqpioSOglTRNOwH9vcf3kiPrqdcyHkFO+GKb
         cLPf5FYL37gtQGpBYXORbP7VMFak8+fFg9bfinXubvlkduB4MdQsnIW6ZOxBTERSx2
         g1Cv6JLYlvq8dV6kJ3/qYtJ1TlcV1EaJY52LylhJxCnuzNINVRY80y4pHTJa+dzuCI
         gX8Xl/gB7DLziG5m5CrBtGu4sAtw6Vpo+5L3P8Kh0hSMGnnovFnMxt4AKjC5qh9LkC
         3ahPycSPHFJoA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN4nEs1725474;
        Wed, 17 Jul 2019 16:04:49 -0700
Date:   Wed, 17 Jul 2019 16:04:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-37c1f991b1bcdbe268b99b22e265738f4209f4f4@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
          jolsa@redhat.com
In-Reply-To: <20190710085810.1650-21-adrian.hunter@intel.com>
References: <20190710085810.1650-21-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-sqlite.py: Export
 switch events
Git-Commit-ID: 37c1f991b1bcdbe268b99b22e265738f4209f4f4
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

Commit-ID:  37c1f991b1bcdbe268b99b22e265738f4209f4f4
Gitweb:     https://git.kernel.org/tip/37c1f991b1bcdbe268b99b22e265738f4209f4f4
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:09 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:37:35 -0300

perf scripts python: export-to-sqlite.py: Export switch events

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
 tools/perf/scripts/python/export-to-sqlite.py | 41 +++++++++++++++++++++++++++
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
