Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD78DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AB720815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfCITwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:52:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfCITwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:52:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Jq9IM3201223
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:52:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Jq9xZ3201220;
        Sat, 9 Mar 2019 11:52:09 -0800
Date:   Sat, 9 Mar 2019 11:52:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b09oukl48rsl9azkp2wmh0bl@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de, acme@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-sqlite.py: Export
 calls parent_id
Git-Commit-ID: 8ce9a7251d110c7bbb43e30dd42f81d8e6286516
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

Commit-ID:  8ce9a7251d110c7bbb43e30dd42f81d8e6286516
Gitweb:     https://git.kernel.org/tip/8ce9a7251d110c7bbb43e30dd42f81d8e6286516
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:25 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:52:29 -0300

perf scripts python: export-to-sqlite.py: Export calls parent_id

Export to the 'calls' table the newly created 'parent_id'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-b09oukl48rsl9azkp2wmh0bl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index ed237f2ed03f..eb63e6c7107f 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -222,7 +222,8 @@ if perf_db_export_calls:
 		'call_id	bigint,'
 		'return_id	bigint,'
 		'parent_call_path_id	bigint,'
-		'flags		integer)')
+		'flags		integer,'
+		'parent_id	bigint)')
 
 # printf was added to sqlite in version 3.8.3
 sqlite_has_printf = False
@@ -321,7 +322,8 @@ if perf_db_export_calls:
 			'call_id,'
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
-			'parent_call_path_id'
+			'parent_call_path_id,'
+			'parent_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
 do_query(query, 'CREATE VIEW samples_view AS '
@@ -373,7 +375,7 @@ if perf_db_export_calls or perf_db_export_callchains:
 	call_path_query.prepare("INSERT INTO call_paths VALUES (?, ?, ?, ?)")
 if perf_db_export_calls:
 	call_query = QSqlQuery(db)
-	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
+	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
 	print datetime.datetime.today(), "Writing records..."
@@ -388,6 +390,7 @@ def trace_begin():
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 	if perf_db_export_calls or perf_db_export_callchains:
 		call_path_table(0, 0, 0, 0)
+		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 
 unhandled_count = 0
 
@@ -397,6 +400,7 @@ def trace_end():
 	print datetime.datetime.today(), "Adding indexes"
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
+		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
 		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
@@ -452,4 +456,4 @@ def call_path_table(*x):
 	bind_exec(call_path_query, 4, x)
 
 def call_return_table(*x):
-	bind_exec(call_query, 11, x)
+	bind_exec(call_query, 12, x)
