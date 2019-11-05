Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DCDCA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C8821882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572913045;
	bh=aa+lHiitl6Vs5l8bpw2fpH46b6u0fQ7ZvdPGLvO8nsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=voELlHRFpln19HOYpYHaGde6jhPfdfOOSitX1JBlG1MZ0Bfej52NlEGL/EFfmJUao
	 3fXZuGgKsNeXTXrjegbB3vvtVkGdKYtIk9Emr/WpUQheUHXoxsDXD6Rzvbpt544qUK
	 X9xDxzcgp2zaTlVlCDQGjqUd8syr41glRB3ywYFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfKEARY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbfKEARY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:17:24 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F7F214D9;
        Tue,  5 Nov 2019 00:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572913043;
        bh=aa+lHiitl6Vs5l8bpw2fpH46b6u0fQ7ZvdPGLvO8nsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7rosmHXDLrkipKWqVA+7ktVMUR+H/QMwCtVNJh6llhpPHC6YbzhP9RYJO4b3eBcz
         Dx5WbjSaWCw705CkVGg//+a0uSz70BbnuR2j9TIsLhYnJ9i3M8gYCkWdd1CUIipSqU
         6szg8p4C3j9L0gtLyJ2W/iHPM7JNaRm2dp/DjGjc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 4/5] perf probe: Support DW_AT_const_value constant value
Date:   Tue,  5 Nov 2019 09:17:19 +0900
Message-Id: <157291303888.19771.11876536314853955934.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157291299825.19771.5190465639558208592.stgit@devnote2>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support DW_AT_const_value for variable assignment instead of location.
Note that this requires ftrace supporting immediate value.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-file.c   |    7 +++++++
 tools/perf/util/probe-file.h   |    1 +
 tools/perf/util/probe-finder.c |   11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index a63f1a19b0e8..5003ba403345 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -1008,6 +1008,7 @@ enum ftrace_readme {
 	FTRACE_README_UPROBE_REF_CTR,
 	FTRACE_README_USER_ACCESS,
 	FTRACE_README_MULTIPROBE_EVENT,
+	FTRACE_README_IMMEDIATE_VALUE,
 	FTRACE_README_END,
 };
 
@@ -1022,6 +1023,7 @@ static struct {
 	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
 	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
 	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
+	DEFINE_TYPE(FTRACE_README_IMMEDIATE_VALUE, "*\\imm-value,*"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -1092,3 +1094,8 @@ bool multiprobe_event_is_supported(void)
 {
 	return scan_ftrace_readme(FTRACE_README_MULTIPROBE_EVENT);
 }
+
+bool immediate_value_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_IMMEDIATE_VALUE);
+}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 850d1b52d60a..0dba88c0f5f0 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -72,6 +72,7 @@ bool kretprobe_offset_is_supported(void);
 bool uprobe_ref_ctr_is_supported(void);
 bool user_access_is_supported(void);
 bool multiprobe_event_is_supported(void);
+bool immediate_value_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
 {
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 9ecea45da4ca..2e3a468c8350 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -177,6 +177,17 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	if (dwarf_attr(vr_die, DW_AT_external, &attr) != NULL)
 		goto static_var;
 
+	/* Constant value */
+	if (dwarf_attr(vr_die, DW_AT_const_value, &attr) &&
+	    immediate_value_is_supported()) {
+		Dwarf_Sword snum;
+
+		dwarf_formsdata(&attr, &snum);
+		ret = asprintf(&tvar->value, "\\%ld", (long)snum);
+
+		return ret < 0 ? -ENOMEM : 0;
+	}
+
 	/* TODO: handle more than 1 exprs */
 	if (dwarf_attr(vr_die, DW_AT_location, &attr) == NULL)
 		return -EINVAL;	/* Broken DIE ? */

