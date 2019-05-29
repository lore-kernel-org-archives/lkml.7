Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975CAC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EF4229EB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137170;
	bh=SrZRm8Xr66glyVeTySY3uuyAcHgta3TQwbNyVCle1qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oi3jdZJ9F/6OSufbVKhArwGK5KK+JiDnezcpN1obZLzb+DV/WMujHDjhSZvIZayvJ
	 GLyuc+BxF01P4n+WdvjcOTrj+a1Qx2/JKxJ/7yd4HqkZljQSVxsZF4F6bQip0UHKWl
	 RRG8pNyCyI9a1awic+rliwJTfDqMXEzMovrqagA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfE2Nj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2Nj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:26 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C998621902;
        Wed, 29 May 2019 13:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137165;
        bh=SrZRm8Xr66glyVeTySY3uuyAcHgta3TQwbNyVCle1qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyoVUnsDT77iWExpP3mkNvAcd4nQrm6Lul8XKMFe+iDaQLQ/4R+5zhkHNOUuVENMt
         SpC3b/5tRE+i40YULLWjZ+tONrjEi7llObZljUgYxrbfWAz6JjSDV5am7JO/yky9HX
         LU2f5xTXT/GvO0iosW42m31NygQWj4kWOOmQQ9bY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/41] perf scripts python: export-to-postgresql.py: Add support for pyside2
Date:   Wed, 29 May 2019 10:36:03 -0300
Message-Id: <20190529133605.21118-40-acme@kernel.org>
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
Link: http://lkml.kernel.org/r/20190412113830.4126-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/export-to-postgresql.py    | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index c3eae1d77d36..b2f481b0d28d 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -27,18 +27,31 @@ import datetime
 #
 # fedora:
 #
-#	$ sudo yum install postgresql postgresql-server python-pyside qt-postgresql
+#	$ sudo yum install postgresql postgresql-server qt-postgresql
 #	$ sudo su - postgres -c initdb
 #	$ sudo service postgresql start
 #	$ sudo su - postgres
-#	$ createuser <your user id here>
+#	$ createuser -s <your user id here>    # Older versions may not support -s, in which case answer the prompt below:
 #	Shall the new role be a superuser? (y/n) y
+#	$ sudo yum install python-pyside
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#		$ sudo yum install python3-pyside
+#		$ pip install --user PySide2
+#		$ pip3 install --user PySide2
 #
 # ubuntu:
 #
-#	$ sudo apt-get install postgresql python-pyside.qtsql libqt4-sql-psql
+#	$ sudo apt-get install postgresql
 #	$ sudo su - postgres
 #	$ createuser -s <your user id here>
+#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#
+#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
+#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
+#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
 #
 # An example of using this script with Intel PT:
 #
@@ -199,7 +212,16 @@ import datetime
 #                   print "{0:>6}  {1:>10}  {2:>9}  {3:<30}  {4:>6}  {5:<30}".format(query.value(0), query.value(1), query.value(2), query.value(3), query.value(4), query.value(5))
 #                   call_path_id = query.value(6)
 
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
 
 if sys.version_info < (3, 0):
 	def toserverstr(str):
@@ -255,11 +277,12 @@ def printdate(*args, **kw_args):
         print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
-	printerr("where:	columns		'all' or 'branches'")
-	printerr("		calls		'calls' => create calls and call_paths table")
-	printerr("		callchains	'callchains' => create call_paths table")
-	raise Exception("Too few arguments")
+	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
+	printerr("where:  columns            'all' or 'branches'");
+	printerr("        calls              'calls' => create calls and call_paths table");
+	printerr("        callchains         'callchains' => create call_paths table");
+	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
+	raise Exception("Too few or bad arguments")
 
 if (len(sys.argv) < 2):
 	usage()
@@ -281,6 +304,8 @@ for i in range(3,len(sys.argv)):
 		perf_db_export_calls = True
 	elif (sys.argv[i] == "callchains"):
 		perf_db_export_callchains = True
+	elif (sys.argv[i] == "pyside-version-1"):
+		pass
 	else:
 		usage()
 
-- 
2.20.1

