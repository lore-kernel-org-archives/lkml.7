Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44719C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271652064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfHPMYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:24:55 -0400
Received: from foss.arm.com ([217.140.110.172]:55836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfHPMYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:24:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4B01570;
        Fri, 16 Aug 2019 05:24:52 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A36833F706;
        Fri, 16 Aug 2019 05:24:51 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC v4 09/18] gcc-plugins: objtool: Add plugin to detect switch table on arm64
Date:   Fri, 16 Aug 2019 13:23:54 +0100
Message-Id: <20190816122403.14994-10-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This plugins comes into play before the final 2 RTL passes of GCC and
detects switch-tables that are to be outputed in the ELF and writes
information in an "objtool_data" section which will be used by objtool.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 scripts/Makefile.gcc-plugins                  |  2 +
 scripts/gcc-plugins/Kconfig                   |  9 +++
 .../arm64_switch_table_detection_plugin.c     | 58 +++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 5f7df50cfe7a..a56736df9dc2 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -44,6 +44,8 @@ ifdef CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK
 endif
 export DISABLE_ARM_SSP_PER_TASK_PLUGIN
 
+gcc-plugin-$(CONFIG_GCC_PLUGIN_SWITCH_TABLES)	+= arm64_switch_table_detection_plugin.so
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index d33de0b9f4f5..1daeffb55dce 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -113,4 +113,13 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
 
+config GCC_PLUGIN_SWITCH_TABLES
+	bool "GCC Plugin: Identify switch tables at compile time"
+	default y
+	depends on STACK_VALIDATION && ARM64
+	help
+	  Plugin to identify switch tables generated at compile time and store
+	  them in a .objtool_data section. Objtool will then use that section
+	  to analyse the different execution path of the switch table.
+
 endmenu
diff --git a/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c b/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
new file mode 100644
index 000000000000..d7f0e13910d5
--- /dev/null
+++ b/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include "gcc-common.h"
+
+__visible int plugin_is_GPL_compatible;
+
+static unsigned int arm64_switchtbl_rtl_execute(void)
+{
+	rtx_insn *insn;
+	rtx_insn *labelp = NULL;
+	rtx_jump_table_data *tablep = NULL;
+	section *sec = get_section(".objtool_data", SECTION_STRINGS, NULL);
+	section *curr_sec = current_function_section();
+
+	for (insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		/*
+		 * Find a tablejump_p INSN (using a dispatch table)
+		 */
+		if (!tablejump_p(insn, &labelp, &tablep))
+			continue;
+
+		if (labelp && tablep) {
+			switch_to_section(sec);
+			assemble_integer_with_op(".quad ", gen_rtx_LABEL_REF(Pmode, labelp));
+			assemble_integer_with_op(".quad ", GEN_INT(GET_NUM_ELEM(tablep->get_labels())));
+			assemble_integer_with_op(".quad ", GEN_INT(ADDR_DIFF_VEC_FLAGS(tablep).offset_unsigned));
+			switch_to_section(curr_sec);
+		}
+	}
+	return 0;
+}
+
+#define PASS_NAME arm64_switchtbl_rtl
+
+#define NO_GATE
+#include "gcc-generate-rtl-pass.h"
+
+__visible int plugin_init(struct plugin_name_args *plugin_info,
+			  struct plugin_gcc_version *version)
+{
+	const char * const plugin_name = plugin_info->base_name;
+	int tso = 0;
+	int i;
+
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		error(G_("incompatible gcc/plugin versions"));
+		return 1;
+	}
+
+	PASS_INFO(arm64_switchtbl_rtl, "outof_cfglayout", 1,
+		  PASS_POS_INSERT_AFTER);
+
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  NULL, &arm64_switchtbl_rtl_pass_info);
+
+	return 0;
+}
-- 
2.17.1

