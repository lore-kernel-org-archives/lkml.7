Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC7020830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbfDJPvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45081 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387476AbfDJPvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:51:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13E6E6DDD6;
        Wed, 10 Apr 2019 15:51:06 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8045D1017B2E;
        Wed, 10 Apr 2019 15:51:04 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 1/9] livepatch: Create and include UAPI headers
Date:   Wed, 10 Apr 2019 11:50:50 -0400
Message-Id: <20190410155058.9437-2-joe.lawrence@redhat.com>
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 10 Apr 2019 15:51:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Define klp prefixes in include/uapi/linux/livepatch.h, and use them for
replacing hard-coded values in kernel/livepatch/core.c.

Update MAINTAINERS.

Note: Add defines to uapi as these are also to be used by a newly
introduced klp-convert script.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Joao Moreira <jmoreira@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 MAINTAINERS                    |  1 +
 include/linux/livepatch.h      |  1 +
 include/uapi/linux/livepatch.h | 17 +++++++++++++++++
 kernel/livepatch/core.c        |  4 ++--
 4 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/livepatch.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..65b4e8f481f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9017,6 +9017,7 @@ R:	Joe Lawrence <joe.lawrence@redhat.com>
 S:	Maintained
 F:	kernel/livepatch/
 F:	include/linux/livepatch.h
+F:	include/uapi/linux/livepatch.h
 F:	arch/x86/include/asm/livepatch.h
 F:	arch/x86/kernel/livepatch.c
 F:	Documentation/livepatch/
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 53551f470722..16b48e8b29a2 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -25,6 +25,7 @@
 #include <linux/ftrace.h>
 #include <linux/completion.h>
 #include <linux/list.h>
+#include <uapi/linux/livepatch.h>
 
 #if IS_ENABLED(CONFIG_LIVEPATCH)
 
diff --git a/include/uapi/linux/livepatch.h b/include/uapi/linux/livepatch.h
new file mode 100644
index 000000000000..bb86243de805
--- /dev/null
+++ b/include/uapi/linux/livepatch.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * livepatch.h - Kernel Live Patching Core
+ *
+ * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _UAPI_LIVEPATCH_H
+#define _UAPI_LIVEPATCH_H
+
+#include <linux/types.h>
+
+#define KLP_RELA_PREFIX		".klp.rela."
+#define KLP_SYM_PREFIX		".klp.sym."
+
+#endif /* _UAPI_LIVEPATCH_H */
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index eb0ee10a1981..3d9ed895b252 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -235,7 +235,7 @@ static int klp_resolve_symbols(Elf_Shdr *relasec, struct module *pmod)
 
 		/* Format: .klp.sym.objname.symname,sympos */
 		cnt = sscanf(strtab + sym->st_name,
-			     ".klp.sym.%55[^.].%127[^,],%lu",
+			     KLP_SYM_PREFIX "%55[^.].%127[^,],%lu",
 			     objname, symname, &sympos);
 		if (cnt != 3) {
 			pr_err("symbol %s has an incorrectly formatted name\n",
@@ -281,7 +281,7 @@ static int klp_write_object_relocations(struct module *pmod,
 		 * See comment in klp_resolve_symbols() for an explanation
 		 * of the selected field width value.
 		 */
-		cnt = sscanf(secname, ".klp.rela.%55[^.]", sec_objname);
+		cnt = sscanf(secname, KLP_RELA_PREFIX "%55[^.]", sec_objname);
 		if (cnt != 1) {
 			pr_err("section %s has an incorrectly formatted name\n",
 			       secname);
-- 
2.20.1

