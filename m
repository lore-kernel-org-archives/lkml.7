Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326F92070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzRkJpcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfG2RKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:10:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43800 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2RKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:10:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so28355495pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFoHn+09VtGJdjwtVsPvAf3qofZi9oxP3RiRfoAV84k=;
        b=OzRkJpcQFkcVD2fO5HDAUU30JD+d/3S42aCvpq0X+TSVjkLb7lvzOGOxTSBja2p+rs
         4otoVPYOvWlY1PntdpklvUWnS+Ip/d0L3ywRzE8usxAWmjqIBS77wa7yk2JdkQaqtm3C
         wWqtFeL9+4b2kaa8lamqvTk74B/C3Rk6y6NA7KbcUnRCFhDPZUHPhLSIa0wSz3+MfER9
         MTO+Ybqm+m0sF4obHoJfj3sIqOMfxeg2AQj51wwav1M3MqSl2TS6aWBmvd9N3ddDUVDR
         EwDXod1x6UkI/dD0BlaP8hIL3/YjwZILxPBjZ5idjLkiKbE0U3Gg8zgCG/tiyeCx4vi5
         FhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFoHn+09VtGJdjwtVsPvAf3qofZi9oxP3RiRfoAV84k=;
        b=GZLQ8BHvRhCHz2+AUSxB8xXokgAD8RxcSrbaEz/yGGmJwezVsydb3qFv+cgSsC3BvO
         rpD+yd3syBO09zB59ZncxDZhntFpAwBP1MZvsnTbTU8PMxmjd1LrHcJ1W3TzqGrqGdj0
         L8/A7s00DpZgEDGNLHj32DQGejkLOpwY5QnnXBvcqZuz94j2jc/nfXiqv3huy1Vqe5qr
         vSCtgC5WLRXYjlH6ReDWkctPp5kr7CMVn8eBntzr5EEfR55HGsTiF+eY35li9nIqbS3k
         2K5nBM6R588EQ+D/J1Uh9xCN23XVvPbBC3pFWOU/59V3GPPgbLNFb1Zih4j2/Wa84jhi
         7WKw==
X-Gm-Message-State: APjAAAV342Ru1rM3KW6VAJxYIfmHaGZ1uAoghdZ8mvuxpDqldw6msxU4
        uYHblpQlhPpZaRTszuw1rLhBod3WKcY=
X-Google-Smtp-Source: APXvYqyuG88fR7A8shWKCpSClnqNA8sMnbSnhfwHisSEFIemZd7K1MafuKx4VVVNDAvmdtfMo0TT9Q==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr107252277pgc.12.1564420203992;
        Mon, 29 Jul 2019 10:10:03 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id d2sm57103750pjs.21.2019.07.29.10.10.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 10:10:03 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [Patch v2] tracing: Introduce trace event injection
Date:   Mon, 29 Jul 2019 10:08:27 -0700
Message-Id: <20190729170828.927-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been trying to use rasdaemon to monitor hardware errors like
correctable memory errors. rasdaemon uses trace events to monitor
various hardware errors. In order to test it, we have to inject some
hardware errors, unfortunately not all of them provide error
injections. MCE does provide a way to inject MCE errors, but errors
like PCI error and devlink error don't, it is not easy to add error
injection to each of them. Instead, it is relatively easier to just
allow users to inject trace events in a generic way so that all trace
events can be injected.

This patch introduces trace event injection, where a new 'inject' is
added to each tracepoint directory. Users could write into this file
with key=value pairs to specify the value of each fields of the trace
event, all unspecified fields are set to zero values by default.

For example, for the net/net_dev_queue tracepoint, we can inject:

  INJECT=/sys/kernel/debug/tracing/events/net/net_dev_queue/inject
  echo "" > $INJECT
  echo "name='test'" > $INJECT
  echo "name='test' len=1024" > $INJECT
  cat /sys/kernel/debug/tracing/trace
  ...
   <...>-614   [000] ....    36.571483: net_dev_queue: dev= skbaddr=00000000fbf338c2 len=0
   <...>-614   [001] ....   136.588252: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=0
   <...>-614   [001] .N..   208.431878: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=1024

Triggers could be triggered as usual too:

  echo "stacktrace if len == 1025" > /sys/kernel/debug/tracing/events/net/net_dev_queue/trigger
  echo "len=1025" > $INJECT
  cat /sys/kernel/debug/tracing/trace
  ...
      bash-614   [000] ....    36.571483: net_dev_queue: dev= skbaddr=00000000fbf338c2 len=0
      bash-614   [001] ....   136.588252: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=0
      bash-614   [001] .N..   208.431878: net_dev_queue: dev=test skbaddr=00000000fbf338c2 len=1024
      bash-614   [001] .N.1   284.236349: <stack trace>
 => event_inject_write
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

