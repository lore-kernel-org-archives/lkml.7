Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C063C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7F20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKNSTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbfKNSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91A0208CC;
        Thu, 14 Nov 2019 18:18:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhL-0001D7-W3; Thu, 14 Nov 2019 13:18:27 -0500
Message-Id: <20191114181827.876046454@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:18:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [for-next][PATCH 31/33] seq_buf: Add printing formatted hex dumps
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>

Provided function is an analogue of print_hex_dump().

Implementing this function in seq_buf allows using for multiple
purposes (e.g. for tracing) and therefore prevents from code duplication
in every layer that uses seq_buf.

print_hex_dump() is an essential part of logging data to dmesg. Adding
similar capability for other purposes is beneficial to all users.

Example usage:
seq_buf_hex_dump(seq, "", DUMP_PREFIX_OFFSET, 16, 4, buf,
		 ARRAY_SIZE(buf), true);
Example output:
00000000: 00000000 ffffff10 ffffff32 ffff3210  ........2....2..
00000010: ffff3210 83d00437 c0700000 00000000  .2..7.....p.....
00000020: 02010004 0000000f 0000000f 00004002  .............@..
00000030: 00000fff 00000000                    ........

Link: http://lkml.kernel.org/r/1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h |  3 ++
 lib/seq_buf.c           | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index aa5deb041c25..fb0205d87d3c 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -125,6 +125,9 @@ extern int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len);
 extern int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 			      unsigned int len);
 extern int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc);
+extern int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str,
+			    int prefix_type, int rowsize, int groupsize,
+			    const void *buf, size_t len, bool ascii);
 
 #ifdef CONFIG_BINARY_PRINTF
 extern int
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index bd807f545a9d..4e865d42ab03 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -328,3 +328,65 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
 	s->readpos += cnt;
 	return cnt;
 }
+
+/**
+ * seq_buf_hex_dump - print formatted hex dump into the sequence buffer
+ * @s: seq_buf descriptor
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
+ * Function is an analogue of print_hex_dump() and thus has similar interface.
+ *
+ * linebuf size is maximal length for one line.
+ * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
+ *	separating space
+ * 2 - spaces separating hex dump and ascii representation
+ * 32 - ascii representation
+ * 1 - terminating '\0'
+ *
+ * Returns zero on success, -1 on overflow
+ */
+int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
+		     int rowsize, int groupsize,
+		     const void *buf, size_t len, bool ascii)
+{
+	const u8 *ptr = buf;
+	int i, linelen, remaining = len;
+	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+	int ret;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+				   linebuf, sizeof(linebuf), ascii);
+
+		switch (prefix_type) {
+		case DUMP_PREFIX_ADDRESS:
+			ret = seq_buf_printf(s, "%s%p: %s\n",
+			       prefix_str, ptr + i, linebuf);
+			break;
+		case DUMP_PREFIX_OFFSET:
+			ret = seq_buf_printf(s, "%s%.8x: %s\n",
+					     prefix_str, i, linebuf);
+			break;
+		default:
+			ret = seq_buf_printf(s, "%s%s\n", prefix_str, linebuf);
+			break;
+		}
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
-- 
2.23.0


