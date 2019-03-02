Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604432075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfCBBSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:18:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:47668 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727800AbfCBBSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:18:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45745AD3E;
        Sat,  2 Mar 2019 01:18:12 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 6/7] perf script python: add Python3 support to sql scripts
Date:   Fri,  1 Mar 2019 17:19:02 -0800
Message-Id: <20190302011903.2416-7-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302011903.2416-1-tonyj@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the exported-sql-viewer.py,
export-to-postgresql.py and export-to-sqlite.py scripts

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 65 +++++++++++++++--------
 tools/perf/scripts/python/export-to-sqlite.py     | 23 ++++----
 tools/perf/scripts/python/exported-sql-viewer.py  | 42 ++++++++++-----
 3 files changed, 84 insertions(+), 46 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 390a351d15ea..439bbbf1e036 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -199,6 +201,16 @@ import datetime
 
 from PySide.QtSql import *
 
+if sys.version_info < (3, 0):
+	def tobytes(str):
+		return str
+else:
+	def tobytes(str):
+		# Use latin-1 (ISO-8859-1) so all code-points 0-255 will result
+		# in one byte (note utf-8 is 2 bytes for values > 128 and
+		# ascii is limited to values <= 128)
+		return bytes(str, "ISO-8859-1")
+
 # Need to access PostgreSQL C library directly to use COPY FROM STDIN
 from ctypes import *
 libpq = CDLL("libpq.so.5")
@@ -234,12 +246,14 @@ perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = False
 
+def printerr(*args, **kw_args):
+	print(*args, file=sys.stderr, **kw_args)
 
 def usage():
-	print >> sys.stderr, "Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
+	printerr("where:	columns		'all' or 'branches'")
+	printerr("		calls		'calls' => create calls and call_paths table")
+	printerr("		callchains	'callchains' => create call_paths table")
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -273,7 +287,7 @@ def do_query(q, s):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+print(datetime.datetime.today(), "Creating database...")
 
 db = QSqlDatabase.addDatabase('QPSQL')
 query = QSqlQuery(db)
@@ -506,12 +520,12 @@ do_query(query, 'CREATE VIEW samples_view AS '
 	' FROM samples')
 
 
-file_header = struct.pack("!11sii", "PGCOPY\n\377\r\n\0", 0, 0)
-file_trailer = "\377\377"
+file_header = struct.pack("!11sii", tobytes("PGCOPY\n\377\r\n\0"), 0, 0)
+file_trailer = tobytes("\377\377")
 
 def open_output_file(file_name):
 	path_name = output_dir_name + "/" + file_name
-	file = open(path_name, "w+")
+	file = open(path_name, "wb+")
 	file.write(file_header)
 	return file
 
@@ -526,13 +540,13 @@ def copy_output_file_direct(file, table_name):
 
 # Use COPY FROM STDIN because security may prevent postgres from accessing the files directly
 def copy_output_file(file, table_name):
-	conn = PQconnectdb("dbname = " + dbname)
+	conn = PQconnectdb(tobytes("dbname = " + dbname))
 	if (PQstatus(conn)):
 		raise Exception("COPY FROM STDIN PQconnectdb failed")
 	file.write(file_trailer)
 	file.seek(0)
 	sql = "COPY " + table_name + " FROM STDIN (FORMAT 'binary')"
-	res = PQexec(conn, sql)
+	res = PQexec(conn, tobytes(sql))
 	if (PQresultStatus(res) != 4):
 		raise Exception("COPY FROM STDIN PQexec failed")
 	data = file.read(65536)
@@ -566,7 +580,7 @@ if perf_db_export_calls:
 	call_file		= open_output_file("call_table.bin")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing to intermediate files..."
+	print(datetime.datetime.today(), "Writing to intermediate files...")
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
@@ -582,7 +596,7 @@ def trace_begin():
 unhandled_count = 0
 
 def trace_end():
-	print datetime.datetime.today(), "Copying to database..."
+	print(datetime.datetime.today(), "Copying to database...")
 	copy_output_file(evsel_file,		"selected_events")
 	copy_output_file(machine_file,		"machines")
 	copy_output_file(thread_file,		"threads")
@@ -597,7 +611,7 @@ def trace_end():
 	if perf_db_export_calls:
 		copy_output_file(call_file,		"calls")
 
-	print datetime.datetime.today(), "Removing intermediate files..."
+	print(datetime.datetime.today(), "Removing intermediate files...")
 	remove_output_file(evsel_file)
 	remove_output_file(machine_file)
 	remove_output_file(thread_file)
@@ -612,7 +626,7 @@ def trace_end():
 	if perf_db_export_calls:
 		remove_output_file(call_file)
 	os.rmdir(output_dir_name)
