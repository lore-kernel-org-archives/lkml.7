Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DE2C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E6E223A1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137166;
	bh=MXRccYpMlxmLylgfI2aT3DcFzrsYYCm6L+HeoEY6cCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gYC89g75XV5bwoXZNZMsJPyadWktc0ugiR/y4zhqbPp6FQEwBazfPeSxLva7D9UWT
	 ofHPicrfTKcNW+Y+FQxIC8Y4uB1d80oxAi8I+9J6s6cp73G4OLrC4rnEsxal8xaHth
	 kkbBU45i1kX/W17QEBv1bj40SZrbGZFdUAiwdWOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfE2NjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2NjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:22 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE56920883;
        Wed, 29 May 2019 13:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137161;
        bh=MXRccYpMlxmLylgfI2aT3DcFzrsYYCm6L+HeoEY6cCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTN6QXYBu4/OqKB41StjquJULPTxTxqioK4Cpexz0bvIzrxVu5/R+cpTLnoPD0Ukp
         jSc6xkmCFHOHjBbQr3CaFuUzs7vBCCXDDTGU85zVY7gM93zm7768zMVpkZj6FdYATA
         //zTjK7LjiO/b0uEyXwvjbC+l0sADNZUdBeEbZM8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/41] perf scripts python: export-to-sqlite.py: Add support for pyside2
Date:   Wed, 29 May 2019 10:36:02 -0300
Message-Id: <20190529133605.21118-39-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

pyside2 is the future for pyside support.

Note pyside use Qt4 whereas pyside2 uses Qt5.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index bf271fbc3a88..f617e518332f 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -21,6 +21,26 @@ import datetime
 # provides LGPL-licensed Python bindings for Qt.  You will also need the package
 # libqt4-sql-sqlite for Qt sqlite3 support.
 #
+# Examples of installing pyside:
+#
+# ubuntu:
+#
+#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#
+#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
+#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
+#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
+# fedora:
+#
+#	$ sudo yum install python-pyside
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#		$ sudo yum install python3-pyside
+#		$ pip install --user PySide2
+#		$ pip3 install --user PySide2
+#
 # An example of using this script with Intel PT:
 #
 #	$ perf record -e intel_pt//u ls
@@ -49,7 +69,16 @@ import datetime
 # difference is  the 'transaction' column of the 'samples' table which is
 # renamed 'transaction_' in sqlite because 'transaction' is a reserved word.
 
-from PySide.QtSql import *
+pyside_version_1 = True
+if not "pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtSql import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtSql import *
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -69,11 +98,12 @@ def printdate(*args, **kw_args):
         print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
-	printerr("where:	columns		'all' or 'branches'");
-	printerr("		calls		'calls' => create calls and call_paths table");
-	printerr("		callchains	'callchains' => create call_paths table");
-	raise Exception("Too few arguments")
+	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
+	printerr("where:  columns            'all' or 'branches'");
+	printerr("        calls              'calls' => create calls and call_paths table");
+	printerr("        callchains         'callchains' => create call_paths table");
+	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
+	raise Exception("Too few or bad arguments")
 
 if (len(sys.argv) < 2):
 	usage()
@@ -95,6 +125,8 @@ for i in range(3,len(sys.argv)):
 		perf_db_export_calls = True
 	elif (sys.argv[i] == "callchains"):
 		perf_db_export_callchains = True
+	elif (sys.argv[i] == "pyside-version-1"):
+		pass
 	else:
 		usage()
 
-- 
2.20.1

