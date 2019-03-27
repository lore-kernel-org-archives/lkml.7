Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA883C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970792146E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="cvXWhOTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbfC0Bs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:48:26 -0400
Received: from chill.innovation.ch ([216.218.245.220]:48406 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732447AbfC0BsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:48:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id BCA55640151;
        Tue, 26 Mar 2019 18:48:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DlDRI_dLx-6n; Tue, 26 Mar 2019 18:48:19 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 5FAD564013A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553651296;
        bh=DrQ/rdQ1ATrsLKUAaHVGRr9qTfe1CEwLc+OV1Wn7biY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvXWhOToTlUcLocKtDDNdRLEPWh8ydwtJGQ7oOcDiQh5CkXW1BtvgFSmDE/QV9633
         tdunPk7J8wn/CLb1kbqFRniBoD+2hFb2XsLoy1Zdix4txGFCU3OutwXfVkHWwqjXlM
         muFI0nxi/x0/xTAT2GLAGdGE/MDRpcvtz0lyFXO8euBoaTIJPPESWQxlTSxILXRtiO
         TdR0sJBFjvvc4KYj3AeCYkYoeZDQ4u0K6hFP6laY0FXrHdqPRK82ACIpJgJrzllZfF
         gtg9ooo8qaD8a7DW4N4Ovu9Rzsp9xc2j0JjnAH4YDe1vXBrXtE1CnfUbWak8lxlpYH
         gB3mf6b/ki/dQ==
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
Subject: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging function.
Date:   Tue, 26 Mar 2019 18:48:06 -0700
Message-Id: <20190327014807.7472-4-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327014807.7472-1-ronald@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
instead of straight printk() to match other dev_xxx() logging functions.
---
 drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 15 +++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0073b09bb99f..eb260d482750 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3097,6 +3097,49 @@ define_dev_printk_level(_dev_warn, KERN_WARNING);
 define_dev_printk_level(_dev_notice, KERN_NOTICE);
 define_dev_printk_level(_dev_info, KERN_INFO);
 
+static void
+print_to_dev_printk(const char *level, void *arg, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	__dev_printk(level, (const struct device *)arg, &vaf);
+
+	va_end(args);
+}
+
+/**
+ * _dev_print_hex_dump - print a text hex dump to syslog for a binary blob of
+ * data
+ * @level: kernel log level (e.g. KERN_DEBUG)
+ * @dev: the device to which this log message pertains
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
+ * See print_hex_dump() for additional details and examples.
+ */
+void _dev_print_hex_dump(const char *level, const struct device *dev,
+			 const char *prefix_str, int prefix_type,
+			 int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii)
+{
+	print_hex_dump_to_cb(level, prefix_str, prefix_type, rowsize, groupsize,
+			     buf, len, ascii, print_to_dev_printk, (void *)dev);
+}
+EXPORT_SYMBOL(_dev_print_hex_dump);
+
 #endif
 
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..dc6fcae3002a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1405,6 +1405,10 @@ __printf(2, 3)
 void _dev_notice(const struct device *dev, const char *fmt, ...);
 __printf(2, 3)
 void _dev_info(const struct device *dev, const char *fmt, ...);
+void _dev_print_hex_dump(const char *level, const struct device *dev,
+			 const char *prefix_str, int prefix_type,
+			 int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii);
 
 #else
 
@@ -1445,6 +1449,12 @@ void _dev_notice(const struct device *dev, const char *fmt, ...)
 static inline __printf(2, 3)
 void _dev_info(const struct device *dev, const char *fmt, ...)
 {}
+static inline
+void _dev_print_hex_dump(const char *level, const struct device *dev,
+			 const char *prefix_str, int prefix_type,
+			 int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii);
+{}
 
 #endif
 
@@ -1467,6 +1477,11 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
 #define dev_info(dev, fmt, ...)						\
 	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_print_hex_dump(level, dev, prefix_str, prefix_type,		\
+			   rowsize, groupsize, buf, len, ascii)		\
+	_dev_print_hex_dump(level, dev, dev_fmt(prefix_str),		\
+			    prefix_type, rowsize, groupsize, buf, len,	\
+			    ascii);
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define dev_dbg(dev, fmt, ...)						\
-- 
2.20.1

