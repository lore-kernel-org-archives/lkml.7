Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912DDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B0F20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QbWlUH6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfCSRMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:12:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45659 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfCSRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:12:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so5065640pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6SLpr2bzpflDnJzOmI6lRnJ6iq6HyooN6i24GTNQEI=;
        b=QbWlUH6CibRcqYz2o5kwDaqyXELi1wuqAJ4AWXEbOQEyho78XwSSjB/02KdsQRHTVi
         DtS7P7WAliYFnmcp/I9vtz/eh6WsraCy1RUt+NaP+MKzCB3ugJRmk86k6sAD+lpaCVtx
         1vPFNxt/k0yrJhTL4dYQ9QloF3OYo7pemgZ5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6SLpr2bzpflDnJzOmI6lRnJ6iq6HyooN6i24GTNQEI=;
        b=keOwP9KZY6U0wX+eUFjxFTY887Zfqrm36h5LZV88ucxhJzIVGtf3SR6pSmSS26p4Yk
         M3xlkk0fELXEm4ZK11KufkAedTSLv+aYzsSPfrErckHzzlQShOLpZRjF/3+kXF8A2JFP
         TJdlmgXJ4x3MdMhEhLkKPg4UnMNK2feXL5tGm8OGwBy0c7y8pp+oJDyMULcLXJ7M3GpL
         OgUvuGZ4PBTIcMoUmmFRQ1eO2LO8QlgqfbxTOxwlnNWGvPi51SU4zLukJQfqaMIVVq6L
         oE4PwNp0WGNnmPKj8E49tpZmUIyixQ+jQMWRjzrT5CkDT6BGAJQ0RN5bmbDVSisTR1U9
         N56A==
X-Gm-Message-State: APjAAAUEuYnfFYrJ+VrPLyN4Qu2oy1aAoO71xIlXwlmse6qAoXd9rH2f
        DWb6x85oYB7RUE7BMn8ki1Q3YQ==
X-Google-Smtp-Source: APXvYqwA0Pn+8B6WNkShkheWn67eDkI24Q5gk75UM2gpjbySssFCdQ2xDNglL+Hkmiw2N+eDZG4Ckg==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr3316979pla.178.1553015554222;
        Tue, 19 Mar 2019 10:12:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g6sm18293918pgq.54.2019.03.19.10.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:12:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] tracing: Add trace_total_entries() / trace_total_entries_cpu()
Date:   Tue, 19 Mar 2019 10:12:05 -0700
Message-Id: <20190319171206.97107-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190319171206.97107-1-dianders@chromium.org>
References: <20190319171206.97107-1-dianders@chromium.org>
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
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v6:
- Add Daniel Thompson Ack.

Changes in v5: None
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
2.21.0.225.g810b269d1ac-goog

