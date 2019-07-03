Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CAFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7771218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="POjbIMZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfGCOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:09:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:09:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E8R583321288
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:08:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E8R583321288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162907;
        bh=Bf4J55Homo0QR7s5O9BYU2q4JpfW+reTBmfwsrskFRc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=POjbIMZ2LVNjnuqDqVad+JuqlfBlHVc2oUAqcTJE0+D99GXkh8PJkThx0V1Ap2mev
         Twans9yUUxxxJvBbJo2JVX7aEeAnK06xDxhXh9vx60lN7W3X32pQcN/HACUXnCVNC8
         M/bUlrqJGMOHaqX7W2IrhQgspnQLFcHor20NxZlfceM4fcJ2YrVKyfewnmoxIYrWlp
         6YRuU2J1zBjhGKgf0QyPP93ein8W2n5N5hdDUwcAGFDVQ2WYL8UxFwR+h6Wlmle2ZC
         XT4n0vaWE9VjaMQMXjI7YixPriu5KhtyrDvHV9yNb0iFZ/0hcq3GevfkrEyBO3bSBw
         PkGUIZ7PH62GA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E8Q7N3321285;
        Wed, 3 Jul 2019 07:08:26 -0700
Date:   Wed, 3 Jul 2019 07:08:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-aba44287a224dfcfdd99ba885ca9d9acc4de0c17@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
        acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          acme@redhat.com, jolsa@redhat.com
In-Reply-To: <20190622093248.581-8-adrian.hunter@intel.com>
References: <20190622093248.581-8-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: export-to-postgresql.py:
 Export Intel PT power and ptwrite events
Git-Commit-ID: aba44287a224dfcfdd99ba885ca9d9acc4de0c17
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

Commit-ID:  aba44287a224dfcfdd99ba885ca9d9acc4de0c17
Gitweb:     https://git.kernel.org/tip/aba44287a224dfcfdd99ba885ca9d9acc4de0c17
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sat, 22 Jun 2019 12:32:48 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events

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
Link: http://lkml.kernel.org/r/20190622093248.581-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 251 ++++++++++++++++++++++
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
