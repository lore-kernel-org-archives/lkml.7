Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735B520863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZ/R2Oqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfCSRMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:12:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38537 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfCSRMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:12:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id n125so14146298pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2gxacLerenlq+tpCzltLpWgzd/hECbnnlj9EPYDwCRc=;
        b=eZ/R2Oqb8umjYtWnzmRHtVbAyA5bhJ6XnGXWT7Yl8tmlY4aPzWSsedBHw9thUa7+c4
         EbT9YT60VNoZLYdOQrxUUdsEcz4XBFjUXfsk7iooR2igOC9vhnekVQbaxAfKEB2BzrWD
         +qUf9dTB6njpAwDF+AfmflYFlgLEIL/G4oonU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gxacLerenlq+tpCzltLpWgzd/hECbnnlj9EPYDwCRc=;
        b=EfLTcfQp19CxJeaCwi/j/DfVG+qvz6fp+/muh45tyUYH+5u12cBl+DjTy3+msCn1NS
         tPLg0r4vlnJJwqtUw5ENQbk6cbICk1D06LsQW7dx1DVA5oPqEi9+E6UVnoOKEWhga47o
         u8HLQD3FJpoYboKjLJBqejA2z6tFbzebWxOt+pJRk+ZNim1p57nbvB4/3kY69n6e798H
         qSXZks4hThxeOhAyH8HkK6r5+mcElZVckk+hVKjTuJzGGlOAy71GOZxFuNizOW3x+8Ua
         04DdvkU3nzMfECaMrhzSnKaU1shDhVcOmsBPjeLvVJ/OLjF81EYy0lqn0PVIc9bCTeLd
         peAw==
X-Gm-Message-State: APjAAAVownLzU/EJmY+cHnf8+hcU74USc1qaQUJMRdLcfdT3hcmu6byu
        /08XP/kWDESqSQyo+1Aeljo65A==
X-Google-Smtp-Source: APXvYqwqxovP8aTwH1Ri/M4FU+VvkcU+hklzMGM1fRAqgAevKE+8UubKjmNCRIdqJoiBLEpXO5SNiQ==
X-Received: by 2002:a63:1d03:: with SMTP id d3mr3055444pgd.42.1553015555512;
        Tue, 19 Mar 2019 10:12:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g6sm18293918pgq.54.2019.03.19.10.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:12:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] tracing: kdb: Allow ftdump to skip all but the last few entries
Date:   Tue, 19 Mar 2019 10:12:06 -0700
Message-Id: <20190319171206.97107-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190319171206.97107-1-dianders@chromium.org>
References: <20190319171206.97107-1-dianders@chromium.org>
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
---

Changes in v6:
- Keep tracing disabled between counting and dumping.
- Remove Daniel Thompson Ack due to changes between v5 and v6.

Changes in v5:
- Only print skipping info if we skipped something (Daniel/Steven)
- Add Daniel Thompson Ack.

Changes in v4:
- Now uses trace_total_entries() / trace_total_entries_cpu().
- Based upon new patch that renames "lines" to "entries".

Changes in v3:
- Optimize counting as per Steven Rostedt.
- Down to 1 patch since patch #1 from v2 landed.

 kernel/trace/trace_kdb.c | 45 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 4b666643d69f..6c1ae6b752d1 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -17,29 +17,25 @@
 #include "trace.h"
 #include "trace_output.h"
 
+static struct trace_iterator iter;
+static struct ring_buffer_iter *buffer_iter[CONFIG_NR_CPUS];
+
 static void ftrace_dump_buf(int skip_entries, long cpu_file)
 {
-	/* use static because iter can be a bit big for the stack */
-	static struct trace_iterator iter;
-	static struct ring_buffer_iter *buffer_iter[CONFIG_NR_CPUS];
 	struct trace_array *tr;
 	unsigned int old_userobj;
 	int cnt = 0, cpu;
 
-	trace_init_global_iter(&iter);
-	iter.buffer_iter = buffer_iter;
 	tr = iter.tr;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
-	}
-
 	old_userobj = tr->trace_flags;
 
 	/* don't look at user memory in panic mode */
 	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
 
 	kdb_printf("Dumping ftrace buffer:\n");
+	if (skip_entries)
+		kdb_printf("(skipping %d entries)\n", skip_entries);
 
 	/* reset all but tr, trace, and overruns */
 	memset(&iter.seq, 0,
@@ -89,10 +85,6 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 out:
 	tr->trace_flags = old_userobj;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
-	}
-
 	for_each_tracing_cpu(cpu) {
 		if (iter.buffer_iter[cpu]) {
 			ring_buffer_read_finish(iter.buffer_iter[cpu]);
@@ -109,6 +101,8 @@ static int kdb_ftdump(int argc, const char **argv)
 	int skip_entries = 0;
 	long cpu_file;
 	char *cp;
+	int cnt;
+	int cpu;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
@@ -129,7 +123,29 @@ static int kdb_ftdump(int argc, const char **argv)
 	}
 
 	kdb_trap_printk++;
+
+	trace_init_global_iter(&iter);
+	iter.buffer_iter = buffer_iter;
+
+	for_each_tracing_cpu(cpu) {
+		atomic_inc(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
+	}
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
+
+	for_each_tracing_cpu(cpu) {
+		atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
+	}
+
 	kdb_trap_printk--;
 
 	return 0;
@@ -138,7 +154,8 @@ static int kdb_ftdump(int argc, const char **argv)
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

