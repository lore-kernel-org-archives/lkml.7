Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435CDC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D926205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFJBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:01:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:41583 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLFJBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:01:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 01:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; 
   d="scan'208";a="202048619"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2019 01:01:17 -0800
From:   Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, acme@redhat.com, tstoyanov@vmware.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: [PATCH] libtraceevent: add __print_hex_dump support
Date:   Fri,  6 Dec 2019 10:00:51 +0100
Message-Id: <1575622851-26514-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows using parsing __print_hex_dump in user space tools. Print
format is aligned with debugfs tracing interface.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 tools/lib/traceevent/event-parse.c | 123 +++++++++++++++++++++++++++++++++++++
 tools/lib/traceevent/event-parse.h |  12 ++++
 tools/lib/traceevent/trace-seq.c   |  92 +++++++++++++++++++++++++++
 tools/lib/traceevent/trace-seq.h   |   3 +
 4 files changed, 230 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d948475..b8f6686 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -898,6 +898,15 @@ static void free_arg(struct tep_print_arg *arg)
 		free_arg(arg->int_array.count);
 		free_arg(arg->int_array.el_size);
 		break;
+	case TEP_PRINT_HEX_DUMP:
+		free_arg(arg->hex_dump.prefix_str);
+		free_arg(arg->hex_dump.prefix_type);
+		free_arg(arg->hex_dump.rowsize);
+		free_arg(arg->hex_dump.groupsize);
+		free_arg(arg->hex_dump.buf);
+		free_arg(arg->hex_dump.len);
+		free_arg(arg->hex_dump.ascii);
+		break;
 	case TEP_PRINT_TYPE:
 		free(arg->typecast.type);
 		free_arg(arg->typecast.item);
@@ -2752,6 +2761,58 @@ process_int_array(struct tep_event *event, struct tep_print_arg *arg, char **tok
 }
 
 static enum tep_event_type
