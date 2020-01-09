Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67792C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DECC206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJtpigQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgAIQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36799 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731305AbgAIQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZWC3NYwPtgLE6SG36C3VaKcOwxxIR92Oe8t166+ozo=;
        b=jJtpigQdZafVzkg5PRk0P73Mitrt5qMXQivHzy9kfuAe724okC1Ax33+Gf9Qfe6t9lu33n
        rGfo1H0VDU6aaRIpNQYjv0o1XIkVAG8PzNcJwebaoeu4WAKG1NxCEj7CXAvxg2F60HS6ka
        YrtrOcA3h9cbeQusCVyFwLlAq8Rf72E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-V_09Tj43P9yrdiM1zlWmtA-1; Thu, 09 Jan 2020 11:03:54 -0500
X-MC-Unique: V_09Tj43P9yrdiM1zlWmtA-1
Received: by mail-wm1-f70.google.com with SMTP id 7so614679wmf.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZWC3NYwPtgLE6SG36C3VaKcOwxxIR92Oe8t166+ozo=;
        b=Xrp66syEve9Hqlx0up6NHhi2WwdxIzLfiO8tiVUsfDW2UxW803lse3fshdk8W5hAXx
         PJ3xbcRK9XynvKFLr1BhCHl0XdXU8avyI4TuNA87vrNjSE9Q/AoaI9koW77cKw/yqWLj
         EgWshVabZ0pgO694eLH6qsVcG8HQRxZri8UmvXzzU/xUphXCThlcAxoP0pOZ4wTVyiFT
         S14b2nElqh6RRyTXsQ2xd6n0JzS+T/XfyN0X6JqO/L6Vboin3JBhPDLivOyplKItXZBv
         CWjDbrnX49lvABlxTzH7x6W+VXwcoEhW12pZyICa8++bs3PoPh/32ScHhc8U2uEPg8MD
         +z/A==
X-Gm-Message-State: APjAAAXHe1kM52Z42Mx1G0lfVZAkYwCW+wk6FirsY0RT9pUvzT7M9nE+
        eACux4LOVULjfwQ8H4nHWDlKzukwz3qJL3vr60CP/xIG7PTFpt7i/+dEbfeOzPhNVVVjynrEmgX
        Z4IxF3tiq/bVkJUW+tsQxEpCK
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr5714908wmh.35.1578585832572;
        Thu, 09 Jan 2020 08:03:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3K422AcRc43kA+7KXUEORNfUwnc+dzxIyEmAHwHDVmV1yK+mA2HEhXQ9YIN/yRwLx6UmfRA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr5714878wmh.35.1578585832351;
        Thu, 09 Jan 2020 08:03:52 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m126sm3321546wmf.7.2020.01.09.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:51 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 08/57] objtool: Make ORC support optional
Date:   Thu,  9 Jan 2020 16:02:11 +0000
Message-Id: <20200109160300.26150-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only x86 supports ORC. To simplify the addition of other
supported architectures to objtool 'check' command, make the 'orc'
objtool command optional to implement for a given architecture.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Build     |  2 +-
 tools/objtool/Makefile  | 10 +++++++++-
 tools/objtool/check.c   |  4 ++++
 tools/objtool/objtool.c |  2 ++
 tools/objtool/orc.h     | 33 +++++++++++++++++++++++++++++++--
 5 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index d069d26d97fa..6e7163f9522a 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -1,6 +1,6 @@
 objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
-objtool-y += builtin-orc.o
+objtool-$(OBJTOOL_ORC) += builtin-orc.o
 objtool-y += check.o
 objtool-y += elf.o
 objtool-y += special.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index d2a19b0bc05a..24d653e0b6ec 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -6,6 +6,10 @@ ifeq ($(ARCH),x86_64)
 ARCH := x86
 endif
 
+ifeq ($(ARCH),x86)
+OBJTOOL_ORC := y
+endif
+
 # always use the host compiler
 HOSTAR	?= ar
 HOSTCC	?= gcc
@@ -42,8 +46,12 @@ LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
 CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
+ifeq ($(OBJTOOL_ORC),y)
+CFLAGS	+= -DOBJTOOL_ORC
+endif
+
 AWK = awk
-export srctree OUTPUT CFLAGS SRCARCH AWK
+export srctree OUTPUT CFLAGS SRCARCH AWK OBJTOOL_ORC
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2c5ccf61510a..8f2ff030936d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1317,6 +1317,7 @@ static bool has_valid_stack_frame(struct insn_state *state)
 	return false;
 }
 
+#ifdef OBJTOOL_ORC
 static int update_insn_state_regs(struct instruction *insn, struct insn_state *state)
 {
 	struct cfi_reg *cfa = &state->cfa;
@@ -1340,6 +1341,7 @@ static int update_insn_state_regs(struct instruction *insn, struct insn_state *s
 
 	return 0;
 }
+#endif
 
 static void save_reg(struct insn_state *state, unsigned char reg, int base,
 		     int offset)
@@ -1425,8 +1427,10 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 		return 0;
 	}
 
+#ifdef OBJTOOL_ORC
 	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
 		return update_insn_state_regs(insn, state);
+#endif
 
 	switch (op->dest.type) {
 
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 0b3528f05053..8db7139b72cd 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -34,7 +34,9 @@ static const char objtool_usage_string[] =
 
 static struct cmd_struct objtool_cmds[] = {
 	{"check",	cmd_check,	"Perform stack metadata validation on an object file" },
+#ifdef OBJTOOL_ORC
 	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file" },
+#endif
 };
 
 bool help;
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
index ffda072cf4ad..f5303b8264e3 100644
--- a/tools/objtool/orc.h
+++ b/tools/objtool/orc.h
@@ -6,14 +6,43 @@
 #ifndef _ORC_H
 #define _ORC_H
 
-#include <asm/orc_types.h>
-
 struct objtool_file;
 
+#ifdef OBJTOOL_ORC
+
+#include <asm/orc_types.h>
+
 int arch_orc_init(struct objtool_file *file);
 int arch_orc_create_sections(struct objtool_file *file);
 int arch_orc_read_unwind_hints(struct objtool_file *file);
 
 int orc_dump(const char *objname);
 
+#else
+
+struct orc_entry {
+};
+
+static inline int arch_orc_init(struct objtool_file *file)
+{
+	return 0;
+}
+
+static inline int arch_orc_create_sections(struct objtool_file *file)
+{
+	return 0;
+}
+
+static inline int arch_orc_read_unwind_hints(struct objtool_file *file)
+{
+	return 0;
+}
+
+static inline int orc_dump(const char *objname)
+{
+	return 0;
+}
+
+#endif /* OBJTOOL_ORC */
+
 #endif /* _ORC_H */
-- 
2.21.0

