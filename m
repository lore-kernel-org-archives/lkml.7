Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7460C218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N6Vmub2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfCOXJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:09:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43095 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfCOXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:09:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so7418783pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTrlfWpUID/PcAN97LCVFZfkJdnNGdhGx+PjqyTrmPo=;
        b=N6Vmub2nprj5DzzrBrPEHkvDie8vcslO8U3QWpZ96jmfDtgYTSwbgYhUKapz0gI0LS
         S3pcArzyExlA3jJMaqip3neNt1eH0iM6nx+kWdewVLTdg7X5Nqpt/HjzRNL3zQK5Gv9k
         rcKBVvArx3h8cIcP2NJFS5fzHde+IM3VoOTOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTrlfWpUID/PcAN97LCVFZfkJdnNGdhGx+PjqyTrmPo=;
        b=RayuvlqogcmST2Ti9/HSphBWxmqfCzrJNP0gUlJ0K+l1sM2DsGr1XnhCsWlMmyn+TB
         4275KExh4Zpg21s9fW4wJbMqIP7ZcAtj5lMNPgu7kVPs6d7qYzEHV+OomRCxb6wAnR0X
         pWFC0l3E3kKJMnkOv4+/dfeUaXDGKBCpdulRP7J4tRlRD5wsUnbLD/K0p2XvdP/lYlWt
         XmgdKLBmxlEgZ+BwoBDaB+D+kSI/RuJfIMxV3L7FeIrAkFSLqgt/OzumUwYzriu76OXe
         /vBe41MP/3r7X0zOl/vyvWWCXEems8yxuuQV8sRL2BrQltZBt4P3D9fNH6VzGILXXJbl
         XRzQ==
X-Gm-Message-State: APjAAAUEwZFCaQ9Y7JbIl2pz6f9bgOP2W7wXMG+LRBZTdX51xNtUcr7N
        YN5dBdEo/a8igRkbqGJ3J5tp0A==
X-Google-Smtp-Source: APXvYqzQc74ie5ylTcC2TQqVEolQk1kWKaKOSLpXTCyQbXD7LJ4BRS3zN6DZx4FSiOEg0LLk9icyoA==
X-Received: by 2002:a63:ef05:: with SMTP id u5mr5855153pgh.177.1552691378128;
        Fri, 15 Mar 2019 16:09:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q62sm8192428pfi.183.2019.03.15.16.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 16:09:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] tracing: kdb: The skip_lines parameter should have been skip_entries
Date:   Fri, 15 Mar 2019 16:09:04 -0700
Message-Id: <20190315230906.250598-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The things skipped by kdb's "ftdump" command when you pass it a
parameter has always been entries, not lines.  The difference usually
doesn't matter but when the trace buffer has multi-line entries (like
a stack dump) it can matter.

Let's fix this both in the help text for ftdump and also in the local
variable names.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- skip_lines => skip_entries new for v4.

Changes in v3: None

 kernel/trace/trace_kdb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 810d78a8d14c..4b666643d69f 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -17,7 +17,7 @@
 #include "trace.h"
 #include "trace_output.h"
 
-static void ftrace_dump_buf(int skip_lines, long cpu_file)
+static void ftrace_dump_buf(int skip_entries, long cpu_file)
 {
 	/* use static because iter can be a bit big for the stack */
 	static struct trace_iterator iter;
@@ -70,11 +70,11 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 			kdb_printf("---------------------------------\n");
 		cnt++;
 
-		if (!skip_lines) {
+		if (!skip_entries) {
 			print_trace_line(&iter);
 			trace_printk_seq(&iter.seq);
 		} else {
-			skip_lines--;
+			skip_entries--;
 		}
 
 		if (KDB_FLAG(CMD_INTERRUPT))
@@ -106,7 +106,7 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
  */
 static int kdb_ftdump(int argc, const char **argv)
 {
-	int skip_lines = 0;
+	int skip_entries = 0;
 	long cpu_file;
 	char *cp;
 
@@ -114,9 +114,9 @@ static int kdb_ftdump(int argc, const char **argv)
 		return KDB_ARGCOUNT;
 
 	if (argc) {
-		skip_lines = simple_strtol(argv[1], &cp, 0);
+		skip_entries = simple_strtol(argv[1], &cp, 0);
 		if (*cp)
-			skip_lines = 0;
+			skip_entries = 0;
 	}
 
 	if (argc == 2) {
@@ -129,7 +129,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	}
 
 	kdb_trap_printk++;
-	ftrace_dump_buf(skip_lines, cpu_file);
+	ftrace_dump_buf(skip_entries, cpu_file);
 	kdb_trap_printk--;
 
 	return 0;
@@ -137,7 +137,7 @@ static int kdb_ftdump(int argc, const char **argv)
 
 static __init int kdb_ftrace_register(void)
 {
-	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#lines] [cpu]",
+	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
 			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
 	return 0;
 }
-- 
2.21.0.360.g471c308f928-goog

