Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D63AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C84B2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980729;
	bh=Cy2t5kaNMXoNsPLseG3hCD0f20nB7IRxerfuwqbyahg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lTFbrB9siBka/ZugYU5QFcjf9d4sJGTdAFSLMCDziKYDVyEKf1HUHQnfxwizLMp1i
	 O8xtm3jYV9njoRKtoVj8hXasdYpUKplR5/V9dK6cKY8mgDhMkFjHuRf0UROq1RyGwx
	 rDwwaA6jMEetY29vd7WTznfY/ZIw463FZmnuzUL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfCGRp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfCGRp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:27 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5172E20854;
        Thu,  7 Mar 2019 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980726;
        bh=Cy2t5kaNMXoNsPLseG3hCD0f20nB7IRxerfuwqbyahg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zofR8lk6rBgGI1sMlAf8qk+IN9zBjUYJMrMAo+bZIqNrLznIQSP1gBiSwYS1BExHw
         pwgG4ud902J0d/et1/Y1H3H5mRs69qkvvFwv2VqmPUu5z7p/3fD15uG+c6iOIxhFJI
         xlDKSzFJl4kMNpcF4L1x8sYn7x52kUVkN4R2KDTE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/35] perf scripts python: export-to-sqlite.py: Export calls parent_id
Date:   Thu,  7 Mar 2019 14:44:07 -0300
Message-Id: <20190307174433.28819-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.20.1

