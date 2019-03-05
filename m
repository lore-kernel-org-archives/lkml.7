Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6828FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1375D20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DEdjknw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfCEFvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:51:23 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:38938 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfCEFvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 00:51:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x255mOrV002400;
        Tue, 5 Mar 2019 14:48:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x255mOrV002400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551764908;
        bh=U4tagWc0AgGmL8q9wck+LfW8WuxK4FEczZ1llFEiWSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEdjknw/Xv8Q1D21LXlOQkgEprQ/aOX4PpHSz3NmuFClzCKhcrgQHTvQysARHC2M/
         4YD+pxCl4U/7QiFaJqgzg36YZ9OUGl6wxRFoql3p+mWcgaXf0TxeD+8eCx6CebJL22
         byrmcofed26mPbRRmsk4nV3RwsHaEfDBJGQ5pqpU5FK7KkPbG016BOLuQvzDGAvdPC
         WT1rUjZWT33yUXg1JD4kiBbJMz4Wzm94jB0fLVO39LMG1c92IqCMQCsVz+cAfDYwMP
         3pmrcrOfiaMfLCG+seD1l7a1VBO7Swd3ET5bVOfSaV+ZCkJlRNq8nLKpglVxAUf3JU
         e8kf3siNXDQVg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Meijboom <robin@meijboom.info>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 3/3] objtool: move tools/objtool/ to scripts/objtool/
Date:   Tue,  5 Mar 2019 14:48:16 +0900
Message-Id: <1551764896-8453-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
References: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tools that are globally needed for building the kernel are supposed to
be put in the scripts/ directory, but objtool is the exceptional one.

