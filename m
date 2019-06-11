Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB0C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2292184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279626;
	bh=+OF5zFOJa31EoZCk+UrWuoYFaekvddYLG6JDR6DgowM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rTthS1+PQBFXIHCEPVrxACxlTLBSM5KxC2Md2uNo/SUwK/CLEmnOtVxWpH2pJuT8P
	 vZCWKhlkO4FBmKCEuAdElRZXYZ7zaz2OxUn/8bvgIYM+4B1pFfxQgXQyt9modLp/Jh
	 UlGeMPQVM18Zehq/v1aehvH+Uiqlb9AeuI/y5Lwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407206AbfFKTAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405198AbfFKTAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708382184E;
        Tue, 11 Jun 2019 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279623;
        bh=+OF5zFOJa31EoZCk+UrWuoYFaekvddYLG6JDR6DgowM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PR5vKh9S7bj7giD4y7PVFjYKdPZlTYxgOvActmFuf2JZ/WxSWxD/JRBN70WxfXt5z
         ehnPJAc2Cc595vCiO+jCet7jY9WzZpvbyRvPg+mHViKRj2VV08rKdsE1295Pl9ryWx
         8W3CusHRUCM1C5jCeA05bh1UVQ5bD2Kd2QFW10Rc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/85] perf db-export: Export IPC information
Date:   Tue, 11 Jun 2019 15:58:04 -0300
Message-Id: <20190611185911.11645-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Export cycle and instruction counts on samples and call-returns.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 22f52b669871..6acb379b53ec 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1111,7 +1111,7 @@ static int python_export_sample(struct db_export *dbe,
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(22);
+	t = tuple_new(24);
 
 	tuple_set_u64(t, 0, es->db_id);
 	tuple_set_u64(t, 1, es->evsel->db_id);
@@ -1135,6 +1135,8 @@ static int python_export_sample(struct db_export *dbe,
 	tuple_set_s32(t, 19, es->sample->flags & PERF_BRANCH_MASK);
 	tuple_set_s32(t, 20, !!(es->sample->flags & PERF_IP_FLAG_IN_TX));
 	tuple_set_u64(t, 21, es->call_path_id);
+	tuple_set_u64(t, 22, es->sample->insn_cnt);
+	tuple_set_u64(t, 23, es->sample->cyc_cnt);
 
 	call_object(tables->sample_handler, t, "sample_table");
 
@@ -1173,7 +1175,7 @@ static int python_export_call_return(struct db_export *dbe,
 	u64 comm_db_id = cr->comm ? cr->comm->db_id : 0;
 	PyObject *t;
 
-	t = tuple_new(12);
+	t = tuple_new(14);
 
 	tuple_set_u64(t, 0, cr->db_id);
 	tuple_set_u64(t, 1, cr->thread->db_id);
@@ -1187,6 +1189,8 @@ static int python_export_call_return(struct db_export *dbe,
 	tuple_set_u64(t, 9, cr->cp->parent->db_id);
 	tuple_set_s32(t, 10, cr->flags);
 	tuple_set_u64(t, 11, cr->parent_db_id);
+	tuple_set_u64(t, 12, cr->insn_count);
+	tuple_set_u64(t, 13, cr->cyc_count);
 
 	call_object(tables->call_return_handler, t, "call_return_table");
 
-- 
2.20.1

