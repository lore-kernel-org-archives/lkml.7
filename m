Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B6C2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="acbiimxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfC0BsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:48:22 -0400
Received: from chill.innovation.ch ([216.218.245.220]:48350 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731934AbfC0BsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:48:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 1FCD2640142;
        Tue, 26 Mar 2019 18:48:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dzsrBp4skozY; Tue, 26 Mar 2019 18:48:17 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch D25D1640132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553651296;
        bh=ZOYKOCOCagszNyNYoqWohIc3ssKVCHQF6EgvwCGGM94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acbiimxhiIuTYTk7qSZiX++6Ft4hROOoeC5zYvzY82Up3ZhqSln0JbgAE1rJLQ8X1
         EVYWlGn+Q7q4/EipGKDW0EyeUorBhx0DFVcNU9IN3rntYr8PK6e3rXVB6RQ9OI6Qsa
         3o5ySye+Eiq9zgBv1mSw0IumGZ9TuTzWe8Cmpo0LzDaRgXCtGygi2mY3ySR6n8urUA
         K7eF1XVGQ42FV91Syx6YvZEGdhE4YJWbJm6bBqBTvhZdGK0MQJpm6KzNBlsZGQK7v8
         WlEO9fUGjFqq12DqzmmK53z8sqq+P8L6XqQi65llIsrnKXIPUkdWIfRKh0nSyG5dEr
         lYZqbKfPeJCSg==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] lib/hexdump.c: factor out generic hexdump formatting for reuse.
Date:   Tue, 26 Mar 2019 18:48:05 -0700
Message-Id: <20190327014807.7472-3-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327014807.7472-1-ronald@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces print_hex_dump_to_cb() which contains all the hexdump
formatting minus the actual printk() call, allowing an arbitrary print
function to be supplied instead. And print_hex_dump() is re-implemented
using print_hex_dump_to_cb().

This allows other hex-dump logging functions to be provided which call
printk() differently or even log the hexdump somewhere entirely
different.
---
 include/linux/printk.h | 12 ++++++
 lib/hexdump.c          | 95 +++++++++++++++++++++++++++++++-----------
 2 files changed, 83 insertions(+), 24 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a506ebb..4ebdacd7a287 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -483,10 +483,16 @@ enum {
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
 			      bool ascii);
+typedef
+void (*hex_dump_callback)(const char *level, void *arg, const char *fmt, ...);
 #ifdef CONFIG_PRINTK
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
 			   const void *buf, size_t len, bool ascii);
+extern void print_hex_dump_to_cb(const char *level, const char *prefix_str,
+				 int prefix_type, int rowsize, int groupsize,
+				 const void *buf, size_t len, bool ascii,
+				 hex_dump_callback print, void *print_arg);
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
 	dynamic_hex_dump(prefix_str, prefix_type, 16, 1, buf, len, true)
@@ -500,6 +506,12 @@ static inline void print_hex_dump(const char *level, const char *prefix_str,
 				  const void *buf, size_t len, bool ascii)
 {
 }
