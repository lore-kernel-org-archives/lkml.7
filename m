Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B8ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F7221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824421;
	bh=apHZ9rudVgCTWRXQuc7jv0YuJ3otSuvlm+LIBNP/Ycw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bh4aRPlX8Qo6cSM2VVl5ci4/1mqE9nE9FEzM9rVvnJocEaEbSdWF0J7pBokhVrjb1
	 dDerCk42pbUhX2T+mTpodzRJBMZ3gKDPRVhfpgA0ItsalgzX5WP0T8DU9y1SXDg9v7
	 DE+OPz2/8N6ZVikzbfzFUNFHdWbDeLo68KNtpIWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfJKUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfJKUHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:07:00 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740F6222D1;
        Fri, 11 Oct 2019 20:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824419;
        bh=apHZ9rudVgCTWRXQuc7jv0YuJ3otSuvlm+LIBNP/Ycw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1cHA5B2E32VQEBZf+0zyFuKJtIl/pZY23rWdcHhDphBzFcbizgO4zCnVnJeVhdaG
         hHUN8asbqbJrRWbpnyBV5ZAvKl3suUWkxysDuVUk//bT52TGVWS5yeMkmtWEZDNQ6N
         Zp62kZ0AsWGEFGls0ajw91rqu2vVAZohe3YJR5Qw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 07/69] perf trace: Postpone parsing .perfconfig trace.add_events to after --verbose is processed
Date:   Fri, 11 Oct 2019 17:04:57 -0300
Message-Id: <20191011200559.7156-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we add events via the '[trace]' section in perfconfig the command
line options are not yet processed, so when something goes wrong with
parsing those events and using --verbose is advised, we end up not
getting any more verbosity by doing so.

So just copy the trace.add_events string for later processing, after we
processed --verbose and the other command line options.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-d6wbnz85ftqljdll6ynjyjd8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 313dfc1cefc5..3d54316639a4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -162,6 +162,7 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
+	char			*perfconfig_events;
 	struct {
 		struct ordered_events	data;
 		u64			last;
@@ -4044,15 +4045,11 @@ static int trace__config(const char *var, const char *value, void *arg)
 	int err = 0;
 
 	if (!strcmp(var, "trace.add_events")) {
-		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
-					       "event selector. use 'perf list' to list available events",
-					       parse_events_option);
-		/*
-		 * We can't propagate parse_event_option() return, as it is 1
-		 * for failure while perf_config() expects -1.
-		 */
-		if (parse_events_option(&o, value, 0))
-			err = -1;
+		trace->perfconfig_events = strdup(value);
+		if (trace->perfconfig_events == NULL) {
+			pr_err("Not enough memory for %s\n", "trace.add_events");
+			return -1;
+		}
 	} else if (!strcmp(var, "trace.show_timestamp")) {
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
@@ -4224,6 +4221,21 @@ int cmd_trace(int argc, const char **argv)
 
 	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
 				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	/*
+	 * Now that we have --verbose figured out, lets see if we need to parse
+	 * events from .perfconfig, so that if those events fail parsing, say some
+	 * BPF program fails, then we'll be able to use --verbose to see what went
+	 * wrong in more detail.
+	 */
+	if (trace.perfconfig_events != NULL) {
+		struct parse_events_error parse_err = { .idx = 0, };
+
+		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err);
+		if (err) {
+			parse_events_print_error(&parse_err, trace.perfconfig_events);
+			goto out;
+		}
+	}
 
 	if ((nr_cgroups || trace.cgroup) && !trace.opts.target.system_wide) {
 		usage_with_options_msg(trace_usage, trace_options,
@@ -4441,5 +4453,6 @@ int cmd_trace(int argc, const char **argv)
 	if (output_name != NULL)
 		fclose(trace.output);
 out:
+	zfree(&trace.perfconfig_events);
 	return err;
 }
-- 
2.21.0

