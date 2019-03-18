Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C420C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241D2213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTbOVAa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfCRUrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:47:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46192 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfCRUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:47:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so12057113pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHJl74N1/9tygGzDIZ7jPn/B28U84b17IZ7EyS5PPMw=;
        b=DTbOVAa4OHdmgadBgm6esTsB8fJ/r1WLIy4aji2L8BX65FiVqRfoiEjivwxV0dm6KJ
         9Pbg1r/Y/xVHmsJ6xrBzP6qRucNEPM71HQgU4KRJMARKO0eDe6lgJQRpVILz82eDaA+L
         nitrIcAAMLUc8b/r0avdb9L/48KS4JuiOCw+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHJl74N1/9tygGzDIZ7jPn/B28U84b17IZ7EyS5PPMw=;
        b=b3t8qcPOLVAVqqQJsHLyG3X6JtgSNk2K7bBx3XkYDwgLtgzszqCm1H2kzamFK5K0vH
         rYfi8Mas5OxbKk/90q3qMx0nk1Hmju4QyRI625zZCh6GoVPU3h4+0e+IuzpBSVWazdLq
         GF0GkAmi1UCvvu1gRoLvh9n3V6jRu6QEDnv3pazNKfrAPG3Mdxge+Memncop5LUfXFWw
         AEPMMjjR/eS28v7KzJmTUHRTlveOlS77ggHLkQKv1Fwi2YrjanEtJ0V8d6mt7bjINi/U
         OJHw3dg7rQhZctmutHjm9Xp54R0mHj8Hy6p+uk43NA7TzIZsmRHsmUghgRR46cCyGK6k
         qLeQ==
X-Gm-Message-State: APjAAAVLToxamDtiZnQgEmZ5CvC7pmO1Nko9H+NBK/Zow094ww7rU9bA
        IXeVfX/Q27pwdwXrgh+MEEvxOQ==
X-Google-Smtp-Source: APXvYqzYA5wmir4fL1hYHQoaKZq3BWeV5KTdb1a9VlZ5xaweYr39HzOIhHc+CnZ9RTuLJSrSGqm55g==
X-Received: by 2002:a63:6a08:: with SMTP id f8mr19596176pgc.165.1552942066677;
        Mon, 18 Mar 2019 13:47:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u14sm16835807pfm.66.2019.03.18.13.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 13:47:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] tracing: kdb: The skip_lines parameter should have been skip_entries
Date:   Mon, 18 Mar 2019 13:47:39 -0700
Message-Id: <20190318204741.116550-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
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
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v5:
- Add Daniel Thompson Ack.

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
2.21.0.225.g810b269d1ac-goog

