Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA97C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC2A218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555079020;
	bh=zXcHCxeg8l0aai5YuHU8um+TigJOZ6n8cHI83Ae8QW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3wsCpGPx2z+OBLHVgmYZ99HpPlQifq2sKf5a6iqBkrop03L/KQRbswvPwgRtYQE1
	 ccTgTtNI+4jv+fVpi5nY4lWkIY6SisF5eyRHUWTI1h1/84TrnUCY9v9y6OSUWaTmBq
	 rNMDEUILuXnPoFlm/st67ynPuUBYrC6ky68n70xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfDLOXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfDLOXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:23:38 -0400
Received: from quaco.ghostprotocols.net (177-58-174-75.3g.claro.net.br [177.58.174.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6A42186A;
        Fri, 12 Apr 2019 14:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555079017;
        bh=zXcHCxeg8l0aai5YuHU8um+TigJOZ6n8cHI83Ae8QW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGotGBoTOp9u1NFz9+xFgL70LGmCw2ccQse8vgjAvjLIo9AL42Jhy6M3sT5By9HgC
         nu3EfmPOSVtMevl1wEPz4Uwqt1Py6AKBy+ZPgbF/KDtTWIQiuoFkw1VDHBQvYqTlyt
         q6aLXJ7so5xU2Z22rOWoWhw5UlIx7+tkoZoD1uZo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/7] perf scripts python: export-to-sqlite.py: Fix use of parent_id in calls_view
Date:   Fri, 12 Apr 2019 11:22:47 -0300
Message-Id: <20190412142250.20595-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.20.1