People were confused by objtool's Makefile since most of tools run on
the target whereas objtool runs on the host machine. Some time ago,
Douglas Anderson suggested to move tools/objtool/ to scripts/tools/
(https://patchwork.kernel.org/patch/9983535/#20996057), but we did
not go as far as submitting a patch at that time.

Recently, Robin Meijboom reported that the generated files for objtool
were never cleaned up. (https://patchwork.kernel.org/patch/10813797/)

So, I looked into this to fix the distortion. Move tools/objtool/ to
scripts/objtool/, and rewrite Makefiles in the Kbuild-ish manner.

I also cleaned up the top-level Makefile by moving the libelf check
scripts/objtool/Makefile.

I see some benefits in this.

[1] generated files under scripts/ are cleaned up by 'make mrproper'

Currently, the generated files under tools/objtool/ are not cleaned up
since the build system under tools/ is a complete different world.

If we want to clean them up, it should be done by 'make mrproper'
instead of 'make clean' since objtool is needed for building external
modules.

This commit naturally solves the issue since Kbuild cleans under
scripts/ by 'make mrproper'.

[2] build log looks nicer

Currently, the build log under tools/objtool/ shows absolute paths, and
displays 'DESCEND  objtool' every time for incremental building.

Switching over to the standard Kbuild scheme will improve the log.

  Before:

  DESCEND  objtool
  HOSTCC   /home/masahiro/workspace/linux/tools/objtool/fixdep.o
  HOSTLD   /home/masahiro/workspace/linux/tools/objtool/fixdep-in.o
  LINK     /home/masahiro/workspace/linux/tools/objtool/fixdep
  CC       /home/masahiro/workspace/linux/tools/objtool/exec-cmd.o
  CC       /home/masahiro/workspace/linux/tools/objtool/help.o
  CC       /home/masahiro/workspace/linux/tools/objtool/pager.o
  CC       /home/masahiro/workspace/linux/tools/objtool/parse-options.o
  CC       /home/masahiro/workspace/linux/tools/objtool/run-command.o
  CC       /home/masahiro/workspace/linux/tools/objtool/sigchain.o
  CC       /home/masahiro/workspace/linux/tools/objtool/subcmd-config.o
  LD       /home/masahiro/workspace/linux/tools/objtool/libsubcmd-in.o
  AR       /home/masahiro/workspace/linux/tools/objtool/libsubcmd.a
  GEN      /home/masahiro/workspace/linux/tools/objtool/arch/x86/lib/inat-tables.c
  CC       /home/masahiro/workspace/linux/tools/objtool/arch/x86/decode.o
  LD       /home/masahiro/workspace/linux/tools/objtool/arch/x86/objtool-in.o
  CC       /home/masahiro/workspace/linux/tools/objtool/builtin-check.o
  CC       /home/masahiro/workspace/linux/tools/objtool/builtin-orc.o
  CC       /home/masahiro/workspace/linux/tools/objtool/check.o
  CC       /home/masahiro/workspace/linux/tools/objtool/orc_gen.o
  CC       /home/masahiro/workspace/linux/tools/objtool/orc_dump.o
  CC       /home/masahiro/workspace/linux/tools/objtool/elf.o
  CC       /home/masahiro/workspace/linux/tools/objtool/special.o
  CC       /home/masahiro/workspace/linux/tools/objtool/objtool.o
  CC       /home/masahiro/workspace/linux/tools/objtool/libstring.o
  CC       /home/masahiro/workspace/linux/tools/objtool/str_error_r.o
  LD       /home/masahiro/workspace/linux/tools/objtool/objtool-in.o
  LINK     /home/masahiro/workspace/linux/tools/objtool/objtool

  After:

  HOSTCC  scripts/objtool/builtin-check.o
  HOSTCC  scripts/objtool/builtin-orc.o
  HOSTCC  scripts/objtool/check.o
  HOSTCC  scripts/objtool/orc_gen.o
  HOSTCC  scripts/objtool/orc_dump.o
  HOSTCC  scripts/objtool/elf.o
  HOSTCC  scripts/objtool/special.o
  HOSTCC  scripts/objtool/objtool.o
  HOSTCC  scripts/objtool/libstring.o
  HOSTCC  scripts/objtool/str_error_r.o
  HOSTCC  scripts/objtool/exec-cmd.o
  HOSTCC  scripts/objtool/pager.o
  HOSTCC  scripts/objtool/parse-options.o
  HOSTCC  scripts/objtool/run-command.o
  HOSTCC  scripts/objtool/sigchain.o
  HOSTCC  scripts/objtool/subcmd-config.o
  AWK     scripts/objtool/arch/x86/lib/inat-tables.c
  HOSTCC  scripts/objtool/arch/x86/decode.o
  HOSTLD  scripts/objtool/objtool

[3] simplify distro package script

The special handling in scripts/package/buildeb is no longer needed
since all host programs are copied to linux-headers packages.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Reported-by: Robin Meijboom <robin@meijboom.info>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS                                        |  2 +-
 Makefile                                           | 24 +--------
 scripts/Makefile                                   |  1 +
 scripts/Makefile.build                             |  4 +-
 {tools => scripts}/objtool/.gitignore              |  1 -
 scripts/objtool/Makefile                           | 43 +++++++++++++++
 {tools => scripts}/objtool/arch.h                  |  0
 scripts/objtool/arch/x86/Makefile                  | 20 +++++++
 {tools => scripts}/objtool/arch/x86/decode.c       |  0
 .../objtool/arch/x86/include/asm/inat.h            |  0
 .../objtool/arch/x86/include/asm/inat_types.h      |  0
 .../objtool/arch/x86/include/asm/insn.h            |  0
 .../objtool/arch/x86/include/asm/orc_types.h       |  0
 {tools => scripts}/objtool/arch/x86/lib/inat.c     |  0
 {tools => scripts}/objtool/arch/x86/lib/insn.c     |  0
 .../objtool/arch/x86/lib/x86-opcode-map.txt        |  0
 .../objtool/arch/x86/tools/gen-insn-attr-x86.awk   |  0
 {tools => scripts}/objtool/builtin-check.c         |  0
 {tools => scripts}/objtool/builtin-orc.c           |  0
 {tools => scripts}/objtool/builtin.h               |  0
 {tools => scripts}/objtool/cfi.h                   |  0
 {tools => scripts}/objtool/check.c                 |  0
 {tools => scripts}/objtool/check.h                 |  0
 {tools => scripts}/objtool/elf.c                   |  0
 {tools => scripts}/objtool/elf.h                   |  0
 scripts/objtool/exec-cmd.c                         |  2 +
 scripts/objtool/libstring.c                        |  1 +
 {tools => scripts}/objtool/objtool.c               |  0
 {tools => scripts}/objtool/orc.h                   |  0
 {tools => scripts}/objtool/orc_dump.c              |  0
 {tools => scripts}/objtool/orc_gen.c               |  0
 scripts/objtool/pager.c                            |  1 +
 scripts/objtool/parse-options.c                    |  2 +
 scripts/objtool/run-command.c                      |  2 +
 scripts/objtool/sigchain.c                         |  2 +
 {tools => scripts}/objtool/special.c               |  0
 {tools => scripts}/objtool/special.h               |  0
 scripts/objtool/str_error_r.c                      |  1 +
 scripts/objtool/subcmd-config.c                    |  1 +
 {tools => scripts}/objtool/sync-check.sh           |  8 +--
 {tools => scripts}/objtool/warn.h                  |  0
 scripts/package/builddeb                           |  3 --
 tools/objtool/Build                                | 22 --------
 tools/objtool/Makefile                             | 63 ----------------------
 tools/objtool/arch/x86/Build                       | 12 -----
 45 files changed, 84 insertions(+), 131 deletions(-)
 rename {tools => scripts}/objtool/.gitignore (83%)
 create mode 100644 scripts/objtool/Makefile
 rename {tools => scripts}/objtool/arch.h (100%)
 create mode 100644 scripts/objtool/arch/x86/Makefile
 rename {tools => scripts}/objtool/arch/x86/decode.c (100%)
 rename {tools => scripts}/objtool/arch/x86/include/asm/inat.h (100%)
 rename {tools => scripts}/objtool/arch/x86/include/asm/inat_types.h (100%)
 rename {tools => scripts}/objtool/arch/x86/include/asm/insn.h (100%)
 rename {tools => scripts}/objtool/arch/x86/include/asm/orc_types.h (100%)
 rename {tools => scripts}/objtool/arch/x86/lib/inat.c (100%)
 rename {tools => scripts}/objtool/arch/x86/lib/insn.c (100%)
 rename {tools => scripts}/objtool/arch/x86/lib/x86-opcode-map.txt (100%)
 rename {tools => scripts}/objtool/arch/x86/tools/gen-insn-attr-x86.awk (100%)
 rename {tools => scripts}/objtool/builtin-check.c (100%)
 rename {tools => scripts}/objtool/builtin-orc.c (100%)
 rename {tools => scripts}/objtool/builtin.h (100%)
 rename {tools => scripts}/objtool/cfi.h (100%)
 rename {tools => scripts}/objtool/check.c (100%)
 rename {tools => scripts}/objtool/check.h (100%)
 rename {tools => scripts}/objtool/elf.c (100%)
 rename {tools => scripts}/objtool/elf.h (100%)
 create mode 100644 scripts/objtool/exec-cmd.c
 create mode 100644 scripts/objtool/libstring.c
 rename {tools => scripts}/objtool/objtool.c (100%)
 rename {tools => scripts}/objtool/orc.h (100%)
 rename {tools => scripts}/objtool/orc_dump.c (100%)
 rename {tools => scripts}/objtool/orc_gen.c (100%)
 create mode 100644 scripts/objtool/pager.c
 create mode 100644 scripts/objtool/parse-options.c
 create mode 100644 scripts/objtool/run-command.c
 create mode 100644 scripts/objtool/sigchain.c
 rename {tools => scripts}/objtool/special.c (100%)
 rename {tools => scripts}/objtool/special.h (100%)
 create mode 100644 scripts/objtool/str_error_r.c
 create mode 100644 scripts/objtool/subcmd-config.c
 rename {tools => scripts}/objtool/sync-check.sh (62%)
 rename {tools => scripts}/objtool/warn.h (100%)
 delete mode 100644 tools/objtool/Build
 delete mode 100644 tools/objtool/Makefile
 delete mode 100644 tools/objtool/arch/x86/Build

diff --git a/MAINTAINERS b/MAINTAINERS
index dce5c09..2fd8b9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10948,7 +10948,7 @@ OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
 S:	Supported
-F:	tools/objtool/
+F:	scripts/objtool/
 
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
 M:	Frederic Barrat <fbarrat@linux.ibm.com>
diff --git a/Makefile b/Makefile
index d5713e7..4251aca 100644
--- a/Makefile
+++ b/Makefile
@@ -944,17 +944,6 @@ mod_sign_cmd = true
 endif
 export mod_sign_cmd
 
-ifdef CONFIG_STACK_VALIDATION
-  has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
-  ifeq ($(has_libelf),1)
-    objtool_target := tools/objtool FORCE
-  else
-    SKIP_STACK_VALIDATION := 1
-    export SKIP_STACK_VALIDATION
-  endif
-endif
-
 PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
@@ -1092,7 +1081,7 @@ prepare0: archprepare
 	$(Q)$(MAKE) $(build)=.
 
 # All the preparing..
-prepare: prepare0 prepare-objtool
+prepare: prepare0
 
 # Support for using generic headers in asm-generic
 asm-generic := -f $(srctree)/scripts/Makefile.asm-generic obj
@@ -1103,17 +1092,6 @@ asm-generic: uapi-asm-generic
 uapi-asm-generic:
 	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/uapi/asm
 
-PHONY += prepare-objtool
-prepare-objtool: $(objtool_target)
-ifeq ($(SKIP_STACK_VALIDATION),1)
-ifdef CONFIG_UNWINDER_ORC
-	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
-	@false
-else
-	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
-endif
-endif
-
 # Generate some files
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile b/scripts/Makefile
index feb1f71..edb780f 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -36,6 +36,7 @@ PHONY += build_unifdef
 build_unifdef: $(obj)/unifdef
 	@:
 
+subdir-$(CONFIG_STACK_VALIDATION) += objtool
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fd03d60..ccf8310 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -206,9 +206,8 @@ endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
-ifneq ($(SKIP_STACK_VALIDATION),1)
 
-__objtool_obj := $(objtree)/tools/objtool/objtool
+__objtool_obj := $(objtree)/scripts/objtool/objtool
 
 objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
 
@@ -234,7 +233,6 @@ objtool_obj = $(if $(patsubst y%,, \
 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
 	$(__objtool_obj))
 
-endif # SKIP_STACK_VALIDATION
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
diff --git a/tools/objtool/.gitignore b/scripts/objtool/.gitignore
similarity index 83%
rename from tools/objtool/.gitignore
rename to scripts/objtool/.gitignore
index 914cff1..103ee54 100644
--- a/tools/objtool/.gitignore
+++ b/scripts/objtool/.gitignore
@@ -1,3 +1,2 @@
 arch/x86/lib/inat-tables.c
 objtool
-fixdep
diff --git a/scripts/objtool/Makefile b/scripts/objtool/Makefile
new file mode 100644
index 0000000..34aa625
--- /dev/null
+++ b/scripts/objtool/Makefile
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+
+libelf-missing := $(call try-run,\
+	echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,,1)
+
+$(if $(libelf-missing), \
+$(error "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel"))
+
+hostprogs-y := objtool
+always := objtool sync-check
+
+HOSTLDLIBS_objtool := -lelf
+
+objtool-objs := \
+	builtin-check.o \
+	builtin-orc.o \
+	check.o \
+	orc_gen.o \
+	orc_dump.o \
+	elf.o \
+	special.o \
+	objtool.o \
+	libstring.o \
+	str_error_r.o \
+	exec-cmd.o \
+	pager.o \
+	parse-options.o \
+	run-command.o \
+	sigchain.o \
+	subcmd-config.o
+
+HOST_EXTRACFLAGS := \
+	-I $(srctree)/tools/include \
+	-I $(srctree)/tools/lib \
+	-I $(srctree)/$(src)/arch/$(SRCARCH)/include \
+	-Werror -Wno-switch-default -Wno-switch-enum -Wno-packed -g
+
+include $(srctree)/$(src)/arch/$(SRCARCH)/Makefile
+
+cmd_sync_check = $(CONFIG_SHELL) $(srctree)/$(src)/sync-check.sh
+
+$(obj)/sync-check: FORCE
+	$(call cmd,sync_check)
diff --git a/tools/objtool/arch.h b/scripts/objtool/arch.h
similarity index 100%
rename from tools/objtool/arch.h
rename to scripts/objtool/arch.h
diff --git a/scripts/objtool/arch/x86/Makefile b/scripts/objtool/arch/x86/Makefile
new file mode 100644
index 0000000..cb1515e
--- /dev/null
+++ b/scripts/objtool/arch/x86/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+
+$(shell mkdir -p $(obj)/arch/$(SRCARCH)/lib)
+
+objtool-objs += arch/$(SRCARCH)/decode.o
+
+HOSTCFLAGS_decode.o := -I $(objtree)/$(obj)/arch/$(SRCARCH)/lib
+
+$(obj)/arch/$(SRCARCH)/decode.o: $(obj)/arch/$(SRCARCH)/lib/inat-tables.c
+
+inat_tables_script = $(srctree)/$(src)/arch/$(SRCARCH)/tools/gen-insn-attr-x86.awk
+inat_tables_maps = $(srctree)/$(src)/arch/$(SRCARCH)/lib/x86-opcode-map.txt
+
+quiet_cmd_inat_table = AWK     $@
+      cmd_inat_table = $(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@
+
+$(obj)/arch/$(SRCARCH)/lib/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
+	$(call cmd,inat_table)
+
+clean-files += arch/$(SRCARCH)/lib/inat-tables.c
diff --git a/tools/objtool/arch/x86/decode.c b/scripts/objtool/arch/x86/decode.c
similarity index 100%
rename from tools/objtool/arch/x86/decode.c
rename to scripts/objtool/arch/x86/decode.c
diff --git a/tools/objtool/arch/x86/include/asm/inat.h b/scripts/objtool/arch/x86/include/asm/inat.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/inat.h
rename to scripts/objtool/arch/x86/include/asm/inat.h
diff --git a/tools/objtool/arch/x86/include/asm/inat_types.h b/scripts/objtool/arch/x86/include/asm/inat_types.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/inat_types.h
rename to scripts/objtool/arch/x86/include/asm/inat_types.h
diff --git a/tools/objtool/arch/x86/include/asm/insn.h b/scripts/objtool/arch/x86/include/asm/insn.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/insn.h
rename to scripts/objtool/arch/x86/include/asm/insn.h
diff --git a/tools/objtool/arch/x86/include/asm/orc_types.h b/scripts/objtool/arch/x86/include/asm/orc_types.h
similarity index 100%
rename from tools/objtool/arch/x86/include/asm/orc_types.h
rename to scripts/objtool/arch/x86/include/asm/orc_types.h
diff --git a/tools/objtool/arch/x86/lib/inat.c b/scripts/objtool/arch/x86/lib/inat.c
similarity index 100%
rename from tools/objtool/arch/x86/lib/inat.c
rename to scripts/objtool/arch/x86/lib/inat.c
diff --git a/tools/objtool/arch/x86/lib/insn.c b/scripts/objtool/arch/x86/lib/insn.c
similarity index 100%
rename from tools/objtool/arch/x86/lib/insn.c
rename to scripts/objtool/arch/x86/lib/insn.c
diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/scripts/objtool/arch/x86/lib/x86-opcode-map.txt
similarity index 100%
rename from tools/objtool/arch/x86/lib/x86-opcode-map.txt
rename to scripts/objtool/arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk b/scripts/objtool/arch/x86/tools/gen-insn-attr-x86.awk
similarity index 100%
rename from tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
rename to scripts/objtool/arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/tools/objtool/builtin-check.c b/scripts/objtool/builtin-check.c
similarity index 100%
rename from tools/objtool/builtin-check.c
rename to scripts/objtool/builtin-check.c
diff --git a/tools/objtool/builtin-orc.c b/scripts/objtool/builtin-orc.c
similarity index 100%
rename from tools/objtool/builtin-orc.c
rename to scripts/objtool/builtin-orc.c
diff --git a/tools/objtool/builtin.h b/scripts/objtool/builtin.h
similarity index 100%
rename from tools/objtool/builtin.h
rename to scripts/objtool/builtin.h
diff --git a/tools/objtool/cfi.h b/scripts/objtool/cfi.h
similarity index 100%
rename from tools/objtool/cfi.h
rename to scripts/objtool/cfi.h
diff --git a/tools/objtool/check.c b/scripts/objtool/check.c
similarity index 100%
rename from tools/objtool/check.c
rename to scripts/objtool/check.c
diff --git a/tools/objtool/check.h b/scripts/objtool/check.h
similarity index 100%
rename from tools/objtool/check.h
rename to scripts/objtool/check.h
diff --git a/tools/objtool/elf.c b/scripts/objtool/elf.c
similarity index 100%
rename from tools/objtool/elf.c
rename to scripts/objtool/elf.c
diff --git a/tools/objtool/elf.h b/scripts/objtool/elf.h
similarity index 100%
rename from tools/objtool/elf.h
rename to scripts/objtool/elf.h
diff --git a/scripts/objtool/exec-cmd.c b/scripts/objtool/exec-cmd.c
new file mode 100644
index 0000000..4a153ea
--- /dev/null
+++ b/scripts/objtool/exec-cmd.c
@@ -0,0 +1,2 @@
+#define _GNU_SOURCE
+#include "../../tools/lib/subcmd/exec-cmd.c"
diff --git a/scripts/objtool/libstring.c b/scripts/objtool/libstring.c
new file mode 100644
index 0000000..840c910c
--- /dev/null
+++ b/scripts/objtool/libstring.c
@@ -0,0 +1 @@
+#include "../../tools/lib/string.c"
diff --git a/tools/objtool/objtool.c b/scripts/objtool/objtool.c
similarity index 100%
rename from tools/objtool/objtool.c
rename to scripts/objtool/objtool.c
diff --git a/tools/objtool/orc.h b/scripts/objtool/orc.h
similarity index 100%
rename from tools/objtool/orc.h
rename to scripts/objtool/orc.h
diff --git a/tools/objtool/orc_dump.c b/scripts/objtool/orc_dump.c
similarity index 100%
rename from tools/objtool/orc_dump.c
rename to scripts/objtool/orc_dump.c
diff --git a/tools/objtool/orc_gen.c b/scripts/objtool/orc_gen.c
similarity index 100%
rename from tools/objtool/orc_gen.c
rename to scripts/objtool/orc_gen.c
diff --git a/scripts/objtool/pager.c b/scripts/objtool/pager.c
new file mode 100644
index 0000000..88652da
--- /dev/null
+++ b/scripts/objtool/pager.c
@@ -0,0 +1 @@
+#include "../../tools/lib/subcmd/pager.c"
diff --git a/scripts/objtool/parse-options.c b/scripts/objtool/parse-options.c
new file mode 100644
index 0000000..a9d29b4
--- /dev/null
+++ b/scripts/objtool/parse-options.c
@@ -0,0 +1,2 @@
+#define _GNU_SOURCE
+#include "../../tools/lib/subcmd/parse-options.c"
diff --git a/scripts/objtool/run-command.c b/scripts/objtool/run-command.c
new file mode 100644
index 0000000..f37ca5e
--- /dev/null
+++ b/scripts/objtool/run-command.c
@@ -0,0 +1,2 @@
+#define _GNU_SOURCE
+#include "../../tools/lib/subcmd/run-command.c"
diff --git a/scripts/objtool/sigchain.c b/scripts/objtool/sigchain.c
new file mode 100644
index 0000000..a5ad9bf
--- /dev/null
+++ b/scripts/objtool/sigchain.c
@@ -0,0 +1,2 @@
+#define _GNU_SOURCE
+#include "../../tools/lib/subcmd/sigchain.c"
diff --git a/tools/objtool/special.c b/scripts/objtool/special.c
similarity index 100%
rename from tools/objtool/special.c
rename to scripts/objtool/special.c
diff --git a/tools/objtool/special.h b/scripts/objtool/special.h
similarity index 100%
rename from tools/objtool/special.h
rename to scripts/objtool/special.h
diff --git a/scripts/objtool/str_error_r.c b/scripts/objtool/str_error_r.c
new file mode 100644
index 0000000..a32f7ae
--- /dev/null
+++ b/scripts/objtool/str_error_r.c
@@ -0,0 +1 @@
+#include "../../tools/lib/str_error_r.c"
diff --git a/scripts/objtool/subcmd-config.c b/scripts/objtool/subcmd-config.c
new file mode 100644
index 0000000..6834fd6
--- /dev/null
+++ b/scripts/objtool/subcmd-config.c
@@ -0,0 +1 @@
+#include "../../tools/lib/subcmd/subcmd-config.c"
diff --git a/tools/objtool/sync-check.sh b/scripts/objtool/sync-check.sh
similarity index 62%
rename from tools/objtool/sync-check.sh
rename to scripts/objtool/sync-check.sh
index 1470e74..98d2c97 100755
--- a/tools/objtool/sync-check.sh
+++ b/scripts/objtool/sync-check.sh
@@ -16,11 +16,13 @@ check()
 {
 	local file=$1
 
-	diff $file ../../$file > /dev/null ||
-		echo "Warning: synced file at 'tools/objtool/$file' differs from latest kernel version at '$file'"
+	diff $file scripts/objtool/$file > /dev/null ||
+		echo "Warning: synced file at 'scripts/objtool/$file' differs from latest kernel version at '$file'"
 }
 
-if [ ! -d ../../kernel ] || [ ! -d ../../tools ] || [ ! -d ../objtool ]; then
+cd $srctree
+
+if [ ! -d kernel ] || [ ! -d scripts/objtool ]; then
 	exit 0
 fi
 
diff --git a/tools/objtool/warn.h b/scripts/objtool/warn.h
similarity index 100%
rename from tools/objtool/warn.h
rename to scripts/objtool/warn.h
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index f43a274..abed281 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -158,9 +158,6 @@ done
 (cd $srctree; find arch/*/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
-if grep -q '^CONFIG_STACK_VALIDATION=y' $KCONFIG_CONFIG ; then
-	(cd $objtree; find tools/objtool -type f -executable) >> "$objtree/debian/hdrobjfiles"
-fi
 (cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f) >> "$objtree/debian/hdrobjfiles"
 if grep -q '^CONFIG_GCC_PLUGINS=y' $KCONFIG_CONFIG ; then
 	(cd $objtree; find scripts/gcc-plugins -name \*.so -o -name gcc-common.h) >> "$objtree/debian/hdrobjfiles"
diff --git a/tools/objtool/Build b/tools/objtool/Build
deleted file mode 100644
index 749becd..0000000
--- a/tools/objtool/Build
+++ /dev/null
@@ -1,22 +0,0 @@
-objtool-y += arch/$(SRCARCH)/
-objtool-y += builtin-check.o
-objtool-y += builtin-orc.o
-objtool-y += check.o
-objtool-y += orc_gen.o
-objtool-y += orc_dump.o
-objtool-y += elf.o
-objtool-y += special.o
-objtool-y += objtool.o
-
-objtool-y += libstring.o
-objtool-y += str_error_r.o
-
-CFLAGS += -I$(srctree)/tools/lib
-
-$(OUTPUT)libstring.o: ../lib/string.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
-
-$(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
deleted file mode 100644
index c9d038f..0000000
--- a/tools/objtool/Makefile
+++ /dev/null
@@ -1,63 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-include ../scripts/Makefile.include
-include ../scripts/Makefile.arch
-
-ifeq ($(ARCH),x86_64)
-ARCH := x86
-endif
-
-# always use the host compiler
-HOSTCC	?= gcc
-HOSTLD	?= ld
-CC	 = $(HOSTCC)
-LD	 = $(HOSTLD)
-AR	 = ar
-
-ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
-endif
-
-SUBCMD_SRCDIR		= $(srctree)/tools/lib/subcmd/
-LIBSUBCMD_OUTPUT	= $(if $(OUTPUT),$(OUTPUT),$(CURDIR)/)
-LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
-
-OBJTOOL    := $(OUTPUT)objtool
-OBJTOOL_IN := $(OBJTOOL)-in.o
-
-all: $(OBJTOOL)
-
-INCLUDES := -I$(srctree)/tools/include \
-	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
-WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
-LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
-
-# Allow old libelf to be used:
-elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
-CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
-
-AWK = awk
-export srctree OUTPUT CFLAGS SRCARCH AWK
-include $(srctree)/tools/build/Makefile.include
-
-$(OBJTOOL_IN): fixdep FORCE
-	@$(MAKE) $(build)=objtool
-
-$(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
-	@$(CONFIG_SHELL) ./sync-check.sh
-	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
-
-
-$(LIBSUBCMD): fixdep FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
-
-clean:
-	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
-	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
-
-FORCE:
-
-.PHONY: clean FORCE
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
deleted file mode 100644
index b998412..0000000
--- a/tools/objtool/arch/x86/Build
+++ /dev/null
@@ -1,12 +0,0 @@
-objtool-y += decode.o
-
-inat_tables_script = arch/x86/tools/gen-insn-attr-x86.awk
-inat_tables_maps = arch/x86/lib/x86-opcode-map.txt
-
-$(OUTPUT)arch/x86/lib/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@
-
-$(OUTPUT)arch/x86/decode.o: $(OUTPUT)arch/x86/lib/inat-tables.c
-
-CFLAGS_decode.o += -I$(OUTPUT)arch/x86/lib
-- 
2.7.4

