Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8466C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A665C20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfDJPvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387528AbfDJPvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:51:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBFFD316891D;
        Wed, 10 Apr 2019 15:51:14 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95D841062225;
        Wed, 10 Apr 2019 15:51:13 +0000 (UTC)
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
Subject: [PATCH v3 7/9] livepatch: Add sample livepatch module
Date:   Wed, 10 Apr 2019 11:50:56 -0400
Message-Id: <20190410155058.9437-8-joe.lawrence@redhat.com>
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 10 Apr 2019 15:51:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add a new livepatch sample in samples/livepatch/ to make use of
symbols that must be post-processed to enable load-time relocation
resolution. As the new sample is to be used as an example, it is
annotated with KLP_MODULE_RELOC and with KLP_SYMPOS macros.

The livepatch sample updates the function cmdline_proc_show to
print the string referenced by the symbol saved_command_line
appended by the string "livepatch=1".

Update livepatch-sample.c to remove livepatch MODULE_INFO
statement.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Joao Moreira <jmoreira@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 samples/livepatch/Makefile                    |   2 +
 .../livepatch/livepatch-annotated-sample.c    | 102 ++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 samples/livepatch/livepatch-annotated-sample.c

diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
index 5fb3280bbdc4..dea530840725 100644
--- a/samples/livepatch/Makefile
+++ b/samples/livepatch/Makefile
@@ -2,6 +2,7 @@ LIVEPATCH_livepatch-sample := y
 LIVEPATCH_livepatch-shadow-fix1 := y
 LIVEPATCH_livepatch-shadow-fix2 := y
 LIVEPATCH_livepatch-callbacks-demo := y
+LIVEPATCH_livepatch-annotated-sample := y
 
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-sample.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o
@@ -10,3 +11,4 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
 obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
+obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-annotated-sample.o
diff --git a/samples/livepatch/livepatch-annotated-sample.c b/samples/livepatch/livepatch-annotated-sample.c
new file mode 100644
index 000000000000..556ce7e0bdab
--- /dev/null
+++ b/samples/livepatch/livepatch-annotated-sample.c
@@ -0,0 +1,102 @@
+/*
+ * livepatch-annotated-sample.c - Kernel Live Patching Sample Module
+ *
+ * Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+
+/*
+ * This (dumb) live patch overrides the function that prints the
+ * kernel boot cmdline when /proc/cmdline is read.
+ *
+ * This livepatch uses the symbol saved_command_line whose relocation
+ * must be resolved during load time. To enable that, this module
+ * must be post-processed by a tool called klp-convert, which embeds
+ * information to be used by the loader to solve the relocation.
+ *
+ * The module is annotated with KLP_MODULE_RELOC/KLP_SYMPOS macros.
+ * These annotations are used by klp-convert to infer that the symbol
+ * saved_command_line is in the object vmlinux.
+ *
+ * As saved_command_line has no other homonimous symbol across
+ * kernel objects, this annotation is not a requirement, and can be
+ * suppressed with no harm to klp-convert. Yet, it is kept here as an
+ * example on how to annotate livepatch modules that contain symbols
+ * whose names are used in more than one kernel object.
+ *
+ * Example:
+ *
+ * $ cat /proc/cmdline
+ * <your cmdline>
+ *
+ * $ insmod livepatch-sample.ko
+ * $ cat /proc/cmdline
+ * <your cmdline> livepatch=1
+ *
+ * $ echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled
+ * $ cat /proc/cmdline
+ * <your cmdline>
+ */
+
+extern char *saved_command_line;
+
+#include <linux/seq_file.h>
+static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s livepatch=1\n", saved_command_line);
+	return 0;
+}
+
+KLP_MODULE_RELOC(vmlinux) vmlinux_relocs[] = {
+	KLP_SYMPOS(saved_command_line, 0)
+};
+
+static struct klp_func funcs[] = {
+	{
+		.old_name = "cmdline_proc_show",
+		.new_func = livepatch_cmdline_proc_show,
+	}, { }
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int livepatch_init(void)
+{
+	return klp_enable_patch(&patch);
+}
+
+static void livepatch_exit(void)
+{
+}
+
+module_init(livepatch_init);
+module_exit(livepatch_exit);
+MODULE_LICENSE("GPL");
-- 
2.20.1

