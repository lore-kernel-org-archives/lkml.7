Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6169F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X+c3x2nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfGQXAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:00:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGQXAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:00:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN0X1p1723272
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:00:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN0X1p1723272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404434;
        bh=6ib0mAtXsLzLBJSw+zgJNgjgoobzRfZnGenf5JDHOYc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X+c3x2nx+i8RpwwLozxP5/HiEyx6UBLGo4dNjrnsK+7cn1UnAJvFLVC75i0AUPBhn
         2tb7QE6qI1vwsBvCj7Myj4TK2W+K6fDxd6eRCM7nA/+H+TE3Qc3TIyf+q9G930fhLX
         avOwfw1/7X3Nb22gG4lwdfimOFImMW0QPWtbzSXIcLsmnQNiETqDn1NmvTwjZbXIsM
         sVEouH6WaWO3LDEaoJkxJSfX2Y9OxHfx4hMWhL3Hkr6esLg8soN50D61om9sZ4XlY9
         U8900i3KaULIxCtbg7YWO0RXs9ig0W/sLmdvG+SyIhieGIc1cYjy1jn3Q6LYpy9uo4
         W9C5a+teU8e0A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN0WNJ1723269;
        Wed, 17 Jul 2019 16:00:32 -0700
Date:   Wed, 17 Jul 2019 16:00:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-d9efc1d25214da500d6592095b542b32c15459df@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
        adrian.hunter@intel.com
Reply-To: jolsa@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20190710085810.1650-15-adrian.hunter@intel.com>
References: <20190710085810.1650-15-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-postgresql.py: Add
 has_calls column to comms table
Git-Commit-ID: d9efc1d25214da500d6592095b542b32c15459df
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

Commit-ID:  d9efc1d25214da500d6592095b542b32c15459df
Gitweb:     https://git.kernel.org/tip/d9efc1d25214da500d6592095b542b32c15459df
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:03 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:25:05 -0300

perf scripts python: export-to-postgresql.py: Add has_calls column to comms table

Now that a thread's current comm is exported, it shows up in the call graph
and call tree even if it has no calls. That can happen because the calls
are recorded against the main thread's initial comm.

Add a table column to make it easy for the exported-sql-viewer.py script to
select only comms with calls.

Committer testing:

  $ rm -f simple-retpoline.db
  $ sudo ~acme/bin/perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
  2019-07-10 12:25:33.200529 Creating database ...
  2019-07-10 12:25:33.211548 Writing records...
  2019-07-10 12:25:33.549630 Adding indexes
  2019-07-10 12:25:33.560715 Dropping unused tables
  2019-07-10 12:25:33.580201 Done
  $ sha256sum tools/perf/scripts/python/export-to-sqlite.py ~/libexec/perf-core/scripts/python/export-to-sqlite.py
  2922b642c392004dffa1d8789296478c85904623f5895bcb9b6cbf33e3ca999f  tools/perf/scripts/python/export-to-sqlite.py
  2922b642c392004dffa1d8789296478c85904623f5895bcb9b6cbf33e3ca999f  /home/acme/libexec/perf-core/scripts/python/export-to-sqlite.py
  $
  $ sqlite3 simple-retpoline.db
  SQLite version 3.26.0 2018-12-01 12:34:55
  Enter ".help" for usage hints.
  sqlite> .schema comms
  CREATE TABLE comms (id integer NOT NULL PRIMARY KEY,comm varchar(16),c_thread_id bigint,c_time bigint,exec_flag boolean, has_calls boolean);
  sqlite> select id,has_calls from comms;
  0|1
  1|1
  sqlite> select distinct comm_id from calls;
  0
  1
  sqlite>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 01f37877f5bb..13205e4e5b3b 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -886,6 +886,8 @@ def trace_end():
 					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
+		do_query(query, 'UPDATE comms SET has_calls = TRUE WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
 	do_query(query, 'ALTER TABLE ptwrite '
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
 	do_query(query, 'ALTER TABLE  cbr '
