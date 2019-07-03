Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77923C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33256218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HpCgxrHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfGCOIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:08:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:08:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E7iUx3321221
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:07:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E7iUx3321221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162865;
        bh=pdY3r2tGvz/D/4aLE1F1UTy2UvuA3DsUqwQjW1ZErww=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HpCgxrHwcnBaqtJQmezijjE7dgOk2OCEHXJ0pnHXmEfZphJkc/yLiJodsO2HZgrb9
         49g8y04KNlo17dv3u4dvGovIX9y6jN+3/4oi1KS/2sEeD17CYwpwhorzCSyg+g6u/4
         OOFezhMZcGZR1eFQmwEpzSmVHlO9gvE6kTkNJd7zaqrtuTrXHmXMxsDf03vN1vsgav
         VmHHPDpq1ffK7nkHtpm5O147mXtkIfWcv04hBu1mqXi2VF/fOK7BVUVwfAHN+Gp06Y
         PwmZn+ndt5BBXxfp/iwv85rYIu/ELztgZvaRa1jFLsHEIQkztUzwKK9QD/dio7dsvK
         LqSHaiVdRbfBg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E7iwN3321215;
        Wed, 3 Jul 2019 07:07:44 -0700
Date:   Wed, 3 Jul 2019 07:07:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5130c6e55531b9bbcdeb8b327711ff204bc4835f@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jolsa@redhat.com
In-Reply-To: <20190622093248.581-7-adrian.hunter@intel.com>
References: <20190622093248.581-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: export-to-sqlite.py: Export
 Intel PT power and ptwrite events
Git-Commit-ID: 5130c6e55531b9bbcdeb8b327711ff204bc4835f
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

Commit-ID:  5130c6e55531b9bbcdeb8b327711ff204bc4835f
Gitweb:     https://git.kernel.org/tip/5130c6e55531b9bbcdeb8b327711ff204bc4835f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sat, 22 Jun 2019 12:32:47 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events

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
 tools/perf/scripts/python/export-to-sqlite.py | 239 ++++++++++++++++++++++++++
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
