Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE3AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13920449
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225258;
	bh=Olz0CnjJxMfBl4EwOx1kmCz81KW4dHyIn0WSOOAwvgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AbuM7swXzK1uJugZP1tRo6155MhHHH6MVESU18+jqCrtuYiSnFY5B7vurpE5SFaUB
	 Mi/+nFQB6GfT2XWVITt1aTRi3BQZ7GP/l9JpViwx8iL/Pur/7fNPGoEW9ftnVW1HjV
	 jAaWguv2SindtJQRJvojbmTGvXBCBQd4s2YTOdns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbfGOVOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfGOVOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:14:16 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21F121721;
        Mon, 15 Jul 2019 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225254;
        bh=Olz0CnjJxMfBl4EwOx1kmCz81KW4dHyIn0WSOOAwvgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpECbgyMvWNMoO3ETCCfRTKBEInhB1YQhjeUkcnA8vmIYOrq5hoMiYvdeDWpGKdbp
         sMUa0SGyz+iqnBIYqjYu89tC9Xf4/TOFv5q1ssizRZ246p9U7RzDJAnxEoz0g8hQCW
         zGWQKAeN88rraVXXasssgg7toomYMf7P7xySXKb8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/28] perf scripts python: export-to-postgresql.py: Export switch events
Date:   Mon, 15 Jul 2019 18:11:56 -0300
Message-Id: <20190715211200.10984-25-acme@kernel.org>
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
'context_switches_view'. The table and view will show automatically in the
exported-sql-viewer.py script.

If the table ends up empty, then it and the view are dropped.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-22-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/export-to-postgresql.py    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 13205e4e5b3b..7bd73a904b4e 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -482,6 +482,17 @@ do_query(query, 'CREATE TABLE pwrx ('
 	'last_cstate	integer,'
 	'wake_reason	integer)')
 
+do_query(query, 'CREATE TABLE context_switches ('
+		'id		bigint		NOT NULL,'
+		'machine_id	bigint,'
+		'time		bigint,'
+		'cpu		integer,'
+		'thread_out_id	bigint,'
+		'comm_out_id	bigint,'
+		'thread_in_id	bigint,'
+		'comm_in_id	bigint,'
+		'flags		integer)')
+
 do_query(query, 'CREATE VIEW machines_view AS '
 	'SELECT '
 		'id,'
@@ -695,6 +706,29 @@ do_query(query, 'CREATE VIEW power_events_view AS '
 	' INNER JOIN selected_events ON selected_events.id = samples.evsel_id'
 	' ORDER BY samples.id')
 
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
+			' ELSE CAST ( context_switches.flags AS VARCHAR(11) )'
+		'END AS flags'
+	' FROM context_switches'
+	' INNER JOIN threads AS th_out ON th_out.id   = context_switches.thread_out_id'
+	' INNER JOIN threads AS th_in  ON th_in.id    = context_switches.thread_in_id'
+	' INNER JOIN comms AS comm_out ON comm_out.id = context_switches.comm_out_id'
+	' INNER JOIN comms AS comm_in  ON comm_in.id  = context_switches.comm_in_id')
+
 file_header = struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
 file_trailer = b"\377\377"
 
@@ -759,6 +793,7 @@ mwait_file		= open_output_file("mwait_table.bin")
 pwre_file		= open_output_file("pwre_table.bin")
 exstop_file		= open_output_file("exstop_table.bin")
 pwrx_file		= open_output_file("pwrx_table.bin")
+context_switches_file	= open_output_file("context_switches_table.bin")
 
 def trace_begin():
 	printdate("Writing to intermediate files...")
@@ -807,6 +842,7 @@ def trace_end():
 	copy_output_file(pwre_file,		"pwre")
 	copy_output_file(exstop_file,		"exstop")
 	copy_output_file(pwrx_file,		"pwrx")
+	copy_output_file(context_switches_file,	"context_switches")
 
 	printdate("Removing intermediate files...")
 	remove_output_file(evsel_file)
@@ -828,6 +864,7 @@ def trace_end():
 	remove_output_file(pwre_file)
 	remove_output_file(exstop_file)
 	remove_output_file(pwrx_file)
+	remove_output_file(context_switches_file)
 	os.rmdir(output_dir_name)
 	printdate("Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
@@ -849,6 +886,7 @@ def trace_end():
 	do_query(query, 'ALTER TABLE pwre            ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE exstop          ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE pwrx            ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE context_switches ADD PRIMARY KEY (id)')
 
 	printdate("Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
@@ -900,6 +938,12 @@ def trace_end():
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
 	do_query(query, 'ALTER TABLE  pwrx '
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+	do_query(query, 'ALTER TABLE  context_switches '
+					'ADD CONSTRAINT machinefk   FOREIGN KEY (machine_id)    REFERENCES machines (id),'
+					'ADD CONSTRAINT toutfk      FOREIGN KEY (thread_out_id) REFERENCES threads  (id),'
+					'ADD CONSTRAINT tinfk       FOREIGN KEY (thread_in_id)  REFERENCES threads  (id),'
+					'ADD CONSTRAINT coutfk      FOREIGN KEY (comm_out_id)   REFERENCES comms    (id),'
+					'ADD CONSTRAINT cinfk       FOREIGN KEY (comm_in_id)    REFERENCES comms    (id)')
 
 	printdate("Dropping unused tables")
 	if is_table_empty("ptwrite"):
@@ -912,6 +956,8 @@ def trace_end():
 		drop("pwrx")
 		if is_table_empty("cbr"):
 			drop("cbr")
+	if is_table_empty("context_switches"):
+		drop("context_switches")
 
 	if (unhandled_count):
 		printdate("Warning: ", unhandled_count, " unhandled events")
@@ -1058,3 +1104,8 @@ def synth_data(id, config, raw_buf, *x):
 		pwrx(id, raw_buf)
 	elif config == 5:
 		cbr(id, raw_buf)
+
+def context_switch_table(id, machine_id, time, cpu, thread_out_id, comm_out_id, thread_in_id, comm_in_id, flags, *x):
+	fmt = "!hiqiqiqiiiqiqiqiqii"
+	value = struct.pack(fmt, 9, 8, id, 8, machine_id, 8, time, 4, cpu, 8, thread_out_id, 8, comm_out_id, 8, thread_in_id, 8, comm_in_id, 4, flags)
+	context_switches_file.write(value)
-- 
2.21.0

