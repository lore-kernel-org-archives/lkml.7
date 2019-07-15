Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C875EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A071320693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225218;
	bh=4rkAXhuHH4Dez79qh8tQwbMAfyaPWdnXBeZswSQzr7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LQxhhvZAARnaoNw9HK2jRE+V54tNdMqbHxkHA+1DWc6VmPoP0yoM/nlLFiP7DbSKo
	 QFKWG66EfnDGXj5OGG45v7mqZVMB6HtLYcfHxIOqnWFDOlmYwuC18F4yproN1/nmGi
	 arBKMrSpIhmkGmWnzpJwitViDeidtUJTyeK8zJ0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbfGOVNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbfGOVNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:37 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27BFD20665;
        Mon, 15 Jul 2019 21:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225216;
        bh=4rkAXhuHH4Dez79qh8tQwbMAfyaPWdnXBeZswSQzr7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMy0pYf2XegkGwYE4sLT9qKK5M9UNKnqSQAjL0yC2rRp+eh+C4UZSua6swpbdpAw0
         fmE2REoQLWPclEuZ8yyecA5CcumWOSWG+fN+j8jXsSog0bFVpzY2ElXJ3CeDHhZ4iG
         wi9srGN/nmrB9jgFwRsIWPx4fQ0vN4DI/sxpwAoQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 16/28] perf scripts python: export-to-sqlite.py: Add has_calls column to comms table
Date:   Mon, 15 Jul 2019 18:11:48 -0300
Message-Id: <20190715211200.10984-17-acme@kernel.org>
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

Now that a thread's current comm is exported, it shows up in the call
graph and call tree even if it has no calls. That can happen because the
calls are recorded against the main thread's initial comm.

Add a table column to make it easy for the exported-sql-viewer.py script
to select only comms with calls.

Committer notes:

Running the export-to-sqlite.py worked without warnings and using the
exported-sql-viewer.py worked as before.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 97aa66dd2fe1..9156f6a1e5f0 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -606,6 +606,8 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
+		do_query(query, 'UPDATE comms SET has_calls = 1 WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
 
 	printdate("Dropping unused tables")
 	if is_table_empty("ptwrite"):
-- 
2.21.0

