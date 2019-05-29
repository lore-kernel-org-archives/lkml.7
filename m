Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724DD227C1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137156;
	bh=crZ486SCP0JFt7/c9ArEIgV7Lz6lr4WAwABUiXEV3CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3gEGm+c+4zIiZ8AHr+4vIJaZQEUMT6jFVsLVL/DKWTG7u23pFFiMDl1JGeW+44yO
	 eu9jxjKW1mBYqsvP3v4sI6+rsSaG7nJE9wLCLUD5jpH3p5NOgvtf12AuQpcBgSj9vj
	 TRowQ+8FnIVBQ747OdzNmagDyitQ3AoVKXX/XE2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfE2NjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2NjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:13 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3D3421902;
        Wed, 29 May 2019 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137152;
        bh=crZ486SCP0JFt7/c9ArEIgV7Lz6lr4WAwABUiXEV3CU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LafFC8qVhRxkxbL2hbNAatT3RibyXxbMtO8pKL1O1pD1hL0B56VQR7U0PduMx+fFI
         8Dh3nss+Lklg58UGvbUvOQ4XEGHnOCbtzF44+4V9k70ge3XmQLB+J7ezPju7ABEAES
         N97jtRZiQoKyseu9Ei+TeiK0b2pdPWTdOlnIGVx0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 36/41] perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
Date:   Wed, 29 May 2019 10:36:00 -0300
Message-Id: <20190529133605.21118-37-acme@kernel.org>
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

The argparse module makes it easier to add new arguments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 9ff92a130655..498b79454012 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -91,6 +91,7 @@
 from __future__ import print_function
 
 import sys
+import argparse
 import weakref
 import threading
 import string
@@ -3361,18 +3362,26 @@ class DBRef():
 # Main
 
 def Main():
-	if (len(sys.argv) < 2):
-		printerr("Usage is: exported-sql-viewer.py {<database name> | --help-only}");
-		raise Exception("Too few arguments")
-
-	dbname = sys.argv[1]
-	if dbname == "--help-only":
+	usage_str =	"exported-sql-viewer.py [--pyside-version-1] <database name>\n" \
+			"   or: exported-sql-viewer.py --help-only"
+	ap = argparse.ArgumentParser(usage = usage_str, add_help = False)
+	ap.add_argument("dbname", nargs="?")
+	ap.add_argument("--help-only", action='store_true')
+	args = ap.parse_args()
+
+	if args.help_only:
 		app = QApplication(sys.argv)
 		mainwindow = HelpOnlyWindow()
 		mainwindow.show()
 		err = app.exec_()
 		sys.exit(err)
 
+	dbname = args.dbname
+	if dbname is None:
+		ap.print_usage()
+		print("Too few arguments")
+		sys.exit(1)
+
 	is_sqlite3 = False
 	try:
 		f = open(dbname, "rb")
-- 
2.20.1