The only thing that can't be injected is string pointers as they
require constant string pointers, this can't be done at run time.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 kernel/trace/Makefile              |   1 +
 kernel/trace/trace.h               |   1 +
 kernel/trace/trace_events.c        |   4 +
 kernel/trace/trace_events_inject.c | 328 +++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 kernel/trace/trace_events_inject.c

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c2b2148bb1d2..3c7bbacf4c18 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
 endif
 obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
 obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
+obj-$(CONFIG_EVENT_TRACING) += trace_events_inject.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
 obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..23741d9b59f1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1582,6 +1582,7 @@ extern struct list_head ftrace_events;
 
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
+extern const struct file_operations event_inject_fops;
 
 #ifdef CONFIG_HIST_TRIGGERS
 extern int register_trigger_hist_cmd(void);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c7506bc81b75..47a5e548cfd4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2018,6 +2018,10 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	trace_create_file("format", 0444, file->dir, call,
 			  &ftrace_event_format_fops);
 
+	if (call->event.type && call->class->reg)
+		trace_create_file("inject", 0200, file->dir, file,
+				  &event_inject_fops);
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
new file mode 100644
index 000000000000..6347029a1fa1
--- /dev/null
+++ b/kernel/trace/trace_events_inject.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace_events_inject - trace event injection
+ *
+ * Copyright (C) 2019 Cong Wang <cwang@twitter.com>
+ */
+
+#include <linux/module.h>
+#include <linux/ctype.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/rculist.h>
+
+#include "trace.h"
+
+static int
+trace_inject_entry(struct trace_event_file *file, void *rec, int len)
+{
+	struct trace_event_buffer fbuffer;
+	struct ring_buffer *buffer;
+	int written = 0;
+	void *entry;
+
+	buffer = file->tr->trace_buffer.buffer;
+	entry = trace_event_buffer_reserve(&fbuffer, file, len);
+	if (entry) {
+		memcpy(entry, rec, len);
+		written = len;
+		trace_event_buffer_commit(&fbuffer);
+	}
+
+	return written;
+}
+
+static int
+parse_field(char *str, struct trace_event_call *call,
+	    struct ftrace_event_field **pf, u64 *pv)
+{
+	struct ftrace_event_field *field;
+	char *field_name;
+	int s, i = 0;
+	char *p;
+	int len;
+	u64 val;
+
+	if (!str[i])
+		return 0;
+	/* First find the field to associate to */
+	while (isspace(str[i]))
+		i++;
+	s = i;
+	while (isalnum(str[i]) || str[i] == '_')
+		i++;
+	len = i - s;
+	if (!len)
+		return -EINVAL;
+
+	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
+	if (!field_name)
+		return -ENOMEM;
+	field = trace_find_event_field(call, field_name);
+	kfree(field_name);
+	if (!field)
+		return -ENOENT;
+
+	*pf = field;
+	p = strchr(str + i, '=');
+	if (!p)
+		return -EINVAL;
+	i = p + 1 - str;
+	while (isspace(str[i]))
+		i++;
+	s = i;
+	if (isdigit(str[i]) || str[i] == '-') {
+		char *num, c;
+		int ret;
+
+		/* Make sure the field is not a string */
+		if (is_string_field(field))
+			return -EINVAL;
+
+		if (str[i] == '-')
+			i++;
+
+		/* We allow 0xDEADBEEF */
+		while (isalnum(str[i]))
+			i++;
+		num = str + s;
+		c = str[i];
+		str[i] = '\0';
+		/* Make sure it is a value */
+		if (field->is_signed)
+			ret = kstrtoll(num, 0, &val);
+		else
+			ret = kstrtoull(num, 0, &val);
+		str[i] = c;
+		if (ret)
+			return ret;
+
+		*pv = val;
+		return i;
+	} else if (str[i] == '\'' || str[i] == '"') {
+		char q = str[i];
+
+		/* Make sure the field is OK for strings */
+		if (!is_string_field(field))
+			return -EINVAL;
+
+		for (i++; str[i]; i++) {
+			if (str[i] == '\\' && str[i + 1]) {
+				i++;
+				continue;
+			}
+			if (str[i] == q)
+				break;
+		}
+		if (!str[i])
+			return -EINVAL;
+
+		/* Skip quotes */
+		s++;
+		len = i - s;
+		if (len >= MAX_FILTER_STR_VAL)
+			return -EINVAL;
+
+		*pv = (unsigned long)(str + s);
+		str[i] = 0;
+		/* go past the last quote */
+		i++;
+		return i;
+	}
+
+	return -EINVAL;
+}
+
+static int trace_get_entry_size(struct trace_event_call *call)
+{
+	struct ftrace_event_field *field;
+	struct list_head *head;
+	int size = 0;
+
+	head = trace_get_fields(call);
+	list_for_each_entry(field, head, link) {
+		if (field->size + field->offset > size)
+			size = field->size + field->offset;
+	}
+
+	return size;
+}
+
+static void *trace_alloc_entry(struct trace_event_call *call, int *size)
+{
+	int entry_size = trace_get_entry_size(call);
+	struct ftrace_event_field *field;
+	struct list_head *head;
+	void *entry = NULL;
+
+	/* We need an extra '\0' at the end. */
+	entry = kzalloc(entry_size + 1, GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	head = trace_get_fields(call);
+	list_for_each_entry(field, head, link) {
+		if (!is_string_field(field))
+			continue;
+		if (field->filter_type == FILTER_STATIC_STRING)
+			continue;
+		if (field->filter_type == FILTER_DYN_STRING) {
+			u32 *str_item;
+			int str_len = 0;
+			int str_loc = entry_size & 0xffff;
+
+			str_item = (u32 *)(entry + field->offset);
+			*str_item = (str_len << 16) | str_loc;
+		} else {
+			char **paddr;
+
+			paddr = (char **)(entry + field->offset);
+			*paddr = "";
+		}
+	}
+
+	*size = entry_size + 1;
+	return entry;
+}
+
+#define INJECT_STRING "STATIC STRING CAN NOT BE INJECTED"
+
+/* Caller is responsible to free the *pentry. */
+static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
+{
+	struct ftrace_event_field *field;
+	unsigned long irq_flags;
+	void *entry = NULL;
+	int entry_size;
+	u64 val;
+	int len;
+
+	entry = trace_alloc_entry(call, &entry_size);
+	*pentry = entry;
+	if (!entry)
+		return -ENOMEM;
+
+	local_save_flags(irq_flags);
+	tracing_generic_entry_update(entry, call->event.type, irq_flags,
+				     preempt_count());
+
+	while ((len = parse_field(str, call, &field, &val)) > 0) {
+		if (is_function_field(field))
+			return -EINVAL;
+
+		if (is_string_field(field)) {
+			char *addr = (char *)(unsigned long) val;
+
+			if (field->filter_type == FILTER_STATIC_STRING) {
+				strlcpy(entry + field->offset, addr, field->size);
+			} else if (field->filter_type == FILTER_DYN_STRING) {
+				int str_len = strlen(addr) + 1;
+				int str_loc = entry_size & 0xffff;
+				u32 *str_item;
+
+				entry_size += str_len;
+				*pentry = krealloc(entry, entry_size, GFP_KERNEL);
+				entry = *pentry;
+				if (!entry)
+					return -ENOMEM;
+
+				strlcpy(entry + (entry_size - str_len), addr, str_len);
+				str_item = (u32 *)(entry + field->offset);
+				*str_item = (str_len << 16) | str_loc;
+			} else {
+				char **paddr;
+
+				/* TODO: can we find the constant string? */
+				paddr = (char **)(entry + field->offset);
+				*paddr = INJECT_STRING;
+			}
+		} else {
+			switch (field->size) {
+			case 1: {
+				u8 tmp = (u8) val;
+
+				memcpy(entry + field->offset, &tmp, 1);
+				break;
+			}
+			case 2: {
+				u16 tmp = (u16) val;
+
+				memcpy(entry + field->offset, &tmp, 2);
+				break;
+			}
+			case 4: {
+				u32 tmp = (u32) val;
+
+				memcpy(entry + field->offset, &tmp, 4);
+				break;
+			}
+			case 8:
+				memcpy(entry + field->offset, &val, 8);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+
+		str += len;
+	}
+
+	if (len < 0)
+		return len;
+
+	return entry_size;
+}
+
+static ssize_t
+event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
+		   loff_t *ppos)
+{
+	struct trace_event_call *call;
+	struct trace_event_file *file;
+	int err = -ENODEV, size;
+	void *entry = NULL;
+	char *buf;
+
+	if (cnt >= PAGE_SIZE)
+		return -EINVAL;
+
+	buf = memdup_user_nul(ubuf, cnt);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+	strim(buf);
+
+	mutex_lock(&event_mutex);
+	file = event_file_data(filp);
+	if (file) {
+		call = file->event_call;
+		size = parse_entry(buf, call, &entry);
+		if (size < 0)
+			err = size;
+		else
+			err = trace_inject_entry(file, entry, size);
+	}
+	mutex_unlock(&event_mutex);
+
+	kfree(entry);
+	kfree(buf);
+
+	if (err < 0)
+		return err;
+
+	*ppos += err;
+	return cnt;
+}
+
+static ssize_t
+event_inject_read(struct file *file, char __user *buf, size_t size,
+		  loff_t *ppos)
+{
+	return -EPERM;
+}
+
+const struct file_operations event_inject_fops = {
+	.open = tracing_open_generic,
+	.read = event_inject_read,
+	.write = event_inject_write,
+};
+
-- 
2.21.0

