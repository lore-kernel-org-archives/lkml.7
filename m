Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AECC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC7A222A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163276;
	bh=kZns9EiLbSSDlr484MfBmApBU06eR9ZZ4874rNRPAXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UEsGd8+weNOhX/KbJQTqeMuxbNYOtWKsHp98C9HpJnlm6XByjO/LYU/Yx/JwgCKzb
	 iKxF1T8nv26Vq0zfzNpx/of+FPCdQWyHgbi8ArwQe2kW9fZqFsBGiyGCXm2tSpQA3/
	 WV0Eh9rHdDGrYMaI5mY68R+BXWeHdvrrlJYA/Yq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfKSLee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfKSLe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:34:29 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737692230D;
        Tue, 19 Nov 2019 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163268;
        bh=kZns9EiLbSSDlr484MfBmApBU06eR9ZZ4874rNRPAXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8UUimy/OhOa0bU7CA1qBNhFgv3oS/0Mjc93RdTeN6JhS9/7rNnpuqYdjAoYT+MkN
         fSbW0Vtk/9CbIyyACcxqrT6NyC38N9VylUD52+Z18VX6qYWOGMKCOHnNtWtX5U+PeT
         +HXYPrYH0wlmxEFIowbYf7ub1lx09dVkPisB3beQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/25] perf probe: Support DW_AT_const_value constant value
Date:   Tue, 19 Nov 2019 08:32:43 -0300
Message-Id: <20191119113245.19593-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Support DW_AT_const_value for variable assignment instead of location.
Note that this requires ftrace supporting immediate value.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406476012.24476.16096289871757175775.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c   |  7 +++++++
 tools/perf/util/probe-file.h   |  1 +
 tools/perf/util/probe-finder.c | 11 +++++++++++
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
index f12ad507a822..33e90054ad84 100644
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
-- 
2.21.0

