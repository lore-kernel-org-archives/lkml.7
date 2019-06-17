Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3820C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BCF20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dI6NDUIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfFQWUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:20:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34172 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbfFQWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so18483480edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/V2r9j2gZVk1sA5eZyOyZ148EpYAOs3e61Sgdw5EMs=;
        b=dI6NDUItBQG57mwKO5FrrgxLQPD0rB5+WZpx17jnJbxmYZfReoAbrGeslSoXqxcewu
         ix86vBM4ZOE8qePDgqhVDlR7/rf0OsypiFFWU+dddH/bnIAWpP7q+RZlhEHCZBQbfeSU
         /ThksDc92j2cpRmjOYOtUgTupJRjzncOs/eAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/V2r9j2gZVk1sA5eZyOyZ148EpYAOs3e61Sgdw5EMs=;
        b=HFMXG/2JdgeO8LUHASELIFDfq91JcNeZq9orRIgcZ5+H6LVSI949lAd48aFwepaJLZ
         +ALOPu1gkCX/o50s4MyuiJqtVDgwOekyNx1/PfOMsnUcfulfnBLS/sSMuZP8qdVHqcxz
         qvE/uXjIF5C8RuIVIDzode7HoG/+sg0MvBTKQZMmHyTEl+OcSdc+vyxj9J0ghq6W29ZD
         WK1ekRvZCEu7/H92sIvXlZTExcOP1zL00wqA1hFEkc1bCeJwF2UzEa8r989hQoEYAFi2
         ZoCFSJM94Q4tU0fCeMFloPguSCybiut0aXdwJih0CCa6oeaMduM9zJax06XsAT+iiQJP
         miJA==
X-Gm-Message-State: APjAAAXTFEiRNnS9Be2C9lxvvd48UpzKoPwtunXF70qpNTcLjo2+MPiV
        pv09sFYuGwGAR2tqPLcu1qW3d/TUSewZB8GH
X-Google-Smtp-Source: APXvYqwOL+7hGg/9DZvz68/aGVpu4WHBV0NUHL7I2aAqSRumwmP1GizygDVm7L+Hu1lxuokKNUUh6A==
X-Received: by 2002:a17:906:bb11:: with SMTP id jz17mr29449461ejb.185.1560810049489;
        Mon, 17 Jun 2019 15:20:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 6/8] dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue, 18 Jun 2019 00:20:32 +0200
Message-Id: <20190617222034.10799-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the same idea for struct bug_entry, one can use relative
pointers in struct _ddebug. It only makes sense for 64 bit
architectures, where one saves 16 bytes per entry (out of 40 or 56,
depending on CONFIG_JUMP_LABEL).

Unlike the bug_entry case, this turns out not to work with some older
toolchains, so the actual config option must be set by the user and
not just selected by the various architectures. Still, the
architecture must select HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS and is
then responsible for providing a suitable
DEFINE_DYNAMIC_DEBUG_METADATA macro in <asm/dynamic_debug.h>.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 14 ++++++++++++++
 lib/Kconfig.debug             | 13 +++++++++++++
 lib/dynamic_debug.c           | 20 ++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7d6d0153096e..572921e880ec 100644
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
@@ -77,6 +84,12 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev,
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
@@ -87,6 +100,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.flags_lineno = _DPRINTK_FLAGS_LINENO_INIT,	\
 		_DPRINTK_KEY_INIT				\
 	}
+#endif
 
 #ifdef CONFIG_JUMP_LABEL
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cbdfae379896..f3d2e234c15f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -164,6 +164,19 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS
+	bool
+
+config DYNAMIC_DEBUG_RELATIVE_POINTERS
+	bool "Reduce size of dynamic debug metadata"
+	depends on DYNAMIC_DEBUG
+	depends on HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS
+	help
+	  If you say Y here, the static memory footprint of the kernel
+	  image will be reduced somewhat (about 40K for a typical
+	  distro kernel). There is no performance difference either
+	  way.
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3a1a80041cd6..f1646795692c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -39,6 +39,24 @@
 
 #include <rdma/ib_verbs.h>
 
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
@@ -55,6 +73,8 @@ static inline const char *dd_format(const struct _ddebug *dd)
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

