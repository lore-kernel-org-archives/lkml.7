Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ACEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7176922B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576104502;
	bh=Cc9R1JknzDFhlW0u4z5RgFtaMEIgEx8xxtLecx3MIo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YlVyiTLMn9eZR5e3+DlfJ/WoguNCaS37Y8wD8R3WkNHqD4HiknSNOtDRk2Rquvs0N
	 KpZP9XU7yFQrSHmDjSGuHiQ16ZXbqC8Qg/BsoyQEXZcd6TNBUas+Nc89lx//jYYGS0
	 T/8XrhIRDynpVpkCLIsgXYdHahxooRplhRIiJsys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLKWsV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:48:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbfLKWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:48:20 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-TpcOdCAhPSuvz5ZfiRufqQ-1; Wed, 11 Dec 2019 17:48:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81DD91220;
        Wed, 11 Dec 2019 22:48:14 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F67060BF1;
        Wed, 11 Dec 2019 22:48:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH 3/3] perf stat: Add --metric option
Date:   Wed, 11 Dec 2019 23:48:00 +0100
Message-Id: <20191211224800.9066-4-jolsa@kernel.org>
In-Reply-To: <20191211224800.9066-1-jolsa@kernel.org>
References: <20191211224800.9066-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TpcOdCAhPSuvz5ZfiRufqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --metric option that allows to specify metric on the command
line, like:

  # perf stat  --metric 'DECODED_ICACHE_UOPS% = 100 * (idq.dsb_uops / \
    (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops))' ...

The syntax of the --metric option argument is:

  [name[/unit]=]expression

where:
  name - is string that will identify expression in results
          (can't have = or /) default is "user metric"
  unit - is conversion number that multiplies result

Examples:
  ipc = instructions / cycles
  ipc/1 = instructions / cycles
  instructions / cycles

Currently only one metric can be passed to perf stat command.
The code facilitates the current metric code.

Link: https://lkml.kernel.org/n/tip-oe1ke93t9x9uc1hy0iueksqq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt | 16 ++++++++++
 tools/perf/builtin-stat.c              | 21 +++++++++++++
 tools/perf/util/metricgroup.c          | 43 ++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h          |  2 ++
 4 files changed, 82 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9431b8066fb4..6a76faec91f1 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -264,6 +264,22 @@ For a group all metrics from the group are added.
 The events from the metrics are automatically measured.
 See perf list output for the possble metrics and metricgroups.
 
+--metric::
+Print metric specified by the argument, where argument is defined as:
+
+  [name[/unit]=]expression
+
+  where:
+    name - is string that will identify expression in results
+           (can't have = or /) default is "user metric"
+    unit - is conversion number that multiplies result
+           default is 1
+
+  Examples:
+      ipc = instructions / cycles
+      ipc/1 = instructions / cycles
+      instructions / cycles
+
 -A::
 --no-aggr::
 Do not aggregate counts across all monitored CPUs.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a098c2ebf4ea..206df6f1cc8a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -161,6 +161,7 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
+static char			*user_metric;
 
 struct perf_stat {
 	bool			 record;
@@ -841,6 +842,22 @@ static int parse_metric_groups(const struct option *opt,
 	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
+static int parse_metric_expr(const struct option *opt,
+			     const char *str,
+			     int unset __maybe_unused)
+{
+	if (user_metric) {
+		pr_err("Only one user metric is currently supported.\n");
+		return -EINVAL;
+	}
+
+	user_metric = strdup(str);
+	if (!user_metric)
+		return -ENOMEM;
+
+	return metricgroup__parse_expr(opt, user_metric, &stat_config.metric_events);
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -923,6 +940,9 @@ static struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_CALLBACK('m', "metric", &evsel_list, "metric expression",
+		     "monitor specified metric expression ([name/unit=]expression)",
+		     parse_metric_expr),
 	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
 			 "Configure all used events to run in kernel space.",
 			 PARSE_OPT_EXCLUSIVE),
@@ -2184,6 +2204,7 @@ int cmd_stat(int argc, const char **argv)
 	perf_evlist__free_stats(evsel_list);
 out:
 	zfree(&stat_config.walltime_run);
+	zfree(&user_metric);
 
 	if (smi_cost && smi_reset)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index abcfa3c1b4d5..c85be0ad8227 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -563,6 +563,49 @@ int metricgroup__parse_groups(const struct option *opt,
 	return ret;
 }
 
+int metricgroup__parse_expr(const struct option *opt, char *str,
+			    struct rblist *metric_events)
+{
+	struct evlist *perf_evlist = *(struct evlist **)opt->value;
+	char *tok, *expr, *unit = NULL;
+	struct strbuf extra_events;
+	LIST_HEAD(group_list);
+	const char *name;
+	int ret;
+
+	/*
+	 * user metric is passed as following argument:
+	 *   [name[/unit]=]expression
+	 */
+	tok = strchr(str, '=');
+	if (tok) {
+		*tok++ = 0;
+		name = str;
+		expr = tok;
+
+		tok = strchr(name, '/');
+		if (tok) {
+			*tok++ = 0;
+			unit = tok;
+		}
+	} else {
+		expr = str;
+		name = "user metric";
+	}
+
+	strbuf_init(&extra_events, 100);
+
+	ret = add_metric(name, expr, unit, &extra_events, &group_list);
+	if (ret)
+		return ret;
+
+	ret = metricgroup__setup(perf_evlist, metric_events, &extra_events,
+				 &group_list);
+	strbuf_release(&extra_events);
+	metricgroup__free_egroups(&group_list);
+	return ret;
+}
+
 bool metricgroup__has_metric(const char *metric)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 475c7f912864..b66546b3ce1c 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -30,6 +30,8 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 int metricgroup__parse_groups(const struct option *opt,
 			const char *str,
 			struct rblist *metric_events);
+int metricgroup__parse_expr(const struct option *opt, char *str,
+			    struct rblist *metric_events);
 
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
-- 
2.21.1

