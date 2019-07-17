Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF2CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5267221019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="K32JixrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfGQW5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:57:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfGQW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:57:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMuvaX1722478
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:56:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMuvaX1722478
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404218;
        bh=a+v9Vn71CzHKXM1R1lsU1cnM9m2RZkCV2Q80GahzR+E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=K32JixrGTzHCX0hwNBNlNhNHK5ohP5l29wCTnue0MrUg+MxxhL8dextkHVPfg19mG
         JHvyouEL6DFzmFMg5IcJ2uQRG0CPm08HRjNS1zho7GWzlBAdvbMNw/32rUStAFFaTe
         R+qoPc41KETq+zj1kwpOhpoC+GvdahbzT6Fv8orKIIrz0R9J7ywhCywr1eVTy7W3+J
         kgCbgbII58P3I/yOqsoIYvpxqiD8GulH7j/ifpCkJP+1GzsqSVg7wc1L3Xr03QHNjJ
         Yikk6NNhZoCg1CQuyPITVdVlpDDLQScvdIH+NwEV48yLGDK2W1DVaprEHDjCP+SFDZ
         obChSCA8e3qSg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMuvXG1722475;
        Wed, 17 Jul 2019 15:56:57 -0700
Date:   Wed, 17 Jul 2019 15:56:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-41085f2bdd5882632e7dd88d1e5b59b7eac2a2a9@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
        mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, jolsa@redhat.com,
          tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190710085810.1650-10-adrian.hunter@intel.com>
References: <20190710085810.1650-10-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-sqlite.py: Export
 comm details
Git-Commit-ID: 41085f2bdd5882632e7dd88d1e5b59b7eac2a2a9
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

Commit-ID:  41085f2bdd5882632e7dd88d1e5b59b7eac2a2a9
Gitweb:     https://git.kernel.org/tip/41085f2bdd5882632e7dd88d1e5b59b7eac2a2a9
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:58 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:13:26 -0300

perf scripts python: export-to-sqlite.py: Export comm details

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
