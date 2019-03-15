Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB27C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F922218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d6EF/xAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCORpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:45:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41051 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfCORpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:45:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so6945135pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8N0lNRE/vp6+wBnPYESHVIwiQW+s55dvM92A6syMPX4=;
        b=d6EF/xAbD+Gj7CEyabx2uRhWsP/cl+vLCyNeLkAQRzWsBdOrN6zo1kYRF/ozbGP3Ng
         XBn1Hzxqbk9nxYHAHvoM2t2PsJOJ68xWOeuAvkgXo3VPZPPTwYrRxDfCRxSl58daI93y
         sx9Cudl8l5fkX1kfuVKxkdkjf2lDurc21AteU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8N0lNRE/vp6+wBnPYESHVIwiQW+s55dvM92A6syMPX4=;
        b=m44A+LQ+GK3/jmUbLkpOsznPJwe5kuwRfA+QvlY8P6P87D5oyuGh2h9RrQDu3LjIme
         apkQTs3N33Zop4h2HQwxvtcxO0PkO9QcIaEdhD9EcUt/I1TMWo+ndQE1buP5tW0tSedB
         s+o6kOfLxc2LCvzK/1PZCOUFsCC6bQ55VQx3JZF84GXJBHysFrZTXqeNbxfIKrdtUw22
         DnU5X7AsWsq8XT0O6Fh/SIhyimQLrHLXG2S1g4+MnoMt5OYAcNZ4KhJPaEwrIwD4Mj5q
         EVweJP7IkSZquHPVe0dksme3A1Yeh+SJ8lQfxWw7kgwBFcfCwyBGGWZtVLU2HeX1abVS
         HIzQ==
X-Gm-Message-State: APjAAAXtRkoIFz97wu0ZvA0moHpcAQaTEA/M/HGEw3G3Dt/BC5fXvX1o
        W0VIFmkC+f+ShrvABUOE7mdhKg==
X-Google-Smtp-Source: APXvYqxGh05CaD0PgytsF9CTwVrX5A1ze1bIljdbk8gjRT6hanpbuFhKhxvJs2dH5WISHjYgZ6iUMw==
X-Received: by 2002:a62:4214:: with SMTP id p20mr5409552pfa.204.1552671952099;
        Fri, 15 Mar 2019 10:45:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h23sm3222761pfn.68.2019.03.15.10.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 10:45:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] tracing: kdb: Allow ftdump to skip all but the last few lines
Date:   Fri, 15 Mar 2019 10:45:28 -0700
Message-Id: <20190315174528.16531-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ftdump' command in kdb is currently a bit of a last resort, at
least if you have lots of traces turned on.  It's going to print a
whole boatload of lines out your serial port which is probably running
at 115200.  This could easily take many, many minutes.

Usually you're most interested in what's at the _end_ of the ftrace
buffer, AKA what happened most recently.  That means you've got to
wait the full time for the dump.  The 'ftdump' command does attempt to
help you a little bit by allowing you to skip a fixed number of lines.
Unfortunately it provides no way for you to know how many lines you
should skip.

Let's do similar to python and allow you to use a negative number to
indicate that you want to skip all lines except the last few.  This
allows you to quickly see what you want.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Optimize counting as per Steven Rostedt.
- Down to 1 patch since patch #1 from v2 landed.

 kernel/trace/trace_kdb.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 810d78a8d14c..cc6ca6c0d6de 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -17,7 +17,7 @@
 #include "trace.h"
 #include "trace_output.h"
 
-static void ftrace_dump_buf(int skip_lines, long cpu_file)
+static int ftrace_dump_buf(int skip_lines, long cpu_file, bool quiet)
 {
 	/* use static because iter can be a bit big for the stack */
 	static struct trace_iterator iter;
@@ -39,8 +39,6 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 	/* don't look at user memory in panic mode */
 	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
 
-	kdb_printf("Dumping ftrace buffer:\n");
-
 	/* reset all but tr, trace, and overruns */
 	memset(&iter.seq, 0,
 		   sizeof(struct trace_iterator) -
@@ -55,6 +53,9 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 						 cpu, GFP_ATOMIC);
 			ring_buffer_read_start(iter.buffer_iter[cpu]);
 			tracing_iter_reset(&iter, cpu);
+
+			cnt +=
+			ring_buffer_entries_cpu(iter.trace_buffer->buffer, cpu);
 		}
 	} else {
 		iter.cpu_file = cpu_file;
@@ -63,13 +64,21 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 						 cpu_file, GFP_ATOMIC);
 		ring_buffer_read_start(iter.buffer_iter[cpu_file]);
 		tracing_iter_reset(&iter, cpu_file);
+
+		cnt += ring_buffer_entries_cpu(iter.trace_buffer->buffer,
+					       cpu_file);
 	}
 
-	while (trace_find_next_entry_inc(&iter)) {
-		if (!cnt)
-			kdb_printf("---------------------------------\n");
-		cnt++;
+	if (quiet)
+		goto out;
+
+	kdb_printf("Dumping ftrace buffer (skipping %d lines):\n",
+		   skip_lines);
+
+	if (cnt)
+		kdb_printf("---------------------------------\n");
 
+	while (trace_find_next_entry_inc(&iter)) {
 		if (!skip_lines) {
 			print_trace_line(&iter);
 			trace_printk_seq(&iter.seq);
@@ -99,6 +108,8 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 			iter.buffer_iter[cpu] = NULL;
 		}
 	}
+
+	return cnt;
 }
 
 /*
@@ -109,6 +120,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	int skip_lines = 0;
 	long cpu_file;
 	char *cp;
+	int cnt;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
@@ -129,7 +141,14 @@ static int kdb_ftdump(int argc, const char **argv)
 	}
 
 	kdb_trap_printk++;
-	ftrace_dump_buf(skip_lines, cpu_file);
+
+	/* A negative skip_lines means skip all but the last lines */
+	if (skip_lines < 0) {
+		cnt = ftrace_dump_buf(0, cpu_file, true);
+		skip_lines = max(cnt + skip_lines, 0);
+	}
+
+	ftrace_dump_buf(skip_lines, cpu_file, false);
 	kdb_trap_printk--;
 
 	return 0;
@@ -138,7 +157,8 @@ static int kdb_ftdump(int argc, const char **argv)
 static __init int kdb_ftrace_register(void)
 {
 	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#lines] [cpu]",
-			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
+			    "Dump ftrace log; -skip dumps last #lines", 0,
+			    KDB_ENABLE_ALWAYS_SAFE);
 	return 0;
 }
 
-- 
2.21.0.360.g471c308f928-goog

