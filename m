Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4390FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1872C2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfDLQiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:38:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:38:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3CGc76O1752892
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 09:38:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3CGc75s1752889;
        Fri, 12 Apr 2019 09:38:07 -0700
Date:   Fri, 12 Apr 2019 09:38:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-961df45e5de662e65fc6bc415fecc8caa8a3045c@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
        mingo@kernel.org, acme@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@redhat.com
In-Reply-To: <20190409062557.26138-1-adrian.hunter@intel.com>
References: <20190409062557.26138-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-sqlite.py: Fix use
 of parent_id in calls_view
Git-Commit-ID: 961df45e5de662e65fc6bc415fecc8caa8a3045c
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

Commit-ID:  961df45e5de662e65fc6bc415fecc8caa8a3045c
Gitweb:     https://git.kernel.org/tip/961df45e5de662e65fc6bc415fecc8caa8a3045c
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 9 Apr 2019 09:25:57 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Apr 2019 10:15:00 -0300

perf scripts python: export-to-sqlite.py: Fix use of parent_id in calls_view

Fix following error using calls_view:

 Query failed: ambiguous column name: parent_id Unable to execute statement

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: 8ce9a7251d11 ("perf scripts python: export-to-sqlite.py: Export calls parent_id")
Link: http://lkml.kernel.org/r/20190409062557.26138-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 3b71902a5a21..bf271fbc3a88 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -331,7 +331,7 @@ if perf_db_export_calls:
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
 			'parent_call_path_id,'
-			'parent_id'
+			'calls.parent_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
 do_query(query, 'CREATE VIEW samples_view AS '
