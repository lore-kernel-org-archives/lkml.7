Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D70C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB7120663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a9n6pS40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfCEXcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:32:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34416 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfCEXcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:32:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so6757321pgd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 15:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNFW5yIZll5cOjHqM/Myiq8X7O8OqPGbii/df9gqpZ4=;
        b=a9n6pS40yXAkzmNTP1jL+ydcDpUJMTpq86NaoSzGZW4WFhaspTja+PzBOOlhZ97cqD
         8uKGbX9Q1ysjR6JuKtgaJSo5H8j6+kUF1WeG3i5CZ+qAyoGLXN0tQH68qjzpfShDYp59
         r3k+L3fu1GYdCocRK87S6yI7UQBdElnqEhspU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNFW5yIZll5cOjHqM/Myiq8X7O8OqPGbii/df9gqpZ4=;
        b=ozT+u1i/l9TkT0I88mdC5xqfELpSLQqXRn/LGDch/ExC2DtGjOKizRoJ7737qze/rs
         lZMDDfxkoeXrWkTWCTPNqizdB/xCvdeepTxxnstdfhUhOeHHcZqGj/HldgSuJh7ecAzf
         NHR2q8brt1aonw2FXokTCyBWoNsYrauwT+dAKTgWS5RHGJvXh+gXdAAM0KMMGIVZB8oy
         /fcoLHdNzlh4iGSEHFf6xfzu9+lYlOf31F5e1jrpv36vNEyTK4uLD5ZrcQGmB82TNLhQ
         dsKf8uXPSy8Kh18bqCUh2DuduaDip18uXCHTRIddOY4qEYRVygvhqlI+9kTeSQgtWmGN
         zTog==
X-Gm-Message-State: APjAAAX13Iq1MksWivtKXCCXTsy57Z/9aSFtZoITR+HcYm3mehV/r563
        xbjZJwRq+aketqKvEicl0mdbyQ==
X-Google-Smtp-Source: APXvYqz4/Ra19RlsykuaUKDB4jifRcxpbTrOb7J3qKYIm+WCRGENCrSZh/lCqC4bE8D0d6TCP6lxpA==
X-Received: by 2002:a63:8048:: with SMTP id j69mr3583249pgd.432.1551828729843;
        Tue, 05 Mar 2019 15:32:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j1sm20345pgp.84.2019.03.05.15.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 15:32:09 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: kdb: Allow ftdump to skip all but the last few lines
Date:   Tue,  5 Mar 2019 15:31:50 -0800
Message-Id: <20190305233150.159633-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
In-Reply-To: <20190305233150.159633-1-dianders@chromium.org>
References: <20190305233150.159633-1-dianders@chromium.org>
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

 kernel/trace/trace_kdb.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index be84fa1ded35..40844e168a8c 100644
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
@@ -39,7 +39,9 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 	/* don't look at user memory in panic mode */
 	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
 
-	kdb_printf("Dumping ftrace buffer:\n");
+	if (!quiet)
+		kdb_printf("Dumping ftrace buffer (skipping %d lines):\n",
+			   skip_lines);
 
 	/* reset all but tr, trace, and overruns */
 	memset(&iter.seq, 0,
@@ -66,25 +68,29 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 	}
 
 	while (trace_find_next_entry_inc(&iter)) {
-		if (!cnt)
-			kdb_printf("---------------------------------\n");
-		cnt++;
-
-		if (!skip_lines) {
-			print_trace_line(&iter);
-			trace_printk_seq(&iter.seq);
-		} else {
-			skip_lines--;
+		if (!quiet) {
+			if (!cnt)
+				kdb_printf("---------------------------------\n");
+
+			if (!skip_lines) {
+				print_trace_line(&iter);
+				trace_printk_seq(&iter.seq);
+			} else {
+				skip_lines--;
+			}
 		}
+		cnt++;
 
 		if (KDB_FLAG(CMD_INTERRUPT))
 			goto out;
 	}
 
-	if (!cnt)
-		kdb_printf("   (ftrace buffer empty)\n");
-	else
-		kdb_printf("---------------------------------\n");
+	if (!quiet) {
+		if (!cnt)
+			kdb_printf("   (ftrace buffer empty)\n");
+		else
+			kdb_printf("---------------------------------\n");
+	}
 
 out:
 	tr->trace_flags = old_userobj;
@@ -99,6 +105,8 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 			iter.buffer_iter[cpu] = NULL;
 		}
 	}
+
+	return cnt;
 }
 
 /*
@@ -109,6 +117,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	int skip_lines = 0;
 	long cpu_file;
 	char *cp;
+	int count;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
@@ -129,7 +138,14 @@ static int kdb_ftdump(int argc, const char **argv)
 	}
 
 	kdb_trap_printk++;
-	ftrace_dump_buf(skip_lines, cpu_file);
+
+	/* A negative skip_lines means skip all but the last lines */
+	if (skip_lines < 0) {
+		count = ftrace_dump_buf(0, cpu_file, true);
+		skip_lines = max(count + skip_lines, 0);
+	}
+
+	count = ftrace_dump_buf(skip_lines, cpu_file, false);
 	kdb_trap_printk--;
 
 	return 0;
@@ -138,7 +154,8 @@ static int kdb_ftdump(int argc, const char **argv)
 static __init int kdb_ftrace_register(void)
 {
 	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#lines] [cpu]",
-			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
+			    "Dump ftrace log; -skip dumps last #lines", 0,
+			    KDB_ENABLE_ALWAYS_SAFE);
 	return 0;
 }
 
-- 
2.21.0.352.gf09ad66450-goog

