Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C10C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524A21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PbrTASXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGCOH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:07:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36065 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGCOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:07:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E70bc3321088
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:07:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E70bc3321088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162821;
        bh=h30Hhr2WykBofjJ5RMGqhEeXePYe6eO+OK+G+uoIV/k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PbrTASXf9tnIF1UVcCdcmC4VfXz7Cj7sIQCGq0YTJ6JwRJ34aWYSVJm/H5eAvSTTy
         +sSrmNFJKdICNqcXXFA38TW+PZJMq/pA7hH/Ao+PexPRvqpMabkp+fDecu+URRF3GJ
         46tYHwnQ/ZlWQtBWM0UVISksLQ+506Hra1MG6U8FBjvtjII698T5WW+QHIj/Zj1xt1
         MiU13ZtBMKXQb36oaxyq0DKXZnLGExdUIkrzMWTDjk/NtPywidyIOTB5bCoES8IGKw
         JpIklXojtqE7t/5E/SzTkDmOYKnlLViOwepA+S4sR8KGyYbmIZ7+v9yCGkyw8PgOqd
         g3zrsu+wNUEiA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E6xG93321082;
        Wed, 3 Jul 2019 07:06:59 -0700
Date:   Wed, 3 Jul 2019 07:06:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b9322cab17a1092e2aa7ee2505ecceb0cd5fd685@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        jolsa@redhat.com
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
          jolsa@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190622093248.581-6-adrian.hunter@intel.com>
References: <20190622093248.581-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf db-export: Export synth events
Git-Commit-ID: b9322cab17a1092e2aa7ee2505ecceb0cd5fd685
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

Commit-ID:  b9322cab17a1092e2aa7ee2505ecceb0cd5fd685
Gitweb:     https://git.kernel.org/tip/b9322cab17a1092e2aa7ee2505ecceb0cd5fd685
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sat, 22 Jun 2019 12:32:46 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf db-export: Export synth events

Synthesized events are samples but with architecture-specific data
stored in sample->raw_data. They are identified by attribute type
PERF_TYPE_SYNTH.  Add a function to export them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 46 +++++++++++++++++++++-
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
