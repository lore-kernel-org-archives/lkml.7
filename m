Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025B8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D256E20B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfIVKwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:52:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55549 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfIVKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:52:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBzTc-0000v1-Sy; Sun, 22 Sep 2019 12:52:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5922C1C0DF0;
        Sun, 22 Sep 2019 12:52:24 +0200 (CEST)
Date:   Sun, 22 Sep 2019 10:52:24 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf probe: Fix to clear tev->nargs in
 clear_probe_trace_event()
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <156856587999.25775.5145779959474477595.stgit@devnote2>
References: <156856587999.25775.5145779959474477595.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <156914954430.24167.14701079319060500126.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9e6124d9d635957b56717f85219a88701617253f
Gitweb:        https://git.kernel.org/tip/9e6124d9d635957b56717f85219a88701617253f
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Mon, 16 Sep 2019 01:44:40 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 15:30:09 -03:00

perf probe: Fix to clear tev->nargs in clear_probe_trace_event()

Since add_probe_trace_event() can reuse tf->tevs[i] after calling
clear_probe_trace_event(), this can make perf-probe crash if the 1st
attempt of probe event finding fails to find an event argument, and the
2nd attempt fails to find probe point.

E.g.
  $ perf probe -D "task_pid_nr tsk"
  Failed to find 'tsk' in this function.
  Failed to get entry address of warn_bad_vsyscall
  Segmentation fault (core dumped)

Committer testing:

After the patch:

  $ perf probe -D "task_pid_nr tsk"
  Failed to find 'tsk' in this function.
  Failed to get entry address of warn_bad_vsyscall
  Failed to get entry address of signal_fault
  Failed to get entry address of show_signal
  Failed to get entry address of umip_printk
  Failed to get entry address of __bad_area_nosemaphore
  <SNIP>
  Failed to get entry address of sock_set_timeout
  Failed to get entry address of tcp_recvmsg
  Probe point 'task_pid_nr' not found.
    Error: Failed to add events.
  $

Fixes: 092b1f0b5f9f ("perf probe: Clear probe_trace_event when add_probe_trace_event() fails")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lore.kernel.org/lkml/156856587999.25775.5145779959474477595.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b8e0967..91cab5f 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2331,6 +2331,7 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
 		}
 	}
 	zfree(&tev->args);
+	tev->nargs = 0;
 }
 
 struct kprobe_blacklist_node {
