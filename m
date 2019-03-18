Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F869C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC0B213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g7ekm0lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfCRUr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:47:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44057 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfCRUrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:47:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id a3so12065258pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nmY39NqjbJjPMzWIg+Tj7pvCw+EDxtYkJ2n1A8J3RZI=;
        b=g7ekm0lkyAWpPBPoJ5x2jgD+5JYl3+eEVOuZ8NxH9nWCiIX5MjaySo2KT7YHTORu5z
         2pivMG0mF6kyOGWjZVYNdhIZLEDIJfocZjZA9DOVRc/xmmhHblyii+doItc+3C9rBIvM
         2/QS29e4+n1nQGlt4UsxgKPuVtE9vDfCgc69M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmY39NqjbJjPMzWIg+Tj7pvCw+EDxtYkJ2n1A8J3RZI=;
        b=LcpV/GX9p+pN+2/uO+Q8jWr1dEO3PmaAfr5Zp/O2xl7QHOZWa8pjEpmBirOZ+W43/Y
         bE3FalT8AYNLTsjGCHlOhUxpfBhF0wYk+no+d++vsLwBsGL/1LX0rpQpgUvko6O0U1bJ
         GB0enVLS41WbXRTSBf+rQnB3EgX2eR2egMhUMgn5jsTupSfGX0AqVU6+J3G9odgQkpl9
         FW7nHV1sp96dHLG48suiE21utY76X2nuKEigk1VGSpJLEhqrQVvOjxmDRnNGYeeGapWu
         C1XZHLevGXU5nLyHp1x53gkGDRIaQha64xw3+0Tw2w3AHGj0RSDiC2R+qftgPhEo+PEh
         C5OA==
X-Gm-Message-State: APjAAAUp/ARQI1M9i6jg9CCd1F6Xtb998uqQ+dczx6IzVXb19D/JHMw0
        CxGSa+cCoqrNxhRJRExhXpKt3g==
X-Google-Smtp-Source: APXvYqx9NXz8mc/1hF8wpyL7j8r6FEvXgT+EJm2eEAcui1rXUILi+O62mQQs1yNlazuVn0N8cxd+BA==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr22219543plo.265.1552942069180;
        Mon, 18 Mar 2019 13:47:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u14sm16835807pfm.66.2019.03.18.13.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 13:47:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] tracing: kdb: Allow ftdump to skip all but the last few entries
Date:   Mon, 18 Mar 2019 13:47:41 -0700
Message-Id: <20190318204741.116550-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190318204741.116550-1-dianders@chromium.org>
References: <20190318204741.116550-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ftdump' command in kdb is currently a bit of a last resort, at
least if you have lots of traces turned on.  It's going to print a
whole boatload of data out your serial port which is probably running
at 115200.  This could easily take many, many minutes.

Usually you're most interested in what's at the _end_ of the ftrace
buffer, AKA what happened most recently.  That means you've got to
wait the full time for the dump.  The 'ftdump' command does attempt to
help you a little bit by allowing you to skip a fixed number of
entries.  Unfortunately it provides no way for you to know how many
entries you should skip.

Let's do similar to python and allow you to use a negative number to
indicate that you want to skip all entries except the last few.  This
allows you to quickly see what you want.

Note that we also change the printout in ftdump to print the
(positive) number of entries actually skipped since that could be
helpful to know when you've specified a negative skip count.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v5:
- Only print skipping info if we skipped something (Daniel/Steven)
- Add Daniel Thompson Ack.

Changes in v4:
- Now uses trace_total_entries() / trace_total_entries_cpu().
- Based upon new patch that renames "lines" to "entries".

Changes in v3:
- Optimize counting as per Steven Rostedt.
- Down to 1 patch since patch #1 from v2 landed.

 kernel/trace/trace_kdb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 4b666643d69f..a9fc4f828036 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -40,6 +40,8 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
 
 	kdb_printf("Dumping ftrace buffer:\n");
+	if (skip_entries)
+		kdb_printf("(skipping %d entries)\n", skip_entries);
 
 	/* reset all but tr, trace, and overruns */
 	memset(&iter.seq, 0,
@@ -109,6 +111,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	int skip_entries = 0;
 	long cpu_file;
 	char *cp;
+	int cnt;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
@@ -129,6 +132,16 @@ static int kdb_ftdump(int argc, const char **argv)
 	}
 
 	kdb_trap_printk++;
+
+	/* A negative skip_entries means skip all but the last entries */
+	if (skip_entries < 0) {
+		if (cpu_file == RING_BUFFER_ALL_CPUS)
+			cnt = trace_total_entries(NULL);
+		else
+			cnt = trace_total_entries_cpu(NULL, cpu_file);
+		skip_entries = max(cnt + skip_entries, 0);
+	}
+
 	ftrace_dump_buf(skip_entries, cpu_file);
 	kdb_trap_printk--;
 
@@ -138,7 +151,8 @@ static int kdb_ftdump(int argc, const char **argv)
 static __init int kdb_ftrace_register(void)
 {
 	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
-			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
+			    "Dump ftrace log; -skip dumps last #entries", 0,
+			    KDB_ENABLE_ALWAYS_SAFE);
 	return 0;
 }
 
-- 
2.21.0.225.g810b269d1ac-goog

