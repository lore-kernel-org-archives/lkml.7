Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DDFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE9B218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfGXVFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:05:45 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:53154 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfGXVFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:05:42 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 24 Jul 2019 14:05:09 -0700
Received: from rlwimi.localdomain (unknown [10.166.65.164])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8DAC2407C8;
        Wed, 24 Jul 2019 14:05:29 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v3 10/13] objtool: Make recordmcount into an objtool subcmd
Date:   Wed, 24 Jul 2019 14:05:04 -0700
Message-ID: <13ef7e93410f99579fa9b8a44bdd313e8300b706.1563992889.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1563992889.git.mhelsley@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than a standalone executable merge recordmcount as a sub command
of objtool. This is a small step towards cleaning up recordmcount and
eventually saving ELF code with objtool.

For the initial step all that's required is a bit of Makefile changes
and invoking the former main() function from recordmcount.c because the
subcommand code uses similar function arguments as main when dispatching.

objtool ignores some object files that tracing does not, specifically
those with OBJECT_FILES_NON_STANDARD Makefile variables. For this reason
we keep the recordmcount_dep separate from the objtool_dep. When using
objtool mcount we can also, like the other objtool invocations, just
depend on the binary rather than the source the binary is built from.

Subsequent patches will gradually convert recordmcount to use
more and more of libelf/objtool's ELF accessor code. This will both
clean up recordmcount to be more easily readable and remove
recordmcount's crude accessor wrapping code.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 Makefile                       |  6 +--
 scripts/Makefile.build         | 22 +++++------
 tools/objtool/Build            |  3 +-
 tools/objtool/Makefile         | 12 +-----
 tools/objtool/builtin-mcount.c | 72 ++++++++++++++++++++++++++++++++++
 tools/objtool/builtin-mcount.h | 23 +++++++++++
 tools/objtool/builtin.h        |  1 +
 tools/objtool/objtool.c        |  1 +
 tools/objtool/recordmcount.c   | 29 +++++---------
 9 files changed, 122 insertions(+), 47 deletions(-)
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/builtin-mcount.h

diff --git a/Makefile b/Makefile
index 9be5834073f8..686634387296 100644
--- a/Makefile
+++ b/Makefile
@@ -817,11 +817,11 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
 KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
-		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
+		USE_OBJTOOL_MCOUNT := y
+		export USE_OBJTOOL_MCOUNT
 	endif
 endif
-endif
+endif # CONFIG_FUNCTION_TRACER
 
 # We trigger additional mismatches with less inlining
 ifdef CONFIG_DEBUG_SECTION_MISMATCH
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 08b70ee9614a..43707491317c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -170,22 +170,21 @@ endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 ifndef CC_USING_RECORD_MCOUNT
-# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
-ifdef BUILD_C_RECORDMCOUNT
+# compiler will not generate __mcount_loc use objtool mcount record or recordmcount.pl
+ifdef USE_OBJTOOL_MCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
 endif
 # Due to recursion, we must skip empty.o.
 # The empty.o file is created in the make process in order to determine
 # the target endianness and word size. It is made before all other C
-# files, including recordmcount.
+# files, including objtool.
 sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
-		$(objtree)/tools/objtool/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
+		$(objtree)/tools/objtool/objtool mcount record $(RECORDMCOUNT_FLAGS) "$(@)";	\
 	fi;
 
-recordmcount_source := $(srctree)/tools/objtool/recordmcount.c \
-		    $(srctree)/tools/objtool/recordmcount.h
+recordmcount_dep := $(objtree)/tools/objtool/objtool
 else
 sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
@@ -193,8 +192,8 @@ sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)"
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
-recordmcount_source := $(srctree)/tools/objtool/recordmcount.pl
-endif # BUILD_C_RECORDMCOUNT
+recordmcount_dep := $(srctree)/tools/objtool/recordmcount.pl
+endif # USE_OBJTOOL_MCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
 endif # CC_USING_RECORD_MCOUNT
@@ -236,9 +235,10 @@ endif # SKIP_STACK_VALIDATION
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
-objtool_dep = $(objtool_obj)					\
+objtool_dep += $(objtool_obj)					\
 	      $(wildcard include/config/orc/unwinder.h		\
-			 include/config/stack/validation.h)
+			 include/config/stack/validation.h	\
+			 include/config/ftrace/mcount/record.h)
 
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 cmd_gen_ksymdeps = \
@@ -270,7 +270,7 @@ cmd_undef_syms = echo
 endif
 
 # Built-in and composite module parts
-$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
+$(obj)/%.o: $(src)/%.c $(recordmcount_dep) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 686edb170e3a..ab60b43fdbbb 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -1,6 +1,7 @@
 objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
+objtool-y += builtin-mcount.o recordmcount.o
 objtool-y += check.o
 objtool-y += orc_gen.o
 objtool-y += orc_dump.o
@@ -25,5 +26,3 @@ $(OUTPUT)libctype.o: ../lib/ctype.c FORCE
 $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-recordmcount-y += recordmcount.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index bd9d0b6534cf..30f7e98ee8ef 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -29,12 +29,6 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
 LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
 
-RECORDMCOUNT := $(OUTPUT)recordmcount
-RECORDMCOUNT_IN := $(RECORDMCOUNT)-in.o
-ifeq ($(BUILD_C_RECORDMCOUNT),y)
-all:  $(RECORDMCOUNT)
-endif
-
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
@@ -55,21 +49,17 @@ include $(srctree)/tools/build/Makefile.include
 $(OBJTOOL_IN): fixdep FORCE
 	@$(MAKE) $(build)=objtool
 
