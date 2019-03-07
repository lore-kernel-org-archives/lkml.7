Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B7C20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980738;
	bh=CLVq/GOoMD1AWcr2ibKLhu3teZxEb1Ri2NRUdETigVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jr+k1t5ue6QPEiz0h8b35/9LqYNRe3eqYF6BN8MeWQ23wyidFg9viYwxstdqPqdN5
	 dsUt9ZuUQD8HNTl02eim7Pu3W3h0m4r/+YqaqDwmPEXxIkXc459uMMtwfbfYR+CTKZ
	 ua41wFBsFB4Aije98oA8flQLjvNERafHGovtxX+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCGRpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCGRpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:35 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2A272085A;
        Thu,  7 Mar 2019 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980733;
        bh=CLVq/GOoMD1AWcr2ibKLhu3teZxEb1Ri2NRUdETigVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFD3G6xAPL5sBcO2oPfP4LGfDxHWZWKXsbg8Ws0VpDcd3/AdT00UF7f0QYcpV6ZBu
         Z4AadXwtTz2BZjSN8S0pxfePhX+opbXI/z7zU8LMQIY4BXgjanmU4vNVQcKHT11BKQ
         YRWGKtcRyxBZwopEV93xXagYzusavfkbfb+tEZtc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/35] perf scripts python: export-to-postgresql.py: Export calls parent_id
Date:   Thu,  7 Mar 2019 14:44:09 -0300
Message-Id: <20190307174433.28819-12-acme@kernel.org>
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
-- 
2.20.1

