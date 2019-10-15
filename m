Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B963C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F0421848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfJOFfz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:35:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbfJOFcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR2-0000E0-Jv; Tue, 15 Oct 2019 07:31:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CEE221C04A9;
        Tue, 15 Oct 2019 07:31:42 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:42 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Expand strings in filters to integers
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-dx5j70fv2rgkeezd1cb3hv2p@git.kernel.org>
References: <tip-dx5j70fv2rgkeezd1cb3hv2p@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750273.12254.3506068585260421140.tip-bot2@tip-bot2>
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

Commit-ID:     90df0249c2eae21f329760ee857575260926188a
Gitweb:        https://git.kernel.org/tip/90df0249c2eae21f329760ee857575260926188a
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 09 Oct 2019 16:22:16 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 16:22:16 -03:00

perf trace: Expand strings in filters to integers

So that one can try things like:

  # perf trace -e msr:* --filter="msr!=FS_BASE && msr != IA32_TSC_DEADLINE && msr != 0x830 && msr != 0x83f && msr !=IA32_SPEC_CTRL" --filter-pids 3750

That, at this point in the patchset, without any strtoul in place for
tracepoint arguments, will result in:

  No resolver (strtoul) for "msr" in "msr:read_msr", can't set filter "(msr!=FS_BASE && msr != IA32_TSC_DEADLINE && msr != 0x830 && msr != 0x83f && msr !=IA32_SPEC_CTRL) && (common_pid != 25407 && common_pid != 3750)"
  #

See you in the next cset!

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dx5j70fv2rgkeezd1cb3hv2p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 130 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 50a1aeb..515a800 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3484,6 +3484,133 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 	return __trace__deliver_event(trace, event->event);
 }
 
+static struct syscall_arg_fmt *perf_evsel__syscall_arg_fmt(struct evsel *evsel, char *arg)
+{
+	struct tep_format_field *field;
+	struct syscall_arg_fmt *fmt = evsel->priv;
+
+	if (evsel->tp_format == NULL || fmt == NULL)
+		return NULL;
+
+	for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
+		if (strcmp(field->name, arg) == 0)
+			return fmt;
+
+	return NULL;
+}
+
+static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel *evsel)
+{
+	char *tok, *left = evsel->filter, *new_filter = evsel->filter;
+
+	while ((tok = strpbrk(left, "=<>!")) != NULL) {
+		char *right = tok + 1, *right_end;
+
+		if (*right == '=')
+			++right;
+
+		while (isspace(*right))
+			++right;
+
+		if (*right == '\0')
+			break;
+
+		while (!isalpha(*left))
+			if (++left == tok) {
+				/*
+				 * Bail out, can't find the name of the argument that is being
+				 * used in the filter, let it try to set this filter, will fail later.
+				 */
+				return 0;
+			}
+
+		right_end = right + 1;
+		while (isalnum(*right_end) || *right_end == '_')
+			++right_end;
+
+		if (isalpha(*right)) {
+			struct syscall_arg_fmt *fmt;
+			int left_size = tok - left,
+			    right_size = right_end - right;
+			char arg[128];
+
+			while (isspace(left[left_size - 1]))
+				--left_size;
+
+			scnprintf(arg, sizeof(arg), "%.*s", left_size, left);
+
+			fmt = perf_evsel__syscall_arg_fmt(evsel, arg);
+			if (fmt == NULL) {
+				pr_debug("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
+					 arg, evsel->name, evsel->filter);
+				return -1;
+			}
+
+			pr_debug2("trying to expand \"%s\" \"%.*s\" \"%.*s\" -> ",
+				 arg, (int)(right - tok), tok, right_size, right);
+
+			if (fmt->strtoul) {
+				u64 val;
+				if (fmt->strtoul(right, right_size, NULL, &val)) {
+					char *n, expansion[19];
+					int expansion_lenght = scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
+					int expansion_offset = right - new_filter;
+
+					pr_debug("%s", expansion);
+
+					if (asprintf(&n, "%.*s%s%s", expansion_offset, new_filter, expansion, right_end) < 0) {
+						pr_debug(" out of memory!\n");
+						free(new_filter);
+						return -1;
+					}
+					if (new_filter != evsel->filter)
+						free(new_filter);
+					left = n + expansion_offset + expansion_lenght;
+					new_filter = n;
+				} else {
+					pr_err("\"%.*s\" not found for \"%s\" in \"%s\", can't set filter \"%s\"\n",
+					       right_size, right, arg, evsel->name, evsel->filter);
+					return -1;
+				}
+			} else {
+				pr_err("No resolver (strtoul) for \"%s\" in \"%s\", can't set filter \"%s\"\n",
+				       arg, evsel->name, evsel->filter);
+				return -1;
+			}
+
+			pr_debug("\n");
+		} else {
+			left = right_end;
+		}
+	}
+
+	if (new_filter != evsel->filter) {
+		pr_debug("New filter for %s: %s\n", evsel->name, new_filter);
+		perf_evsel__set_filter(evsel, new_filter);
+		free(new_filter);
+	}
+
+	return 0;
+}
+
+static int trace__expand_filters(struct trace *trace, struct evsel **err_evsel)
+{
+	struct evlist *evlist = trace->evlist;
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->filter == NULL)
+			continue;
+
+		if (trace__expand_filter(trace, evsel)) {
+			*err_evsel = evsel;
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct evlist *evlist = trace->evlist;
@@ -3625,6 +3752,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 */
 	trace->fd_path_disabled = !trace__syscall_enabled(trace, syscalltbl__id(trace->sctbl, "close"));
 
+	err = trace__expand_filters(trace, &evsel);
+	if (err)
+		goto out_delete_evlist;
 	err = perf_evlist__apply_filters(evlist, &evsel);
 	if (err < 0)
 		goto out_error_apply_filters;
