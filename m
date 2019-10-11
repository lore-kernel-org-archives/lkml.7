Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5653C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD88421835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824595;
	bh=wTCodaxuPM2M23dY6clu4WG4vzVyAKBhGzmMis+jdUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jvx1vgjcN/3h7EC8VKG3r1tdy5SyDTzi7CY0Kzzei+Mgf4pTQLbbCrfli7AfaMGZJ
	 T9xiLB11CK9FJvSUAQFCNqYm+lTdn/lPQIyGbbiOjLanz1PDFEKWTUzBAyrEtKz5dK
	 i85VQiy5tPAQnkF+eVFZ55lMKbYS6S4FIurPFXXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfJKUJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:53 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B380321D7E;
        Fri, 11 Oct 2019 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824591;
        bh=wTCodaxuPM2M23dY6clu4WG4vzVyAKBhGzmMis+jdUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tllPckVAgbhQ2K21/Qd/Y4TAU0Pwi4Nd7zMjHDaS+PZf3PXp58F88tI48GTOqL3RI
         /Xf8IvHGU8sLclJAtQcRmcJE5YDpLf9I6TiN03P1sStVKQysGnR2gfrQOyY4Z129SN
         08TDWnRndYAMFXQkOPwp0w5RN/Zt9T/CwLwNp1Jc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 38/69] perf trace: Expand strings in filters to integers
Date:   Fri, 11 Oct 2019 17:05:28 -0300
Message-Id: <20191011200559.7156-39-acme@kernel.org>
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
 tools/perf/builtin-trace.c | 130 +++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 50a1aeb997ae..515a800efc9c 100644
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
-- 
2.21.0

