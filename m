Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D290FC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927312171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455549;
	bh=lPVZoEvh5Ym7AizwJpG+FpWH8wpNClq96HFJvtSzVx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mb/A5MvpTIbpWT+bMhArO5gcLc2zfq4p4+Gi/yGGItK5Bjq3aElGolWtkGTjHMJuU
	 Cc1xkhyfFJvK6n+VMGyh04cp+ztdLxG34hZ/wOkyKmBWkeVxp2p556+ls8RLz9rvew
	 3L4M2mu/Md8Nyw5Q6kM0ITRzJqs5TTta3TnnNQyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbfG3C7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbfG3C7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D75206DD;
        Tue, 30 Jul 2019 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455543;
        bh=lPVZoEvh5Ym7AizwJpG+FpWH8wpNClq96HFJvtSzVx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOrDwafRRlcyFzgKKVrM7RYIkERJGd5EeyaVSo9CPm/xMiPoVXv/flkc+IBKwHT9t
         SWmXcZihHmuZrSSxIPzZE8GObsgyh/7FnOn4z1zVJwGbD18TBSZYqQlOEi1cfRhBnp
         GdPEO4KoxaYqKl0ob4jIeHB39THWj3AyPsmJanhk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 050/107] libperf: Make libperf.a part of the perf build
Date:   Mon, 29 Jul 2019 23:55:13 -0300
Message-Id: <20190730025610.22603-51-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add an empty libperf.a under tools/perf/lib and link it with perf.

It can also be built separately with:

  $ cd tools/perf/lib && make
    CC       core.o
    LD       libperf-in.o
    AR       libperf.a
    LINK     libperf.so

Committer testing:

  $ make O=/tmp/build/perf -C tools/perf/lib/
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     /tmp/build/perf/libperf.so
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  $ ls -la /tmp/build/perf/libperf.so
  -rwxrwxr-x. 1 acme acme 16232 Jul 22 15:30 /tmp/build/perf/libperf.so
  $ file /tmp/build/perf/libperf.so
  /tmp/build/perf/libperf.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, BuildID[sha1]=7a51d227d871b381ddb686dcf94145c4dd908221, not stripped
  $ git status tools/perf
  On branch perf/core
  nothing to commit, working tree clean
  $
  $ ls -lart tools/perf/lib/
  total 16
  drwxrwxr-x. 16 acme acme 4096 Jul 22 15:29 ..
  -rw-rw-r--.  1 acme acme 1633 Jul 22 15:29 Makefile
  -rw-rw-r--.  1 acme acme    0 Jul 22 15:29 core.c
  -rw-rw-r--.  1 acme acme   20 Jul 22 15:29 Build
  drwxrwxr-x.  2 acme acme 4096 Jul 22 15:29 .
  $

Committer notes:

Need to add -I$(srctree)/tools/arch/$(ARCH)/include/uapi
-I$(srctree)/tools/include/uapi to tools/perf/lib/Makefile's INCLUDE
variable to pick up the latest versions of kernel headers, even in older
systems, this is in line with what is in tools/lib/bpf/Makefile.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config |  1 +
 tools/perf/Makefile.perf   | 30 ++++++++--------
 tools/perf/lib/Build       |  1 +
 tools/perf/lib/Makefile    | 74 ++++++++++++++++++++++++++++++++++++++
 tools/perf/lib/core.c      |  0
 5 files changed, 92 insertions(+), 14 deletions(-)
 create mode 100644 tools/perf/lib/Build
 create mode 100644 tools/perf/lib/Makefile
 create mode 100644 tools/perf/lib/core.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 89ac5a1f1550..e4988f49ea79 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -277,6 +277,7 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
+INC_FLAGS += -I$(src-perf)/lib/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
 INC_FLAGS += -I$(srctree)/tools/include/uapi
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0fffd2bb6cd9..6e7e7d44ffac 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -224,6 +224,7 @@ LIB_DIR         = $(srctree)/tools/lib/api/
 TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 BPF_DIR         = $(srctree)/tools/lib/bpf/
 SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
+LIBPERF_DIR     = $(srctree)/tools/perf/lib/
 
 # Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
 # Without this setting the output feature dump file misses some features, for
@@ -272,6 +273,7 @@ ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
   BPF_PATH=$(OUTPUT)
   SUBCMD_PATH=$(OUTPUT)