-$(RECORDMCOUNT_IN): fixdep FORCE
-	@$(MAKE) $(build)=recordmcount
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	@$(CONFIG_SHELL) ./sync-check.sh
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
-$(RECORDMCOUNT): $(RECORDMCOUNT_IN)
-	$(QUIET_LINK)$(CC) $(RECORDMCOUNT_IN) $(KBUILD_HOSTLDFLAGS) -o $@
 
 $(LIBSUBCMD): fixdep FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
 
 clean:
-	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL) $(RECORDMCOUNT)
+	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 
diff --git a/tools/objtool/builtin-mcount.c b/tools/objtool/builtin-mcount.c
new file mode 100644
index 000000000000..0ed014b82b9d
--- /dev/null
+++ b/tools/objtool/builtin-mcount.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Matt Helsley <mhelsley@vmware.com>
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
+/*
+ * objtool mcount:
+ *
+ * This command analyzes a .o file and constructs a table of the locations of
+ * calls to 'mcount' useful to ftrace. We can optionally append this table to
+ * the object file ("objtool mcount record foo.o") or output it separately
+ * ("objtool mcount show"). The latter can be used to compare the expected
+ * callers of mcount to those actually found.
+ */
+
+#include <string.h>
+#include <subcmd/parse-options.h>
+#include "builtin.h"
+
+#ifndef cmd_mcount
+#include "builtin-mcount.h"
+
+static const char * const mcount_usage[] = {
+	"objtool mcount record [<options>] file.o [file2.o ...]",
+	NULL,
+};
+
+bool warn_on_notrace_sect;
+
+const static struct option mcount_options[] = {
+	OPT_BOOLEAN('w', "warn-on-notrace-section", &warn_on_notrace_sect,
+			"Emit a warning when a section omitting mcount "
+			"(possibly due to \"notrace\" marking) is encountered"),
+	OPT_END(),
+};
+
+int cmd_mcount(int argc, const char **argv)
+{
+	argc--; argv++;
+	if (argc <= 0)
+		usage_with_options(mcount_usage, mcount_options);
+
+	if (!strncmp(argv[0], "rec", 3)) {
+		if (argc != 2)
+			usage_with_options(mcount_usage, mcount_options);
+
+		argc = parse_options(argc, argv,
+				     mcount_options, mcount_usage, 0);
+		if (argc < 1)
+			usage_with_options(mcount_usage, mcount_options);
+
+		return record_mcount(argc, argv);
+	}
+
+	usage_with_options(mcount_usage, mcount_options);
+
+	return 0;
+}
+#endif /* !def cmd_mcount */
diff --git a/tools/objtool/builtin-mcount.h b/tools/objtool/builtin-mcount.h
new file mode 100644
index 000000000000..b7b508781127
--- /dev/null
+++ b/tools/objtool/builtin-mcount.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Matt Helsley <mhelsley@vmware.com>
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
+#ifndef BUILTIN_SUBCMD_MCOUNT
+#define BUILTIN_SUBCMD_MCOUNT 1
+
+extern int record_mcount(int argc, const char **argv);
+
+#endif /* BUILTIN_SUBCMD_MCOUNT */
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index a32736f8d2a4..125207c6a2fa 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -12,5 +12,6 @@ extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
+extern int cmd_mcount(int argc, const char **argv);
 
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 0b3528f05053..a2c45e70d74f 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -35,6 +35,7 @@ static const char objtool_usage_string[] =
 static struct cmd_struct objtool_cmds[] = {
 	{"check",	cmd_check,	"Perform stack metadata validation on an object file" },
 	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file" },
+	{"mcount",	cmd_mcount,	"Construct a table of locations of calls to mcount. Useful for ftrace."},
 };
 
 bool help;
diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 9f4af109277e..2de31e2913d1 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -24,7 +24,6 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
-#include <getopt.h>
 #include <elf.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -32,6 +31,8 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "builtin-mcount.h"
+
 #ifndef EM_AARCH64
 #define EM_AARCH64	183
 #define R_AARCH64_NONE		0
@@ -470,7 +471,7 @@ static int do_file(char const *const fname)
 		goto out;
 	case ELFDATA2LSB:
 		if (*(unsigned char const *)&endian != 1) {
-			/* main() is big endian, file.o is little endian. */
+			/* objtool is big endian, file.o is little endian. */
 			w = w4rev;
 			w2 = w2rev;
 			w8 = w8rev;
@@ -483,7 +484,7 @@ static int do_file(char const *const fname)
 		break;
 	case ELFDATA2MSB:
 		if (*(unsigned char const *)&endian != 0) {
-			/* main() is little endian, file.o is big endian. */
+			/*  objtool is little endian, file.o is big endian. */
 			w = w4rev;
 			w2 = w2rev;
 			w8 = w8rev;
@@ -596,33 +597,21 @@ static int do_file(char const *const fname)
 	return rc;
 }
 
-int main(int argc, char *argv[])
+int record_mcount(int argc, const char **argv)
 {
 	const char ftrace[] = "/ftrace.o";
 	int ftrace_size = sizeof(ftrace) - 1;
 	int n_error = 0;  /* gcc-4.3.0 false positive complaint */
-	int c;
 	int i;
 
-	while ((c = getopt(argc, argv, "w")) >= 0) {
-		switch (c) {
-		case 'w':
-			warn_on_notrace_sect = 1;
-			break;
-		default:
-			fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
-			return 0;
-		}
-	}
-
-	if ((argc - optind) < 1) {
-		fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
+	if (argc < 1) {
+		fprintf(stderr, "usage: objtool mcount record [-w] file.o...\n");
 		return 0;
 	}
 
 	/* Process each file in turn, allowing deep failure. */
-	for (i = optind; i < argc; i++) {
-		char *file = argv[i];
+	for (i = 0; i < argc; i++) {
+		const char *file = argv[i];
 		int len;
 
 		/*
-- 
2.20.1

