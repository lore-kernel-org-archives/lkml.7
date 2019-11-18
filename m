Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01EAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937832084C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064759;
	bh=FqcDv1sjY05veUgpDJnfxuCQBeNLAI8X0PRJC2Y59xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Ss1Hk+rTwR9JF+fB+aqbjdjB+35i6n834tn9fmD7EfV0XoEK2Hc2eJHIs4JHWHVo
	 L4nl9wHYxpl4kZpJ65+KRxvLW+48sTk/SZ0gzA/ip9li7pQWWBi7/SrPTm+Zl/3NvS
	 XL06Xn5YNtXukmJRKQgtR01H9VZe7xhqqXzUINzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKRIMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:12:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKRIMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:12:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D464920740;
        Mon, 18 Nov 2019 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574064754;
        bh=FqcDv1sjY05veUgpDJnfxuCQBeNLAI8X0PRJC2Y59xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFovBanfu4CUeJMdb3jmO3DRCwJ7P4pT/yHJc0sQ0B14p3Nlxy5fevJMMRXd0PrTl
         amkBr6J1Q4Rf/ckYsKWFFnsZOAgOFsMpCDJxOJh0XI3JIrZKVlJfY1hiZyhya+CZGe
         Be2wnq5yalgGwUUiTa5BOwWDjtK+vlaeWVy9cq9M=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 5/7] perf probe: Support multiprobe event
Date:   Mon, 18 Nov 2019 17:12:30 +0900
Message-Id: <157406475010.24476.586290752591512351.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157406469983.24476.13195800716161845227.stgit@devnote2>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
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

