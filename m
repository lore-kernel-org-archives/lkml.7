Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C2DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F272420645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbfETLiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:38:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733157AbfETLiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:38:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:38:04 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:38:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/22] perf db-export: Export IPC information
Date:   Mon, 20 May 2019 14:37:21 +0300
Message-Id: <20190520113728.14389-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export cycle and instruction counts on samples and call-returns.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.17.1

