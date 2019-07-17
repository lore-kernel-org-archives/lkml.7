Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C55C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA2821019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xLrzDNVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfGQW5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:57:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55399 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:57:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMvenm1722799
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:57:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMvenm1722799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404261;
        bh=BcDdJypNcJxSeuA7BeTnxAOT2pej9UfLDAJpv3AbcvY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xLrzDNVQGaCPFLnTI3XYPDVd525xpH1flzn/cjy1zCGxckrUg7F0DeY0E0DmSYNFi
         +QvpRUF3NKJEKuwGO6cvkA/0yY9YprDfKL84eNmIiyEh/nkvOsXPV59rg+Zt4C3ySG
         HdSDcEwhjeXkuEZjYITsjHt2BgCBtB6HZdDLPu5UKo5h7m+2QxwaGYJMWs41ktAqTc
         Ku/F1VxXY6MBichB19eCoN6zaQKqhuEJLbtpakwOm7NnDexTmUGXfBuL+4Wl7M15S+
         8Mad3oYmdzOxKtacuN5Am0Jvimq1X67w98c5wdRyNs1gSAvyAnFNt6S5BcGKNsJ36b
         i6Xc+eku373sA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMvdf41722796;
        Wed, 17 Jul 2019 15:57:39 -0700
Date:   Wed, 17 Jul 2019 15:57:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-8534b5de81802a82b13fe05acc3e749e3baf980e@git.kernel.org>
Cc:     jolsa@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          hpa@zytor.com, jolsa@redhat.com, adrian.hunter@intel.com,
          tglx@linutronix.de
In-Reply-To: <20190710085810.1650-11-adrian.hunter@intel.com>
References: <20190710085810.1650-11-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-postgresql.py:
 Export comm details
Git-Commit-ID: 8534b5de81802a82b13fe05acc3e749e3baf980e
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

Commit-ID:  8534b5de81802a82b13fe05acc3e749e3baf980e
Gitweb:     https://git.kernel.org/tip/8534b5de81802a82b13fe05acc3e749e3baf980e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:59 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:13:36 -0300

perf scripts python: export-to-postgresql.py: Export comm details

Add table columns for thread id, comm start time and exec flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 92713d93e956..01f37877f5bb 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -353,7 +353,10 @@ do_query(query, 'CREATE TABLE threads ('
 		'tid		integer)')
 do_query(query, 'CREATE TABLE comms ('
 		'id		bigint		NOT NULL,'
-		'comm		varchar(16))')
+		'comm		varchar(16),'
+		'c_thread_id	bigint,'
+		'c_time		bigint,'
+		'exec_flag	boolean)')
 do_query(query, 'CREATE TABLE comm_threads ('
 		'id		bigint		NOT NULL,'
 		'comm_id	bigint,'
@@ -763,7 +766,7 @@ def trace_begin():
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
 	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown")
+	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -851,6 +854,8 @@ def trace_end():
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
+	do_query(query, 'ALTER TABLE comms '
+					'ADD CONSTRAINT threadfk   FOREIGN KEY (c_thread_id)  REFERENCES threads    (id)')
 	do_query(query, 'ALTER TABLE comm_threads '
 					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comms      (id),'
 					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES threads    (id)')
@@ -935,11 +940,11 @@ def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
 	value = struct.pack("!hiqiqiqiiii", 5, 8, thread_id, 8, machine_id, 8, process_id, 4, pid, 4, tid)
 	thread_file.write(value)
 
-def comm_table(comm_id, comm_str, *x):
+def comm_table(comm_id, comm_str, thread_id, time, exec_flag, *x):
 	comm_str = toserverstr(comm_str)
 	n = len(comm_str)
-	fmt = "!hiqi" + str(n) + "s"
-	value = struct.pack(fmt, 2, 8, comm_id, n, comm_str)
+	fmt = "!hiqi" + str(n) + "s" + "iqiqiB"
+	value = struct.pack(fmt, 5, 8, comm_id, n, comm_str, 8, thread_id, 8, time, 1, exec_flag)
 	comm_file.write(value)
 
 def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
