Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392E0C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0552A21841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034419;
	bh=i5bAD8paIfaeRL1qrOjQWawLQ1rVavx01EbHgmKJq6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BqqfnhynavDIpDfYoJYt5KX27w14AvhlebVdLbZJMHzV7NRGxvaUkhUUtmVXFSC/6
	 2x33GpkZQi7PMwJKana1w2r1V8B88y2fFpNE6r/DQr6W65fXP2cLX2eIIBiY/7UGVf
	 iHwNWcHIUapEaNYa5eH0zbMF0zr5NIhHm7nlv2QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGBC06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfGBC0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3376D2184B;
        Tue,  2 Jul 2019 02:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034412;
        bh=i5bAD8paIfaeRL1qrOjQWawLQ1rVavx01EbHgmKJq6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=palQTjFYRdYUMldbst8+Pf+JMHzkbVYM4SbQEZlG+9DsOb7dSCyvK3Fy4e+8ImGF6
         dxvrplpps5hyThzAGxWZ4v+d6Nqr8JCpnVfdZIPH/Rpx5i9IpPI1ZOkH3trkq7BfcE
         Y1JlY2Qpa+YiIeKZLFOhb4nBLXFkswFxdf2qX850=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/43] perf db-export: Export synth events
Date:   Mon,  1 Jul 2019 23:25:42 -0300
Message-Id: <20190702022616.1259-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Synthesized events are samples but with architecture-specific data
stored in sample->raw_data. They are identified by attribute type
PERF_TYPE_SYNTH.  Add a function to export them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

