Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E95CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E11120863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfETLiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733133AbfETLiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:38:02 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:38:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/22] perf db-export: Add brief documentation
Date:   Mon, 20 May 2019 14:37:20 +0300
Message-Id: <20190520113728.14389-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add brief documentation to explain how the database export maintains
backward and forward compatibility.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/db-export.txt | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/perf/Documentation/db-export.txt

diff --git a/tools/perf/Documentation/db-export.txt b/tools/perf/Documentation/db-export.txt
new file mode 100644
index 000000000000..52ffccb02d55
--- /dev/null
+++ b/tools/perf/Documentation/db-export.txt
@@ -0,0 +1,41 @@
+Database Export
+===============
+
+perf tool's python scripting engine:
+
+	tools/perf/util/scripting-engines/trace-event-python.c
+
+supports scripts:
+
+	tools/perf/scripts/python/export-to-sqlite.py
+	tools/perf/scripts/python/export-to-postgresql.py
+
+which export data to a SQLite3 or PostgreSQL database.
+
+The export process provides records with unique sequential ids which allows the
+data to be imported directly to a database and provides the relationships
+between tables.
+
+Over time it is possible to continue to expand the export while maintaining
+backward and forward compatibility, by following some simple rules:
+
+1. Because of the nature of SQL, existing tables and columns can continue to be
+used so long as the names and meanings (and to some extent data types) remain
+the same.
+
+2. New tables and columns can be added, without affecting existing SQL queries,
+so long as the new names are unique.
+
+3. Scripts that use a database (e.g. exported-sql-viewer.py) can maintain
+backward compatibility by testing for the presence of new tables and columns
+before using them. e.g. function IsSelectable() in exported-sql-viewer.py
+
+4. The export scripts themselves maintain forward compatibility (i.e. an existing
+script will continue to work with new versions of perf) by accepting a variable
+number of arguments (e.g. def call_return_table(*x)) i.e. perf can pass more
+arguments which old scripts will ignore.
+
+5. The scripting engine tests for the existence of script handler functions
+before calling them.  The scripting engine can also test for the support of new
+or optional features by checking for the existence and value of script global
+variables.
-- 
2.17.1

