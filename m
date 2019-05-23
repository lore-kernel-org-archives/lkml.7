Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E11BC282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDF820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfEWAEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:04:24 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13607 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729685AbfEWAEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:04:22 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 22 May 2019 17:03:44 -0700
Received: from rlwimi.localdomain (unknown [10.129.221.32])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8429CB2067;
        Wed, 22 May 2019 20:03:58 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 10/13] objtool: Make recordmcount into an objtool subcmd
Date:   Wed, 22 May 2019 17:03:33 -0700
Message-ID: <10da56db6206a99d1b909e56ee48cb4ceb374ef8.1558569448.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558569448.git.mhelsley@vmware.com>
References: <cover.1558569448.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than a standalone executable merge recordmcount as a sub
command of objtool. This is a small step towards cleaning up
recordmcount and eventually saving ELF code with objtool.

For the initial step all that's required is a bit of Makefile
changes and invoking the former main() function from recordmcount.c
because the subcommand code uses similar function arguments as
main when dispatching.

Subsequent patches will gradually convert recordmcount to use
more and more of libelf/objtool's ELF accessor code. This will both
clean up recordmcount to be more easily readable and remove
recordmcount's crude accessor wrapping code.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/Makefile.build         | 15 +++++--
 tools/objtool/Build            |  3 +-
 tools/objtool/Makefile         | 18 +++------
 tools/objtool/builtin-mcount.c | 72 ++++++++++++++++++++++++++++++++++
 tools/objtool/builtin-mcount.h | 23 +++++++++++
 tools/objtool/builtin.h        |  6 +++
 tools/objtool/objtool.c        |  6 +++
 tools/objtool/recordmcount.c   | 29 +++++---------
 8 files changed, 134 insertions(+), 38 deletions(-)
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/builtin-mcount.h

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f32cfe63bb0e..6a3a5a477cbd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -173,10 +173,13 @@ cmd_modversions_c =								\
 	fi
 endif
 
+objtool_dep =
+
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 ifndef CC_USING_RECORD_MCOUNT
-# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
+# compiler will not generate __mcount_loc use objtool mcount record or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
+objtool_dep += $(objtree)/tools/objtool/objtool
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
 endif
@@ -186,10 +189,12 @@ endif
 # files, including recordmcount.
 sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
-		$(objtree)/tools/objtool/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
+		$(objtree)/tools/objtool/objtool mcount record $(RECORDMCOUNT_FLAGS) "$(@)";	\
 	fi;
 
-recordmcount_source := $(srctree)/tools/objtool/recordmcount.c \
+recordmcount_source := $(srctree)/tools/objtool/builtin-mcount.c \
+		    $(srctree)/tools/objtool/builtin-mcount.h \
+		    $(srctree)/tools/objtool/recordmcount.c \
 		    $(srctree)/tools/objtool/recordmcount.h
 else
 sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)" \
@@ -203,6 +208,8 @@ endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
 endif # CC_USING_RECORD_MCOUNT
+
+objtool_dep += $(recordmcount_source)
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
@@ -241,7 +248,7 @@ endif # SKIP_STACK_VALIDATION
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
-objtool_dep = $(objtool_obj)					\
+objtool_dep += $(objtool_obj)		\
 	      $(wildcard include/config/orc/unwinder.h		\
 			 include/config/stack/validation.h)
 
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 78c4a8a2f9e7..7b71534767bd 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -1,6 +1,7 @@
 objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
+objtool-$(BUILD_C_RECORDMCOUNT) += builtin-mcount.o recordmcount.o
 objtool-y += check.o
 objtool-y += orc_gen.o
 objtool-y += orc_dump.o
@@ -20,5 +21,3 @@ $(OUTPUT)libstring.o: ../lib/string.c FORCE
 $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-recordmcount-y += recordmcount.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index bd9d0b6534cf..2b018f2109aa 100644
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
@@ -48,28 +42,28 @@ LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
 CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
+ifeq ($(BUILD_C_RECORDMCOUNT),y)
+CFLAGS += -DCMD_MCOUNT
+endif
+
 AWK = awk
-export srctree OUTPUT CFLAGS SRCARCH AWK
+export srctree OUTPUT CFLAGS SRCARCH AWK BUILD_C_RECORDMCOUNT
 include $(srctree)/tools/build/Makefile.include
 
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
index a32736f8d2a4..29ac9be56f7b 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -13,4 +13,10 @@ extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess;
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
 
+#ifdef CMD_MCOUNT
+extern int cmd_mcount(int argc, const char **argv);
+#else
+#define cmd_mcount cmd_nop
+#endif
+
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 0b3528f05053..002a6322f4a1 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -29,12 +29,18 @@ struct cmd_struct {
 	const char *help;
 };
 
+static int __attribute__((used)) cmd_nop(int argc, const char **argv)
+{
+	return EXIT_FAILURE;
+}
+
 static const char objtool_usage_string[] =
 	"objtool COMMAND [ARGS]";
 
 static struct cmd_struct objtool_cmds[] = {
 	{"check",	cmd_check,	"Perform stack metadata validation on an object file" },
 	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file" },
+	{"mcount",	cmd_mcount,	"Construct a table of locations of calls to mcount. Useful for ftrace."},
 };
 
 bool help;
diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 697c567c2517..8345eb5b681b 100644
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

