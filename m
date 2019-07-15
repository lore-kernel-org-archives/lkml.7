Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3408C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765AE21721
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225179;
	bh=xQ17dzcn8z3NVFJMUJH+h00uR7WizII0rtS9Svk49kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JoJMz92X1+F8YlTsPXxSTpCAmDZdgM79qLNKcHmn329skDVWSktZzUhNSv1RwCS23
	 Msqebaw9I4ROatGUq0GJJrMiEq3r3U5RQeuXbU5zazE8Vqq42Sk+mzdndSi70fKVEd
	 Qfll0IinRHYvegQm7EJ9viJBIrwT2MlU1/roHSOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbfGOVM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfGOVM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:57 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3A22171F;
        Mon, 15 Jul 2019 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225176;
        bh=xQ17dzcn8z3NVFJMUJH+h00uR7WizII0rtS9Svk49kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDmP5DQIn/ItPsaQK+WYW00LqVcEhw0xBAAOMenbnRQMTulEDIZn49ecNcEYB/kPL
         uftw/4JKLMNDuI/0NEpA12HZ07t2QAJR7oXIBNsdBKD+yraTZEeERmnbJYi+L4nUaT
         InQtbs5tMs9t0QUb4lmG+kQrKqfBbTyuNeXkj1Sc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/28] perf db-export: Export comm before exporting thread
Date:   Mon, 15 Jul 2019 18:11:40 -0300
Message-Id: <20190715211200.10984-9-acme@kernel.org>
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

Export comm before exporting the non-main thread because
db_export__thread() also exports the comm_thread.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 63f9edf65eee..99ad759561de 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -312,6 +312,12 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 					main_thread);
 		if (err)
 			goto out_put;
+		if (comm) {
+			err = db_export__exec_comm(dbe, comm, main_thread);
+			if (err)
+				goto out_put;
+			es.comm_db_id = comm->db_id;
+		}
 	}
 
 	if (thread != main_thread) {
@@ -321,13 +327,6 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 			goto out_put;
 	}
 
-	if (comm) {
-		err = db_export__exec_comm(dbe, comm, main_thread);
-		if (err)
-			goto out_put;
-		es.comm_db_id = comm->db_id;
-	}
-
 	es.db_id = ++dbe->sample_last_db_id;
 
 	err = db_ids_from_al(dbe, al, &es.dso_db_id, &es.sym_db_id, &es.offset);
-- 
2.21.0

