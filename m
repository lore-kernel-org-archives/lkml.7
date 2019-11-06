Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8AAC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50D5217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfKFG3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:29:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:24752 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKFG3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:29:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 22:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="376952022"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2019 22:29:41 -0800
From:   Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, andriy.shevchenko@intel.com,
        cezary.rojewski@intel.com, gustaw.lewandowski@intel.com,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Subject: [PATCH 1/2] seq_buf: Add printing formatted hex dumps
Date:   Wed,  6 Nov 2019 07:27:39 +0100
Message-Id: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provided function is an analogue of print_hex_dump().

Implementing this function in seq_buf allows using for multiple
purposes (e.g. for tracing) and therefore prevents from code duplication
in every layer that uses seq_buf.

print_hex_dump() is an essential part of logging data to dmesg. Adding
similar capability for other purposes is beneficial to all users.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/seq_buf.h |  3 +++
 lib/seq_buf.c           | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index aa5deb0..fb0205d 100644
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
index bd807f5..0509706 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -328,3 +328,41 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
 	s->readpos += cnt;
 	return cnt;
 }
+
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
2.7.4

