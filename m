Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB823C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B003C2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfCVWIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:08:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfCVWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:08:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM7sO5747918
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:07:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM7rjs747915;
        Fri, 22 Mar 2019 15:07:53 -0700
Date:   Fri, 22 Mar 2019 15:07:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-beda0e725e5f06aca27eda2434ea9447dad88e36@git.kernel.org>
Cc:     acme@redhat.com, tonyj@suse.de, adrian.hunter@intel.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, s1seetee@linux.vnet.ibm.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, s1seetee@linux.vnet.ibm.com, tonyj@suse.de,
          adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190309000518.2438-2-tonyj@suse.de>
References: <20190309000518.2438-2-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Add Python3 support to
 exported-sql-viewer.py
Git-Commit-ID: beda0e725e5f06aca27eda2434ea9447dad88e36
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

Commit-ID:  beda0e725e5f06aca27eda2434ea9447dad88e36
Gitweb:     https://git.kernel.org/tip/beda0e725e5f06aca27eda2434ea9447dad88e36
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 8 Mar 2019 16:05:15 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:12:52 -0300

perf script python: Add Python3 support to exported-sql-viewer.py

Support both Python2 and Python3 in the exported-sql-viewer.py script.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20190309000518.2438-2-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 42 ++++++++++++++++--------
 1 file changed, 28 insertions(+), 14 deletions(-)

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
