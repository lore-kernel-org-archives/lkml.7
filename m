Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D81C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C602087C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980733;
	bh=rXfbpaRe/Z3E9pMn/26sUPKzVlcrrtJN33m3FT+A5D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R81gRc9XeBpz2kCM+h9NeO2UhFN9ouZ26WzWX9evQbK/OjpZBeBOFTQZcADM1+jTr
	 AJC6LeomdF7bhdZfqpO56ouRRVvmpO0FgqJWKtGOIyXO4QnottaqyVIMxOW4zPX/TU
	 sPJUKE+CwXulv2J9/iOgE+Gt/Dw/CjqMVSt9wXk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCGRpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfCGRpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:31 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144E92087C;
        Thu,  7 Mar 2019 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980730;
        bh=rXfbpaRe/Z3E9pMn/26sUPKzVlcrrtJN33m3FT+A5D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK5klDD0Um/3xDXVPM29gom8VSnB1Eixqo8GC7T5HSFqVvLJjQFYrbTw0jHFscMbw
         pJXOPIu32tWcYRQP6AVMAcoOBqo+4+VFtxG83zXAuvOwLnQ9e2XJ1RlTC7zVOvGpuG
         o/l59O6/OZR+4IH/W0Oxqh4kFFwnzg43JceCkcm0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/35] perf scripts python: export-to-postgresql.py: Fix invalid input syntax for integer error
Date:   Thu,  7 Mar 2019 14:44:08 -0300
Message-Id: <20190307174433.28819-11-acme@kernel.org>
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
 
-- 
2.20.1

