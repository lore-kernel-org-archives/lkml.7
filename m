Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79312089C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFVJeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:34:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:26120 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfFVJeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:34:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 02:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="312233174"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2019 02:34:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events
Date:   Sat, 22 Jun 2019 12:32:48 +0300
Message-Id: <20190622093248.581-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190622093248.581-1-adrian.hunter@intel.com>
References: <20190622093248.581-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format of synthesized events is determined by the attribute config. For
the formats for Intel PT power and ptwrite events, create tables and
populate them when the synth_data handler is called. If the tables remain
empty, drop them at the end.

The tables and views, including a combined power_events_view, will display
automatically from the tables menu of the exported exported-sql-viewer.py
script.

Note, currently only Atoms since Gemini Lake have support for ptwrite and
mwait, pwre, exstop and pwrx, but all Intel PT implementations support cbr.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/export-to-postgresql.py    | 251 ++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 93225c02117e..4447f0d7c754 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -447,6 +447,38 @@ if perf_db_export_calls:
 		'insn_count	bigint,'
 		'cyc_count	bigint)')
 
+do_query(query, 'CREATE TABLE ptwrite ('
+	'id		bigint		NOT NULL,'
+	'payload	bigint,'
+	'exact_ip	boolean)')
+
+do_query(query, 'CREATE TABLE cbr ('
+	'id		bigint		NOT NULL,'
+	'cbr		integer,'
+	'mhz		integer,'
+	'percent	integer)')
+
+do_query(query, 'CREATE TABLE mwait ('
+	'id		bigint		NOT NULL,'
+	'hints		integer,'
+	'extensions	integer)')
+
+do_query(query, 'CREATE TABLE pwre ('
+	'id		bigint		NOT NULL,'
+	'cstate		integer,'
+	'subcstate	integer,'
+	'hw		boolean)')
+
+do_query(query, 'CREATE TABLE exstop ('
+	'id		bigint		NOT NULL,'
+	'exact_ip	boolean)')
+
+do_query(query, 'CREATE TABLE pwrx ('
+	'id		bigint		NOT NULL,'
+	'deepest_cstate	integer,'
+	'last_cstate	integer,'
+	'wake_reason	integer)')
+
 do_query(query, 'CREATE VIEW machines_view AS '
 	'SELECT '
 		'id,'
@@ -561,6 +593,104 @@ do_query(query, 'CREATE VIEW samples_view AS '
 		'CASE WHEN cyc_count=0 THEN CAST(0 AS NUMERIC(20, 2)) ELSE CAST((CAST(insn_count AS FLOAT) / cyc_count) AS NUMERIC(20, 2)) END AS IPC'
 	' FROM samples')
 
+do_query(query, 'CREATE VIEW ptwrite_view AS '
+	'SELECT '
+		'ptwrite.id,'
+		'time,'
+		'cpu,'
+		'to_hex(payload) AS payload_hex,'
+		'CASE WHEN exact_ip=FALSE THEN \'False\' ELSE \'True\' END AS exact_ip'
+	' FROM ptwrite'
+	' INNER JOIN samples ON samples.id = ptwrite.id')
+
+do_query(query, 'CREATE VIEW cbr_view AS '
+	'SELECT '
+		'cbr.id,'
+		'time,'
+		'cpu,'
+		'cbr,'
+		'mhz,'
+		'percent'
+	' FROM cbr'
+	' INNER JOIN samples ON samples.id = cbr.id')
+
+do_query(query, 'CREATE VIEW mwait_view AS '
+	'SELECT '
+		'mwait.id,'
+		'time,'
+		'cpu,'
+		'to_hex(hints) AS hints_hex,'
+		'to_hex(extensions) AS extensions_hex'
+	' FROM mwait'
+	' INNER JOIN samples ON samples.id = mwait.id')
+
+do_query(query, 'CREATE VIEW pwre_view AS '
+	'SELECT '
+		'pwre.id,'
+		'time,'
+		'cpu,'
+		'cstate,'
+		'subcstate,'
+		'CASE WHEN hw=FALSE THEN \'False\' ELSE \'True\' END AS hw'
+	' FROM pwre'
+	' INNER JOIN samples ON samples.id = pwre.id')
+
+do_query(query, 'CREATE VIEW exstop_view AS '
+	'SELECT '
+		'exstop.id,'
+		'time,'
+		'cpu,'
+		'CASE WHEN exact_ip=FALSE THEN \'False\' ELSE \'True\' END AS exact_ip'
+	' FROM exstop'
+	' INNER JOIN samples ON samples.id = exstop.id')
+
+do_query(query, 'CREATE VIEW pwrx_view AS '
+	'SELECT '
+		'pwrx.id,'
+		'time,'
+		'cpu,'
+		'deepest_cstate,'
+		'last_cstate,'
+		'CASE     WHEN wake_reason=1 THEN \'Interrupt\''
+			' WHEN wake_reason=2 THEN \'Timer Deadline\''
+			' WHEN wake_reason=4 THEN \'Monitored Address\''
+			' WHEN wake_reason=8 THEN \'HW\''
+			' ELSE CAST ( wake_reason AS VARCHAR(2) )'
+		'END AS wake_reason'
+	' FROM pwrx'
+	' INNER JOIN samples ON samples.id = pwrx.id')
+
+do_query(query, 'CREATE VIEW power_events_view AS '
+	'SELECT '
+		'samples.id,'
+		'samples.time,'
+		'samples.cpu,'
+		'selected_events.name AS event,'
+		'FORMAT(\'%6s\', cbr.cbr) AS cbr,'
+		'FORMAT(\'%6s\', cbr.mhz) AS MHz,'
+		'FORMAT(\'%5s\', cbr.percent) AS percent,'
+		'to_hex(mwait.hints) AS hints_hex,'
+		'to_hex(mwait.extensions) AS extensions_hex,'
+		'FORMAT(\'%3s\', pwre.cstate) AS cstate,'
+		'FORMAT(\'%3s\', pwre.subcstate) AS subcstate,'
+		'CASE WHEN pwre.hw=FALSE THEN \'False\' WHEN pwre.hw=TRUE THEN \'True\' ELSE NULL END AS hw,'
+		'CASE WHEN exstop.exact_ip=FALSE THEN \'False\' WHEN exstop.exact_ip=TRUE THEN \'True\' ELSE NULL END AS exact_ip,'
+		'FORMAT(\'%3s\', pwrx.deepest_cstate) AS deepest_cstate,'
+		'FORMAT(\'%3s\', pwrx.last_cstate) AS last_cstate,'
+		'CASE     WHEN pwrx.wake_reason=1 THEN \'Interrupt\''
+			' WHEN pwrx.wake_reason=2 THEN \'Timer Deadline\''
+			' WHEN pwrx.wake_reason=4 THEN \'Monitored Address\''
+			' WHEN pwrx.wake_reason=8 THEN \'HW\''
+			' ELSE FORMAT(\'%2s\', pwrx.wake_reason)'
+		'END AS wake_reason'
+	' FROM cbr'
+	' FULL JOIN mwait ON mwait.id = cbr.id'
+	' FULL JOIN pwre ON pwre.id = cbr.id'
+	' FULL JOIN exstop ON exstop.id = cbr.id'
+	' FULL JOIN pwrx ON pwrx.id = cbr.id'
+	' INNER JOIN samples ON samples.id = coalesce(cbr.id, mwait.id, pwre.id, exstop.id, pwrx.id)'
+	' INNER JOIN selected_events ON selected_events.id = samples.evsel_id'
+	' ORDER BY samples.id')
 
 file_header = struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
 file_trailer = b"\377\377"
@@ -620,6 +750,12 @@ if perf_db_export_calls or perf_db_export_callchains:
 	call_path_file		= open_output_file("call_path_table.bin")
 if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
+ptwrite_file		= open_output_file("ptwrite_table.bin")
+cbr_file		= open_output_file("cbr_table.bin")
+mwait_file		= open_output_file("mwait_table.bin")
+pwre_file		= open_output_file("pwre_table.bin")
+exstop_file		= open_output_file("exstop_table.bin")
+pwrx_file		= open_output_file("pwrx_table.bin")
 
 def trace_begin():
 	printdate("Writing to intermediate files...")
@@ -637,6 +773,16 @@ def trace_begin():
 
 unhandled_count = 0
 
+def is_table_empty(table_name):
+	do_query(query, 'SELECT * FROM ' + table_name + ' LIMIT 1');
+	if query.next():
+		return False
+	return True
+
+def drop(table_name):
+	do_query(query, 'DROP VIEW ' + table_name + '_view');
+	do_query(query, 'DROP TABLE ' + table_name);
+
 def trace_end():
 	printdate("Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
@@ -652,6 +798,12 @@ def trace_end():
 		copy_output_file(call_path_file,	"call_paths")
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
+	copy_output_file(ptwrite_file,		"ptwrite")
+	copy_output_file(cbr_file,		"cbr")
+	copy_output_file(mwait_file,		"mwait")
+	copy_output_file(pwre_file,		"pwre")
+	copy_output_file(exstop_file,		"exstop")
+	copy_output_file(pwrx_file,		"pwrx")
 
 	printdate("Removing intermediate files...")
 	remove_output_file(evsel_file)
@@ -667,6 +819,12 @@ def trace_end():
 		remove_output_file(call_path_file)
 	if perf_db_export_calls:
 		remove_output_file(call_file)
+	remove_output_file(ptwrite_file)
+	remove_output_file(cbr_file)
+	remove_output_file(mwait_file)
+	remove_output_file(pwre_file)
+	remove_output_file(exstop_file)
+	remove_output_file(pwrx_file)
 	os.rmdir(output_dir_name)
 	printdate("Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
@@ -682,6 +840,12 @@ def trace_end():
 		do_query(query, 'ALTER TABLE call_paths      ADD PRIMARY KEY (id)')
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE ptwrite         ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE cbr             ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE mwait           ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE pwre            ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE exstop          ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE pwrx            ADD PRIMARY KEY (id)')
 
 	printdate("Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
@@ -717,6 +881,30 @@ def trace_end():
 					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+	do_query(query, 'ALTER TABLE ptwrite '
+					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+	do_query(query, 'ALTER TABLE  cbr '
+					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+	do_query(query, 'ALTER TABLE  mwait '
+					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+	do_query(query, 'ALTER TABLE  pwre '
+					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+	do_query(query, 'ALTER TABLE  exstop '
+					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+	do_query(query, 'ALTER TABLE  pwrx '
+					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+
+	printdate("Dropping unused tables")
+	if is_table_empty("ptwrite"):
+		drop("ptwrite")
+	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty("exstop") and is_table_empty("pwrx"):
+		drop("mwait")
+		drop("pwre")
+		drop("exstop")
+		drop("pwrx")
+		do_query(query, 'DROP VIEW power_events_view');
+		if is_table_empty("cbr"):
+			drop("cbr")
 
 	if (unhandled_count):
 		printdate("Warning: ", unhandled_count, " unhandled events")
@@ -800,3 +988,66 @@ def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return
 	fmt = "!hiqiqiqiqiqiqiqiqiqiqiiiqiqiq"
 	value = struct.pack(fmt, 14, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags, 8, parent_id, 8, insn_cnt, 8, cyc_cnt)
 	call_file.write(value)
+
+def ptwrite(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	flags = data[0]
+	payload = data[1]
+	exact_ip = flags & 1
+	value = struct.pack("!hiqiqiB", 3, 8, id, 8, payload, 1, exact_ip)
+	ptwrite_file.write(value)
+
+def cbr(id, raw_buf):
+	data = struct.unpack_from("<BBBBII", raw_buf)
+	cbr = data[0]
+	MHz = (data[4] + 500) / 1000
+	percent = ((cbr * 1000 / data[2]) + 5) / 10
+	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, MHz, 4, percent)
+	cbr_file.write(value)
+
+def mwait(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	payload = data[1]
+	hints = payload & 0xff
+	extensions = (payload >> 32) & 0x3
+	value = struct.pack("!hiqiiii", 3, 8, id, 4, hints, 4, extensions)
+	mwait_file.write(value)
+
+def pwre(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	payload = data[1]
+	hw = (payload >> 7) & 1
+	cstate = (payload >> 12) & 0xf
+	subcstate = (payload >> 8) & 0xf
+	value = struct.pack("!hiqiiiiiB", 4, 8, id, 4, cstate, 4, subcstate, 1, hw)
+	pwre_file.write(value)
+
+def exstop(id, raw_buf):
+	data = struct.unpack_from("<I", raw_buf)
+	flags = data[0]
+	exact_ip = flags & 1
+	value = struct.pack("!hiqiB", 2, 8, id, 1, exact_ip)
+	exstop_file.write(value)
+
+def pwrx(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	payload = data[1]
+	deepest_cstate = payload & 0xf
+	last_cstate = (payload >> 4) & 0xf
+	wake_reason = (payload >> 8) & 0xf
+	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, deepest_cstate, 4, last_cstate, 4, wake_reason)
+	pwrx_file.write(value)
+
+def synth_data(id, config, raw_buf, *x):
+	if config == 0:
+		ptwrite(id, raw_buf)
+	elif config == 1:
+		mwait(id, raw_buf)
+	elif config == 2:
+		pwre(id, raw_buf)
+	elif config == 3:
+		exstop(id, raw_buf)
+	elif config == 4:
+		pwrx(id, raw_buf)
+	elif config == 5:
+		cbr(id, raw_buf)
-- 
2.17.1

