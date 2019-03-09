Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B456FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8989120815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCITw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:52:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCITw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:52:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JqpDP3201257
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:52:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JqoX83201254;
        Sat, 9 Mar 2019 11:52:50 -0800
Date:   Sat, 9 Mar 2019 11:52:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-strfpdozrvg7bi1xzrivxzqt@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de, jolsa@redhat.com,
          acme@redhat.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-postgresql.py: Fix
 invalid input syntax for integer error
Git-Commit-ID: 07c5ebead85f507271fb8e2a8b5814e486702518
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

Commit-ID:  07c5ebead85f507271fb8e2a8b5814e486702518
Gitweb:     https://git.kernel.org/tip/07c5ebead85f507271fb8e2a8b5814e486702518
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:26 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:53:12 -0300

perf scripts python: export-to-postgresql.py: Fix invalid input syntax for integer error

Fix SQL query error "invalid input syntax for integer":

  Traceback (most recent call last):
    File "tools/perf/scripts/python/export-to-postgresql.py", line 465, in <module>
      do_query(query, 'CREATE VIEW calls_view AS '
    File "tools/perf/scripts/python/export-to-postgresql.py", line 274, in do_query
      raise Exception("Query failed: " + q.lastError().text())
  Exception: Query failed: ERROR:  invalid input syntax for integer: ""
  LINE 1: ...ch_count,call_id,return_id,CASE WHEN flags=0 THEN '' WHEN fl...
                                                               ^
  (22P02) QPSQL: Unable to create query
  Error running python script tools/perf/scripts/python/export-to-postgresql.py

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: f08046cb3082 ("perf thread-stack: Represent jmps to the start of a different symbol")
Link: https://lkml.kernel.org/n/tip-strfpdozrvg7bi1xzrivxzqt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 30130213da7e..6358522a69f6 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -478,7 +478,7 @@ if perf_db_export_calls:
 			'branch_count,'
 			'call_id,'
 			'return_id,'
-			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
+			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
 			'parent_call_path_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
