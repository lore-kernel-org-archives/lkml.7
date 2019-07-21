Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80BCC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32842147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708758;
	bh=1PKLopZ2B1TA37clZUJgk2xzyzh4cVCaEXJ7mC/jvkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ymdYcZox2/ujbudXauO3tZTdnyGLxX3lzVhK0Es++/8+/CKcHWZZW56YnvvXills4
	 W/yD3tyqOYh+0/YYK1LZrNejq6IsYf7WqEe2k87hVob88n5yWzTGQ1kDXCD3AVwoZn
	 fBezn/Lmg0cLk8sX5tsHanZJXO4WTTA/kdht4uMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfGULch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 447913082DDD;
        Sun, 21 Jul 2019 11:32:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C2825D9D3;
        Sun, 21 Jul 2019 11:32:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 71/79] libperf: Add install targets
Date:   Sun, 21 Jul 2019 13:24:58 +0200
Message-Id: <20190721112506.12306-72-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 21 Jul 2019 11:32:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add install targets (mostly copied from lib/bpf),
it's now possible to install libperf with:

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

Link: http://lkml.kernel.org/n/tip-gz16baafdkv6irfkywache2i@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Makefile            | 69 +++++++++++++++++++++++++++++-
 tools/perf/lib/libperf.pc.template | 11 +++++
 2 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/lib/libperf.pc.template

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 25a6476f8b12..e69014a76971 100644
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

