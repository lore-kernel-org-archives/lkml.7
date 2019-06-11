Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C9EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1721883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279623;
	bh=HdrzoafaQcnRasYBrRhe0+Rvc1fqSkkmL3jE0TvvnnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WfbmY7vnhvKZYbag2JRV8/muslH6SkfD/jfKiFuWGjHGNOXoggTqC7lT7SOyAiM6h
	 tGrDmMdNa2Nsg3VNgOstHEHz716/Nnt3VY7LTugG/jwsXz3m6jM3hQYBQQZmSZ/MEm
	 IO9GX3pTFqXzuL59bYDR2IkYKzzYvyKeJSd0RPdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436466AbfFKTAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405209AbfFKTAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B222183F;
        Tue, 11 Jun 2019 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279620;
        bh=HdrzoafaQcnRasYBrRhe0+Rvc1fqSkkmL3jE0TvvnnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+5Z9FrzaFHuUlSKFMYkQOL29+FY0O7/q0ypbLqRnPjnrcS6q7eIwuwRziOLI8gr+
         MUKWo98sBhQast5XIcVwgFAqPydc8X5iRDK3qtmBwyq6Gi5i4y21QAXqdhevVLA1I5
         nkmK3NmaZZlNnqWjqewJvZJWVUo9O9mFPZ+4+K7Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/85] perf db-export: Add brief documentation
Date:   Tue, 11 Jun 2019 15:58:03 -0300
Message-Id: <20190611185911.11645-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add brief documentation to explain how the database export maintains
backward and forward compatibility.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

