Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC692CA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7031521882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572913037;
	bh=du5wPW8mDNBCWJJtGIhJS2OiVj0j0zl/aWOKZmpNVEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qPFimy2LPK2919hVtySHFTNrd3ZaUTE/rqQXnaCOvwYwm8Tw3/TI36L9O88E3I+/S
	 BjYAWGObLZCc9/GtV82ct0KA4VIvZrh3woIhxYH77pkI86ehme5YT09JOQHhjSAQfk
	 MJjlMdOl53HCOoE5tJ0wHdNlYmOxVN+6lzopyPSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfKEARQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbfKEARO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:17:14 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9343E20717;
        Tue,  5 Nov 2019 00:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572913033;
        bh=du5wPW8mDNBCWJJtGIhJS2OiVj0j0zl/aWOKZmpNVEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs7YAZBYOfjGhbpt/3yG2dUFEUkbt72Yynuw9e646+XGMvomA5GQCePoKRRZX3FsF
         xrCVxkW1/UZyvrsHwd1aHFJgDOrbPaLj+LjgOjfVshw9EMxqLXIloCDEpdUZl6cZ4i
         Z4+9hU+0yQ5yE/sty0RxbdKRE0dcbSpkGNHfo+hs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 3/5] perf probe: Support multiprobe event
Date:   Tue,  5 Nov 2019 09:17:09 +0900
Message-Id: <157291302895.19771.12251353345858434064.stgit@devnote2>
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

Support multiprobe event if the event is based on function
and lines and kernel supports it. In this case, perf probe
creates the first probe with an event, and tries to append
following probes on that event, since those probes must be
on the same source code line.

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    9 +++++++--
 tools/perf/util/probe-file.c  |    7 +++++++
 tools/perf/util/probe-file.h  |    1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index d14b970a6461..23db6786c3ea 100644
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

