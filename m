Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292EC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31A6206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575920007;
	bh=n5SbiNuR8YYIXQCgU3Bd9wub+TDmfVccTlgdt6L9yZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1dRKSIKz9xWZVRU4z1KGuE7KFMCbDISeCOL9FiLtOO95M6CQrF6oykzR/vjQDOeAb
	 8APGNNcPKWzwNBYOtmjAQQyZWNnsMIn++XlNixFkSX2yD/EsbgSSQVyR1M8NMwU9jo
	 YV3rScv/7pczYVezB04j0Kr6myeU7quEQKQM+iLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLITdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfLITdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:33:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFDF206E0;
        Mon,  9 Dec 2019 19:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575920002;
        bh=n5SbiNuR8YYIXQCgU3Bd9wub+TDmfVccTlgdt6L9yZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyYfE45xb5qqFfV3oHKgiAX/8ClPOzIJNwqs5P9XcQb8DTUFDw8hLuxgsr6y2LlOv
         RYLnG7hHluk7AtiaXJZf6J3EFCNZxDoJeaqbQuJ7AB933KmwcFj0Z3GAyiJZ7fMoVL
         1Qr5V77G2ie2TMu4HqTs97GeLQNW1L1YnY56nZlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/6] device.h: move dev_printk()-like functions to dev_printk.h
