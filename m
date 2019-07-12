Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9010C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877192080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfGLRVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbfGLRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:21:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54693AFAB;
        Fri, 12 Jul 2019 17:21:11 +0000 (UTC)
From:   Petr Tesarik <ptesarik@suse.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] init: Separate banner from init_uts_ns
Date:   Fri, 12 Jul 2019 19:21:00 +0200
Message-Id: <ba55d42e6dfb76229d85366dcb44b9e208df40d6.1562950641.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1562950641.git.ptesarik@suse.com>
References: <cover.1562950641.git.ptesarik@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux banner is self-contained, so it could be theoretically
added to separately linked binaries (e.g. the kernel decompressor).
Unfortunately, it lives in the same object file as init_uts_ns,
which needs additional symbols from other object files.

Let's divorce the two.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 init/Makefile  |  2 +-
 init/banner.c  | 21 +++++++++++++++++++++
 init/version.c | 10 ----------
 3 files changed, 22 insertions(+), 11 deletions(-)
 create mode 100644 init/banner.c

diff --git a/init/Makefile b/init/Makefile
index a3e5ce2bcf08..5009ea808ce4 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -5,7 +5,7 @@
 
 ccflags-y := -fno-function-sections -fno-data-sections
 
-obj-y                          := main.o version.o mounts.o
+obj-y                          := main.o version.o banner.o mounts.o
 ifneq ($(CONFIG_BLK_DEV_INITRD),y)
 obj-y                          += noinitramfs.o
 else
diff --git a/init/banner.c b/init/banner.c
new file mode 100644
index 000000000000..653ee081d474
--- /dev/null
+++ b/init/banner.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  linux/init/banner.c
+ *
+ *  Copyright (C) 1992  Theodore Ts'o
+ *
+ *  May be freely distributed as part of Linux.
+ */
+
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
+
+/* FIXED STRINGS! Don't touch! */
+const char linux_banner[] =
+	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
+	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+
+const char linux_proc_banner[] =
+	"%s version %s"
+	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
+	" (" LINUX_COMPILER ") %s\n";
diff --git a/init/version.c b/init/version.c
index cba341161b58..989cf9f9fe2c 100644
--- a/init/version.c
+++ b/init/version.c
@@ -42,14 +42,4 @@ struct uts_namespace init_uts_ns = {
 };
 EXPORT_SYMBOL_GPL(init_uts_ns);
 
-/* FIXED STRINGS! Don't touch! */
-const char linux_banner[] =
-	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
-
-const char linux_proc_banner[] =
-	"%s version %s"
-	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
-	" (" LINUX_COMPILER ") %s\n";
-
 BUILD_SALT;
-- 
2.16.4

