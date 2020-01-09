Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E0AC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8620661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODQVEDcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbgAIQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:08:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23136 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733254AbgAIQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdbyLSo/LKwv0IS4UY8BmEznN2tnAhqPqp9PsERe1ZM=;
        b=ODQVEDcgbOoiLXSv4Wy9tqRH7MSY4o2tXwWHHNQg0mSVcqfaWT4SLIAcj144wJI2BLxTwP
        dRgvLdq0Ksj1ZzAikgCaoO8mBERib7ETKq9bb8gVzYcCIbzM7GyYIwJqcfBltq1JN2LUXb
        4Y9GfVfa6q/vJmI0n2zJW6s9YmdW1p8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-vl6AkKC0OE2g2Qp_PWcN7w-1; Thu, 09 Jan 2020 11:08:22 -0500
X-MC-Unique: vl6AkKC0OE2g2Qp_PWcN7w-1
Received: by mail-wr1-f69.google.com with SMTP id r2so3049961wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XdbyLSo/LKwv0IS4UY8BmEznN2tnAhqPqp9PsERe1ZM=;
        b=GQBEBUz942VFLc25YJeUr/KVv5Jq1z8vpjJ10HZq9BdkxWVh+27JgWbE0iCfmYoU2O
         7LT7z+FrdpF3lstNDnhwoTyoxlP77GJLNywlWa7nghGc4Z28/ITLcBWS8lWV7CmPH7FD
         d747v62A5SNolFQih3JSCw+XS6+g1O09lX6ZccdB4YVzPGmbYXBseEKQxqA6iyndZ19L
         LGXlvhvXcSc7PdgGLXOBDxjN5kOH54nsF0Zh5Dj18TvAlU4Q2LLZbDET+TKa+vd/SuM4
         ahL/xq8/gSky1p77zxkmcnFWlakYWWQS+brDTtQjRq9xNdxA2PQtTj/PrhAyxe72y1w0
         M1Mw==
X-Gm-Message-State: APjAAAXDtEy/2RVkVaZikqPWTirhMq5luudbtTrHXTH483lAIx27Me64
        ggsao33C/EGMRM9f8bsyzOZIHz6ckFnKWzBMOk629cKp96OXMEMOLDjo1arZzSN/4Kh9s1jGXTC
        kRVDHN8mBWlSqe4koCbgly0Fz
X-Received: by 2002:a7b:c935:: with SMTP id h21mr5629111wml.173.1578586100903;
        Thu, 09 Jan 2020 08:08:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqybaGwF2SifAH/vF/5c/Zg4lZFldMQtCNPmw+l0nkZ5ezrMFKLX54upiO65e6Aqyi7sdLTdig==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr5629084wml.173.1578586100669;
        Thu, 09 Jan 2020 08:08:20 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m10sm8562605wrx.19.2020.01.09.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:20 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, linux-kbuild@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [RFC v5 43/57] gcc-plugins: objtool: Add plugin to detect switch table on arm64
Date:   Thu,  9 Jan 2020 16:02:46 +0000
Message-Id: <20200109160300.26150-44-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

This plugins comes into play before the final 2 RTL passes of GCC and
detects switch-tables that are to be outputed in the ELF and writes
information in an ".discard.switch_table_info" section which will be
used by objtool.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Change section name to store switch table information,
       Make plugin Kconfig be selected rather than opt-in by user,
       Add a relocation in the switch_table_info that points to
       the jump operation itself]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: linux-kbuild@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
---
 arch/arm64/Kconfig                            |  1 +
 scripts/Makefile.gcc-plugins                  |  2 +
 scripts/gcc-plugins/Kconfig                   |  4 +
 .../arm64_switch_table_detection_plugin.c     | 94 +++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1b4476ddb83..a7b2116d5d13 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -90,6 +90,7 @@ config ARM64
 	select DMA_DIRECT_REMAP
 	select EDAC_SUPPORT
 	select FRAME_POINTER
+	select GCC_PLUGIN_SWITCH_TABLES if STACK_VALIDATION
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS
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
index e3569543bdac..f50047939660 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -112,4 +112,8 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM

+config GCC_PLUGIN_SWITCH_TABLES
+	bool
+	depends on GCC_PLUGINS && ARM64
+
 endif
diff --git a/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c b/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
new file mode 100644
index 000000000000..9b8b2ec6a3c8
--- /dev/null
+++ b/scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include "gcc-common.h"
+
+__visible int plugin_is_GPL_compatible;
+
+#define GEN_QUAD(rtx)	assemble_integer_with_op(".quad ", rtx)
+
+/*
+ * Create an array of metadata for each jump table found in the rtl.
+ * The metadata contains:
+ * - A pointer to the table of offsets used for the actual branch
+ * - A pointer to first instruction of the group getting expanded into an
+ *   acutal jump
+ * - The number of entries in the table of offsets
+ * - Whether the offsets in the table are signed or not
+ */
+static unsigned int arm64_switchtbl_rtl_execute(void)
+{
+	rtx_insn *insn;
+	rtx_insn *labelp = NULL;
+	rtx_jump_table_data *tablep = NULL;
+	section *swt_sec;
+	section *curr_sec = current_function_section();
+
+	swt_sec = get_section(".discard.switch_table_info",
+			      SECTION_EXCLUDE | SECTION_COMMON, NULL);
+
+	for (insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		/*
+		 * Find a tablejump_p INSN (using a dispatch table)
+		 */
+		if (!tablejump_p(insn, &labelp, &tablep))
+			continue;
+
+		if (labelp && tablep) {
+			rtx_code_label *label_to_jump;
+
+			/*
+			 * GCC is a bit touchy about adding the label right
+			 * before the jump rtx_insn as it modifies the
+			 * basic_block created for the jump table.
+			 * Make sure we create the label before the whole
+			 * basic_block of the jump table.
+			 */
+			label_to_jump = gen_label_rtx();
+			SET_LABEL_KIND(label_to_jump, LABEL_NORMAL);
+			emit_label_before(label_to_jump, insn);
+			/* Force label to be kept, apparently LABEL_PRESERVE_P is an rvalue :) */
+			LABEL_PRESERVE_P(label_to_jump) = 1;
+
+			switch_to_section(swt_sec);
+			GEN_QUAD(gen_rtx_LABEL_REF(Pmode, labelp));
+			GEN_QUAD(gen_rtx_LABEL_REF(Pmode, label_to_jump));
+			GEN_QUAD(GEN_INT(GET_NUM_ELEM(tablep->get_labels())));
+			GEN_QUAD(GEN_INT(ADDR_DIFF_VEC_FLAGS(tablep).offset_unsigned));
+			switch_to_section(curr_sec);
+
+			/*
+			 * Scheduler isn't very happy about leaving labels in
+			 * the middle of jump table basic blocks.
+			 */
+			delete_insn(label_to_jump);
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
+	PASS_INFO(arm64_switchtbl_rtl, "expand", 1,
+		  PASS_POS_INSERT_AFTER);
+
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  NULL, &arm64_switchtbl_rtl_pass_info);
+
+	return 0;
+}
--
2.21.0

