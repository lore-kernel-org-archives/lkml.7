Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82CAC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6AE21851
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034422;
	bh=6twMUHcD6og42d8hAhF3dmZ0VKhQv87lWGOA4hB7I3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QnEPcRAvi/mDH/6BcpmFbT1zTy8Ib7zVpar0kMvx7Qr7zG977if1JPYycRZUeIcYN
	 KqYart+tGkGb2iP/HIVHIPAC/3FujecJdVZzbDvB3jB9cmRg2bIsmbOWQTBQy0jCn/
	 sxUd8sDgQIR4vb9p+BqNnBWDe68Z36ADtbwFnke4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGBC1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfGBC05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4B321721;
        Tue,  2 Jul 2019 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034415;
        bh=6twMUHcD6og42d8hAhF3dmZ0VKhQv87lWGOA4hB7I3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iw5N6k/E/J6PARESO6oK/2irkSpw8WVnEWyh0ReFfVCaXwFB/1Gf06kL6BfFZ01ZK
         IJ1qWX1XxLgltsns2CFxIqiU5DZ5pwl7prX6Tko9gxEO0SusfyD1tFXurAq+Nq7bNS
         d6oAU/o3rlV41UddPyAY8ympKhocvpYcw2EzU7DQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/43] perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events
Date:   Mon,  1 Jul 2019 23:25:43 -0300
Message-Id: <20190702022616.1259-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The format of synthesized events is determined by the attribute config.
For the formats for Intel PT power and ptwrite events, create tables and
populate them when the synth_data handler is called. If the tables
remain empty, drop them at the end.

The tables and views, including a combined power_events_view, will
display automatically from the tables menu of the exported
exported-sql-viewer.py script.

Note, currently only Atoms since Gemini Lake have support for ptwrite
and mwait, pwre, exstop and pwrx, but all Intel PT implementations
support cbr.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 239 ++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 4542ce89034b..3222a83f4184 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -271,6 +271,38 @@ if perf_db_export_calls:
 		'insn_count	bigint,'
 		'cyc_count	bigint)')
 
+do_query(query, 'CREATE TABLE ptwrite ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'payload	bigint,'
+		'exact_ip	integer)')
+
+do_query(query, 'CREATE TABLE cbr ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'cbr		integer,'
+		'mhz		integer,'
+		'percent	integer)')
+
+do_query(query, 'CREATE TABLE mwait ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'hints		integer,'
+		'extensions	integer)')
+
+do_query(query, 'CREATE TABLE pwre ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'cstate		integer,'
+		'subcstate	integer,'
+		'hw		integer)')
+
+do_query(query, 'CREATE TABLE exstop ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'exact_ip	integer)')
+
+do_query(query, 'CREATE TABLE pwrx ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'deepest_cstate	integer,'
+		'last_cstate	integer,'
+		'wake_reason	integer)')
+
 # printf was added to sqlite in version 3.8.3
 sqlite_has_printf = False
 try:
@@ -399,6 +431,102 @@ do_query(query, 'CREATE VIEW samples_view AS '
 		'CASE WHEN cyc_count=0 THEN CAST(0 AS FLOAT) ELSE ROUND(CAST(insn_count AS FLOAT) / cyc_count, 2) END AS IPC'
 	' FROM samples')
 
+do_query(query, 'CREATE VIEW ptwrite_view AS '
+	'SELECT '
+		'ptwrite.id,'
+		'time,'
+		'cpu,'
+		+ emit_to_hex('payload') + ' AS payload_hex,'
+		'CASE WHEN exact_ip=0 THEN \'False\' ELSE \'True\' END AS exact_ip'
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
+		+ emit_to_hex('hints') + ' AS hints_hex,'
+		+ emit_to_hex('extensions') + ' AS extensions_hex'
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
+		'CASE WHEN hw=0 THEN \'False\' ELSE \'True\' END AS hw'
+	' FROM pwre'
+	' INNER JOIN samples ON samples.id = pwre.id')
+
+do_query(query, 'CREATE VIEW exstop_view AS '
+	'SELECT '
+		'exstop.id,'
+		'time,'
+		'cpu,'
+		'CASE WHEN exact_ip=0 THEN \'False\' ELSE \'True\' END AS exact_ip'
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
+			' ELSE wake_reason '
+		'END AS wake_reason'
+	' FROM pwrx'
+	' INNER JOIN samples ON samples.id = pwrx.id')
+
+do_query(query, 'CREATE VIEW power_events_view AS '
+	'SELECT '
+		'samples.id,'
+		'time,'
+		'cpu,'
+		'selected_events.name AS event,'
+		'CASE WHEN selected_events.name=\'cbr\' THEN (SELECT cbr FROM cbr WHERE cbr.id = samples.id) ELSE "" END AS cbr,'
+		'CASE WHEN selected_events.name=\'cbr\' THEN (SELECT mhz FROM cbr WHERE cbr.id = samples.id) ELSE "" END AS mhz,'
+		'CASE WHEN selected_events.name=\'cbr\' THEN (SELECT percent FROM cbr WHERE cbr.id = samples.id) ELSE "" END AS percent,'
+		'CASE WHEN selected_events.name=\'mwait\' THEN (SELECT ' + emit_to_hex('hints') + ' FROM mwait WHERE mwait.id = samples.id) ELSE "" END AS hints_hex,'
+		'CASE WHEN selected_events.name=\'mwait\' THEN (SELECT ' + emit_to_hex('extensions') + ' FROM mwait WHERE mwait.id = samples.id) ELSE "" END AS extensions_hex,'
+		'CASE WHEN selected_events.name=\'pwre\' THEN (SELECT cstate FROM pwre WHERE pwre.id = samples.id) ELSE "" END AS cstate,'
+		'CASE WHEN selected_events.name=\'pwre\' THEN (SELECT subcstate FROM pwre WHERE pwre.id = samples.id) ELSE "" END AS subcstate,'
+		'CASE WHEN selected_events.name=\'pwre\' THEN (SELECT hw FROM pwre WHERE pwre.id = samples.id) ELSE "" END AS hw,'
+		'CASE WHEN selected_events.name=\'exstop\' THEN (SELECT exact_ip FROM exstop WHERE exstop.id = samples.id) ELSE "" END AS exact_ip,'
+		'CASE WHEN selected_events.name=\'pwrx\' THEN (SELECT deepest_cstate FROM pwrx WHERE pwrx.id = samples.id) ELSE "" END AS deepest_cstate,'
+		'CASE WHEN selected_events.name=\'pwrx\' THEN (SELECT last_cstate FROM pwrx WHERE pwrx.id = samples.id) ELSE "" END AS last_cstate,'
+		'CASE WHEN selected_events.name=\'pwrx\' THEN (SELECT '
+			'CASE     WHEN wake_reason=1 THEN \'Interrupt\''
+				' WHEN wake_reason=2 THEN \'Timer Deadline\''
+				' WHEN wake_reason=4 THEN \'Monitored Address\''
+				' WHEN wake_reason=8 THEN \'HW\''
+				' ELSE wake_reason '
+			'END'
+		' FROM pwrx WHERE pwrx.id = samples.id) ELSE "" END AS wake_reason'
+	' FROM samples'
+	' INNER JOIN selected_events ON selected_events.id = evsel_id'
+	' WHERE selected_events.name IN (\'cbr\',\'mwait\',\'exstop\',\'pwre\',\'pwrx\')')
+
 do_query(query, 'END TRANSACTION')
 
 evsel_query = QSqlQuery(db)
