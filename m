Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074CBECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58AB21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfJOFdu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:33:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42225 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfJOFcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRM-0000VF-SF; Tue, 15 Oct 2019 07:32:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 768881C06DF;
        Tue, 15 Oct 2019 07:31:51 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Postpone parsing .perfconfig
 trace.add_events to after --verbose is processed
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-d6wbnz85ftqljdll6ynjyjd8@git.kernel.org>
References: <tip-d6wbnz85ftqljdll6ynjyjd8@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111751133.12254.14364169350677000203.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7e035929f3fec70d411fb660c434f4a7f8ca386d
Gitweb:        https://git.kernel.org/tip/7e035929f3fec70d411fb660c434f4a7f8ca386d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 01 Oct 2019 15:44:44 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf trace: Postpone parsing .perfconfig trace.add_events to after --verbose is processed

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
index 313dfc1..3d54316 100644
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
@@ -4441,5 +4453,6 @@ out_close:
 	if (output_name != NULL)
 		fclose(trace.output);
 out:
+	zfree(&trace.perfconfig_events);
 	return err;
 }