+  LIBPERF_PATH=$(OUTPUT)
 ifneq ($(subdir),)
   API_PATH=$(OUTPUT)/../lib/api/
 else
@@ -282,6 +284,7 @@ else
   API_PATH=$(LIB_DIR)
   BPF_PATH=$(BPF_DIR)
   SUBCMD_PATH=$(SUBCMD_DIR)
+  LIBPERF_PATH=$(LIBPERF_DIR)
 endif
 
 LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
@@ -303,6 +306,8 @@ LIBBPF = $(BPF_PATH)libbpf.a
 
 LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
 
+LIBPERF = $(LIBPERF_PATH)libperf.a
+
 # python extension build directories
 PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
 PYTHON_EXTBUILD_LIB := $(PYTHON_EXTBUILD)lib/
@@ -348,9 +353,7 @@ endif
 
 export PERL_PATH
 
-LIBPERF_A=$(OUTPUT)libperf.a
-
-PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD)
+PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
 ifndef NO_LIBBPF
   PERFLIBS += $(LIBBPF)
 endif
@@ -583,8 +586,6 @@ JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
 PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
 
-LIBPERF_IN := $(OUTPUT)libperf-in.o
-
 export JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
@@ -601,12 +602,9 @@ $(JEVENTS): $(JEVENTS_IN)
 $(PMU_EVENTS_IN): $(JEVENTS) FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
-$(LIBPERF_IN): prepare FORCE
-	$(Q)$(MAKE) $(build)=libperf
-
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBPERF_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS) \
-		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBPERF_IN) $(LIBS) -o $@
+		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE
 	$(Q)$(MAKE) $(build)=gtk
@@ -727,9 +725,6 @@ endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
-$(LIBPERF_A): $(LIBPERF_IN)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIB_OBJS)
-
 LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
 
 $(LIBTRACEEVENT): FORCE
@@ -762,6 +757,13 @@ $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(MAKE) -C $(BPF_DIR) O=$(OUTPUT) clean >/dev/null
 
+$(LIBPERF): FORCE
+	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) $(OUTPUT)libperf.a
+
+$(LIBPERF)-clean:
+	$(call QUIET_CLEAN, libperf)
+	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) clean >/dev/null
+
 $(LIBSUBCMD): FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
 
@@ -948,7 +950,7 @@ config-clean:
 python-clean:
 	$(python-clean)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean config-clean fixdep-clean python-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
new file mode 100644
index 000000000000..5196958cec01
--- /dev/null
+++ b/tools/perf/lib/Build
@@ -0,0 +1 @@
+libperf-y += core.o
diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
new file mode 100644
index 000000000000..33046e7c6a2a
--- /dev/null
+++ b/tools/perf/lib/Makefile
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Most of this file is copied from tools/lib/bpf/Makefile
+
+MAKEFLAGS += --no-print-directory
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+include $(srctree)/tools/scripts/Makefile.include
+include $(srctree)/tools/scripts/Makefile.arch
+
+ifeq ("$(origin V)", "command line")
+  VERBOSE = $(V)
+endif
+ifndef VERBOSE
+  VERBOSE = 0
+endif
+
+ifeq ($(VERBOSE),1)
+  Q =
+else
+  Q = @
+endif
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/ -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
+
+# Append required CFLAGS
+override CFLAGS += $(EXTRA_WARNINGS)
+override CFLAGS += -Werror -Wall
+override CFLAGS += -fPIC
+override CFLAGS += $(INCLUDES)
+override CFLAGS += -fvisibility=hidden
+
+all:
+
+export srctree OUTPUT CC LD CFLAGS V
+include $(srctree)/tools/build/Makefile.include
+
+LIBPERF_SO := $(OUTPUT)libperf.so
+LIBPERF_A  := $(OUTPUT)libperf.a
+LIBPERF_IN := $(OUTPUT)libperf-in.o
+
+$(LIBPERF_IN): FORCE
+	$(Q)$(MAKE) $(build)=libperf
+
+$(LIBPERF_A): $(LIBPERF_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
+
+$(LIBPERF_SO): $(LIBPERF_IN)
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so $^ -o $@
+
+libs: $(LIBPERF_A) $(LIBPERF_SO)
+
+all: fixdep
+	$(Q)$(MAKE) libs
+
+clean:
+	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
+                *.o *~ *.a *.so .*.d .*.cmd LIBPERF-CFLAGS
+
+FORCE:
+
+.PHONY: all install clean FORCE
diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.21.0