@@ -428,6 +556,18 @@ if perf_db_export_calls or perf_db_export_callchains:
 if perf_db_export_calls:
 	call_query = QSqlQuery(db)
 	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+ptwrite_query = QSqlQuery(db)
+ptwrite_query.prepare("INSERT INTO ptwrite VALUES (?, ?, ?)")
+cbr_query = QSqlQuery(db)
+cbr_query.prepare("INSERT INTO cbr VALUES (?, ?, ?, ?)")
+mwait_query = QSqlQuery(db)
+mwait_query.prepare("INSERT INTO mwait VALUES (?, ?, ?)")
+pwre_query = QSqlQuery(db)
+pwre_query.prepare("INSERT INTO pwre VALUES (?, ?, ?, ?)")
+exstop_query = QSqlQuery(db)
+exstop_query.prepare("INSERT INTO exstop VALUES (?, ?)")
+pwrx_query = QSqlQuery(db)
+pwrx_query.prepare("INSERT INTO pwrx VALUES (?, ?, ?, ?)")
 
 def trace_begin():
 	printdate("Writing records...")
@@ -446,6 +586,16 @@ def trace_begin():
 
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
 	do_query(query, 'END TRANSACTION')
 
@@ -454,6 +604,18 @@ def trace_end():
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
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
+
 	if (unhandled_count):
 		printdate("Warning: ", unhandled_count, " unhandled events")
 	printdate("Done")
@@ -509,3 +671,80 @@ def call_path_table(*x):
 
 def call_return_table(*x):
 	bind_exec(call_query, 14, x)
+
+def ptwrite(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	flags = data[0]
+	payload = data[1]
+	exact_ip = flags & 1
+	ptwrite_query.addBindValue(str(id))
+	ptwrite_query.addBindValue(str(payload))
+	ptwrite_query.addBindValue(str(exact_ip))
+	do_query_(ptwrite_query)
+
+def cbr(id, raw_buf):
+	data = struct.unpack_from("<BBBBII", raw_buf)
+	cbr = data[0]
+	MHz = (data[4] + 500) / 1000
+	percent = ((cbr * 1000 / data[2]) + 5) / 10
+	cbr_query.addBindValue(str(id))
+	cbr_query.addBindValue(str(cbr))
+	cbr_query.addBindValue(str(MHz))
+	cbr_query.addBindValue(str(percent))
+	do_query_(cbr_query)
+
+def mwait(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	payload = data[1]
+	hints = payload & 0xff
+	extensions = (payload >> 32) & 0x3
+	mwait_query.addBindValue(str(id))
+	mwait_query.addBindValue(str(hints))
+	mwait_query.addBindValue(str(extensions))
+	do_query_(mwait_query)
+
+def pwre(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	payload = data[1]
+	hw = (payload >> 7) & 1
+	cstate = (payload >> 12) & 0xf
+	subcstate = (payload >> 8) & 0xf
+	pwre_query.addBindValue(str(id))
+	pwre_query.addBindValue(str(cstate))
+	pwre_query.addBindValue(str(subcstate))
+	pwre_query.addBindValue(str(hw))
+	do_query_(pwre_query)
+
+def exstop(id, raw_buf):
+	data = struct.unpack_from("<I", raw_buf)
+	flags = data[0]
+	exact_ip = flags & 1
+	exstop_query.addBindValue(str(id))
+	exstop_query.addBindValue(str(exact_ip))
+	do_query_(exstop_query)
+
+def pwrx(id, raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	payload = data[1]
+	deepest_cstate = payload & 0xf
+	last_cstate = (payload >> 4) & 0xf
+	wake_reason = (payload >> 8) & 0xf
+	pwrx_query.addBindValue(str(id))
+	pwrx_query.addBindValue(str(deepest_cstate))
+	pwrx_query.addBindValue(str(last_cstate))
+	pwrx_query.addBindValue(str(wake_reason))
+	do_query_(pwrx_query)
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
2.20.1

