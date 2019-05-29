Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6643AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A61B21902
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137161;
	bh=B11Yj+8sxnTDyXtrPmHvMLu7liezdbxl0bQPc7HC/I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drn6IpAKDG6W/w2lSsOW1xjIfvr9tLtWxFQWPL9U4AFzAYJa+fraGiYLnHOUv47CF
	 /8vX2h0XNems8J03rw8nNyqzofqbSQayihoew/N3/PYjbs25AQuc7QaPy5SHWDP1Bl
	 NHme3NXhbQsgvOaK/6rSZ31+HGEfon4XoYocrmzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfE2NjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2NjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:18 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339D822353;
        Wed, 29 May 2019 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137157;
        bh=B11Yj+8sxnTDyXtrPmHvMLu7liezdbxl0bQPc7HC/I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbNQ6SBW2kWNlPR3LtXz5+0QdRwH8m+K/uT+AmSwS8N83mX9Evl4jnrxS6fINQ0zM
         N0HlKY9aG3QAcE3wkYzJfsko48jVMYhS1Ovb4yS64F7uC8GxkbcpytcvIBApZyGSJc
         KTGXfoxiHms+ylCPw9kASKy3pn/fJTWwZpPuTgg8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 37/41] perf scripts python: exported-sql-viewer.py: Add support for pyside2
Date:   Wed, 29 May 2019 10:36:01 -0300
Message-Id: <20190529133605.21118-38-acme@kernel.org>
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

Committer testing:

On a system with just:

  # rpm -qa| grep -i pyside
  python2-pyside-1.2.4-7.fc29.x86_64
  #

Running:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db &
  [1] 7438

Makes it use the pyside 1 files:

  $ grep -i pyside /proc/7438/maps | cut -d ' ' -f 6- | sort -u
     /usr/lib64/libpyside-python2.7.so.1.2.4
     /usr/lib64/python2.7/site-packages/PySide/QtCore.so
     /usr/lib64/python2.7/site-packages/PySide/QtGui.so
     /usr/lib64/python2.7/site-packages/PySide/QtSql.so
  $ rpm -qf /usr/lib64/libpyside-python2.7.so.1.2.4
  python2-pyside-1.2.4-7.fc29.x86_64
  $

To get PySide2 I guess one needs to do:

  $ pip install PySide2

But thats a 142MiB download I can't do right now, perhaps before pushing
upstream...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 498b79454012..6fe553258ce5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -105,10 +105,23 @@ except ImportError:
 	glb_nsz = 16
 import re
 import os
-from PySide.QtCore import *
-from PySide.QtGui import *
-from PySide.QtSql import *
+
 pyside_version_1 = True
+if not "--pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtCore import *
+		from PySide2.QtGui import *
+		from PySide2.QtSql import *
+		from PySide2.QtWidgets import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtCore import *
+	from PySide.QtGui import *
+	from PySide.QtSql import *
+
 from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
@@ -2755,7 +2768,7 @@ class WindowMenu():
 			action = self.window_menu.addAction(label)
 			action.setCheckable(True)
 			action.setChecked(sub_window == self.mdi_area.activeSubWindow())
-			action.triggered.connect(lambda x=nr: self.setActiveSubWindow(x))
+			action.triggered.connect(lambda a=None,x=nr: self.setActiveSubWindow(x))
 			self.window_menu.addAction(action)
 			nr += 1
 
@@ -3115,14 +3128,14 @@ class MainWindow(QMainWindow):
 			event = event.split(":")[0]
 			if event == "branches":
 				label = "All branches" if branches_events == 1 else "All branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewBranchView(x), self))
 				label = "Selected branches" if branches_events == 1 else "Selected branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewSelectedBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewSelectedBranchView(x), self))
 
 	def TableMenu(self, tables, menu):
 		table_menu = menu.addMenu("&Tables")
 		for table in tables:
-			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda t=table: self.NewTableView(t), self))
+			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda a=None,t=table: self.NewTableView(t), self))
 
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
@@ -3365,6 +3378,7 @@ def Main():
 	usage_str =	"exported-sql-viewer.py [--pyside-version-1] <database name>\n" \
 			"   or: exported-sql-viewer.py --help-only"
 	ap = argparse.ArgumentParser(usage = usage_str, add_help = False)
+	ap.add_argument("--pyside-version-1", action='store_true')
 	ap.add_argument("dbname", nargs="?")
 	ap.add_argument("--help-only", action='store_true')
 	args = ap.parse_args()
-- 
2.20.1