Date:   Mon,  9 Dec 2019 20:33:00 +0100
Message-Id: <20191209193303.1694546-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
References: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device.h has everything and the kitchen sink when it comes to struct
device things, so split out the printk-specific things to a separate .h
file to make things easier to maintain and manage over time.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/dev_printk.h | 235 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h     | 217 +---------------------------------
 2 files changed, 236 insertions(+), 216 deletions(-)
 create mode 100644 include/linux/dev_printk.h

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
new file mode 100644
index 000000000000..5aad06b4ca7b
--- /dev/null
+++ b/include/linux/dev_printk.h
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dev_printk.h - printk messages helpers for devices
+ *
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2004-2009 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2008-2009 Novell Inc.
+ *
+ */
+
+#ifndef _DEVICE_PRINTK_H_
+#define _DEVICE_PRINTK_H_
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/ratelimit.h>
+
+#ifndef dev_fmt
+#define dev_fmt(fmt) fmt
+#endif
+
+struct device;
+
+#ifdef CONFIG_PRINTK
+
+__printf(3, 0) __cold
+int dev_vprintk_emit(int level, const struct device *dev,
+		     const char *fmt, va_list args);
+__printf(3, 4) __cold
+int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...);
+
+__printf(3, 4) __cold
+void dev_printk(const char *level, const struct device *dev,
+		const char *fmt, ...);
+__printf(2, 3) __cold
+void _dev_emerg(const struct device *dev, const char *fmt, ...);
+__printf(2, 3) __cold
+void _dev_alert(const struct device *dev, const char *fmt, ...);
+__printf(2, 3) __cold
+void _dev_crit(const struct device *dev, const char *fmt, ...);
+__printf(2, 3) __cold
+void _dev_err(const struct device *dev, const char *fmt, ...);
+__printf(2, 3) __cold
+void _dev_warn(const struct device *dev, const char *fmt, ...);
+__printf(2, 3) __cold
+void _dev_notice(const struct device *dev, const char *fmt, ...);
+__printf(2, 3) __cold
+void _dev_info(const struct device *dev, const char *fmt, ...);
+
+#else
+
+static inline __printf(3, 0)
+int dev_vprintk_emit(int level, const struct device *dev,
+		     const char *fmt, va_list args)
+{ return 0; }
+static inline __printf(3, 4)
+int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...)
+{ return 0; }
+
+static inline void __dev_printk(const char *level, const struct device *dev,
+				struct va_format *vaf)
+{}
+static inline __printf(3, 4)
+void dev_printk(const char *level, const struct device *dev,
+		 const char *fmt, ...)
+{}
+
+static inline __printf(2, 3)
+void _dev_emerg(const struct device *dev, const char *fmt, ...)
+{}
+static inline __printf(2, 3)
+void _dev_crit(const struct device *dev, const char *fmt, ...)
+{}
+static inline __printf(2, 3)
+void _dev_alert(const struct device *dev, const char *fmt, ...)
+{}
+static inline __printf(2, 3)
+void _dev_err(const struct device *dev, const char *fmt, ...)
+{}
+static inline __printf(2, 3)
+void _dev_warn(const struct device *dev, const char *fmt, ...)
+{}
+static inline __printf(2, 3)
+void _dev_notice(const struct device *dev, const char *fmt, ...)
+{}
+static inline __printf(2, 3)
+void _dev_info(const struct device *dev, const char *fmt, ...)
+{}
+
+#endif
+
+/*
+ * #defines for all the dev_<level> macros to prefix with whatever
+ * possible use of #define dev_fmt(fmt) ...
+ */
+
+#define dev_emerg(dev, fmt, ...)					\
+	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_crit(dev, fmt, ...)						\
+	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_alert(dev, fmt, ...)					\
+	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_err(dev, fmt, ...)						\
+	_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_warn(dev, fmt, ...)						\
+	_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_notice(dev, fmt, ...)					\
+	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_info(dev, fmt, ...)						\
+	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define dev_dbg(dev, fmt, ...)						\
+	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#elif defined(DEBUG)
+#define dev_dbg(dev, fmt, ...)						\
+	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#else
+#define dev_dbg(dev, fmt, ...)						\
+({									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+})
+#endif
+
+#ifdef CONFIG_PRINTK
+#define dev_level_once(dev_level, dev, fmt, ...)			\
+do {									\
+	static bool __print_once __read_mostly;				\
+									\
+	if (!__print_once) {						\
+		__print_once = true;					\
+		dev_level(dev, fmt, ##__VA_ARGS__);			\
+	}								\
+} while (0)
+#else
+#define dev_level_once(dev_level, dev, fmt, ...)			\
+do {									\
+	if (0)								\
+		dev_level(dev, fmt, ##__VA_ARGS__);			\
+} while (0)
+#endif
+
+#define dev_emerg_once(dev, fmt, ...)					\
+	dev_level_once(dev_emerg, dev, fmt, ##__VA_ARGS__)
+#define dev_alert_once(dev, fmt, ...)					\
+	dev_level_once(dev_alert, dev, fmt, ##__VA_ARGS__)
+#define dev_crit_once(dev, fmt, ...)					\
+	dev_level_once(dev_crit, dev, fmt, ##__VA_ARGS__)
+#define dev_err_once(dev, fmt, ...)					\
+	dev_level_once(dev_err, dev, fmt, ##__VA_ARGS__)
+#define dev_warn_once(dev, fmt, ...)					\
+	dev_level_once(dev_warn, dev, fmt, ##__VA_ARGS__)
+#define dev_notice_once(dev, fmt, ...)					\
+	dev_level_once(dev_notice, dev, fmt, ##__VA_ARGS__)
+#define dev_info_once(dev, fmt, ...)					\
+	dev_level_once(dev_info, dev, fmt, ##__VA_ARGS__)
+#define dev_dbg_once(dev, fmt, ...)					\
+	dev_level_once(dev_dbg, dev, fmt, ##__VA_ARGS__)
+
+#define dev_level_ratelimited(dev_level, dev, fmt, ...)			\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	if (__ratelimit(&_rs))						\
+		dev_level(dev, fmt, ##__VA_ARGS__);			\
+} while (0)
+
+#define dev_emerg_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_emerg, dev, fmt, ##__VA_ARGS__)
+#define dev_alert_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_alert, dev, fmt, ##__VA_ARGS__)
+#define dev_crit_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_crit, dev, fmt, ##__VA_ARGS__)
+#define dev_err_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
+#define dev_warn_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
+#define dev_notice_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
+#define dev_info_ratelimited(dev, fmt, ...)				\
+	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
+#if defined(CONFIG_DYNAMIC_DEBUG)
+/* descriptor check is first to prevent flooding with "callbacks suppressed" */
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
+	    __ratelimit(&_rs))						\
+		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
+				  ##__VA_ARGS__);			\
+} while (0)
+#elif defined(DEBUG)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	if (__ratelimit(&_rs))						\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+} while (0)
+#else
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+do {									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+} while (0)
+#endif
+
+#ifdef VERBOSE_DEBUG
+#define dev_vdbg	dev_dbg
+#else
+#define dev_vdbg(dev, fmt, ...)						\
+({									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+})
+#endif
+
+/*
+ * dev_WARN*() acts like dev_printk(), but with the key difference of
+ * using WARN/WARN_ONCE to include file/line information and a backtrace.
+ */
+#define dev_WARN(dev, format, arg...) \
+	WARN(1, "%s %s: " format, dev_driver_string(dev), dev_name(dev), ## arg);
+
+#define dev_WARN_ONCE(dev, condition, format, arg...) \
+	WARN_ONCE(condition, "%s %s: " format, \
+			dev_driver_string(dev), dev_name(dev), ## arg)
+
+#endif /* _DEVICE_PRINTK_H_ */
diff --git a/include/linux/device.h b/include/linux/device.h
index 3daec3af1753..7a00f25efef7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -12,6 +12,7 @@
 #ifndef _DEVICE_H_
 #define _DEVICE_H_
 
+#include <linux/dev_printk.h>
 #include <linux/ioport.h>
 #include <linux/kobject.h>
 #include <linux/klist.h>
@@ -22,7 +23,6 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/atomic.h>
-#include <linux/ratelimit.h>
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
@@ -1683,221 +1683,6 @@ void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
-#ifndef dev_fmt
-#define dev_fmt(fmt) fmt
-#endif
-
-#ifdef CONFIG_PRINTK
-
-__printf(3, 0) __cold
-int dev_vprintk_emit(int level, const struct device *dev,
-		     const char *fmt, va_list args);
-__printf(3, 4) __cold
-int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...);
-
-__printf(3, 4) __cold
-void dev_printk(const char *level, const struct device *dev,
-		const char *fmt, ...);
-__printf(2, 3) __cold
-void _dev_emerg(const struct device *dev, const char *fmt, ...);
-__printf(2, 3) __cold
-void _dev_alert(const struct device *dev, const char *fmt, ...);
-__printf(2, 3) __cold
-void _dev_crit(const struct device *dev, const char *fmt, ...);
-__printf(2, 3) __cold
-void _dev_err(const struct device *dev, const char *fmt, ...);
-__printf(2, 3) __cold
-void _dev_warn(const struct device *dev, const char *fmt, ...);
-__printf(2, 3) __cold
-void _dev_notice(const struct device *dev, const char *fmt, ...);
-__printf(2, 3) __cold
-void _dev_info(const struct device *dev, const char *fmt, ...);
-
-#else
-
-static inline __printf(3, 0)
-int dev_vprintk_emit(int level, const struct device *dev,
-		     const char *fmt, va_list args)
-{ return 0; }
-static inline __printf(3, 4)
-int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...)
-{ return 0; }
-
-static inline void __dev_printk(const char *level, const struct device *dev,
-				struct va_format *vaf)
-{}
-static inline __printf(3, 4)
-void dev_printk(const char *level, const struct device *dev,
-		 const char *fmt, ...)
-{}
-
-static inline __printf(2, 3)
-void _dev_emerg(const struct device *dev, const char *fmt, ...)
-{}
-static inline __printf(2, 3)
-void _dev_crit(const struct device *dev, const char *fmt, ...)
-{}
-static inline __printf(2, 3)
-void _dev_alert(const struct device *dev, const char *fmt, ...)
-{}
-static inline __printf(2, 3)
-void _dev_err(const struct device *dev, const char *fmt, ...)
-{}
-static inline __printf(2, 3)
-void _dev_warn(const struct device *dev, const char *fmt, ...)
-{}
-static inline __printf(2, 3)
-void _dev_notice(const struct device *dev, const char *fmt, ...)
-{}
-static inline __printf(2, 3)
-void _dev_info(const struct device *dev, const char *fmt, ...)
-{}
-
-#endif
-
-/*
- * #defines for all the dev_<level> macros to prefix with whatever
- * possible use of #define dev_fmt(fmt) ...
- */
-
-#define dev_emerg(dev, fmt, ...)					\
-	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_crit(dev, fmt, ...)						\
-	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_alert(dev, fmt, ...)					\
-	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_err(dev, fmt, ...)						\
-	_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_warn(dev, fmt, ...)						\
-	_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_notice(dev, fmt, ...)					\
-	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_info(dev, fmt, ...)						\
-	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
-
-#if defined(CONFIG_DYNAMIC_DEBUG)
-#define dev_dbg(dev, fmt, ...)						\
-	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#elif defined(DEBUG)
-#define dev_dbg(dev, fmt, ...)						\
-	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
-#else
-#define dev_dbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
-#endif
-
-#ifdef CONFIG_PRINTK
-#define dev_level_once(dev_level, dev, fmt, ...)			\
-do {									\
-	static bool __print_once __read_mostly;				\
-									\
-	if (!__print_once) {						\
-		__print_once = true;					\
-		dev_level(dev, fmt, ##__VA_ARGS__);			\
-	}								\
-} while (0)
-#else
-#define dev_level_once(dev_level, dev, fmt, ...)			\
-do {									\
-	if (0)								\
-		dev_level(dev, fmt, ##__VA_ARGS__);			\
-} while (0)
-#endif
-
-#define dev_emerg_once(dev, fmt, ...)					\
-	dev_level_once(dev_emerg, dev, fmt, ##__VA_ARGS__)
-#define dev_alert_once(dev, fmt, ...)					\
-	dev_level_once(dev_alert, dev, fmt, ##__VA_ARGS__)
-#define dev_crit_once(dev, fmt, ...)					\
-	dev_level_once(dev_crit, dev, fmt, ##__VA_ARGS__)
-#define dev_err_once(dev, fmt, ...)					\
-	dev_level_once(dev_err, dev, fmt, ##__VA_ARGS__)
-#define dev_warn_once(dev, fmt, ...)					\
-	dev_level_once(dev_warn, dev, fmt, ##__VA_ARGS__)
-#define dev_notice_once(dev, fmt, ...)					\
-	dev_level_once(dev_notice, dev, fmt, ##__VA_ARGS__)
-#define dev_info_once(dev, fmt, ...)					\
-	dev_level_once(dev_info, dev, fmt, ##__VA_ARGS__)
-#define dev_dbg_once(dev, fmt, ...)					\
-	dev_level_once(dev_dbg, dev, fmt, ##__VA_ARGS__)
-
-#define dev_level_ratelimited(dev_level, dev, fmt, ...)			\
-do {									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-	if (__ratelimit(&_rs))						\
-		dev_level(dev, fmt, ##__VA_ARGS__);			\
-} while (0)
-
-#define dev_emerg_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_emerg, dev, fmt, ##__VA_ARGS__)
-#define dev_alert_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_alert, dev, fmt, ##__VA_ARGS__)
-#define dev_crit_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_crit, dev, fmt, ##__VA_ARGS__)
-#define dev_err_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_err, dev, fmt, ##__VA_ARGS__)
-#define dev_warn_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
-#define dev_notice_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_notice, dev, fmt, ##__VA_ARGS__)
-#define dev_info_ratelimited(dev, fmt, ...)				\
-	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
-#if defined(CONFIG_DYNAMIC_DEBUG)
-/* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
-do {									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
-	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
-	    __ratelimit(&_rs))						\
-		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
-				  ##__VA_ARGS__);			\
-} while (0)
-#elif defined(DEBUG)
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
-do {									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,	\
-				      DEFAULT_RATELIMIT_BURST);		\
-	if (__ratelimit(&_rs))						\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-} while (0)
-#else
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
-do {									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-} while (0)
-#endif
-
-#ifdef VERBOSE_DEBUG
-#define dev_vdbg	dev_dbg
-#else
-#define dev_vdbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
-#endif
-
-/*
- * dev_WARN*() acts like dev_printk(), but with the key difference of
- * using WARN/WARN_ONCE to include file/line information and a backtrace.
- */
-#define dev_WARN(dev, format, arg...) \
-	WARN(1, "%s %s: " format, dev_driver_string(dev), dev_name(dev), ## arg);
-
-#define dev_WARN_ONCE(dev, condition, format, arg...) \
-	WARN_ONCE(condition, "%s %s: " format, \
-			dev_driver_string(dev), dev_name(dev), ## arg)
-
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.24.0

