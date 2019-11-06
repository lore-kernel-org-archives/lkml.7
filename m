Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3597FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDE2206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfKFG35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:29:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:52106 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKFG35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:29:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 22:29:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="376952057"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2019 22:29:54 -0800
From:   Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, andriy.shevchenko@intel.com,
        cezary.rojewski@intel.com, gustaw.lewandowski@intel.com,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Subject: [PATCH 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
Date:   Wed,  6 Nov 2019 07:27:40 +0100
Message-Id: <1573021660-30540-2-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, buffers can be printed with __print_array macro that has
no formatting options and can be hard to read. The other way is to
mimic formatting capability with multiple calls of trace event with one
call per row which gives performance impact and different timestamp in
each row.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/trace_events.h |  5 +++++
 include/linux/trace_seq.h    |  4 ++++
 include/trace/trace_events.h |  6 ++++++
 kernel/trace/trace_output.c  | 15 +++++++++++++++
 kernel/trace/trace_seq.c     | 30 ++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 30a8cdc..60a41b7 100644
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
index 6609b39a..6c30508 100644
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
index 4ecdfe2..7089760 100644
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
index d54ce25..d9b4b7c 100644
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
index 6b1c562..344e4c1 100644
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
2.7.4