+process_hex_dump(struct tep_event *event, struct tep_print_arg *arg, char **tok)
+{
+	memset(arg, 0, sizeof(*arg));
+	arg->type = TEP_PRINT_HEX_DUMP;
+
+	if (alloc_and_process_delim(event, ",", &arg->hex_dump.prefix_str))
+		goto out;
+
+	if (alloc_and_process_delim(event, ",", &arg->hex_dump.prefix_type))
+		goto free_prefix_str;
+
+	if (alloc_and_process_delim(event, ",", &arg->hex_dump.rowsize))
+		goto free_prefix_type;
+
+	if (alloc_and_process_delim(event, ",", &arg->hex_dump.groupsize))
+		goto free_rowsize;
+
+	if (alloc_and_process_delim(event, ",", &arg->hex_dump.buf))
+		goto free_groupsize;
+
+	if (alloc_and_process_delim(event, ",", &arg->hex_dump.len))
+		goto free_buf;
+
+	if (alloc_and_process_delim(event, ")", &arg->hex_dump.ascii))
+		goto free_len;
+
+	return read_token_item(tok);
+
+free_len:
+	free_arg(arg->hex_dump.len);
+	arg->hex_dump.len = NULL;
+free_buf:
+	free_arg(arg->hex_dump.buf);
+	arg->hex_dump.buf = NULL;
+free_groupsize:
+	free_arg(arg->hex_dump.groupsize);
+	arg->hex_dump.groupsize = NULL;
+free_rowsize:
+	free_arg(arg->hex_dump.rowsize);
+	arg->hex_dump.rowsize = NULL;
+free_prefix_type:
+	free_arg(arg->hex_dump.prefix_type);
+	arg->hex_dump.prefix_type = NULL;
+free_prefix_str:
+	free_arg(arg->hex_dump.prefix_str);
+	arg->hex_dump.prefix_str = NULL;
+out:
+	*tok = NULL;
+	return TEP_EVENT_ERROR;
+}
+
+static enum tep_event_type
 process_dynamic_array(struct tep_event *event, struct tep_print_arg *arg, char **tok)
 {
 	struct tep_format_field *field;
@@ -3090,6 +3151,10 @@ process_function(struct tep_event *event, struct tep_print_arg *arg,
 		free_token(token);
 		return process_int_array(event, arg, tok);
 	}
+	if (strcmp(token, "__print_hex_dump") == 0) {
+		free_token(token);
+		return process_hex_dump(event, arg, tok);
+	}
 	if (strcmp(token, "__get_str") == 0) {
 		free_token(token);
 		return process_str(event, arg, tok);
@@ -3626,6 +3691,7 @@ eval_num_arg(void *data, int size, struct tep_event *event, struct tep_print_arg
 	case TEP_PRINT_FLAGS:
 	case TEP_PRINT_SYMBOL:
 	case TEP_PRINT_INT_ARRAY:
+	case TEP_PRINT_HEX_DUMP:
 	case TEP_PRINT_HEX:
 	case TEP_PRINT_HEX_STR:
 		break;
@@ -4124,6 +4190,46 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 		}
 		break;
 	}
+	case TEP_PRINT_HEX_DUMP: {
+		void *buf;
+		char *prefix_str;
+		int prefix_type, rowsize, groupsize, ascii;
+
+		if (arg->hex_dump.buf->type == TEP_PRINT_DYNAMIC_ARRAY) {
+			unsigned long offset;
+
+			field = arg->hex_dump.buf->dynarray.field;
+			offset = tep_read_number(tep,
+						 data + field->offset,
+						 field->size);
+			buf = data + (offset & 0xffff);
+		} else {
+			field = arg->hex_dump.buf->field.field;
+			if (!field) {
+				str = arg->hex_dump.buf->field.name;
+				field = tep_find_any_field(event, str);
+				if (!field)
+					goto out_warning_field;
+				arg->hex_dump.buf->field.field = field;
+			}
+			buf = data + field->offset;
+		}
+		prefix_type = eval_num_arg(data, size, event,
+					   arg->hex_dump.prefix_type);
+		rowsize = eval_num_arg(data, size, event,
+				       arg->hex_dump.rowsize);
+		groupsize = eval_num_arg(data, size, event,
+					 arg->hex_dump.groupsize);
+		len = eval_num_arg(data, size, event, arg->hex_dump.len);
+		ascii = eval_num_arg(data, size, event,
+					   arg->hex_dump.ascii);
+		prefix_str = arg->hex_dump.prefix_str->atom.atom;
+
+		trace_seq_putc(s, '\n');
+		trace_seq_hex_dump(s, prefix_str, prefix_type,
+				   rowsize, groupsize, buf, len, ascii);
+		break;
+	}
 	case TEP_PRINT_TYPE:
 		break;
 	case TEP_PRINT_STRING: {
@@ -5984,6 +6090,23 @@ static void print_args(struct tep_print_arg *args)
 		print_args(args->int_array.el_size);
 		printf(")");
 		break;
+	case TEP_PRINT_HEX_DUMP:
+		printf("__print_hex_dump(");
+		print_args(args->hex_dump.prefix_str);
+		printf(", ");
+		print_args(args->hex_dump.prefix_type);
+		printf(", ");
+		print_args(args->hex_dump.rowsize);
+		printf(", ");
+		print_args(args->hex_dump.groupsize);
+		printf(", ");
+		print_args(args->hex_dump.buf);
+		printf(", ");
+		print_args(args->hex_dump.len);
+		printf(", ");
+		print_args(args->hex_dump.ascii);
+		printf(")");
+		break;
 	case TEP_PRINT_STRING:
 	case TEP_PRINT_BSTRING:
 		printf("__get_str(%s)", args->string.string);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index b77837f..9d4482f 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -213,6 +213,16 @@ struct tep_print_arg_int_array {
 	struct tep_print_arg	*el_size;
 };
 
+struct tep_print_arg_hex_dump {
+	struct tep_print_arg	*prefix_str;
+	struct tep_print_arg	*prefix_type;
+	struct tep_print_arg	*rowsize;
+	struct tep_print_arg	*groupsize;
+	struct tep_print_arg	*buf;
+	struct tep_print_arg	*len;
+	struct tep_print_arg	*ascii;
+};
+
 struct tep_print_arg_dynarray {
 	struct tep_format_field	*field;
 	struct tep_print_arg	*index;
@@ -242,6 +252,7 @@ enum tep_print_arg_type {
 	TEP_PRINT_SYMBOL,
 	TEP_PRINT_HEX,
 	TEP_PRINT_INT_ARRAY,
+	TEP_PRINT_HEX_DUMP,
 	TEP_PRINT_TYPE,
 	TEP_PRINT_STRING,
 	TEP_PRINT_BSTRING,
@@ -264,6 +275,7 @@ struct tep_print_arg {
 		struct tep_print_arg_symbol	symbol;
 		struct tep_print_arg_hex	hex;
 		struct tep_print_arg_int_array	int_array;
+		struct tep_print_arg_hex_dump	hex_dump;
 		struct tep_print_arg_func	func;
 		struct tep_print_arg_string	string;
 		struct tep_print_arg_bitmask	bitmask;
diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index 8d5ecd2..05e5700 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -247,3 +247,95 @@ int trace_seq_do_printf(struct trace_seq *s)
 {
 	return trace_seq_do_fprintf(s, stdout);
 }
+
+enum {
+	DUMP_PREFIX_NONE,
+	DUMP_PREFIX_ADDRESS,
+	DUMP_PREFIX_OFFSET
+};
+
+int hex_dump_line(const unsigned char *buf, size_t len, int rowsize,
+		  int groupsize, struct trace_seq *s, bool ascii)
+{
+	unsigned long long val;
+	int i, ret, pos = 0;
+	const char *format;
+	int ascii_pos = rowsize * 2 + rowsize / groupsize + 1;
+
+	len = min(len, (size_t)rowsize);
+	if ((groupsize != 2 && groupsize != 4 && groupsize != 8)
+	    || (len % groupsize) != 0) {
+		groupsize = 1;
+	}
+
+	for (i = 0; i < len / groupsize; i++) {
+		if (groupsize == 8) {
+			const unsigned long long *ptr8 = (void *)buf;
+
+			val = *(ptr8 + i);
+			format = "%s%16.16llx";
+		} else if (groupsize == 4) {
+			const unsigned int *ptr4 = (void *)buf;
+
+			val = *(ptr4 + i);
+			format = "%s%8.8x";
+		} else if (groupsize == 2) {
+			const unsigned short *ptr2 = (void *)buf;
+
+			val = *(ptr2 + i);
+			format = "%s%4.4x";
+		} else {
+			const unsigned char *ptr1 = (void *)buf;
+
+			val = *(ptr1 + i);
+			format = "%s%2.2x";
+		}
+		ret = trace_seq_printf(s,
+			       format, i ? " " : "",
+			       val);
+		if (ret <= 0)
+			return ret;
+		pos += ret;
+	}
+	if (!ascii)
+		return 0;
+	ret = trace_seq_printf(s, "%*s", ascii_pos - pos, "");
+	if (ret <= 0)
+		return ret;
+	for (i = 0; i < len; i++)
+		trace_seq_putc(s, (isprint(buf[i])) ? buf[i] : '.');
+	return 0;
+}
+
+int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
+		       int prefix_type, int rowsize, int groupsize,
+		       const void *buf, size_t len, int ascii)
+{
+	const unsigned char *ptr = buf;
+	int i, linelen, remaining = len;
+	int ret;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= linelen;
+
+		if (prefix_type == DUMP_PREFIX_ADDRESS)
+			ret = trace_seq_printf(s, "%s%p: ",
+					       prefix_str, ptr + i);
+		else if (prefix_type == DUMP_PREFIX_OFFSET)
+			ret = trace_seq_printf(s, "%s%.8x: ",
+					       prefix_str, i);
+		else
+			ret = trace_seq_printf(s, "%s",
+					       prefix_str);
+		if (ret <= 0)
+			return ret;
+		hex_dump_line(ptr + i, linelen, rowsize, groupsize,
+			      s, ascii);
+		trace_seq_putc(s, '\n');
+	}
+	return 0;
+}
diff --git a/tools/lib/traceevent/trace-seq.h b/tools/lib/traceevent/trace-seq.h
index d68ec69..7b7d72e 100644
--- a/tools/lib/traceevent/trace-seq.h
+++ b/tools/lib/traceevent/trace-seq.h
@@ -51,5 +51,8 @@ extern void trace_seq_terminate(struct trace_seq *s);
 
 extern int trace_seq_do_fprintf(struct trace_seq *s, FILE *fp);
 extern int trace_seq_do_printf(struct trace_seq *s);
+extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
+			      int prefix_type, int rowsize, int groupsize,
+			      const void *buf, size_t len, int ascii);
 
 #endif /* _TRACE_SEQ_H */
-- 
2.7.4

