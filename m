Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B9FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C3B20731
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKNSTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfKNSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF59D208A3;
        Thu, 14 Nov 2019 18:18:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhM-0001Db-4C; Thu, 14 Nov 2019 13:18:28 -0500
Message-Id: <20191114181828.016121464@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:18:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [for-next][PATCH 32/33] tracing: Use seq_buf_hex_dump() to dump buffers
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>

Without this, buffers can be printed with __print_array macro that has
no formatting options and can be hard to read. The other way is to
mimic formatting capability with multiple calls of trace event with one
call per row which gives performance impact and different timestamp in
each row.

Link: http://lkml.kernel.org/r/1573130738-29390-2-git-send-email-piotrx.maziarz@linux.intel.com

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  5 +++++
 include/linux/trace_seq.h    |  4 ++++
 include/trace/trace_events.h |  6 ++++++
 kernel/trace/trace_output.c  | 15 +++++++++++++++
 kernel/trace/trace_seq.c     | 30 ++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 30a8cdcfd4a4..60a41b7069dd 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -45,6 +45,11 @@ const char *trace_print_array_seq(struct trace_seq *p,
 				   const void *buf, int count,
 				   size_t el_size);
 
+const char *
+trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
+			 int prefix_type, int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii);
+
 struct trace_iterator;
 struct trace_event;
 
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 6609b39a7232..6c30508fca19 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -92,6 +92,10 @@ extern int trace_seq_path(struct trace_seq *s, const struct path *path);
 extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 			     int nmaskbits);
 
+extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
+			      int prefix_type, int rowsize, int groupsize,
+			      const void *buf, size_t len, bool ascii);
+
 #else /* CONFIG_TRACING */
 static inline void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4ecdfe2e3580..7089760d4c7a 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -340,6 +340,12 @@ TRACE_MAKE_SYSTEM_STR();
 		trace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __print_hex_dump
+#define __print_hex_dump(prefix_str, prefix_type,			\
+			 rowsize, groupsize, buf, len, ascii)		\
+	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
+				 rowsize, groupsize, buf, len, ascii)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 static notrace enum print_line_t					\
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d54ce252b05a..d9b4b7c22db4 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -274,6 +274,21 @@ trace_print_array_seq(struct trace_seq *p, const void *buf, int count,
 }
 EXPORT_SYMBOL(trace_print_array_seq);
 
+const char *
+trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
+			 int prefix_type, int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_putc(p, '\n');
+	trace_seq_hex_dump(p, prefix_str, prefix_type,
+			   rowsize, groupsize, buf, len, ascii);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+EXPORT_SYMBOL(trace_print_hex_dump_seq);
+
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *trace_event)
 {
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 6b1c562ffdaf..344e4c1aa09c 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -376,3 +376,33 @@ int trace_seq_to_user(struct trace_seq *s, char __user *ubuf, int cnt)
 	return seq_buf_to_user(&s->seq, ubuf, cnt);
 }
 EXPORT_SYMBOL_GPL(trace_seq_to_user);
+
+int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
+		       int prefix_type, int rowsize, int groupsize,
+		       const void *buf, size_t len, bool ascii)
+{
+		unsigned int save_len = s->seq.len;
+
+	if (s->full)
+		return 0;
+
+	__trace_seq_init(s);
+
+	if (TRACE_SEQ_BUF_LEFT(s) < 1) {
+		s->full = 1;
+		return 0;
+	}
+
+	seq_buf_hex_dump(&(s->seq), prefix_str,
+		   prefix_type, rowsize, groupsize,
+		   buf, len, ascii);
+
+	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
+		s->seq.len = save_len;
+		s->full = 1;
+		return 0;
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL(trace_seq_hex_dump);
-- 
2.23.0