-	print datetime.datetime.today(), "Adding primary keys"
+	print(datetime.datetime.today(), "Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
@@ -627,7 +641,7 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
 
-	print datetime.datetime.today(), "Adding foreign keys"
+	print(datetime.datetime.today(), "Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
@@ -663,8 +677,8 @@ def trace_end():
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
+	print(datetime.datetime.today(), "Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
@@ -676,13 +690,13 @@ def sched__sched_switch(*x):
 def evsel_table(evsel_id, evsel_name, *x):
 	n = len(evsel_name)
 	fmt = "!hiqi" + str(n) + "s"
-	value = struct.pack(fmt, 2, 8, evsel_id, n, evsel_name)
+	value = struct.pack(fmt, 2, 8, evsel_id, n, tobytes(evsel_name))
 	evsel_file.write(value)
 
 def machine_table(machine_id, pid, root_dir, *x):
 	n = len(root_dir)
 	fmt = "!hiqiii" + str(n) + "s"
-	value = struct.pack(fmt, 3, 8, machine_id, 4, pid, n, root_dir)
+	value = struct.pack(fmt, 3, 8, machine_id, 4, pid, n, tobytes(root_dir))
 	machine_file.write(value)
 
 def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
@@ -692,7 +706,7 @@ def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
 def comm_table(comm_id, comm_str, *x):
 	n = len(comm_str)
 	fmt = "!hiqi" + str(n) + "s"
-	value = struct.pack(fmt, 2, 8, comm_id, n, comm_str)
+	value = struct.pack(fmt, 2, 8, comm_id, n, tobytes(comm_str))
 	comm_file.write(value)
 
 def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
@@ -705,19 +719,24 @@ def dso_table(dso_id, machine_id, short_name, long_name, build_id, *x):
 	n2 = len(long_name)
 	n3 = len(build_id)
 	fmt = "!hiqiqi" + str(n1) + "si"  + str(n2) + "si" + str(n3) + "s"
-	value = struct.pack(fmt, 5, 8, dso_id, 8, machine_id, n1, short_name, n2, long_name, n3, build_id)
+	value = struct.pack(fmt, 5, 8, dso_id, 8, machine_id, n1,
+				tobytes(short_name), n2,
+				tobytes(long_name), n3,
+				tobytes(build_id))
 	dso_file.write(value)
 
 def symbol_table(symbol_id, dso_id, sym_start, sym_end, binding, symbol_name, *x):
 	n = len(symbol_name)
 	fmt = "!hiqiqiqiqiii" + str(n) + "s"
-	value = struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8, sym_start, 8, sym_end, 4, binding, n, symbol_name)
+	value = struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8,
+				sym_start, 8, sym_end, 4, binding, n,
+				tobytes(symbol_name))
 	symbol_file.write(value)
 
 def branch_type_table(branch_type, name, *x):
 	n = len(name)
 	fmt = "!hiii" + str(n) + "s"
-	value = struct.pack(fmt, 2, 4, branch_type, n, name)
+	value = struct.pack(fmt, 2, 4, branch_type, n, tobytes(name))
 	branch_type_file.write(value)
 
 def sample_table(sample_id, evsel_id, machine_id, thread_id, comm_id, dso_id, symbol_id, sym_offset, ip, time, cpu, to_dso_id, to_symbol_id, to_sym_offset, to_ip, period, weight, transaction, data_src, branch_type, in_tx, call_path_id, *x):
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index eb63e6c7107f..3da338243aed 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -10,6 +10,8 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -60,11 +62,14 @@ perf_db_export_mode = True
 perf_db_export_calls = False
 perf_db_export_callchains = False
 
+def printerr(*args, **keyword_args):
+	print(*args, file=sys.stderr, **keyword_args)
+
 def usage():
-	print >> sys.stderr, "Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]"
-	print >> sys.stderr, "where:	columns		'all' or 'branches'"
-	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
-	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
+	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
+	printerr("where:	columns		'all' or 'branches'");
+	printerr("		calls		'calls' => create calls and call_paths table");
+	printerr("		callchains	'callchains' => create call_paths table");
 	raise Exception("Too few arguments")
 
 if (len(sys.argv) < 2):
@@ -100,7 +105,7 @@ def do_query_(q):
 		return
 	raise Exception("Query failed: " + q.lastError().text())
 
-print datetime.datetime.today(), "Creating database..."
+print(datetime.datetime.today(), "Creating database ...")
 
 db_exists = False
 try:
@@ -378,7 +383,7 @@ if perf_db_export_calls:
 	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
-	print datetime.datetime.today(), "Writing records..."
+	print(datetime.datetime.today(), "Writing records...")
 	do_query(query, 'BEGIN TRANSACTION')
 	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
 	evsel_table(0, "unknown")
@@ -397,14 +402,14 @@ unhandled_count = 0
 def trace_end():
 	do_query(query, 'END TRANSACTION')
 
-	print datetime.datetime.today(), "Adding indexes"
+	print(datetime.datetime.today(), "Adding indexes")
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
-		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
-	print datetime.datetime.today(), "Done"
+		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
+	print(datetime.datetime.today(), "Done")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	global unhandled_count
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index afec9479ca7f..e38518cdcbc3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -88,11 +88,20 @@
 #                                                                              7fab593ea956 48 89 15 3b 13 22 00                            movq  %rdx, 0x22133b(%rip)
 # 8107675243232  2    ls       22011  22011  hardware interrupt     No         7fab593ea956 _dl_start+0x26 (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
 
+from __future__ import print_function
+
 import sys
 import weakref
 import threading
 import string
-import cPickle
+try:
+	# Python2
+	import cPickle as pickle
+	# size of pickled integer big enough for record size
+	glb_nsz = 8
+except ImportError:
+	import pickle
+	glb_nsz = 16
 import re
 import os
 from PySide.QtCore import *
@@ -102,6 +111,15 @@ from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
 
+# xrange is range in Python3
+try:
+	xrange
+except NameError:
+	xrange = range
+
+def printerr(*args, **keyword_args):
+	print(*args, file=sys.stderr, **keyword_args)
+
 # Data formatting helpers
 
 def tohex(ip):
@@ -1004,10 +1022,6 @@ class ChildDataItemFinder():
 
 glb_chunk_sz = 10000
 
-# size of pickled integer big enough for record size
-
-glb_nsz = 8
-
 # Background process for SQL data fetcher
 
 class SQLFetcherProcess():
@@ -1066,7 +1080,7 @@ class SQLFetcherProcess():
 				return True
 			if space >= glb_nsz:
 				# Use 0 (or space < glb_nsz) to mean there is no more at the top of the buffer
-				nd = cPickle.dumps(0, cPickle.HIGHEST_PROTOCOL)
+				nd = pickle.dumps(0, pickle.HIGHEST_PROTOCOL)
 				self.buffer[self.local_head : self.local_head + len(nd)] = nd
 			self.local_head = 0
 		if self.local_tail - self.local_head > sz:
@@ -1084,9 +1098,9 @@ class SQLFetcherProcess():
 			self.wait_event.wait()
 
 	def AddToBuffer(self, obj):
-		d = cPickle.dumps(obj, cPickle.HIGHEST_PROTOCOL)
+		d = pickle.dumps(obj, pickle.HIGHEST_PROTOCOL)
 		n = len(d)
-		nd = cPickle.dumps(n, cPickle.HIGHEST_PROTOCOL)
+		nd = pickle.dumps(n, pickle.HIGHEST_PROTOCOL)
 		sz = n + glb_nsz
 		self.WaitForSpace(sz)
 		pos = self.local_head
@@ -1198,12 +1212,12 @@ class SQLFetcher(QObject):
 		pos = self.local_tail
 		if len(self.buffer) - pos < glb_nsz:
 			pos = 0
-		n = cPickle.loads(self.buffer[pos : pos + glb_nsz])
+		n = pickle.loads(self.buffer[pos : pos + glb_nsz])
 		if n == 0:
 			pos = 0
-			n = cPickle.loads(self.buffer[0 : glb_nsz])
+			n = pickle.loads(self.buffer[0 : glb_nsz])
 		pos += glb_nsz
-		obj = cPickle.loads(self.buffer[pos : pos + n])
+		obj = pickle.loads(self.buffer[pos : pos + n])
 		self.local_tail = pos + n
 		return obj
 
@@ -2973,7 +2987,7 @@ class DBRef():
 
 def Main():
 	if (len(sys.argv) < 2):
-		print >> sys.stderr, "Usage is: exported-sql-viewer.py {<database name> | --help-only}"
+		printerr("Usage is: exported-sql-viewer.py {<database name> | --help-only}");
 		raise Exception("Too few arguments")
 
 	dbname = sys.argv[1]
@@ -2986,8 +3000,8 @@ def Main():
 
 	is_sqlite3 = False
 	try:
-		f = open(dbname)
-		if f.read(15) == "SQLite format 3":
+		f = open(dbname, "rb")
+		if f.read(15) == b'SQLite format 3':
 			is_sqlite3 = True
 		f.close()
 	except:
-- 
2.16.4

