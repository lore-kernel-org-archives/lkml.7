Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0159CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE8C233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340740;
	bh=7sZC3zR6PxYnna7Srm6q29xaecca2ewl0CO9rvADhF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIeKRbbFW1PzqvrYRShQQ3aARy2IdxZi8rgwTjwAVS9h7XW2YiDMXz+h52YWrkgr+
	 r1CsI6afrnDrRfhnKAJmpZPgGaPtr4l7sQozhkLYx8EnTHvu32eWaJRw3G4xSJj7IQ
	 nwLwBYHbL5QWF4kHNPufOPEGZ9YlHtrt/O0r6Ur4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfIAMZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfIAMZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461702342C;
        Sun,  1 Sep 2019 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340735;
        bh=7sZC3zR6PxYnna7Srm6q29xaecca2ewl0CO9rvADhF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fExwJuHPr0dSnwhPxRhnZ/V8nxlEhzYUz1uIXl0UioVCJ7TZvrkEBfAvfG/c5+WGb
         eDoCdQTQG5+ODCKfXfdVXFxGFKRvl+e5eWgkoxy3TAdtJKUoonDP+qhoFH3vRWRx56
         /QEvObKHJyOO2/sTlhBorGtzcvIu4L7emBSdiMrc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/47] objtool: Move x86 insn decoder to a common location
Date:   Sun,  1 Sep 2019 09:23:20 -0300
Message-Id: <20190901122326.5793-42-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

The kernel tree has three identical copies of the x86 instruction
decoder.  Two of them are in the tools subdir.

The tools subdir is supposed to be completely standalone and separate
from the kernel.  So having at least one copy of the kernel decoder in
the tools subdir is unavoidable.  However, we don't need *two* of them.

Move objtool's copy of the decoder to a shared location, so that perf
will also be able to use it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/55b486b88f6bcd0c9a2a04b34f964860c8390ca8.1567118001.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/{objtool => }/arch/x86/include/asm/inat.h      |  0
 .../{objtool => }/arch/x86/include/asm/inat_types.h  |  0
 tools/{objtool => }/arch/x86/include/asm/insn.h      |  0
 tools/{objtool => }/arch/x86/include/asm/orc_types.h |  0
 tools/{objtool => }/arch/x86/lib/inat.c              |  0
 tools/{objtool => }/arch/x86/lib/insn.c              |  0
 tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt  |  0
 .../arch/x86/tools/gen-insn-attr-x86.awk             |  0
 tools/objtool/Makefile                               |  4 ++--
 tools/objtool/arch/x86/Build                         |  4 ++--
 tools/objtool/arch/x86/decode.c                      |  4 ++--
 tools/objtool/sync-check.sh                          | 12 ++++++------
 12 files changed, 12 insertions(+), 12 deletions(-)
 rename tools/{objtool => }/arch/x86/include/asm/inat.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/inat_types.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/insn.h (100%)
 rename tools/{objtool => }/arch/x86/include/asm/orc_types.h (100%)
 rename tools/{objtool => }/arch/x86/lib/inat.c (100%)
 rename tools/{objtool => }/arch/x86/lib/insn.c (100%)
 rename tools/{objtool => }/arch/x86/lib/x86-opcode-map.txt (100%)
 rename tools/{objtool => }/arch/x86/tools/gen-insn-attr-x86.awk (100%)

diff --git a/tools/objtool/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/inat.h
rename to tools/arch/x86/include/asm/inat.h
diff --git a/tools/objtool/arch/x86/include/asm/inat_types.h b/tools/arch/x86/include/asm/inat_types.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/inat_types.h
rename to tools/arch/x86/include/asm/inat_types.h
diff --git a/tools/objtool/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/insn.h
rename to tools/arch/x86/include/asm/insn.h
diff --git a/tools/objtool/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/orc_types.h
rename to tools/arch/x86/include/asm/orc_types.h
diff --git a/tools/objtool/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
similarity index 100%
rename from tools/objtool/arch/x86/lib/inat.c
rename to tools/arch/x86/lib/inat.c
diff --git a/tools/objtool/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
similarity index 100%
rename from tools/objtool/arch/x86/lib/insn.c
rename to tools/arch/x86/lib/insn.c
diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
similarity index 100%
rename from tools/objtool/arch/x86/lib/x86-opcode-map.txt
rename to tools/arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
similarity index 100%
rename from tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
rename to tools/arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 88158239622b..8c9b9adc67ef 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -33,7 +33,7 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
+	    -I$(srctree)/tools/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
@@ -60,7 +60,7 @@ $(LIBSUBCMD): fixdep FORCE
 clean:
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
+	$(Q)$(RM) $(OUTPUT)arch/x86/inat-tables.c $(OUTPUT)fixdep
 
 FORCE:
 
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index b998412c017d..7c5004008e97 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,7 +1,7 @@
 objtool-y += decode.o
 
-inat_tables_script = arch/x86/tools/gen-insn-attr-x86.awk
-inat_tables_maps = arch/x86/lib/x86-opcode-map.txt
+inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
+inat_tables_maps = ../arch/x86/lib/x86-opcode-map.txt
 
 $(OUTPUT)arch/x86/lib/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
 	$(call rule_mkdir)
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0567c47a91b1..a62e032863a8 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -8,8 +8,8 @@
 
 #define unlikely(cond) (cond)
 #include <asm/insn.h>
-#include "lib/inat.c"
-#include "lib/insn.c"
+#include "../../../arch/x86/lib/inat.c"
+#include "../../../arch/x86/lib/insn.c"
 
 #include "../../elf.h"
 #include "../../arch.h"
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 1470e74e9d66..66f1575b80f3 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -2,21 +2,21 @@
 # SPDX-License-Identifier: GPL-2.0
 
 FILES='
-arch/x86/lib/insn.c
-arch/x86/lib/inat.c
-arch/x86/lib/x86-opcode-map.txt
-arch/x86/tools/gen-insn-attr-x86.awk
-arch/x86/include/asm/insn.h
 arch/x86/include/asm/inat.h
 arch/x86/include/asm/inat_types.h
+arch/x86/include/asm/insn.h
 arch/x86/include/asm/orc_types.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+arch/x86/lib/x86-opcode-map.txt
+arch/x86/tools/gen-insn-attr-x86.awk
 '
 
 check()
 {
 	local file=$1
 
-	diff $file ../../$file > /dev/null ||
+	diff ../$file ../../$file > /dev/null ||
 		echo "Warning: synced file at 'tools/objtool/$file' differs from latest kernel version at '$file'"
 }
 
-- 
2.21.0