+extern void print_hex_dump_to_cb(const char *level, const char *prefix_str,
+				 int prefix_type, int rowsize, int groupsize,
+				 const void *buf, size_t len, bool ascii,
+				 hex_dump_callback *print, void *print_arg);
+{
+}
 static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 					const void *buf, size_t len)
 {
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 81b70ed37209..43583cf6accd 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -210,7 +210,8 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
 
 #ifdef CONFIG_PRINTK
 /**
- * print_hex_dump - print a text hex dump to syslog for a binary blob of data
+ * print_hex_dump_to_cb - print a text hex dump using given callback for a
+ * binary blob of data
  * @level: kernel log level (e.g. KERN_DEBUG)
  * @prefix_str: string to prefix each line with;
  *  caller supplies trailing spaces for alignment if desired
@@ -221,28 +222,18 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
  * @ascii: include ASCII after the hex output
+ * @print: the print function, called once for each line
+ * @print_arg: an arbitrary argument to pass to the print function
  *
- * Given a buffer of u8 data, print_hex_dump() prints a hex + ASCII dump
- * to the kernel log at the specified kernel log level, with an optional
- * leading prefix.
- *
- * print_hex_dump() works on one "line" of output at a time, i.e.,
- * 16 or 32 bytes of input data converted to hex + ASCII output.
- * print_hex_dump() iterates over the entire input @buf, breaking it into
- * "line size" chunks to format and print.
- *
- * E.g.:
- *   print_hex_dump(KERN_DEBUG, "raw data: ", DUMP_PREFIX_ADDRESS,
- *		    16, 1, frame->data, frame->len, true);
+ * This is a low level helper function - normally you want to use
+ * print_hex_dump() or other wrapper around it.
  *
- * Example output using %DUMP_PREFIX_OFFSET and 1-byte mode:
- * 0009ab42: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
- * Example output using %DUMP_PREFIX_ADDRESS and 4-byte mode:
- * ffffffff88089af0: 73727170 77767574 7b7a7978 7f7e7d7c  pqrstuvwxyz{|}~.
+ * See print_hex_dump() for more details and examples.
  */
-void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
-		    int rowsize, int groupsize,
-		    const void *buf, size_t len, bool ascii)
+void print_hex_dump_to_cb(const char *level, const char *prefix_str,
+			  int prefix_type, int rowsize, int groupsize,
+			  const void *buf, size_t len, bool ascii,
+			  hex_dump_callback print, void *print_arg)
 {
 	const u8 *ptr = buf;
 	int i, linelen, remaining = len;
@@ -260,18 +251,74 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 
 		switch (prefix_type) {
 		case DUMP_PREFIX_ADDRESS:
-			printk("%s%s%p: %s\n",
-			       level, prefix_str, ptr + i, linebuf);
+			print(level, print_arg, "%s%p: %s\n", prefix_str,
+			      ptr + i, linebuf);
 			break;
 		case DUMP_PREFIX_OFFSET:
-			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
+			print(level, print_arg, "%s%.8x: %s\n", prefix_str, i,
+			      linebuf);
 			break;
 		default:
-			printk("%s%s%s\n", level, prefix_str, linebuf);
+			print(level, print_arg, "%s%s\n", prefix_str, linebuf);
 			break;
 		}
 	}
 }
+EXPORT_SYMBOL(print_hex_dump_to_cb);
+
+static void print_to_printk(const char *level, void *arg, const char *fmt, ...)
+{
+	va_list args;
+	struct va_format vaf;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	printk("%s%pV", level, &vaf);
+
+	va_end(args);
+}
+
+/**
+ * print_hex_dump - print a text hex dump to syslog for a binary blob of data
+ * @level: kernel log level (e.g. KERN_DEBUG)
+ * @prefix_str: string to prefix each line with;
+ *  caller supplies trailing spaces for alignment if desired
+ * @prefix_type: controls whether prefix of an offset, address, or none
+ *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ * @ascii: include ASCII after the hex output
+ *
+ * Given a buffer of u8 data, print_hex_dump() prints a hex + ASCII dump
+ * to the kernel log at the specified kernel log level, with an optional
+ * leading prefix.
+ *
+ * print_hex_dump() works on one "line" of output at a time, i.e.,
+ * 16 or 32 bytes of input data converted to hex + ASCII output.
+ * print_hex_dump() iterates over the entire input @buf, breaking it into
+ * "line size" chunks to format and print.
+ *
+ * E.g.:
+ *   print_hex_dump(KERN_DEBUG, "raw data: ", DUMP_PREFIX_ADDRESS,
+ *		    16, 1, frame->data, frame->len, true);
+ *
+ * Example output using %DUMP_PREFIX_OFFSET and 1-byte mode:
+ * 0009ab42: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
+ * Example output using %DUMP_PREFIX_ADDRESS and 4-byte mode:
+ * ffffffff88089af0: 73727170 77767574 7b7a7978 7f7e7d7c  pqrstuvwxyz{|}~.
+ */
+void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
+		    int rowsize, int groupsize,
+		    const void *buf, size_t len, bool ascii)
+{
+	print_hex_dump_to_cb(level, prefix_str, prefix_type, rowsize, groupsize,
+			     buf, len, ascii, print_to_printk, NULL);
+}
 EXPORT_SYMBOL(print_hex_dump);
 
 #if !defined(CONFIG_DYNAMIC_DEBUG)
-- 
2.20.1

