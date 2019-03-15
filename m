Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28BAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF454218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="av4VIMON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCOXJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:09:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46027 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfCOXJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:09:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id 125so7409921pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yg/2v9kCjshZO7xiZoMvFBA7joF6PqlRIBti2kFYquA=;
        b=av4VIMONSCxqIAq4pEVyPnfZOM5xNQ80UfXO9WLHDaZHx2LaXf4qORV84D4MgmlIm0
         YIzTHqXL5Vayol86M+yB9Luv4fSEj958N7Mnp/azD6WhjvZRd1ZzId6iViAaISdNGqnJ
         2THV8ou+G2B4KAX+MLxmxiDnlGqyoQObpyFKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yg/2v9kCjshZO7xiZoMvFBA7joF6PqlRIBti2kFYquA=;
        b=s/wdT3fUmS84xU1FfSj7JdNhkfpqnCRutlUfxD9BKax+RP5XIs5C7aft7XdrP9O0sY
         EI4e+e7FLaOQVAKZOGYS4AssKmzYEc/dbzpUkjY/CyT9LzZRIPLvVKLhs3n1QKb2fC88
         w+vJp6kXzntpInIk/0OZ9aT0mv1qZ1IioQkUvFOkEQy3k1tjygfJsfJW3ZPxjmpiRccV
         sS1/K0lCPsm+s2yOSmH6Asvuu7/ByCp9BFaX+r0sl+dY0uhNjF4BOZZrR9w0crO/LDQN
         3bPnl3iMoBCcjE/kbUNCO133PP0Fflp7Eaf/9bqCgQlJ0/DNbX0OqEuJXhjs5JH62WF4
         BZDQ==
X-Gm-Message-State: APjAAAXPGbbpblezeS8Tmsk07IPN5iFSQWlOFhTrhmLjOC1umdgAwZjQ
        m8MD+AnhDo+dKjsK92NFrLh8VA==
X-Google-Smtp-Source: APXvYqyVXrb3FmzlTjvml4ihm9S5/fB1lv9Zm5FBNBO+S67fOGxM3Riboy4zM8cL+kkQN0yxiSSxSg==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr5837970pgp.395.1552691380544;
        Fri, 15 Mar 2019 16:09:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q62sm8192428pfi.183.2019.03.15.16.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 16:09:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] tracing: kdb: Allow ftdump to skip all but the last few entries
Date:   Fri, 15 Mar 2019 16:09:06 -0700
Message-Id: <20190315230906.250598-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190315230906.250598-1-dianders@chromium.org>
References: <20190315230906.250598-1-dianders@chromium.org>
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

Changes in v4:
- Now uses trace_total_entries() / trace_total_entries_cpu().
- Based upon new patch that renames "lines" to "entries".

Changes in v3:
- Optimize counting as per Steven Rostedt.
- Down to 1 patch since patch #1 from v2 landed.

 kernel/trace/trace_kdb.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 4b666643d69f..996e1e9cd9a6 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -39,7 +39,8 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 	/* don't look at user memory in panic mode */
 	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
 
-	kdb_printf("Dumping ftrace buffer:\n");
+	kdb_printf("Dumping ftrace buffer (skipping %d entries):\n",
+		   skip_entries);
 
 	/* reset all but tr, trace, and overruns */
 	memset(&iter.seq, 0,
@@ -109,6 +110,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	int skip_entries = 0;
 	long cpu_file;
 	char *cp;
+	int cnt;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
@@ -129,6 +131,16 @@ static int kdb_ftdump(int argc, const char **argv)
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
 
@@ -138,7 +150,8 @@ static int kdb_ftdump(int argc, const char **argv)
 static __init int kdb_ftrace_register(void)
 {
 	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
-			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
+			    "Dump ftrace log; -skip dumps last #entries", 0,
+			    KDB_ENABLE_ALWAYS_SAFE);
 	return 0;
 }
 
-- 
2.21.0.360.g471c308f928-goog

