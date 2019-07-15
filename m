Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D1EC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED902171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225200;
	bh=vMxHkTu7SqiZCuDVCVcVHodwhNDfiIZ00hYVteqMzNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yO/gCf7c0iCFXkWnJt5UinNHHycjaIqgTLX7BnRGHpdUpfxVB4lnmTIQHfS6n5/uR
	 2UKKUo+ai4isKRZS/63xdzn8Cas1T3JeSWJma8Nl5UuC0Om6A/Li3q+tejGCerS1iM
	 V7qlP1+yYDJ66Vu9awyZ6seGdnmFo7a9nqx2VlJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfGOVNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfGOVNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:15 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F58B20449;
        Mon, 15 Jul 2019 21:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225194;
        bh=vMxHkTu7SqiZCuDVCVcVHodwhNDfiIZ00hYVteqMzNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jP4WNrLq7bjVjAXjZbJIjPwhOTWEs+VcskXGkofyXQAW6j+hYQRa8D6P7cF6SJeEO
         q882slfbOZzIDNWPxESxDwMXfMitVnaYWUc1DGULI1TZPmMi8UjY3uZ8qA//BzCcl0
         rp7mUvRJR5LADop/0hLsZdB2epHJEU+trVxBeVbs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/28] perf scripts python: export-to-sqlite.py: Export comm details
Date:   Mon, 15 Jul 2019 18:11:44 -0300
Message-Id: <20190715211200.10984-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add table columns for thread id, comm start time and exec flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 021326c46285..97aa66dd2fe1 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -177,7 +177,10 @@ do_query(query, 'CREATE TABLE threads ('
 		'tid		integer)')
 do_query(query, 'CREATE TABLE comms ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
-		'comm		varchar(16))')
+		'comm		varchar(16),'
+		'c_thread_id	bigint,'
+		'c_time		bigint,'
+		'exec_flag	boolean)')
 do_query(query, 'CREATE TABLE comm_threads ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
 		'comm_id	bigint,'
@@ -536,7 +539,7 @@ machine_query.prepare("INSERT INTO machines VALUES (?, ?, ?)")
 thread_query = QSqlQuery(db)
 thread_query.prepare("INSERT INTO threads VALUES (?, ?, ?, ?, ?)")
 comm_query = QSqlQuery(db)
-comm_query.prepare("INSERT INTO comms VALUES (?, ?)")
+comm_query.prepare("INSERT INTO comms VALUES (?, ?, ?, ?, ?)")
 comm_thread_query = QSqlQuery(db)
 comm_thread_query.prepare("INSERT INTO comm_threads VALUES (?, ?, ?)")
 dso_query = QSqlQuery(db)
@@ -576,7 +579,7 @@ def trace_begin():
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
 	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown")
+	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -642,7 +645,7 @@ def thread_table(*x):
 	bind_exec(thread_query, 5, x)
 
 def comm_table(*x):
-	bind_exec(comm_query, 2, x)
+	bind_exec(comm_query, 5, x)
 
 def comm_thread_table(*x):
 	bind_exec(comm_thread_query, 3, x)
-- 
2.21.0

