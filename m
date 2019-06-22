Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB9FC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A77F2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfFVJeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:34:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:26120 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfFVJeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:34:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 02:34:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="312233164"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2019 02:34:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] perf db-export: Export synth events
Date:   Sat, 22 Jun 2019 12:32:46 +0300
Message-Id: <20190622093248.581-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190622093248.581-1-adrian.hunter@intel.com>
References: <20190622093248.581-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesized events are samples but with architecture-specific data stored
in sample->raw_data. They are identified by attribute type PERF_TYPE_SYNTH.
Add a function to export them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripting-engines/trace-event-python.c    | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6acb379b53ec..112bed65232f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -112,6 +112,7 @@ struct tables {
 	PyObject		*sample_handler;
 	PyObject		*call_path_handler;
 	PyObject		*call_return_handler;
+	PyObject		*synth_handler;
 	bool			db_export_mode;
 };
 
@@ -947,6 +948,12 @@ static int tuple_set_string(PyObject *t, unsigned int pos, const char *s)
 	return PyTuple_SetItem(t, pos, _PyUnicode_FromString(s));
 }
 
+static int tuple_set_bytes(PyObject *t, unsigned int pos, void *bytes,
+			   unsigned int sz)
+{
+	return PyTuple_SetItem(t, pos, _PyBytes_FromStringAndSize(bytes, sz));
+}
+
 static int python_export_evsel(struct db_export *dbe, struct perf_evsel *evsel)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
@@ -1105,8 +1112,8 @@ static int python_export_branch_type(struct db_export *dbe, u32 branch_type,
 	return 0;
 }
 
-static int python_export_sample(struct db_export *dbe,
-				struct export_sample *es)
+static void python_export_sample_table(struct db_export *dbe,
+				       struct export_sample *es)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
@@ -1141,6 +1148,33 @@ static int python_export_sample(struct db_export *dbe,
 	call_object(tables->sample_handler, t, "sample_table");
 
 	Py_DECREF(t);
+}
+
+static void python_export_synth(struct db_export *dbe, struct export_sample *es)
+{
+	struct tables *tables = container_of(dbe, struct tables, dbe);
+	PyObject *t;
+
+	t = tuple_new(3);
+
+	tuple_set_u64(t, 0, es->db_id);
+	tuple_set_u64(t, 1, es->evsel->attr.config);
+	tuple_set_bytes(t, 2, es->sample->raw_data, es->sample->raw_size);
+
+	call_object(tables->synth_handler, t, "synth_data");
+
+	Py_DECREF(t);
+}
+
+static int python_export_sample(struct db_export *dbe,
+				struct export_sample *es)
+{
+	struct tables *tables = container_of(dbe, struct tables, dbe);
+
+	python_export_sample_table(dbe, es);
+
+	if (es->evsel->attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
+		python_export_synth(dbe, es);
 
 	return 0;
 }
@@ -1477,6 +1511,14 @@ static void set_table_handlers(struct tables *tables)
 	SET_TABLE_HANDLER(sample);
 	SET_TABLE_HANDLER(call_path);
 	SET_TABLE_HANDLER(call_return);
+
+	/*
+	 * Synthesized events are samples but with architecture-specific data
+	 * stored in sample->raw_data. They are exported via
+	 * python_export_sample() and consequently do not need a separate export
+	 * callback.
+	 */
+	tables->synth_handler = get_handler("synth_data");
 }
 
 #if PY_MAJOR_VERSION < 3
-- 
2.17.1

