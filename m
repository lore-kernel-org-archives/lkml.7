Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9FFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF6920679
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163274;
	bh=svKhCQSsoeFi0bRxgEojRjNJ5ptD81XE6rl8tPA5mm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jNTKIvBEXE2e6uaYC4vH3hTAKePSmTukyIzQ4MGZ7m2DCIsHo2yU2uwsn1haip9J5
	 1o2lRl9fLos/dYKy+98ANA1dZ5Lv3cvAFlIK3NS7Ioz5Tba5pVHerCJ3ruU9n9XbwT
	 e2wuihyx7gOPh3H3E/gH+3uttDHhSF0qIjCYfBrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfKSLec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbfKSLe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:34:26 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD5122310;
        Tue, 19 Nov 2019 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163265;
        bh=svKhCQSsoeFi0bRxgEojRjNJ5ptD81XE6rl8tPA5mm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAPhn9KsrXD3rhIwVLinh+EdFaGhc/nbXX8GDTLjnrafccySNKQIbVoQkLu4QyzGU
         navrtHDPevzUYEUWG/+Q/RQFOzaAhjcsBR8KWSwT6+Cg7b8jv2IUEN+7FvOySV2sGM
         qizpHb/Psy3pJS/YnEC3Hmt/ZPbVGl6ChOysXopQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 22/25] perf probe: Support multiprobe event
Date:   Tue, 19 Nov 2019 08:32:42 -0300
Message-Id: <20191119113245.19593-23-acme@kernel.org>
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

Support multiprobe event if the event is based on function and lines and
kernel supports it. In this case, perf probe creates the first probe
with an event, and tries to append following probes on that event, since
those probes must be on the same source code line.

Before this patch;

  # perf probe -a vfs_read:18
  Added new events:
    probe:vfs_read_L18   (on vfs_read:18)
    probe:vfs_read_L18_1 (on vfs_read:18)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_read_L18_1 -aR sleep 1

  #

After this patch (on multiprobe supported kernel)
  # perf probe -a vfs_read:18
  Added new events:
    probe:vfs_read_L18   (on vfs_read:18)
    probe:vfs_read_L18   (on vfs_read:18)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_read_L18 -aR sleep 1

  #

Committer testing:

On a kernel that doesn't support multiprobe events, after this patch:

  # uname -a
  Linux quaco 5.3.8-200.fc30.x86_64 #1 SMP Tue Oct 29 14:46:22 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # grep append /sys/kernel/debug/tracing/README
  	    be modified by appending '.descending' or '.ascending' to a
  	    can be modified by appending any of the following modifiers
  #
  # perf probe -a vfs_read:18
  Added new events:
    probe:vfs_read_L18   (on vfs_read:18)
    probe:vfs_read_L18_1 (on vfs_read:18)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_read_L18_1 -aR sleep 1

  # perf probe -l
    probe:vfs_read_L18   (on vfs_read:18@fs/read_write.c)
    probe:vfs_read_L18_1 (on vfs_read:18@fs/read_write.c)
  #

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406475010.24476.586290752591512351.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 9 +++++++--
 tools/perf/util/probe-file.c  | 7 +++++++
 tools/perf/util/probe-file.h  | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 5c86d2cf6338..8f963a193a5d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2738,8 +2738,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 	if (tev->event == NULL || tev->group == NULL)
 		return -ENOMEM;
 
-	/* Add added event name to namelist */
-	strlist__add(namelist, event);
+	/*
+	 * Add new event name to namelist if multiprobe event is NOT
+	 * supported, since we have to use new event name for following
+	 * probes in that case.
+	 */
+	if (!multiprobe_event_is_supported())
+		strlist__add(namelist, event);
 	return 0;
 }
 
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index b659466ea498..a63f1a19b0e8 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -1007,6 +1007,7 @@ enum ftrace_readme {
 	FTRACE_README_KRETPROBE_OFFSET,
 	FTRACE_README_UPROBE_REF_CTR,
 	FTRACE_README_USER_ACCESS,
+	FTRACE_README_MULTIPROBE_EVENT,
 	FTRACE_README_END,
 };
 
@@ -1020,6 +1021,7 @@ static struct {
 	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
 	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
 	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
+	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -1085,3 +1087,8 @@ bool user_access_is_supported(void)
 {
 	return scan_ftrace_readme(FTRACE_README_USER_ACCESS);
 }
+
+bool multiprobe_event_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_MULTIPROBE_EVENT);
+}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 986c1c94f64f..850d1b52d60a 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -71,6 +71,7 @@ bool probe_type_is_available(enum probe_type type);
 bool kretprobe_offset_is_supported(void);
 bool uprobe_ref_ctr_is_supported(void);
 bool user_access_is_supported(void);
+bool multiprobe_event_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
 {
-- 
2.21.0

