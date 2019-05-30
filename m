Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F4224998
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TsSJuzS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfE3ISi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:18:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59173 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3ISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:18:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8INFL2905561
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:18:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8INFL2905561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204304;
        bh=WtzjA5iVaeZS5aQwYmIMBU/54L7b0eoy5kspVaS4WcE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TsSJuzS9Ysv8vkatXFC/jl/DVwgZULbp/bdqxtVMLGfzrYgy4/iuTuwwelIPRtRFw
         dVsCxzw/oTRaX/nKrdCoRBueeU1rOrROT4Fb9byKEhekvumJ1K7TUuj0C55ATACGw4
         RKBAODlk36/0Z1wX0lM1/97xy0VassemuK23rZqgl6M9xDrxzXiKiZdXj+Mou9R+bu
         QXuhj7abvuWOGn9BfP3rlIOGcxX07jrN6WKH07vwrMcqxTb1YL+DNQC2uFkSBAvGC2
         Fg1Zn8WpoyGFAnQjyZ4Fbxib4NFp1k41/6Hjrs4QPp9/9AqztHw0mDCOQEp8gnF3LJ
         rIb0QzBKLFG7A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8INCd2905558;
        Thu, 30 May 2019 01:18:23 -0700
Date:   Thu, 30 May 2019 01:18:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1ed7f47fd3af3c09d2cd64d1aff1c5b96d238111@git.kernel.org>
Cc:     jolsa@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com
In-Reply-To: <20190412113830.4126-3-adrian.hunter@intel.com>
References: <20190412113830.4126-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Use
 argparse module for argument parsing
Git-Commit-ID: 1ed7f47fd3af3c09d2cd64d1aff1c5b96d238111
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

Commit-ID:  1ed7f47fd3af3c09d2cd64d1aff1c5b96d238111
Gitweb:     https://git.kernel.org/tip/1ed7f47fd3af3c09d2cd64d1aff1c5b96d238111
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:24 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing

The argparse module makes it easier to add new arguments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 21 +++++++++++++++------
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
