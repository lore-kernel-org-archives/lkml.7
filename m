Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3F5218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJa6R8II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfCOXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:09:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41222 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfCOXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:09:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so7422275pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0uPhIN+I7ZuLQj48Ft/0PCdlUfnS3imxj2Pv3kQjr8=;
        b=SJa6R8II+deAQAjL2MznzUedkonNZnMENdd+iIRom65beSm5Jds9IKa82RxwLrwuz6
         D7HNbvT+CWAZv3lGJw3WknIL0cBpkCJs7mWHv6hytIRcx1MhCKqDwpjzGRr1fX6Y2V6O
         Q49z5bJSI93t0uoKfZA13Wre6FkNYjzenY/GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0uPhIN+I7ZuLQj48Ft/0PCdlUfnS3imxj2Pv3kQjr8=;
        b=hr7xCDLGGEPdKHGy66Q//bSNoDpOTMslSiNmf25fsZk9LJO07E3MA8aqjW61+XgtLR
         cfRYQcFkRX45Rs7tWPK8yi/Aav4QoISP/xhH+XfljbOTykwb83pOiP9onPNaXBPwlwKP
         dW4VrN+B2tns1U7OZ46ahg9rQ6MHX8vR+e9esF1Ptou1O/Ae3w2HbfQU8/2JxmML9kB3
         T403vYemCqS2dtJuPewrwRkZUrucg8/EtQzMkWX0ziXDWI36E/76+0fhRcPeGoilDHQs
         I3uz47EzPs+Rl+mDek5WoQnhre08y9pDAMWKd/2opfJQUlFUS0i27OnMK5zRZx4GP3ra
         hDPA==
X-Gm-Message-State: APjAAAWy1QFrKffZBffV4EKjoJcKPqurytXeIsFw9rXVWh+VCGHII2Kp
        4CwK7ErGUuo50B72+oCeOsy9pw==
X-Google-Smtp-Source: APXvYqx42UPF9sRadGwia99n54XbIruEb7d/f6wRXHEg85PtW8zu1DFK85J3VMCcGCee6+7QMe6koA==
X-Received: by 2002:aa7:8051:: with SMTP id y17mr6577775pfm.92.1552691379320;
        Fri, 15 Mar 2019 16:09:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q62sm8192428pfi.183.2019.03.15.16.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 16:09:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] tracing: Add trace_total_entries() / trace_total_entries_cpu()
Date:   Fri, 15 Mar 2019 16:09:05 -0700
Message-Id: <20190315230906.250598-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190315230906.250598-1-dianders@chromium.org>
References: <20190315230906.250598-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two new exported functions will be used in a future patch by
kdb_ftdump() to quickly skip all but the last few trace entries.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- trace_total_entries() / trace_total_entries_cpu() new for v4

Changes in v3: None

 kernel/trace/trace.c | 65 ++++++++++++++++++++++++++++++++++----------
 kernel/trace/trace.h |  3 ++
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ccd759eaad79..7afc90f82e53 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3490,34 +3490,69 @@ static void s_stop(struct seq_file *m, void *p)
 	trace_event_read_unlock();
 }
 
+static void
+get_total_entries_cpu(struct trace_buffer *buf, unsigned long *total,
+		      unsigned long *entries, int cpu)
+{
+	unsigned long count;
+
+	count = ring_buffer_entries_cpu(buf->buffer, cpu);
+	/*
+	 * If this buffer has skipped entries, then we hold all
+	 * entries for the trace and we need to ignore the
+	 * ones before the time stamp.
+	 */
+	if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
+		count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
+		/* total is the same as the entries */
+		*total = count;
+	} else
+		*total = count +
+			ring_buffer_overrun_cpu(buf->buffer, cpu);
+	*entries = count;
+}
+
 static void
 get_total_entries(struct trace_buffer *buf,
 		  unsigned long *total, unsigned long *entries)
 {
-	unsigned long count;
+	unsigned long t, e;
 	int cpu;
 
 	*total = 0;
 	*entries = 0;
 
 	for_each_tracing_cpu(cpu) {
-		count = ring_buffer_entries_cpu(buf->buffer, cpu);
-		/*
-		 * If this buffer has skipped entries, then we hold all
-		 * entries for the trace and we need to ignore the
-		 * ones before the time stamp.
-		 */
-		if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
-			count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
-			/* total is the same as the entries */
-			*total += count;
-		} else
-			*total += count +
-				ring_buffer_overrun_cpu(buf->buffer, cpu);
-		*entries += count;
+		get_total_entries_cpu(buf, &t, &e, cpu);
+		*total += t;
+		*entries += e;
 	}
 }
 
+unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu)
+{
+	unsigned long total, entries;
+
+	if (!tr)
+		tr = &global_trace;
+
+	get_total_entries_cpu(&tr->trace_buffer, &total, &entries, cpu);
+
+	return entries;
+}
+
+unsigned long trace_total_entries(struct trace_array *tr)
+{
+	unsigned long total, entries;
+
+	if (!tr)
+		tr = &global_trace;
+
+	get_total_entries(&tr->trace_buffer, &total, &entries);
+
+	return entries;
+}
+
 static void print_lat_help_header(struct seq_file *m)
 {
 	seq_puts(m, "#                  _------=> CPU#            \n"
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee49e0eb..4562b30eda9d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -719,6 +719,9 @@ void trace_init_global_iter(struct trace_iterator *iter);
 
 void tracing_iter_reset(struct trace_iterator *iter, int cpu);
 
+unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu);
+unsigned long trace_total_entries(struct trace_array *tr);
+
 void trace_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-- 
2.21.0.360.g471c308f928-goog

