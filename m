Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA00C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235920665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225224;
	bh=h/TyKHX7M+gRyR1Pw+EDPUguFpZGjtArJen+VBVpPBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iUXjDkql3tkO/YLyQI9nNnKJm53R3EuhlyxO9sKvQqXqMABbFjtNjYYcLbB9O5w1c
	 TFbr6UrOqWStIx339qeJT0X55t7/IaKU8U2WCd5rq4TyEgqmZMGdmKGE79obdWe72T
	 0WNcQ78UemzRowLLELCKLvKQZH8hRgUWXf0tJCFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfGOVNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbfGOVNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:41 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0FC21721;
        Mon, 15 Jul 2019 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225220;
        bh=h/TyKHX7M+gRyR1Pw+EDPUguFpZGjtArJen+VBVpPBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fc/sh1ueA3PoF61P333+SwXNYChepEy59y4TVVdbG+R6FaBJtNAMW2eDwj0gxHeZO
         IZV4iw1seJ//04n2/Wd4dGMPsHK5xothZLRNJLeODAdx5EernWxgJ58QEBM1s6Y4KH
         dHCT14j0jHlebTDv8osAgzbZORARPQumIDrIZCEw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 17/28] perf scripts python: export-to-postgresql.py: Add has_calls column to comms table
Date:   Mon, 15 Jul 2019 18:11:49 -0300
Message-Id: <20190715211200.10984-18-acme@kernel.org>
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
-- 
2.21.0

