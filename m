Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03F32082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390736AbfIEPor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390525AbfIEPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C13218AE;
        Thu,  5 Sep 2019 15:43:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvB-0007Yx-WE; Thu, 05 Sep 2019 11:43:42 -0400
Message-Id: <20190905154341.880663956@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 14/25] selftests/ftrace: Add a testcase for kprobe multiprobe event
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a testcase for kprobe event with multi-probe.

Link: http://lkml.kernel.org/r/156095692637.28024.17188971794698768977.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
new file mode 100644
index 000000000000..44494bac86d1
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Create/delete multiprobe on kprobe event
+
+[ -f kprobe_events ] || exit_unsupported
+
+grep -q "Create/append/" README || exit_unsupported
+
+# Choose 2 symbols for target
+SYM1=_do_fork
+SYM2=do_exit
+EVENT_NAME=kprobes/testevent
+
+DEF1="p:$EVENT_NAME $SYM1"
+DEF2="p:$EVENT_NAME $SYM2"
+
+:;: "Define an event which has 2 probes" ;:
+echo $DEF1 >> kprobe_events
+echo $DEF2 >> kprobe_events
+cat kprobe_events | grep "$DEF1"
+cat kprobe_events | grep "$DEF2"
+
+:;: "Remove the event by name (should remove both)" ;:
+echo "-:$EVENT_NAME" >> kprobe_events
+test `cat kprobe_events | wc -l` -eq 0
+
+:;: "Remove just 1 event" ;:
+echo $DEF1 >> kprobe_events
+echo $DEF2 >> kprobe_events
+echo "-:$EVENT_NAME $SYM1" >> kprobe_events
+! cat kprobe_events | grep "$DEF1"
+cat kprobe_events | grep "$DEF2"
+
+:;: "Appending different type must fail" ;:
+! echo "$DEF1 \$stack" >> kprobe_events
-- 
2.20.1


