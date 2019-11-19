Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E3C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC75223D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfKSQ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfKSQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6o4-0007Jo-KI; Tue, 19 Nov 2019 17:56:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 428481C19CC;
        Tue, 19 Nov 2019 17:56:48 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:48 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Support multiprobe event
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157406475010.24476.586290752591512351.stgit@devnote2>
References: <157406475010.24476.586290752591512351.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157418260823.12247.17338863416227915427.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     72363540c009db5014252a1a15e149d30f88bcc3
Gitweb:        https://git.kernel.org/tip/72363540c009db5014252a1a15e149d30f88bcc3
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Mon, 18 Nov 2019 17:12:30 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 19:03:38 -03:00

perf probe: Support multiprobe event

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
 tools/perf/util/probe-event.c |  9 +++++++--
 tools/perf/util/probe-file.c  |  7 +++++++
 tools/perf/util/probe-file.h  |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 5c86d2c..8f963a1 100644
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
index b659466..a63f1a1 100644
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
index 986c1c9..850d1b5 100644
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
