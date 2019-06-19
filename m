Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A53C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5E1218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956932;
	bh=j3MJSP4jENoyEXuW0b5eN/KBy8+NvrnljBgllrbjJHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CqYuGr/WqyLCi3FbTkRCqcROnOxZ9ZuZ+s03R10nLc54rCHU9D9Zi9gClA9czRkSL
	 N5sQC0Pjhg1CNh/sxnYp4HgXlE53bnSFPmrcfonQozkFgbHSWmYUuV+KAs8LdU1Cg5
	 GrJWY2rG3KvUULV5HOcYSOEQPsOGIeke+gQVW8ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfFSPIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:08:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E742189E;
        Wed, 19 Jun 2019 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956930;
        bh=j3MJSP4jENoyEXuW0b5eN/KBy8+NvrnljBgllrbjJHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcoGiiq8+LwoygmJD6prOLvS3KE79kMvKLcSStUwASqYxobySMVcTn+CPshYt1xyF
         U+Kw62myWJENjs0lTbnYL/chB2kqww4L+GeVVseNr9IGGACYclL8Ti5yz8d9ZLfSOz
         OwBieQfsU9RPojQYV/grw8tTekXaoNiprBfGAKrQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 10/12] selftests/ftrace: Add a testcase for kprobe multiprobe event
Date:   Thu, 20 Jun 2019 00:08:46 +0900
Message-Id: <156095692637.28024.17188971794698768977.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for kprobe event with multi-probe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |   35 ++++++++++++++++++++
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

