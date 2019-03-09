Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC181C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAC320815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCITxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:53:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32973 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCITxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:53:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JrUlg3201293
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:53:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JrUlg3201290;
        Sat, 9 Mar 2019 11:53:30 -0800
Date:   Sat, 9 Mar 2019 11:53:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-eybd6fnk6j9r7g643lsideoo@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
          adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-postgresql.py:
 Export calls parent_id
Git-Commit-ID: febce6dc1f5167e683d6e3c3d0f6ab7f98201ea8
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

Commit-ID:  febce6dc1f5167e683d6e3c3d0f6ab7f98201ea8
Gitweb:     https://git.kernel.org/tip/febce6dc1f5167e683d6e3c3d0f6ab7f98201ea8
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:27 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:53:33 -0300

perf scripts python: export-to-postgresql.py: Export calls parent_id

Export to the 'calls' table the newly created 'parent_id' and create an
index for it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-eybd6fnk6j9r7g643lsideoo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 6358522a69f6..390a351d15ea 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -394,7 +394,8 @@ if perf_db_export_calls:
 		'call_id	bigint,'
 		'return_id	bigint,'
 		'parent_call_path_id	bigint,'
-		'flags		integer)')
+		'flags		integer,'
+		'parent_id	bigint)')
 
 do_query(query, 'CREATE VIEW machines_view AS '
 	'SELECT '
@@ -479,7 +480,8 @@ if perf_db_export_calls:
 			'call_id,'
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
-			'parent_call_path_id'
+			'parent_call_path_id,'
+			'calls.parent_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
 do_query(query, 'CREATE VIEW samples_view AS '
@@ -575,6 +577,7 @@ def trace_begin():
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 	if perf_db_export_calls or perf_db_export_callchains:
 		call_path_table(0, 0, 0, 0)
+		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
 
 unhandled_count = 0
 
@@ -657,6 +660,7 @@ def trace_end():
 					'ADD CONSTRAINT returnfk    FOREIGN KEY (return_id)    REFERENCES samples    (id),'
 					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
+		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
 
 	if (unhandled_count):
 		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
@@ -728,7 +732,7 @@ def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
 	value = struct.pack(fmt, 4, 8, cp_id, 8, parent_id, 8, symbol_id, 8, ip)
 	call_path_file.write(value)
 
-def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, *x):
-	fmt = "!hiqiqiqiqiqiqiqiqiqiqii"
-	value = struct.pack(fmt, 11, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags)
+def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, parent_id, *x):
+	fmt = "!hiqiqiqiqiqiqiqiqiqiqiiiq"
+	value = struct.pack(fmt, 12, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags, 8, parent_id)
 	call_file.write(value)
