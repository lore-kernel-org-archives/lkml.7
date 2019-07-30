Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E2BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DF9206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455720;
	bh=DZvGRZn0A38NOtzwPWQOjawpO/0N0seWozRzbGutHvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+BimzYsz2HVwCEw0Vgj0sDWm1eeIy4KJI9hUzP5HoVkHpTBF0+AoL7B+h9ysGjSr
	 YK2eyULsBzc0Ptp+hg0Bf1wrMf/QdmUuifaPivCBTXPOUwh9ggAffMiNRJ+p46u7Zl
	 lsgiGnxNBKbvPy+bfILMssnUW1PxMrwxGeWU5dwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfG3DB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbfG3DB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E628121841;
        Tue, 30 Jul 2019 03:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455715;
        bh=DZvGRZn0A38NOtzwPWQOjawpO/0N0seWozRzbGutHvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exqv1bOE6Hkiui5TH9hZbhzBdtPt6Gw0v/isll/4xdp+2MKL/hR76wFSKs51xX5pN
         4O35o1WiIhHX6mjhCpasW+0UlqmCpEKDfic7MHoSoV82mEOrVEfRMSicpCa6reO1TU
         tmJW12UjZ5rB6NjRnxulAEr9cPTL5DaHyqWDE7Ng=
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
Subject: [PATCH 098/107] libperf: Add install targets
Date:   Mon, 29 Jul 2019 23:56:01 -0300
Message-Id: <20190730025610.22603-99-acme@kernel.org>
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

Add install targets (mostly copied from tools/lib/bpf), it's now
possible to install libperf with:

  $ make DESTDIR=/tmp/krava  install
    INSTALL  libperf.a
    INSTALL  libperf.so
    INSTALL  libperf.so.0
    INSTALL  libperf.so.0.0.1
    INSTALL  headers
    INSTALL  libperf.pc

  $ find /tmp/krava/
  /tmp/krava/
  /tmp/krava/include
  /tmp/krava/include/perf
  /tmp/krava/include/perf/evsel.h
  /tmp/krava/include/perf/evlist.h
  /tmp/krava/include/perf/threadmap.h
  /tmp/krava/include/perf/cpumap.h
  /tmp/krava/include/perf/core.h
  /tmp/krava/lib64
  /tmp/krava/lib64/pkgconfig
  /tmp/krava/lib64/pkgconfig/libperf.pc
  /tmp/krava/lib64/libperf.so.0.0.1
  /tmp/krava/lib64/libperf.so.0
  /tmp/krava/lib64/libperf.so
  /tmp/krava/lib64/libperf.a

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-72-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile            | 69 +++++++++++++++++++++++++++++-
 tools/perf/lib/libperf.pc.template | 11 +++++
 2 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/lib/libperf.pc.template

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index cd571ec648ad..f1b3d4c6d5f0 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -14,9 +14,31 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
 include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/Makefile.arch
 
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
+
 ifeq ("$(origin V)", "command line")
   VERBOSE = $(V)
 endif
@@ -49,6 +71,8 @@ override CFLAGS += -fvisibility=hidden
 all:
 
 export srctree OUTPUT CC LD CFLAGS V
+export DESTDIR DESTDIR_SQ
+
 include $(srctree)/tools/build/Makefile.include
 
 VERSION_SCRIPT := libperf.map
@@ -60,6 +84,9 @@ VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
 LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
 LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
+LIBPERF_PC := $(OUTPUT)libperf.pc
+
+LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
 
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
@@ -74,14 +101,52 @@ $(LIBPERF_SO): $(LIBPERF_IN)
 	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
 
 
-libs: $(LIBPERF_A) $(LIBPERF_SO)
+libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
 
 all: fixdep
 	$(Q)$(MAKE) libs
 
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
+
+$(LIBPERF_PC):
+	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
+		-e "s|@LIBDIR@|$(libdir_SQ)|" \
+		-e "s|@VERSION@|$(VERSION)|" \
+		< libperf.pc.template > $@
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: libs
+	$(call QUIET_INSTALL, $(LIBPERF_ALL)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
+
+install_pkgconfig: $(LIBPERF_PC)
+	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
+		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
+
+install: install_lib install_headers install_pkgconfig
 
 FORCE:
 
diff --git a/tools/perf/lib/libperf.pc.template b/tools/perf/lib/libperf.pc.template
new file mode 100644
index 000000000000..117e4a237b55
--- /dev/null
+++ b/tools/perf/lib/libperf.pc.template
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+prefix=@PREFIX@
+libdir=@LIBDIR@
+includedir=${prefix}/include
+
+Name: libperf
+Description: perf library
+Version: @VERSION@
+Libs: -L${libdir} -lperf
+Cflags: -I${includedir}
-- 
2.21.0

