Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552CDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F8220883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Q3/o2P/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDIV0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33205 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDIVZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:25:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so157433edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pvxkQyUAnqltiULwUqvTsk4ca9ur6o2LqkmGmDZivdQ=;
        b=Q3/o2P/LTinil0xEuw56y8/0ZdcgJYGdKduHUFl7ajjJd2714anBGA63CcGiHy+X5L
         8P+jIK/cKXd0qUaQUQWLdqRTPois44hhulAWMPL8p+xNvVvazNLMJqhAugdIquFs7xih
         QxX7HKpcLape6NkhENrQk5HTKo2TWvNXvCMe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvxkQyUAnqltiULwUqvTsk4ca9ur6o2LqkmGmDZivdQ=;
        b=ARAKGY0zCDyanGizgYdqyqBP4U5j1mH4YXYkBA81kQ1Lrq5CcNQk/EGkQhvGiI/JRV
         WU08ysVWCy6IV2YqDLI1sTC2VGwM5ICrPhOP61AJMR59HVocVOjiNWNmTBH0hR3Aeru2
         1n24e3U3elhXnGmmgjVE8sFpSkv4++yb0kD006M1tLdncnNSZh72p217THyjLRsUjEGF
         JDY21JMBpuTquZAfbkT+nXAx1sZVIrq+qUN9qPpyOm8eIwY7YnK+qm1xCUhvjtU2pP9p
         Fc/3mc4UZ+tNJ+HwJbhT7G8gjKpYlYJ1qAoxd/zw9bDF/naXQ70bA2SF7VGCt8vfiRdr
         hCuQ==
X-Gm-Message-State: APjAAAXhoIJ60fSAbPWpIbV77fpQyXPXkUMRJxLX6nA297uQu2gsuG9q
        iYIeClqp93wcxJeRxWKzEMBOYQ==
X-Google-Smtp-Source: APXvYqwceJfT6b2hv0+BIm6S4tNL24MjppTT8T4aXAL7wdLRZnEmd8B0Aw311IKrZtsKQHx3NiRrwg==
X-Received: by 2002:aa7:da13:: with SMTP id r19mr3170727eds.134.1554845156798;
        Tue, 09 Apr 2019 14:25:56 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 06/10] dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue,  9 Apr 2019 23:25:13 +0200
Message-Id: <20190409212517.7321-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the same idea for struct bug_entry, an architecture can opt-in
to use relative pointers in struct _ddebug. It only makes sense for 64
bit architectures, where one saves 16 bytes per entry (out of 40 or 56,
depending on CONFIG_JUMP_LABEL). The architecture is responsible for
providing a suitable DEFINE_DYNAMIC_DEBUG_METADATA macro in
<asm/dynamic_debug.h>.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 14 ++++++++++++++
 lib/Kconfig.debug             |  3 +++
 lib/dynamic_debug.c           | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e2fa2737a485..08175c219d60 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -16,10 +16,17 @@ struct _ddebug {
 	 * These fields are used to drive the user interface
 	 * for selecting and displaying debug callsites.
 	 */
+#ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+	signed int modname_disp;
+	signed int function_disp;
+	signed int filename_disp;
+	signed int format_disp;
+#else
 	const char *modname;
 	const char *function;
 	const char *filename;
 	const char *format;
+#endif
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -70,6 +77,12 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev,
 			  const char *fmt, ...);
 
+#ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+#include <asm/dynamic_debug.h>
+#ifndef DEFINE_DYNAMIC_DEBUG_METADATA
+# error "asm/dynamic_debug.h must provide definition of DEFINE_DYNAMIC_DEBUG_METADATA"
+#endif
+#else
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
 	static struct _ddebug  __aligned(8)			\
 	__attribute__((section("__verbose"))) name = {		\
@@ -80,6 +93,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		.flags_lineno = _DPRINTK_FLAGS_LINENO_INIT,	\
 		_DPRINTK_KEY_INIT				\
 	}
+#endif
 
 #ifdef CONFIG_JUMP_LABEL
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..7cee0895f9c8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -163,6 +163,9 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DYNAMIC_DEBUG_RELATIVE_POINTERS
+	bool
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 482a35a68752..58288560cc35 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,6 +37,24 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
+#ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+static inline const char *dd_modname(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->modname_disp;
+}
+static inline const char *dd_function(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->function_disp;
+}
+static inline const char *dd_filename(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->filename_disp;
+}
+static inline const char *dd_format(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->format_disp;
+}
+#else
 static inline const char *dd_modname(const struct _ddebug *dd)
 {
 	return dd->modname;
@@ -53,6 +71,8 @@ static inline const char *dd_format(const struct _ddebug *dd)
 {
 	return dd->format;
 }
+#endif
+
 static inline unsigned dd_lineno(const struct _ddebug *dd)
 {
 	return dd->flags_lineno >> 8;
-- 
2.20.1

